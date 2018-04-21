% i = fullfile('D:\Power System Design\power.jpg');
x = fullfile('C:\Users\ABC\Desktop\power_lab\Loop4.jpg');
I =imread(x);
I = im2bw(I);
% I = imfill(I,'holes');
imshow (I);
BW = edge (I,'canny');
BW1=bwareaopen(BW,8);
reg = regionprops(BW1,'centroid','area');
cen = cat(1,reg.Centroid);
hold on
plot (cen(:,1),cen(:,2),'*m');

%%
weights = zeros (size(cen,1),1);
for i =1:size(weights,1)
    close all;
    imshow (I);
    hold on
    f = plot (cen(i,1),cen(i,2),'*b');
    weights(i,1)=input ('Enter weight');
    delete (f);
end



%%
index=1:size(weights,1);
index_new=[weights index' cen];
for i=1:size(index_new,1)
value=index_new(i,1);
new_array(value,:)= [index_new(i,2) index_new(i,3) index_new(i,4)];
end
%%
loads=xlsread('C:\Users\ABC\Desktop\power_lab\LOOP4.xlsx');

%%

% 
% %%
cen_x = sum(new_array(:,2).*loads)/(sum(loads));
cen_y = sum(new_array(:,3).*loads)/(sum(loads));

%%
imshow(I);
hold on
plot (cen_x,cen_y,'*r');
plot (cen(20,1),cen(20,2),'*b');
plot (cen(22,1),cen(22,2),'*b');
d1 = pdist2(cen(20,:),cen(22,:));

%%
ratio = input('hard_copy/soft_copy');
d_20 = pdist2(cen(20,:),[cen_x,cen_y])*ratio;
d_22 = pdist2(cen(22,:),[cen_x,cen_y])*ratio;

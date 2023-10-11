FROM ros:melodic

ARG DEBIAN_FRONTEND=noninteractive

#SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get -y install libarmadillo-dev ros-melodic-nlopt libelf-dev libdw-dev libeigen3-dev libpcl-conversions-dev ros-${ROS_DISTRO}-pcl-conversions libopencv-dev python3-opencv ros-${ROS_DISTRO}-cv-bridge ros-${ROS_DISTRO}-tf ros-${ROS_DISTRO}-pcl-ros ros-${ROS_DISTRO}-laser-geometry ros-${ROS_DISTRO}-rviz python-catkin-tools python-osrf-pycommon git wget openssh-server nano

# install LKH-3 and place executable file to /usr/local/bin
WORKDIR /root
RUN wget http://akira.ruc.dk/~keld/research/LKH-3/LKH-3.0.6.tgz
RUN tar xvfz LKH-3.0.6.tgz
WORKDIR /root/LKH-3.0.6
RUN make
RUN sudo cp LKH /usr/local/bin

# make the mounted RACER repository
WORKDIR /root/catkin_ws/
RUN /bin/bash -c '. /opt/ros/${ROS_DISTRO}/setup.bash'

# default locations
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc

WORKDIR /root/catkin_ws

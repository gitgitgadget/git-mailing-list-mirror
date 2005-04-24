From: Roman Zippel <zippel@linux-m68k.org>
Subject: Adding quilt functionality to git?
Date: Sun, 24 Apr 2005 17:23:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0504241319330.4073@scrub.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Apr 24 17:18:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPisQ-00047M-Ed
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 17:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVDXPXX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 11:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVDXPXX
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 11:23:23 -0400
Received: from [194.109.195.176] ([194.109.195.176]:31921 "EHLO
	scrub.xs4all.nl") by vger.kernel.org with ESMTP id S262340AbVDXPXP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 11:23:15 -0400
Received: from roman (helo=localhost)
	by scrub.xs4all.nl with local-esmtp (Exim 3.35 #1 (Debian))
	id 1DPiwq-0007Rw-00
	for <git@vger.kernel.org>; Sun, 24 Apr 2005 17:23:04 +0200
X-X-Sender: roman@scrub.home
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Currently git reproduces the old bk work flow and with this it also has 
the same problems and makes quilt still a very useful tool, so how about 
adding quilt functionality to git?

What basically would be needed is adding a new file type 'series' which 
basically has a contents like this:

top	<sha1>
foo.patch	<sha1>
bar.patch	<sha1>

The sha1 points to commit objects. Next we need a new merge operator, 
which basically does "merge differences between tree1 and tree2 into 
another tree" (without renames this is quite simple, basically just 
calling diff3).
With these two things one can implement quilt on top of git. A push of 
foo.patch would merge its changes into the current working tree. A refresh 
would generate a diff between top and current working tree and stores it 
as the new foo.patch.
This would also allow cherry picking by simply editing the series file. 
E.g. Andrew could merge other patches simply by adding a few lines to his 
series file and run a few updates with an url where to get the missing 
changes from. When he wants to send patches to Linus, he just needs to 
extract a new series file and send it off.

git is currently a bit too much moving target to do this myself right now, 
but maybe someone else wants to do this. As inspiration I appended below 
a simple script to implement something similiar with quilt. It basically 
does a 3-way-merge when updating the patches to a new source tree, so one 
basically uses it like this:

cp -al <src> <dest>
<update dest>
qm <src> <dest>

If there are any conflicts, it just calls kdiff3 or diff3+vi.
With git now one could skip the copy step and simply change the top sha1 
and pull the old files out of the cache.

Personally I think this merging style is more suited for the kernel 
development style then the bk merging method. There might be of course 
other problems, but due the simple design of git it would be a lot easier
to try out new things compared to other traditional SCM.

bye, Roman

---

#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Usage: $0 <src> <dst>"
	exit
fi

DIR1=$1
test ${DIR1:0:1} = / || DIR1=$PWD/$DIR1
DIR2=$2
test ${DIR2:0:1} = / || DIR2=$PWD/$DIR2

if [ ! -d $DIR1/patches -o ! -d $DIR2 ]; then
	echo "Invalid arguments"
	exit
fi

type kdiff3 >& /dev/null && test -n "$DISPLAY" && use_kdiff=1

if [ -e $DIR2/patches ]; then
	time=`date +.%y%m%d.%H%M%S`
	echo "Backing up old patches as patches$time"
	mv $DIR2/patches $DIR2/patches$time
fi

cd $DIR1
cp -a patches $DIR2
quilt top > /dev/null && quilt pop -qa
cd $DIR2
while [ -n "`quilt next`" ]; do
	p=`quilt next`
	echo "Merging patch $p"
	rej=`quilt push | sed -n 's/.* -- rejects in file \(.*\)$/\1/p'`
	if [ -n "$rej" ]; then
		echo "need to resolve conflicts in $rej"
		cd $DIR1
		quilt push -q $p
		cd $DIR2
		for m in $rej; do
			cp $m $m.rq.cur
		done
		quilt push -f
		for m in $rej; do
			if [ "$use_kdiff" -eq 1 ]; then
				kdiff3 -m -o $m \
					-L "$m (`quilt prev`)" \
					-L "$m ($p)" \
					-L "$m (current)" \
					$DIR1/.pc/$p/$m $DIR1/$m $m.rq.cur
			else
				diff3 -mE > $m \
					-L "$m (current)" \
					-L "$m (`quilt prev`)" \
					-L "$m ($p)" \
					$m.rq.cur $DIR1/.pc/$p/$m $DIR1/$m
				${EDITOR:-vi} $m
			fi
			if cmp -s $m.rq.cur $m; then
				echo "No changes"
				quilt remove $m
			fi
			rm $m.rq.cur
		done
		if [ -z "`quilt files`" ]; then
			echo "Empty patch"
			quilt pop -qf
			quilt delete $p
		else
			quilt ref
		fi
	fi
done


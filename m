From: tony.luck@intel.com
Subject: Re: [PATCH] Get commits from remote repositories by HTTP
Date: Mon, 18 Apr 2005 13:48:50 -0700
Message-ID: <200504182048.j3IKmoi32162@unix-os.sc.intel.com>
References: <Pine.LNX.4.21.0504161750020.30848-100000@iabervon.org> <12c511ca050416152452a4c620@mail.gmail.com> <200504181841.j3IIfgP31258@unix-os.sc.intel.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 22:46:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNd7I-0004os-MS
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 22:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVDRUtK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 16:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVDRUtK
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 16:49:10 -0400
Received: from fmr24.intel.com ([143.183.121.16]:8620 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261171AbVDRUs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 16:48:59 -0400
Received: from scsfmr101.sc.intel.com (scsfmr101.sc.intel.com [10.3.253.10])
	by scsfmr004.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j3IKmqcM020838;
	Mon, 18 Apr 2005 20:48:52 GMT
Received: from unix-os.sc.intel.com (unix-os.sc.intel.com [172.25.110.7])
	by scsfmr101.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j3IKiDNo016094;
	Mon, 18 Apr 2005 20:44:13 GMT
Received: from localhost (localhost [[UNIX: localhost]])
	by unix-os.sc.intel.com (8.11.6/8.11.2) id j3IKmoi32162;
	Mon, 18 Apr 2005 13:48:50 -0700
X-Authentication-Warning: unix-os.sc.intel.com: aegl set sender to tony.luck@intel.com using -f
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050418184750.GD5554@pasky.ji.cz>
X-message-flag: Git: a new part of the plan for worl domination
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> ...and this is precisely why ls-tree actually outputs those "blob" and
> "tree" tags. ;-)

Doh!

Here's a fresh copy with "if [ $tag = tree ]".  I just used it to pull
from Linus into an "empty" directory (just ran init-db to make the .git
.git/objects and .git/objects/xx directories).

-Tony


#!/bin/bash

# Copyright (C) 2005 Tony Luck

REMOTE=http://www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git/

rm -rf .gittmp
# set up a temp git repository so that we can use cat-file and ls-tree on the
# objects we pull without installing them into our tree. This allows us to
# restart if the download is interrupted
mkdir .gittmp
cd .gittmp
init-db

wget -q $REMOTE/HEAD

if cmp -s ../.git/HEAD HEAD
then
	echo Already have HEAD = `cat ../.git/HEAD`
	cd ..
	rm -rf .gittmp
	exit 0
fi

sha1=`cat HEAD`
sha1file=${sha1:0:2}/${sha1:2}

if [ -f ../.git/objects/$sha1file ]
then
	echo Already have most recent commit. Update HEAD to $sha1
	cd ..
	rm -rf .gittmp
	exit 0
fi

wget -q $REMOTE/objects/$sha1file -O .git/objects/$sha1file

treesha1=`cat-file commit $sha1 | (read tag tree ; echo $tree)`

get_tree()
{
	treesha1file=${1:0:2}/${1:2}
	if [ -f ../.git/objects/$treesha1file ]
	then
		return
	fi
	wget -q $REMOTE/objects/$treesha1file -O .git/objects/$treesha1file
	ls-tree $1 | while read mode tag sha1 name
	do
		subsha1file=${sha1:0:2}/${sha1:2}
		if [  -f ../.git/objects/$subsha1file ]
		then
			continue
		fi
		if [ $tag = tree ]
		then
			get_tree $sha1 `expr $2 + 1`
		else
			echo objects/$subsha1file >> needbloblist
		fi
	done
}

# get all the tree objects to our .gittmp area, and create list of needed blobs
get_tree $treesha1

# now get the blobs
cd ../.git
if [ -s ../.gittmp/needbloblist ]
then
	wget -q -r -nH  --cut-dirs=6 --base=$REMOTE -i ../.gittmp/needbloblist
fi

# Now we have the blobs, move the trees and commit from .gitttmp
cd ../.gittmp/.git/objects
find ?? -type f -print | while read f
do
	mv $f ../../../.git/objects/$f
done

# update HEAD
cd ../..
mv HEAD ../.git

cd ..
rm -rf .gittmp

From: tony.luck@intel.com
Subject: Re: [PATCH] Get commits from remote repositories by HTTP
Date: Sat, 16 Apr 2005 20:16:36 -0700
Message-ID: <200504170316.j3H3GaZ03333@unix-os.sc.intel.com>
References: <Pine.LNX.4.21.0504161750020.30848-100000@iabervon.org> <12c511ca050416152452a4c620@mail.gmail.com>
Cc: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 05:13:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN0EA-0000w5-OW
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 05:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVDQDRY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 23:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVDQDRY
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 23:17:24 -0400
Received: from fmr22.intel.com ([143.183.121.14]:25318 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261240AbVDQDRM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 23:17:12 -0400
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr002.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j3H3GaXr015430;
	Sun, 17 Apr 2005 03:16:37 GMT
Received: from unix-os.sc.intel.com (unix-os.sc.intel.com [172.25.110.7])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j3H3Hw68030976;
	Sun, 17 Apr 2005 03:17:58 GMT
Received: from localhost (localhost [[UNIX: localhost]])
	by unix-os.sc.intel.com (8.11.6/8.11.2) id j3H3GaZ03333;
	Sat, 16 Apr 2005 20:16:36 -0700
In-Reply-To: <011201c542d5$940bb670$03c8a8c0@kroptech.com>
To: "Adam Kropelin" <akropel1@rochester.rr.com>
Cc: <git@vger.kernel.org>
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>How about building a file list and doing a batch download via 'wget -i 
>/tmp/foo'? A quick test (on my ancient wget-1.7) indicates that it reuses 
>connectionss when successive URLs point to the same server.

Here's a script that does just that.  So there is a burst of individual
wget commands to get HEAD, the top commit object, and all the tree
objects.  The just one to get all the missing blobs.

Subsequent runs will do far less work as many of the tree objects will
not have changed, so we don't descend into any tree that we already have.

-Tony

Not a patch ... it is a whole file.  I called it "git-wget", but it might
also want to be called "git-pulltop".

Signed-off-by: Tony Luck <tony.luck@intel.com>

------ script starts here -----
#!/bin/sh

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
		if [ $mode = 40000 ]
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
------ script ends here -----

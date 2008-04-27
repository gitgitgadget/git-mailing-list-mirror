From: Andrew Morton <akpm@linux-foundation.org>
Subject: my git problem
Date: Sun, 27 Apr 2008 11:29:38 -0700
Message-ID: <20080427112938.4dbe8e2a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 20:30:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqBdr-0005lD-Ut
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 20:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758677AbYD0S3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 14:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758238AbYD0S3l
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 14:29:41 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55040 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758064AbYD0S3k (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Apr 2008 14:29:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3RITc10007782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 27 Apr 2008 11:29:39 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m3RITcJ7019033
	for <git@vger.kernel.org>; Sun, 27 Apr 2008 11:29:38 -0700
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.803 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80475>


git is really really bad to me during the merge window.  Let's look at an
example:

y:/usr/src/git26> cat .git/branches/git-ia64 
git+ssh://master.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6.git#test

Now, I want to generate a plain patch against mainline which will add the
patches which are in git-ia64 and which aren't in mainline.  ie: when that
patch is applied to mainline, we get git-ia64.  Sounds simple.

A naive

	git-diff origin git-ia64

generates vast amounts of stuff which is already in mainline.  Things like

 b/drivers/media/video/au0828/au0828-dvb.c       |    2 
 b/drivers/media/video/au0828/au0828-i2c.c       |    6 
 b/drivers/media/video/au0828/au0828.h           |    8 
 b/drivers/media/video/cx23885/cx23885-dvb.c     |    4 
 b/drivers/media/video/cx88/Kconfig              |    1 
 b/drivers/media/video/cx88/cx88-blackbird.c     |    6 
 b/drivers/media/video/cx88/cx88-cards.c         |    1 
 b/drivers/media/video/cx88/cx88-dvb.c           |   32 
 b/drivers/media/video/em28xx/em28xx-core.c      |    2 
 b/drivers/media/video/ir-kbd-i2c.c              |   21 
 b/drivers/media/video/pvrusb2/Kconfig           |    1 


The appended script is what I usually use.  It was worked out by Junio and
I maybe a couple of years ago. It doesn't work very well: it still generates
large numbers of changes which are already in mainline.  Some of them are
ia64 changes, some are not.

When Tony resyncs his tree with mainline this problem will correct itself. 
I drop the tree and repoll it daily until this happens.


I don't really have a bottom line here - but I would like the git
developers to be aware that what is a fairly sensible usage scenario just
doesn't seem to be satisfied at all well...

Thanks.



#!/bin/sh

GIT_TREE=/usr/src/git26
PULL=/usr/src/pull

git_header()
{
	tree="$1"
	echo GIT $(cat .git/refs/heads/$tree) $(cat .git/branches/$tree)
	echo
}

doit()
{
	tree=$1
	upstream=$2

	cd $GIT_TREE
	git reset --hard "$upstream"
	git fetch "$tree" || exit 1
	git merge --no-commit 'test merge' HEAD FETCH_HEAD > /dev/null

	{
		git_header "$tree"
		git log --no-merges ORIG_HEAD..FETCH_HEAD
		git diff --patch-with-stat ORIG_HEAD
	} >$PULL/$tree.patch
	{
		echo DESC
		echo $tree.patch
		echo EDESC
		git_header "$tree"
		git log --no-merges ORIG_HEAD..FETCH_HEAD
	} >$PULL/$tree.txt
	git reset --hard "$upstream"
}

mkdir -p $PULL

if [ $1"x" = "-x" ]
then
	exit
fi

cd /usr/src

if [ $# == 0 ]
then
	trees=/usr/src/git-trees
else
	trees="$1"
fi

do_one()
{
	tree=$1
	upstream=$2
	if [ ! -e $PULL/$tree.patch ]
	then
		echo "*** doing $tree, based on $upstream"
		git-branch -D $tree
		doit $tree $upstream
	else
		echo skipping $tree
	fi
}
	
if [ $# == 2 ]
then
	do_one $1 $2
else
	while read x
	do
		if echo $x | grep '^#.*' > /dev/null
		then
			true
		else
			do_one $x
		fi
	done < $trees
fi

From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Untracked working tree files
Date: Thu, 16 Oct 2008 02:32:04 -0700
Message-ID: <20081016023204.8927325a.akpm@linux-foundation.org>
References: <20081015115654.fb34438f.akpm@linux-foundation.org>
	<alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm>
	<alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm>
	<alpine.LFD.2.00.0810151219120.3288@nehalem.linux-foundation.org>
	<20081015124949.b657a8db.akpm@linux-foundation.org>
	<alpine.LFD.2.00.0810151256410.3288@nehalem.linux-foundation.org>
	<20081015132309.76d3cc28.akpm@linux-foundation.org>
	<4d8e3fd30810160142x36860354ka30375e3d21438ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, david@lang.hm,
	git@vger.kernel.org
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 11:34:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqPFA-0000cT-1q
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 11:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbYJPJc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 05:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752310AbYJPJc4
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 05:32:56 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37269 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752266AbYJPJcz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Oct 2008 05:32:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9G9W4ps023509
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 16 Oct 2008 02:32:06 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m9G9W4sW029865;
	Thu, 16 Oct 2008 02:32:04 -0700
In-Reply-To: <4d8e3fd30810160142x36860354ka30375e3d21438ae@mail.gmail.com>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.868 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98354>

On Thu, 16 Oct 2008 10:42:13 +0200 "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> wrote:

> On Wed, Oct 15, 2008 at 10:23 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > On Wed, 15 Oct 2008 13:08:36 -0700 (PDT)
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >> On Wed, 15 Oct 2008, Andrew Morton wrote:
> [...]
> >> Is "git checkout -f" part of the scripting? Or "git reset --hard"?
> >
> > well, this script has been hacked on so many times I'm not sure what
> > it does any more.
> >
> > Presently the main generate-a-diff function is
> >
> 
> Hi Andrew,
> I was wondering whether you could share the scripts you built on top of git,
> you might get some useful suggestions from this list and they could be
> inspiration for further improvement in GIT (it just happened with this
> thread ;-)

oh gee, you don't want to look.  It should all be in
http://userweb.kernel.org/~akpm/stuff/patch-scripts.tar.gz

But really it's just the one script, pull-git-patches, below.  That
thing's been hacked around so much that I daren't breathe on it.

Fortunately as long as Stephen Rothwell is producing linux-next I don't
have much need for it any more.




#!/bin/sh

GIT_TREE=/usr/src/git26
PULL=/usr/src/pull

git_header()
{
	tree="$1"
	echo GIT $(cat .git/refs/heads/$tree) $(cat .git/branches/$tree)
	echo
}

# maybe use git clean -dqfx

doit()
{
	tree=$1
	upstream=$2

	cd $GIT_TREE
	git checkout -f "$upstream"
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

do_one()
{
	tree=$1
	upstream=$2
	if [ ! -e $PULL/$tree.patch ]
	then
		echo "*** doing $tree, based on $upstream"
		git branch -D $tree
		doit $tree $upstream
	else
		echo skipping $tree
	fi
}

mkdir -p $PULL

if [ $1"x" = "-x" ]
then
	exit
fi

cd $GIT_TREE
git checkout -f master

cd /usr/src

if [ $# == 0 ]
then
	trees=/usr/src/git-trees
else
	trees="$1"
fi

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

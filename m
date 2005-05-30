From: Dave Jones <davej@redhat.com>
Subject: Re: I want to release a "git-1.0"
Date: Mon, 30 May 2005 18:12:14 -0400
Message-ID: <20050530221214.GA29556@redhat.com>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 00:10:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcsST-0004zt-SX
	for gcvg-git@gmane.org; Tue, 31 May 2005 00:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVE3WMf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 18:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVE3WMf
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 18:12:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17559 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261783AbVE3WMR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 18:12:17 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j4UMCExI008010;
	Mon, 30 May 2005 18:12:14 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j4UMCEO10030;
	Mon, 30 May 2005 18:12:14 -0400
Received: from devserv.devel.redhat.com (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j4UMCEVo031517;
	Mon, 30 May 2005 18:12:14 -0400
Received: (from davej@localhost)
	by devserv.devel.redhat.com (8.12.11/8.12.11/Submit) id j4UMCEs8031515;
	Mon, 30 May 2005 18:12:14 -0400
X-Authentication-Warning: devserv.devel.redhat.com: davej set sender to davej@redhat.com using -f
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 30, 2005 at 01:00:42PM -0700, Linus Torvalds wrote:
 > 
 > Ok, I'm at the point where I really think it's getting close to a 1.0, and
 > make another tar-ball etc. I obviously feel that it's already way superior
 > to CVS, but I also realize that somebody who is used to CVS may not 
 > actually realize that very easily.
 > 
 > So before I do a 1.0 release, I want to write some stupid git tutorial for
 > a complete beginner that has only used CVS before, with a real example of
 > how to use raw git, and along those lines I actually want the thing to
 > show how to do something useful.
 > 
 > So before I do that, is there something people think is just too hard for
 > somebody coming from the CVS world to understand? I already realized that
 > the "git-write-tree" + "git-commit-tree" interfaces were just _too_ hard
 > to put into a sane tutorial.
 > 
 > I was showing off raw git to Steve Chamberlain yesterday, and showing it
 > to him made some things pretty obvious - one of them being that
 > "git-init-db" really needed to set up the initial refs etc). So I wrote
 > this silly "git-commit-script" to make it at least half-way palatable, but
 > what else do people feel is "too hard"?

I finally got around to actually trying to use git to maintain the
cpufreq repository the last few days after reading Jeff Garzik's mini-howto[1]

It's not particularly complicated, but the number one thing that's bugged me is this..

# commit changes
GIT_AUTHOR_NAME="John Doe"		\
    GIT_AUTHOR_EMAIL="jdoe@foo.com"	\
    GIT_COMMITTER_NAME="Jeff Garzik"	\
    GIT_COMMITTER_EMAIL="jgarzik@pobox.com"	\
    git-commit-tree `git-write-tree`	\
    -p $(cat .git/HEAD )			\
    < changelog.txt			\
    > .git/HEAD

For merging a lot of csets, thats a lot of typing per cset. So my .bashrc
now sets up GIT_COMMITTER_NAME & GIT_COMMITTER_EMAIL, because I don't
foresee myself changing either of those anytime soon, which takes it down
to
    GIT_AUTHOR_NAME="John Doe"      \
    GIT_AUTHOR_EMAIL="jdoe@foo.com" \
    git-commit-tree `git-write-tree`    \
    -p $(cat .git/HEAD )            \
    < changelog.txt         \
    > .git/HEAD

per-cset.  Maybe I have early on-set dementia, but the number of times
I've typoed those two remaining environment variables is bizarre.
I must've hit every known combination possible in my merge of ~30 patches.

I could make the latter 4 lines of the above a shell alias to save some
typing, but those shell vars still bug me. Hmm, maybe I could create a
wrapper that splits a "Dave Jones <davej@redhat.com" style string into two vars.

I realise you've got a nifty bunch of tools to apply a whole mbox of
patches, but that's not ideal if all of my patches aren't in mboxes
(some I create myself and toss in my spool, some I pull from bugzilla etc..)

Typos aside, the other thing that seems non-intuitive is the splitting up
of the patch & changelog comment into seperate files during the patch-apply
stage.

Maybe your new git-commit-script wonder-tool fixes up all these problems
already, I'll take a look after food.

Its pretty nifty stuff, but for merging a lot of patches in non-mbox format,
either I'm doing something wrong, or its, well.. painful.

		Dave

[1] http://lkml.org/lkml/2005/5/26/11/index.html


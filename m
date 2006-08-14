From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] git-publish
Date: Sun, 13 Aug 2006 21:51:27 -0400
Message-ID: <20060814015127.GA18667@spearce.org>
References: <Pine.LNX.4.64.0608131158500.9789@iabervon.org> <20060813191346.GA21487@mars.ravnborg.org> <Pine.LNX.4.64.0608131536590.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Aug 14 03:52:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCRcQ-0000LO-Lt
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 03:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbWHNBvt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 21:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWHNBvs
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 21:51:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:23277 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751788AbWHNBvr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 21:51:47 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GCRbr-00043M-HT; Sun, 13 Aug 2006 21:51:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0D1D720FB77; Sun, 13 Aug 2006 21:51:27 -0400 (EDT)
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608131536590.9789@iabervon.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25307>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Sun, 13 Aug 2006, Sam Ravnborg wrote:
> 
> > But important note is that publishing is something I defer until some
> > limited test has been done. And when I omit that I have always ended u
> > pushing some crappy stuff that needs to be dealt with.
> 
> I also test before publishing. But I test before committing, too, because 
> I never get anything right (or even logically complete) the first time. My 
> cycle is edit/build/test, and if the test is successful, I commit and 
> push. Do other people really commit after editing each time? Or are they 
> testing before the commit, and doing more extensive testing after the 
> commit before the push?

I typically edit/commit/test, with a possible commit --amend after
the test to fix whatever trivial bug came up during the test.
But usually I get the initial edit right, so I don't --amend
that often.

When building a patch series for core GIT I tend to make heavy use
of git-format-pach and git-am; e.g. I'll edit/commit/test each change,
then go back and do something like:

	git format-patch -o .. next
	git reset --hard next
	git am ../0003-*
	git am ../0001-*
	git am ../0002-*

or whatever to clean up my history before doing a final test and
format-patch for emailing.  The reason I do this is I tend to to
pay attention to "patch size" when writing a change but I try to
minimize the number of changed lines before submitting so the patch
is cleaner.  :-)

When I'm not hacking on core GIT I'm typically using `git push`
to publish my changes to a common repository.  In this case I
still tend to commit before I test so I'd definately _not_ use a
`git commit && git push` style of operation.


Although other SCMs (e.g. SVN or CVS) would encourage you to commit
and push to the remote immediately this is actually a pretty bad
idea in GIT.

If the remote is ahead of you then the push would automatically fail.
If you are working on a team where everyone is doing `git commit &&
git push` then you will probably find that every other commit the
remote is ahead of you, requiring you to pull first.  But with CVS
and SVN you usually don't run into that issue unless you touched the
same files, and typically in that type of workflow users only edit
"their" files so conflicts like that tend not to happen very often.

But even worse this style of workflow will generate a very messy
history.  Almost every commit will have been done in isolation,
with yet another merge commit to connect it to the commit that
beat it into the shared repository.  This is not going to look very
pretty in gitk.


So in my humble opinion I think this is not really a workflow style
that should be encouraged with GIT.  But perhaps tools to show you
what would happen if you pushed right now (e.g. a shortlog of the
commits that would upload or that must be downloaded and merged)
would be useful.

-- 
Shawn.

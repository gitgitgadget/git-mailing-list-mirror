From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Data Integrity & un-Commited Branches
Date: Fri, 14 Sep 2007 22:51:29 -0400
Message-ID: <20070915025129.GY3099@spearce.org>
References: <2a8a071a0709140028o472bcr8c82bd88e37cc4e9@mail.gmail.com> <2a8a071a0709140036l5db62c0fl5af01f75f35610ba@mail.gmail.com> <7vk5qtd3le.fsf@gitster.siamese.dyndns.org> <2a8a071a0709141740l144b60aevdfec2b6cdab8bb60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Scott Dobrovodsky <brian@pontech.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 04:51:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWNkx-0004Wh-K2
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 04:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038AbXIOCvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 22:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754500AbXIOCve
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 22:51:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57761 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbXIOCve (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 22:51:34 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWNl1-0007Lf-Lp; Fri, 14 Sep 2007 22:51:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4C80320FBAE; Fri, 14 Sep 2007 22:51:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <2a8a071a0709141740l144b60aevdfec2b6cdab8bb60@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58217>

Brian Scott Dobrovodsky <brian@pontech.com> wrote:
> It was a misunderstanding of Git's work flow. By switching from 'an
> un-committed demo' to a previously committed master: I was expecting
> Git to give me the content last commited to master while at the same
> time preserving(without having to commit) the changes made in demo.
> Intuitively, this is how I expected Git to function.

You aren't the only one.

Several of my day-job coworkers have also thought the same thing.
Only they use git-gui, and have never read any of the Git docs.
Because nobody ever reads the docs.  Nope, not if you can just dial
my extension and browbeat me into giving you an answer to your most
urgent question.  :-\

My point is just that some people actually assume that work done
while having one branch checked out is related to that branch and
that branch alone and that switching a branch should put that work
on hold.  Unfortunately for me some of these people at day-job have
also just assumed Git can read their mind and forget to switch
branches at the proper times, resulting in unrelated work mashed
together for days straight (and criss-crossed merge to hell and back)
before they call me and say "MAKEITWORKNOW".
</rant>

It isn't unreasonable to want Git to save uncommitted work for the
current branch and then you switch to another, ending up with a
clean working directory when you finally get there.  Today we have
git-stash to help you with this, but I'm thinking maybe we want to
connect git-checkout with it?

I see `-s` isn't used as an option yet.  What about:

	$ git init
	$ echo master >file
	$ git add file && git commit -m initial

	$ git checkout -b demo         ;  # switch to demo
    $ echo demo >file              ;  # dirty the tree

	$ git checkout -s master       ;  # stash and switch to master
	Uncommitted changes stashed on branch 'demo'.
	$ cat file
	master

	$ git checkout demo            ;  # return to demo
	Uncommitted changes were stashed for 'demo'.
	To recover them now run:

	  git stash apply -s

    $ cat file
	master
	$ git stash apply -s
	$ cat file
	demo

The new `git stash apply -s` here is defined to find the most
recent stash for the current branch (which may not be the top of
the stash!) and apply it.

If you know you want to just reapply the stash when you switch back
we could define `git checkout -a` (also unused) to automatically
execute `git stash apply -s` if a stash is available for the
destination branch.

Just thinking out loud.  I probably won't code up a patch that
implements this but I don't think it would be too difficult for
someone else who wants to get their feet wet.

-- 
Shawn.

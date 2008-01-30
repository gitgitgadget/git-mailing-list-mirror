From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: simple cvs-like git wrapper
Date: Tue, 29 Jan 2008 23:00:02 -0500
Message-ID: <20080130040002.GM24004@spearce.org>
References: <20080129204048.GA9612@venus> <m3hcgw8dz7.fsf@localhost.localdomain> <20080130021050.GB9612@venus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Ed S. Peschko" <esp5@pge.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 05:00:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK47z-0006xz-CZ
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 05:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbYA3EAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 23:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbYA3EAK
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 23:00:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46706 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbYA3EAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 23:00:08 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JK477-0002NH-Ey; Tue, 29 Jan 2008 22:59:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2FBAC20FBAE; Tue, 29 Jan 2008 23:00:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080130021050.GB9612@venus>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72019>

"Ed S. Peschko" <esp5@pge.com> wrote:
> In our case, our code is tied to a database and a database instance. An
> environment equals attachment to a given oracle SID. If someone is out of sync
> with other people's changes, then that person's environment is wrong.

Surely not every single code change impacts the database schema
and meaning of column values?  If that were truely the case then
I'd say you have bigger issues to tackle.

There's perfectly valid reasons a user (or several users) may go
off on a branch for a little while.  Like maybe they are working
together to refactor a chunk of front end user interface, to better
handle result sets >100 rows, something that wasn't anticipated
would ever happen when the system was first built.  It happens.
There may not be any database changes involved on that but it may
be distrubtive enough that you don't want to see their changes
until its mostly done.

I've been there, done that with Oracle and CVS.  Having Git makes
it a whole lot easier to go off on a side branch when refactoring
a chunk of UI, as you don't have to impact all of your coworkers
right away.
 
> I agree with you, however, with the working on branches. We need the 
> ability to do the small incremental commits, and then tie them back to
> SOX requirements (bleah). 

So, uh, mention the requirement using some sort of unique requirement
identifier in each commit message, and use a commit-msg hook to
make sure you didn't forget to include the requirement number.
We make links like that in our issue tracking system with "lpmNNNN"
keywords, where NNNN is the issue tracker number.

If you ever want to know what changes were done for a particular
requirement, pop open gitk and search for contains "soxNNNN", or use
`git log --grep=soxNNN`, and there's your list.
 
> Hence the hope for the automatic merging along with a given branch - that, 
> when you do an 'gvs update', it takes all the outstanding deltas on all the
> branches that have been uploaded into the central repository, and applies 
> them, one by one, to your local repository, and keeps the branch intact.

I don't think you fully understand what git-merge does.  It retains
the full history of every individual change made along that branch,
as well as who performed the merge, and when.  Git also tracks if
the merge makes changes that weren't on either parent branch, and
correctly blames such changes to the individual who did the merge.
Most older SCMs are simply not able to do such detailed reporting.
Heck, some modern SCMs also can't do it.

> That it basically does the perfect patch series functionality you are
> talking about, but in an automatic way..

Yea, git-merge is totally freaking automatic.  Except when there is
a conflict.  Then you have to fix up a few things.  But Git isn't
a mind reader (yet) so there will always be cases where it doesn't
quite do what you wanted it to without a little additional guidence.
 
> A couple of questions:
> 
> 	1. How do you get a list - on a shared, remote, repository - of all the 
>        branches that a shared repository contains, from the point of
> 	   view of a client? ie: git-branch shows local branches..

I think you are talking about `git ls-remote --heads url`.
 
>     2. Could the above 'gvs update' be implemented in terms of a series 
> 	   of 'git pull --rebase' or even 'git pull' merges from the
> 	   centralized repository based on the output from the command 
>        above?

Yes, but why are you merging all of the available branches?
Why aren't you merging a single specific branch?  It seems very odd
to me that you want to merge every branch available.  I just cannot
see how that gives you any benefit over just having a single branch
called "master" that you rebase your changes onto before pushing
them, thus enforcing a mostly linear history.

Only linear history has its downsides.  It doesn't really quite show
you what the commits were developed against.  So it may be possible
that after a rebase the end result compiles and works, but an
earlier commit that used to work now doesn't, due to other changes.

If you are really worried about SOX requirements, I'd imagine you
are also worried about SOX auditing.  In which case I would think
that for most changes that are going to be part of your permenant
history don't want to use rebase, but instead merge, to show the
original history of every change.

> Anyways, I wouldn't mind it if 'gvs update' paused at the end of
> each merge - that you'd do a 'gvs update', it would show you exactly what
> was going to merge before it did it (maybe even via a vimdiff of old and 
> new side by side), and would allow you to do a regression test after
> each patchset was applied..

One of my favorite ways to regression test every commit in a series
during a rebase is to use git-rebase -i:

	$ git rebase -i
	... editor opens ... which is vi ...
	:%s/^pick /edit /
	:wq

	... so now it stops between every patch ...
	$ while test -d .git/.dotest-merge; do \
	make clean test && git-rebase --continue || break; done

If anything breaks, you are right there on the broken change and
you can use `git show` to see it, `git commit --amend` to fix it up,
you can test the fix, and finally then continue the rebase to move
onto the next change.

I've got a 67 patch series I'm in the middle of doing at day-job
using that exact process.  Takes a few minutes per commit as our
build cycle is slow, but it works darn well.  I'm letting it run
overnight as I expect it to get about 70% through before it finds
a problem, if it is going to find one.

-- 
Shawn.

From: Sean <seanlkml@sympatico.ca>
Subject: Re: Terminology question about remote branches.
Date: Sat, 4 Aug 2007 09:29:33 -0400
Message-ID: <20070804092933.aaec6d52.seanlkml@sympatico.ca>
References: <854pjfin68.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 15:29:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHJhT-0004y7-6C
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 15:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761409AbXHDN3o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 09:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759464AbXHDN3o
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 09:29:44 -0400
Received: from bay0-omc2-s10.bay0.hotmail.com ([65.54.246.146]:3951 "EHLO
	bay0-omc2-s10.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757966AbXHDN3n (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 09:29:43 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]) by bay0-omc2-s10.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sat, 4 Aug 2007 06:29:42 -0700
X-Originating-IP: [64.231.205.174]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([64.231.205.174]) by bayc1-pasmtp02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sat, 4 Aug 2007 06:29:42 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IHJhM-00019k-Uy; Sat, 04 Aug 2007 09:29:40 -0400
In-Reply-To: <854pjfin68.fsf@lola.goethe.zz>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.13; i686-pc-linux-gnu)
X-OriginalArrivalTime: 04 Aug 2007 13:29:42.0580 (UTC) FILETIME=[83F9A740:01C7D69B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54845>

On Sat, 04 Aug 2007 12:55:43 +0200
David Kastrup <dak@gnu.org> wrote:

> I am trying to dig through man-pages and user manual and trying to
> match them with reality.  I seem to have a hard time.  My current
> understanding (which definitely differs from the documented state) is
> that there are two types of branches, local and remote branches, and
> both types of branches can be remote-tracking (it may not be possible
> to have a non-remote-tracking remote branch, though).
>
> A local branch is one with a local branch head.  In contrast, checking
> out a remote branch, while possible, leaves one with a detached head.

Yes.

> "remote-tracking" basically means that git-pull will update the branch
> according to changes in the remote repository.

To be clear, it's the job of git-fetch to update remote-tracking branches
with any changes found in the remote repository.  Git-pull runs git-fetch
and then runs a git-merge to update the currently-checked-out branch.

When this happens, git-merge must decide which remote-tracking-branch
to merge into the currently checked out local branch.  You can set which
remote-tracking-branch will be selected in this situation with
the --track option.

So assuming a remote-repo has two branches "master" and "branchX":

   git clone remote-repo

will give us two remote-branch (AKA remote-tracking-branches) of
"origin/master" and "origin/branchX".  So:

   git branch --track mylocalbranch origin/branchX
   git checkout mylocalbranch

Creates a local branch named "mylocalbranch" that by default will
merge in any changes found in the remote-tracking branch
"origin/branchX".  Thus:

   git pull

First runs git fetch which will update all remote-tracking branches
such as origin/master and origin/branchX.  Then it runs git merge.
Git merge has to decide whether to merge in the changes from
origin/master or origin/branchX.  Because of the --track option used
to setup "mylocalbranch",  "origin/branchX" will be merged.

> Creating a branch using git-branch or git-checkout will always create
> a local branch which may or may not be remote-tracking according to
> the --no-track or --track options.

No, a local branch is never a remote-tracking branch; even when created
with a --track option.  The --track option has muddied the terminology
waters a bit and you're not the first to be confused by it.  The
--track selects a branch from the repo to merge by default.

> So there are basically three types of branches in a repository that I
> can see:
> 
> local branch, not remote-tracking
> local branch, remote-tracking
> remote branch, remote-tracking
> 
> The way to add a remote branch basically is not via git-branch or
> git-checkout -b (those always create local branches), but by editing
> .git/config.
> 
> Is this understanding correct or did I get things completely wrong?
> Because there is little sense in myself working on changing the
> documentation if I have not understood the situation.

Functionally, your understanding is correct.  But it helps when you
understand that remote-branches are the "real" remote-tracking-branches.
You don't commit to them locally, they are essentially read-only copies
of exactly what is happening in a remote repository.

A local --track branch, is one that merges changes from the proper
remote-tracking-branch, and is also a place where you can commit your
own work.

> Also, the documentation currently uses "remote-tracking"
> interchangeably for "local branch, remote-tracking" and "remote
> branch, remote-tracking", at some times claiming that one can locally
> switch to a "remote-tracking" branch, at other times not.

A remote branch and a remote-tracking branch are the same thing.
Strictly speaking a local branch is never a remote-tracking-branch
although the "--track" option makes that harder to explain.

> So the terminology seems fuzzy at the moment, and my attempt to clear
> it up might not be the preferred way of doing it.

Yeah, the documentation could use some fine tuning.

Sean

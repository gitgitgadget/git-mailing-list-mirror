From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] A Perforce importer for git.
Date: Mon, 5 Jun 2006 23:00:18 +0200
Message-ID: <20060605210018.GA22650@steel.home>
References: <BAYC1-PASMTP117796558F3B42B2C18DBCAE980@CEZ.ICE> <81b0412b0606020609o24ee34b4p7b1bcd013136d49a@mail.gmail.com> <20060602094357.ee3d8407.seanlkml@sympatico.ca> <20060602212005.GA7801@steel.home> <20060604100430.cb2789dd.seanlkml@sympatico.ca>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 23:00:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnMBZ-0004uO-Li
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 23:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWFEVA0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 17:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWFEVA0
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 17:00:26 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:53734 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750801AbWFEVAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 17:00:25 -0400
Received: from fwd29.aul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 1FnMBS-0007ez-01; Mon, 05 Jun 2006 23:00:22 +0200
Received: from tigra.home (XHny4wZrres-hH8-vC3HxTmjCiKpoKafaHljKblF-GUaNUToGc9KkI@[84.160.126.105]) by fwd29.sul.t-online.de
	with esmtp id 1FnMBP-0JACKO0; Mon, 5 Jun 2006 23:00:19 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 06CAD277B5;
	Mon,  5 Jun 2006 23:00:19 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FnMBO-0005tR-Sz; Mon, 05 Jun 2006 23:00:18 +0200
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <20060604100430.cb2789dd.seanlkml@sympatico.ca>
User-Agent: Mutt/1.5.6i
X-ID: XHny4wZrres-hH8-vC3HxTmjCiKpoKafaHljKblF-GUaNUToGc9KkI
X-TOI-MSGID: ee15845e-bd51-4e9c-b0ca-706a80231596
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21340>

Sean, Sun, Jun 04, 2006 16:04:30 +0200:
> > I'm rather looking for a ability to manage a single branch where
> > import "sync" events appear as a merge of changes to the files
> > involved in the sync. I just haven't figured out yet how to "break" a
> > Perforce change into changes to single files and import that broken up
> > commit into git as a merge.
> 
> Ahh, so what you're really asking is for a way to maintain the perforce
> merge history within git.  Whereas the current p4import script just
> shows a linear history without any merges.

I assume that by "perforce merge" you understand the set of revisions
in the working directory. That's what you get in a typical corporate
environment with hundreds libraries and source files somehow stitched
together in a hope it'd work. It does, surprisingly often. There is
also another "merge" in perforce workflow - plain text merge of many
files, done manually in working directory and checked in afterwards.
I believe it wouldn't be possible to get a history of this merge,
because there is just no information about the merge anywhere.

> The problem is that Perforce doesn't merge at the commit level.  It
> allows changes from other branches to be pulled one file at a time and
> from any rev level.

Right. Awkward.

> Now, even if you break those changes into one git commit per file per
> revision level (yuck!), you still couldn't use them to record Perforce
> merges.  Git would still merge the entire history of such commits from
> the other branch whenever you tried to merge just one.

I think it's worse: you can't merge (as in git) anything because of
that salad from local (working) and remote (p4 server-side) pathnames.

> AFAICS, the best you could do would be to create cherry-picks, plucking
> just the commits from the other branch you want.  However at that point
> you're not getting a git merge anyway and it doesn't seem to be any
> benefit beyond what the importer already does.  Well, the importer
> _could_ make a comment in the commit message describing where each
> file change originated (ie. from which branch/rev).  Would that help?

Don't think so, even if this is surely better detailed this way. I
still wont have the ability to merge branches. Maybe if every change
to every file gets it own commit one can use that information to
either cherry-pick the changes or fix the pathnames and apply that
patch? And a P4 change could be represented as a git-merge.

Like this:

P4:
    Change 213412
    a/foo.c #3
    b/bar.c #6

Git:
     +--commit abcdef ----+
     |  a/foo.c +3 lines  |
base-+                    commit deffff (merge, represents Change 213412)
     |  commit abcccd     |
     +--b/bar.c -3 lines -+

Now I can cherry-pick (or just copy) commit "abcdef" or commit
"abcccd", and still can find out what that "Change 213412" was all
about.

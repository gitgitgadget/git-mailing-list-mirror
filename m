From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to have multiple working copy directories use the same repository?
Date: Thu, 11 Oct 2007 23:52:19 -0400
Message-ID: <20071012035219.GB27899@spearce.org>
References: <744844.82514.qm@web55015.mail.re4.yahoo.com> <20071011190025.GC2804@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>,
	Bill Priest <priestwilliaml@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 05:55:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgBZk-0005z0-8e
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 05:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759249AbXJLDwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 23:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758394AbXJLDwY
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 23:52:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55894 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757573AbXJLDwX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 23:52:23 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IgBZI-0002Kl-DS; Thu, 11 Oct 2007 23:52:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 93A9620FBAE; Thu, 11 Oct 2007 23:52:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071011190025.GC2804@steel.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60652>

Alex Riesen <raa.lkml@gmail.com> wrote:
> Bill Priest, Thu, Oct 11, 2007 20:10:50 +0200:
> >   I've looked at the "git for CVS users" section in
> > the docs and this appears to create two repositories. 
> > Is there a way to have two working directories that
> > utilize the same repository?
> 
> Look for "alternates" in git's documentation. But read all the
> warnings regarding git-gc and git-prune. Make a note of ".keep" files.

Really I think Bill wants the contrib/workdir/git-new-workdir script.

Its downside is that it makes heavy use of symlinks under the
.git directory for the secondary working directories, and you do
have to watch out for committing changes to a branch when more
than one working directory has that branch as its current branch.
But otherwise it works very well for this use case.

Also you may get a few warnings from your HEAD reflog saying objects
no longer exist when you do a git-gc within a working directory.
This can happen for example if you use `git rebase -i` in a working
directory a few times and then later run git-gc from a different
working directory.  But since its just intermediate rebase state
its probably not that big of a deal to have it go missing.

You shouldn't run `git gc --prune` if any of the working directories
has staged but uncommitted changes in them.  Such changes are held
in the working directory's index, which will not be considered
as reachable (as it isn't visible to git-gc) and the objects will
be pruned.  That would not too be pleasant to debug.

Heh.  As you can see it has some "issues" with its use.  Its a very
powerful tool, but it does give you more than enough room to shoot
yourself in the foot.  Using it is like tieing a gun to your ankle,
keeping it aimed at your big toe at all times, with a string tied
to your wrist and the gun's trigger.  Reach too far and *bam*.
Which is why its still in contrib status.
 
-- 
Shawn.

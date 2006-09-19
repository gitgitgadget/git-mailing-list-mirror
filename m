From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Subversion-style incrementing revision numbers
Date: Tue, 19 Sep 2006 18:33:50 -0400
Message-ID: <20060919223350.GD11601@spearce.org>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com> <20060919211844.GB8259@pasky.or.cz> <Pine.LNX.4.62.0609191525490.9752@joeldicepc.ecovate.com> <20060919220011.GD8259@pasky.or.cz> <Pine.LNX.4.62.0609191609090.9752@joeldicepc.ecovate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 00:34:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPoAH-0007lM-Rg
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 00:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWISWeB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 18:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWISWeB
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 18:34:01 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:14792 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751242AbWISWd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 18:33:59 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GPo9v-0008UY-H7; Tue, 19 Sep 2006 18:33:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 006B420E48E; Tue, 19 Sep 2006 18:33:50 -0400 (EDT)
To: Joel Dice <dicej@mailsnare.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0609191609090.9752@joeldicepc.ecovate.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27305>

Joel Dice <dicej@mailsnare.net> wrote:
> The scenario I envision is several developers, each with a clone of a 
> shared repository.  The clones would not have IRNs turned on, only the 
> shared repository.  So, when I do a "git push", I get an IRN back, and I 
> am not confused, because I know that IRN only applies to the shared 
> repository.  Then, when I mark a Bugzilla bug as fixed and attach the IRN 
> to it, everybody knows that IRN refers to the shared repository.  After 
> all, I wouldn't mark the bug fixed if I had only committed it to my own 
> private repository.

How about recording the Bugzilla bug id in the commit message (such
as by simply mentioning "bug 123") and having an update hook on the
central repository extract that from the commits being pushed and
posting an update to the Bugzilla database?  The update can include
the branch name the commit(s) were pushed into and the final commit
SHA1 (or say 8 character abbreviation).

Its automatic and its easy for the developers.  I'm (sort of) doing
this for a system that's a lot more difficult to use than Bugzilla.
My fellow developers are very happy.
 
> That's what I figured.  I should be able to walk the commit chain to get 
> at all the commits in a push or fetch, right?

In the update hook you get 3 args:  refname oldsha1 newsha1

You can get the list of commits you are "receiving" during the single
push operation from:

	git log --pretty=raw $2..$3 

a quick parse for "bug (\d)+" on that text, make a set of of IDs
to update, then go update then storing the first 8 characters of
$3 and $1 (the branch name) into your bug tracker.

I said "receiving" in air quotes as you may already have some or
all of those commits in the current repository; they just are part
of other branches other than the one being pushed into.


Later another developer can ask if the fix for bug 123 is in any
given branch by looking at

	git log master..$idfrombug

where 'master' is any branch and $idfrombug is the 8 character
abbreviation you stored into the bug record in the update hook.

If this returns no output then the bug fix is contained in the
branch master; if it returns output then those are the commits
which were considered to be part of the bug fix that aren't in the
branch master.

-- 
Shawn.

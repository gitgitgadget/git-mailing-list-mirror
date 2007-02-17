From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] A new merge stragety 'subtree'.
Date: Sat, 17 Feb 2007 02:14:25 -0500
Message-ID: <20070217071425.GD27864@spearce.org>
References: <7vfy95y2n9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 17 08:14:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIJmG-00047O-QK
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 08:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946444AbXBQHOa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 02:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946445AbXBQHOa
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 02:14:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60734 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946444AbXBQHO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 02:14:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HIJm7-0006EC-83; Sat, 17 Feb 2007 02:14:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CE45C20FBAE; Sat, 17 Feb 2007 02:14:25 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vfy95y2n9.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39971>

Junio C Hamano <junkio@cox.net> wrote:
> For normal merge strategies, if you are on branch A and merge
> branch B into it, what you will get is exactly the same as what
> you would get by merging branch A while being on branch A
> (modulo the direction of conflict markers).  With the subtree
> merge, it is not the case anymore.  If I pull from git-gui.git,
> the resulting tree look like git.git with Shawn's updates.  If
> Shawn pulls from git.git, even after I did some changes on my
> own to git-gui subdirectory, bypassing his tree, he will get a
> merged result pertaining to git-gui.git repository
> (i.e. git-gui/ subdirectory of what I have).  This way, we can
> continue merging from each other.
> 
> Although I do not plan to commit anything in git-gui/ part of my
> tree myself, bypassing Shawn, it is nice to know that it will
> not introduce problems down the road.

This does actually cause a problem if you merge a git.git commit
into git-gui.git (by stripping the git-gui/ part off).  The problem
is the entire git.git history would then become the second parent
of the git-gui.git merge commit, and suddenly the git-gui.git
repository increases by >11 MiB in size...  ;-)

With regards to maintaining git-gui: I'll apply all patches to my
tree and do testing there, then ask Junio to merge a tagged release
over to git.git for inclusion in the next git release.

To avoid pulling the entire git.git history into git-gui, I'd ask
that anyone bypassing me (e.g. if I'm being horribly unresponsive
one week) checkout the git-gui branch from git.git, apply the
change(s) there, then merge that branch into git.git using the
subtree strategy.  This way I can later fast-forward git-gui.git
to the fixed commit, without sucking in more than I bargained for.

For example:

	git log -n1 -- git-gui
	# copy the second parent...
	git checkout -b fixgg <secondparent>
	# do fixes...
	git checkout master
	git merge -s subtree fixgg

Then I can later obtain `fixgg` from the merge commit in git.git
and update git-gui.git, without sucking in git.git's objects.

-- 
Shawn.

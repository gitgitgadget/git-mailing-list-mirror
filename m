From: Shawn Pearce <spearce@spearce.org>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Mon, 27 Feb 2006 17:26:00 -0500
Message-ID: <20060227222600.GA11797@spearce.org>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 00:14:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDrZL-0002in-NN
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 00:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbWB0XOK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 18:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWB0XOK
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 18:14:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:61879 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751848AbWB0XOI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 18:14:08 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FDrYq-0006IR-6z; Mon, 27 Feb 2006 18:13:53 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id 3EAD320FBA1; Mon, 27 Feb 2006 17:26:00 -0500 (EST)
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Content-Disposition: inline
In-Reply-To: <20060227204252.GA31836@diana.vm.bytemark.co.uk>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16891>

Karl Hasselstr?m <kha@treskal.com> wrote:
> If I make a patch series where more than one patch touches the same
> line, I get a lot of merge errors when upstream has accepted them and
> I try to merge them back.
> 
> Suppose a line contained the string "0". Patch p1 changes that to "1",
> patch p2 further changes that to "2". Upstream accept the patches, and
> I later "stg pull" them. When reapplying p1 after the pull, stg
> generates a merge conflict since upstream changed the "0" to "2" and
> p1 changes the "0" to "1".

You should look at pg:

  http://www.spearce.org/2006/02/pg-version-0111-released.html

It has some of the features of StGIT and it (at least partially)
solves this problem.

Assume you had a patch stack of:

	PatchA : Change 0 to a 1
	PatchB : Change 1 to a 2
	PatchC : Change 2 to a 3

with each affecting the same line of the same file.

When pg grabs its (possibly remote) parent ("stg pull" aka pg-rebase)
we try to push down PatchA.  If PatchA fails to push cleanly we'll
pop it off and try to push PatchA + PatchB.  If that pushes cleanly
then we fold the content of PatchA into PatchB, effectively making
PatchA part of PatchB.  If PatchA + PatchB failed to push down
cleanly then we pop both and retry pushing PatchA + PatchB + PatchC.
If that pushes down cleanly then we make PatchA and PatchB officially
part of PatchC.

This required some ``hacks'' in pg-push.  Basically if we are
doing a non-fastforward push (as there are new commits we must
merge on top of) we run an external diff/patch to apply the change.
If that fails we reset the tree back to a clean state and try again.
Whenever patch rejects a hunk we examine the hunk to see if it is
already applied to the target file; if it is already applied we
skip the hunk.  If all hunks applied cleanly and/or are already
applied we accept the patch (or combination of patches) as merging
cleanly. Yea, its not very pretty.  But it works!

Where it falls down is if the upstream accepts all three of your
patches but then changes the line from a 3 to a 4.  pg won't look
at the GIT commit history to detect that the upstream accepted your
final change (PatchC) but then overwrite it with a newer change
(3->4).  I have thought about trying to implement this but the
current environment where I am using pg wouldn't benefit from it,
so it has not been high on my priority list.

-- 
Shawn.

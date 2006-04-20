From: Shawn Pearce <spearce@spearce.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 13:55:54 -0400
Message-ID: <20060420175554.GH31738@spearce.org>
References: <20060420133640.GA31198@spearce.org> <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org> <20060420150315.GB31198@spearce.org> <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org> <20060420164351.GB31738@spearce.org> <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Apr 20 19:56:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWdNu-0008Ci-GZ
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 19:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWDTR4D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 13:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWDTR4B
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 13:56:01 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:29634 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751202AbWDTR4A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 13:56:00 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FWdNd-0007ar-ED; Thu, 20 Apr 2006 13:55:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 44FE220FBB4; Thu, 20 Apr 2006 13:55:54 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18986>

Linus Torvalds <torvalds@osdl.org> wrote:
> Ok, so that wasn't it, and the new sort order is superior.
> 
> That means that it probably _is_ the delta changes themselves (probably 
> commit c13c6bf7 "diff-delta: bound hash list length to avoid O(m*n) 
> behavior". You can try
> 
> 	git revert c13c6bf7

No effect.
 
> to see if that's it. Although Nico already showed interest, and if you 
> make the archive available to him, he's sure to figure it out.

I sent the URL privately to Nico as I did not want the repository
to be publically available before next Tuesday.

> You can try "--depth=50" (slogan: more "hot delta on delta action"), but 
> it's looking less and less like a delta selection issue, and more and more 
> like the deltas themselves are deproved.

No effect at either 50 or 100.

The more that I think about it the more it seems possible that the
pathname hashing is what may be causing the problem.  Not only did
bisect point to 1d6b38cc76c348e2477506ca9759fc241e3d0d46 but the
directory which contains the bulk of the space has many files with
the same name located in different directories:

	results/MT/Math/10000/0-11-AdjLite.deg
	results/MT/Math/10000/0-12-AdjLite.deg
	...
	results/MT/Math/30000/2-11-AdjLite.deg
	results/MT/Math/30000/2-12-AdjLite.deg
	...
	results/Rand48/Math/10000/2-11-AdjLite.deg
	results/Rand48/Math/10000/2-12-AdjLite.deg
	...
	results/Rand48/Math/30000/2-11-AdjLite.deg
	results/Rand48/Math/30000/2-12-AdjLite.deg
	...

For example the name '0-11-AdjLite.deg' occurs in 63 directories and
none of those occurrances are likely to delta against one another
very well.  Also most of these files only have 1 or 2 revisions,
so there is very little per-file history.

-- 
Shawn.

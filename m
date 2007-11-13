From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [BUG] fast-import producing very deep tree deltas
Date: Tue, 13 Nov 2007 03:53:07 -0500
Message-ID: <20071113085307.GC14735@spearce.org>
References: <20071112110354.GP6212@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 09:53:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrrWV-0004EQ-0k
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 09:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbXKMIxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 03:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbXKMIxP
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 03:53:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58587 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbXKMIxO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 03:53:14 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IrrWB-0003Ia-18; Tue, 13 Nov 2007 03:53:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C09A620FBAE; Tue, 13 Nov 2007 03:53:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20071112110354.GP6212@lavos.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64771>

Brian Downing <bdowning@lavos.net> wrote:
> I've happened upon a case where fast-import produces deep tree deltas.
> How deep?  Really deep.  6035 entries deep to be precise for this case:
> 
>     depths: count 135970 total 120567366 min 0 max 6035 mean 886.72 median 3 std_dev 1653.48
> 
>     27b8a20bdf39fecd917e8401d3499013e49449d0 tree   32 99609547 6035 0000000000000000000000000000000000000000
> 
> This was with git-fast-import from 'next' as of a couple days ago,
> run with the default options (no --depth passed in).
> 
> Needless to say the pack that resulted was just about useless.  Trying to
> repack it resulted in the "counting objects" phase running at about five
> objects per second.

Heh.

I think what's happening here is your active branch cache isn't
big enough.  We're swapping out the branch and thus recycling the
tree information (struct tree_content) back into the free pool.
When we later reload the tree we set the delta_depth to 0 but we
kept the tree we just reloaded as a delta base.

So if the tree we reloaded was already at the maximum we wouldn't
know it and make the new tree a delta.  Multiply the number of times
the branch cache has to swap out the tree times max_depth (10) and
you get the maximum delta depth of a tree created by fast-import.
Given your above data of 6035 I'm guessing your active branch cache
had to swap the branch out 603/604 times during this import.

I think the fix is going to involve caching the depth within struct
object_entry so we can restore it when the tree is reloaded.

-- 
Shawn.

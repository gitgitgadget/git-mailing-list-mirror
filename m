From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/4] Use binary searching on large buckets in git-describe.
Date: Sun, 14 Jan 2007 18:07:21 -0500
Message-ID: <20070114230721.GD10888@spearce.org>
References: <8e29bab8b4b9f53cbdc85e6e783bf3b5d3787f0f.1168727248.git.spearce@spearce.org> <20070113222900.GC18011@spearce.org> <7v3b6dh19y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:31:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VWN-0000lY-KZ
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:21:23 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V8N-0003eK-BH
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbXANXH0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 18:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbXANXH0
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 18:07:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56295 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbXANXHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 18:07:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H6ERW-0001fA-7H; Sun, 14 Jan 2007 18:07:14 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1BC6B20FBAE; Sun, 14 Jan 2007 18:07:21 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3b6dh19y.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36829>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > If a project has a really huge number of tags (such as several
> > thousand tags) then we are likely to have nearly a hundred tags in
> > some buckets.  Scanning those buckets as linked lists could take
> > a large amount of time if done repeatedly during history traversal.
> 
> I think this is a good idea -- but would you still need the 256
> buckets if you do this?

Well, yes and no.  The binary search would make it O(log N) rather
than O(N), which is clearly an improvement.  But we're hashing by
the commit SHA1 and since SHA1 does such a good job of distributing
values around we get pretty even distribution among the buckets.
This gets us a 1/256 reduction within each bucket, at the cost of
just one array index operation.

Since the buckets are so small (1 pointer) and the match function
is in the critical path of describe it would seem reasonable to
take the small memory hit in return for better behavior on very
large sets of tags.  It certainly doesn't hurt on smaller tag sets
(like git.git), we wind up with 1 tag per bucket and our lookups
are constant time.

-- 
Shawn.

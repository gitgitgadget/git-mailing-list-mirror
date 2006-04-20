From: Shawn Pearce <spearce@spearce.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 12:43:51 -0400
Message-ID: <20060420164351.GB31738@spearce.org>
References: <20060420133640.GA31198@spearce.org> <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org> <20060420150315.GB31198@spearce.org> <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 18:44:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWcG7-0002TO-DX
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 18:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWDTQn4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 12:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWDTQn4
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 12:43:56 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50869 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751090AbWDTQnz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 12:43:55 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FWcFv-0005Bw-6h; Thu, 20 Apr 2006 12:43:47 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 67A8620FBB4; Thu, 20 Apr 2006 12:43:51 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18978>

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Thu, 20 Apr 2006, Shawn Pearce wrote:
> > 
> > So with 1.3.0.g56c1 "git repack -a -d -f" did worse:
> > 
> >   Total 46391, written 46391 (delta 6649), reused 39742 (delta 0)
> >   129M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack
> > 
> > I just tried -f on v1.2.3 and it did slightly better then before:
> > 
> >   Total 46391, written 46391 (delta 6847), reused 38012 (delta 0)
> >    59M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack

Oddly enough repacking the v1.2.3 pack using 1.3.0.g56c1 created an
even smaller pack ("git-repack -a -d"):

  Total 46391, written 46391 (delta 8253), reused 44985 (delta 6847)
   49M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack

and repacking again with "git-repack -a -d" chopped another 1M:

  Total 46391, written 46391 (delta 8258), reused 46386 (delta 8253)
   48M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pac
  
but then adding -f definately gives us the 2x explosion again:

  Total 46391, written 46391 (delta 6649), reused 37894 (delta 0)
  129M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack

> Interesting. The bigger packs do generate fewer deltas, but they don't 
> seem to be _that_ much fewer. And the deltas themselves certainly 
> shouldn't be bigger.
> 
> It almost sounds like there's a problem with choosing what to delta 
> against, not necessarily a delta algorithm problem. Although that sounds a 
> bit strange, because I wouldn't have thought we actually changed the 
> packing algorithm noticeably since 1.2.3.
> 
> Hmm. Doing "gitk v1.2.3.. -- pack-objects.c" shows that I was wrong. Junio 
> did the "hash basename and direname a bit differently" thing, which would 
> appear to change the "find objects to delta against" a lot. That could be 
> it. 
> 
> You could try to revert that change:
> 
> 	git revert eeef7135fed9b8784627c4c96e125241c06c65e1
> 
> which needs a trivial manual fixup (remove the conflict entirely: 
> everything between the "<<<<" and ">>>>>" lines should go), and see if 
> that's it.

Whoa.  I did that revert and fixup on top of 'next'.  The pack
from "git-repack -a -d -f" is now even larger due to even less
delta reuse:

  Total 46391, written 46391 (delta 5148), reused 39565 (delta 0)
  171M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack

> You can also try to see if
> 
> 	git repack -a -d -f --window=50
> 
> makes for a better pack (at the cost of a much slower repack). It makes 
> git try more objects to delta against, and can thus hide a bad sort order.

With --window=50 on 'next' (without the revert'):

  Total 46391, written 46391 (delta 6666), reused 39723 (delta 0)
  129M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack

For added measure I tried --window=100 and 500 with pretty much
the same result (slightly higher delta but still a 129M pack).

-- 
Shawn.

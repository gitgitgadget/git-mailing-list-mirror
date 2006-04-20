From: Shawn Pearce <spearce@spearce.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 13:31:31 -0400
Message-ID: <20060420173131.GF31738@spearce.org>
References: <20060420133640.GA31198@spearce.org> <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org> <20060420150315.GB31198@spearce.org> <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org> <20060420164351.GB31738@spearce.org> <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Apr 20 19:31:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWd0H-0003TD-SL
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 19:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWDTRbj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 13:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWDTRbj
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 13:31:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33725 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751188AbWDTRbi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 13:31:38 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FWd03-0006Vk-29; Thu, 20 Apr 2006 13:31:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C570020FBB4; Thu, 20 Apr 2006 13:31:31 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18982>

I just spent some time bisecting this issue and it looks like the
following change by Junio may be the culprit:

  commit 1d6b38cc76c348e2477506ca9759fc241e3d0d46
  Author: Junio C Hamano <junkio@cox.net>
  Date:   Wed Feb 22 22:10:24 2006 -0800
  
      pack-objects: use full pathname to help hashing with "thin" pack.
      
      This uses the same hashing algorithm to the "preferred base
      tree" objects and the incoming pathnames, to group the same
      files from different revs together, while spreading files with
      the same basename in different directories.
      
      Signed-off-by: Junio C Hamano <junkio@cox.net>
  
  :100644 100644 af3bdf5d358b8a47ed23bcb7e9721e956eb59d60 3a16b7e4ce25ec05c64817dfd92dd9d517ab9dd3 M      pack-objects.c


Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Thu, 20 Apr 2006, Shawn Pearce wrote:
> > 
> > Oddly enough repacking the v1.2.3 pack using 1.3.0.g56c1 created an
> > even smaller pack ("git-repack -a -d"):
> 
> That's "normal". Repacking without -f will always pack _more_, never less. 
> So a different packing algorithm can only improve (of course, usually not 
> by a huge margin, and it quickly diminishes).
> 
> > but then adding -f definately gives us the 2x explosion again:
> > 
> >   Total 46391, written 46391 (delta 6649), reused 37894 (delta 0)
> >   129M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack
> 
> Right. Doing the -f will discard any old packing info, so if the new 
> packing algorithm has problems (and it obviously does), then using -f will 
> show them.
> 
> > > You could try to revert that change:
> > > 
> > > 	git revert eeef7135fed9b8784627c4c96e125241c06c65e1
> > 
> > Whoa.  I did that revert and fixup on top of 'next'.  The pack
> > from "git-repack -a -d -f" is now even larger due to even less
> > delta reuse:
> 
> Ok, so that wasn't it, and the new sort order is superior.
> 
> That means that it probably _is_ the delta changes themselves (probably 
> commit c13c6bf7 "diff-delta: bound hash list length to avoid O(m*n) 
> behavior". You can try
> 
> 	git revert c13c6bf7
> 
> to see if that's it. Although Nico already showed interest, and if you 
> make the archive available to him, he's sure to figure it out.
> 
> > With --window=50 on 'next' (without the revert'):
> > 
> >   Total 46391, written 46391 (delta 6666), reused 39723 (delta 0)
> >   129M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack
> 
> Yeah, that didn't do much. Slightly more deltas than without, but not a 
> lot, and it didn't matter much size-wise.
> 
> You can try "--depth=50" (slogan: more "hot delta on delta action"), but 
> it's looking less and less like a delta selection issue, and more and more 
> like the deltas themselves are deproved.
> 
> 			Linus

-- 
Shawn.

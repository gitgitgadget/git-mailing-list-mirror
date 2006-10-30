X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: WARNING: THIS PATCH CAN BREAK YOUR REPO, was Re: [PATCH 2/3] Only repack active packs by skipping over kept packs.
Date: Mon, 30 Oct 2006 16:09:08 -0500
Message-ID: <20061030210908.GB5775@spearce.org>
References: <20061029093754.GD3847@spearce.org> <Pine.LNX.4.64.0610301332440.11384@xanadu.home> <20061030202611.GA5775@spearce.org> <20061030205200.GA20236@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 21:15:28 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061030205200.GA20236@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30524>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeeON-0005UC-89 for gcvg-git@gmane.org; Mon, 30 Oct
 2006 22:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422661AbWJ3VJV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 16:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161489AbWJ3VJV
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 16:09:21 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:63208 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1161366AbWJ3VJU
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 16:09:20 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GeeNS-0006ya-Dg; Mon, 30 Oct 2006 16:09:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 0B29220FB0C; Mon, 30 Oct 2006 16:09:09 -0500 (EST)
To: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: git-owner@vger.kernel.org

Jan Harkes <jaharkes@cs.cmu.edu> wrote:
> On Mon, Oct 30, 2006 at 03:26:11PM -0500, Shawn Pearce wrote:
> > Actually the breakage is easier to reproduce without trashing
> > a repository.
> > 
> > Do the above so you have everything in one pack.  Now use rev-list
> > to simulate the object list construction in pack-objects as though
> > we were doing a 'git repack -a -d':
> > 
> >   git-rev-list --objects --all \
> >     --unpacked=.git/objects/pack/pack-*.pack \
> > 	| wc -l
> > 
> > gives me 102 (WRONG WRONG WRONG WRONG!!!!!!)
> 
> The problem seems to be that as soon as we hit something that is found
> in a pack that is not on the ignore list, that object and all it's
> parents are marked as uninteresting. So if the kept pack contains a
> slice of commits (v1.4.3..v1.4.3.3) the revision walker will only return
> the recent stuff (v1.4.3.3..) and drop the older data (..v1.4.3).

Right - I got that far in my own research and then saw your patch
drop into my inbox. :-)
 
> The following patch does fix the problem Nicolas reported, but for some
> reason I'm still getting only 102 objects (only tags and the commits
> they refer to?) with your test.

Ack'd.

Your patch fixes both bugs for me.  The rev-list test I talked about
above is now turning up 31846 objects which is the correct count.
The repack test Nico crafted works correctly too.

-- 

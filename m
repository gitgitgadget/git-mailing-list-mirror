X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: WARNING: THIS PATCH CAN BREAK YOUR REPO, was Re: [PATCH 2/3] Only repack active packs by skipping over kept packs.
Date: Mon, 30 Oct 2006 16:55:29 -0500
Message-ID: <20061030215529.GC5775@spearce.org>
References: <20061029093754.GD3847@spearce.org> <Pine.LNX.4.64.0610301332440.11384@xanadu.home> <20061030202611.GA5775@spearce.org> <7v7iyhwk47.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 22:00:15 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v7iyhwk47.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30532>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gef6Z-0001Xj-V7 for gcvg-git@gmane.org; Mon, 30 Oct
 2006 22:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161458AbWJ3Vzg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 16:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161528AbWJ3Vzg
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 16:55:36 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58498 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1161458AbWJ3Vzf
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 16:55:35 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gef6I-0003Tr-5d; Mon, 30 Oct 2006 16:55:22 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 3D11320FB0C; Mon, 30 Oct 2006 16:55:29 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
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
> Now I think I know what is going on.
> 
> The meaning of "unpacked" (with or without the "pretend as if
> all objects in this pack are loose") has always been to stop
> traversing once we hit a packed object, not "do not include
> already packed object".

Did you see Jan Harkes' patch that changes the behavior to be what
it should have been?
 
> So --unpacked=pretend-this-is-loose was wrong to begin with; it
> probably should have been --incremental=pretend-this-is-loose.

I don't care about what the option name is.  If you want to change
it to --incremental we can but the --unpacked actually makes more
sense now...  Its saying pretend every object in this pack is
unpacked and therefore should be packed.
 
> How about reverting the following:
> 
> commit ce8590748b918687abc4c7cd2d432dd23f07ae40
> Author: Shawn Pearce <spearce@spearce.org>
> 
>     Only repack active packs by skipping over kept packs.
> 
> 
> commit 106d710bc13f34aec1a15c4cff80f062f384edf6
> Author: Junio C Hamano <junkio@cox.net>
> 
>     pack-objects --unpacked=<existing pack> option.
> 

Nah.  I think Jan's patch fixes the bug and the --unpacked option
now makes sense as is, so I don't see why we would revert these.

-- 

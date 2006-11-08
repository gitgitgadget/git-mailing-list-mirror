X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: win2k/cygwin cannot handle even moderately sized packs
Date: Wed, 8 Nov 2006 17:28:37 -0500
Message-ID: <20061108222837.GA14446@spearce.org>
References: <20061107174859.GB26591@spearce.org> <81b0412b0611071013j51254a40s749fb6cba65e6873@mail.gmail.com> <20061107181808.GC26591@spearce.org> <20061107182636.GD26591@spearce.org> <20061107185648.GE26591@spearce.org> <20061107231130.GA5141@steel.home> <20061108051914.GB28498@spearce.org> <81b0412b0611080537k1087be66x1a4a9686b43d7b46@mail.gmail.com> <20061108171131.GA13487@spearce.org> <20061108213314.GA4437@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 22:29:07 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061108213314.GA4437@steel.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31164>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghvub-0002YM-0h for gcvg-git@gmane.org; Wed, 08 Nov
 2006 23:28:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423812AbWKHW2p (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 17:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423813AbWKHW2p
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 17:28:45 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:6542 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1423812AbWKHW2o
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 17:28:44 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GhvuJ-0001RV-Bk; Wed, 08 Nov 2006 17:28:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 448AA20E487; Wed,  8 Nov 2006 17:28:38 -0500 (EST)
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

Alex Riesen <fork0@t-online.de> wrote:
> Shawn Pearce, Wed, Nov 08, 2006 18:11:31 +0100:
> > The garbage creation is to account for the 2-4 windows required
> > by most applications.  Most of the time each window is unused;
> > we really only have two windows in use during delta decompression,
> > at all other times we really only have 1 window in use.  The commit
> > parsing applications don't keep the commit window in use when they
> > go access a tree or a blob.
> 
> So they actually can call unuse_pack to unmap the window,
> but it's kept for caching reasons?

Actually very few parts of the code even know about the windows.
Really the only parts that know it are the ones that directly
access the pack file, which is mostly restricted to sha1_file.c.

So since all access is through the more public interfaces what
you find is that the application code never keeps the window.
We are always doing use_pack/unuse_pack on every object access.
So the window is almost never in use.  So if we didn't hang onto
it in an LRU we would be in a world of hurt performance wise.

> > I could be wrong.  It may not matter.  But I think its crazy to
> > unmap otherwise valid mappings just because 2 bytes are on the
> > wrong side of an arbitrary boundary.
> 
> You're right, would be unfortunate to remap too often.
> 
> use_pack always maps at least 20 bytes, if I understand in_window and
> its use correctly. Actually, now I'm staring at it longer, I think the
> interface I suggested does almost the same, just allows to configure
> (well, hint at) the amount of bytes to be mapped in.

True; but if you look nobody wants more than 20 bytes.  They either
want <20 for the object header or 20 for the base object id in
a delta.  Otherwise they are shoving the data into zlib which
doesn't care.  No need to configure it, just shove it in.
 
> I still can't let go of the idea to get as much data as possible with
> just one call to sliding window code. Calling use_pack for every byte
> just does not seem right.

True.  But the only other idea I have is to copy the data into a
buffer for the caller.  Which we use only for the header section,
being that its small...  we already copy the delta base (20 bytes)
onto the stack during decompression.  Might as well copy the header
to decompress it.  Then you can batch up the range checks to at
worst no more than 2 range checks per header.

-- 

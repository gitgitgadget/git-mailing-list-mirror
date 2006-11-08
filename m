X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: fork0@t-online.de (Alex Riesen)
Subject: Re: win2k/cygwin cannot handle even moderately sized packs
Date: Wed, 8 Nov 2006 22:33:14 +0100
Message-ID: <20061108213314.GA4437@steel.home>
References: <81b0412b0611070928l7be83e08kbfc9657937fe7c92@mail.gmail.com> <20061107174859.GB26591@spearce.org> <81b0412b0611071013j51254a40s749fb6cba65e6873@mail.gmail.com> <20061107181808.GC26591@spearce.org> <20061107182636.GD26591@spearce.org> <20061107185648.GE26591@spearce.org> <20061107231130.GA5141@steel.home> <20061108051914.GB28498@spearce.org> <81b0412b0611080537k1087be66x1a4a9686b43d7b46@mail.gmail.com> <20061108171131.GA13487@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 21:33:47 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061108171131.GA13487@spearce.org>
User-Agent: Mutt/1.5.11
X-ID: r1CUJmZfwebz9wCMQqy5rl6yCaW3y6peRG3xJy6TtBO2I2Su7G0coL
X-TOI-MSGID: e1cc9475-ac3e-4bce-9f4b-4b5f8f532a8c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31159>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghv37-0007cE-V7 for gcvg-git@gmane.org; Wed, 08 Nov
 2006 22:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423792AbWKHVd2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 16:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423793AbWKHVd2
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 16:33:28 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:58044 "EHLO
 mailout10.sul.t-online.com") by vger.kernel.org with ESMTP id
 S1423792AbWKHVd1 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006
 16:33:27 -0500
Received: from fwd30.aul.t-online.de  by mailout10.sul.t-online.com with smtp
  id 1Ghv2u-00080i-04; Wed, 08 Nov 2006 22:33:20 +0100
Received: from tigra.home
 (r1CUJmZfwebz9wCMQqy5rl6yCaW3y6peRG3xJy6TtBO2I2Su7G0coL@[84.163.111.6]) by
 fwd30.sul.t-online.de with esmtp id 1Ghv2p-0PYAkq0; Wed, 8 Nov 2006 22:33:15
 +0100
Received: from steel.home (steel.home [192.168.1.2]) by tigra.home (Postfix)
 with ESMTP id 1C44B277AF; Wed,  8 Nov 2006 22:33:15 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian)) id
 1Ghv2o-0001PU-8s; Wed, 08 Nov 2006 22:33:14 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce, Wed, Nov 08, 2006 18:11:31 +0100:
> > >All true.  However what happens when the header spans two windows?
> > >Lets say I have the first 4 MiB mapped and the next 4 MiB mapped in
> > >a different window; these are not necessarily at the same locations
> > >within memory.  Now if an object header is split over these two
> > >then some bytes are at the end of the first window and the rest
> > >are at the start of the next window.
> > 
> > Assuming these are adjacent windows, we can just increment counters on the
> > all touched pages (at least the two together) and return the pointer into
> > the lowest page. Otherwise - time for garbage collection (why produce the
> > garbage at all, btw?) and remap.
> 
> They are adjacent in the pack file but not necessarily in virtual memory!

Oh, right! Don't know why I thought the mapped regions would be
connected.

> The garbage creation is to account for the 2-4 windows required
> by most applications.  Most of the time each window is unused;
> we really only have two windows in use during delta decompression,
> at all other times we really only have 1 window in use.  The commit
> parsing applications don't keep the commit window in use when they
> go access a tree or a blob.

So they actually can call unuse_pack to unmap the window,
but it's kept for caching reasons?

> Consequently we want the garbage there.  Actually I shouldn't have
> used garbage: the correct term would be LRU managed cache.  :-)
> When we need a new window and we would exceed our maximum limit
> (128 MiB in my implementation) we unmap the least recently used
> window which is not currently in use.

Yep, noticed that :) Just wondered why.

> I could be wrong.  It may not matter.  But I think its crazy to
> unmap otherwise valid mappings just because 2 bytes are on the
> wrong side of an arbitrary boundary.

You're right, would be unfortunate to remap too often.

use_pack always maps at least 20 bytes, if I understand in_window and
its use correctly. Actually, now I'm staring at it longer, I think the
interface I suggested does almost the same, just allows to configure
(well, hint at) the amount of bytes to be mapped in.

I still can't let go of the idea to get as much data as possible with
just one call to sliding window code. Calling use_pack for every byte
just does not seem right.

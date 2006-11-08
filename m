X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: win2k/cygwin cannot handle even moderately sized packs
Date: Wed, 8 Nov 2006 00:19:14 -0500
Message-ID: <20061108051914.GB28498@spearce.org>
References: <45507965.3010806@peralex.com> <81b0412b0611070555u1833cc8ci1d37d45782562df8@mail.gmail.com> <eiq9vm$l7c$1@sea.gmane.org> <81b0412b0611070928l7be83e08kbfc9657937fe7c92@mail.gmail.com> <20061107174859.GB26591@spearce.org> <81b0412b0611071013j51254a40s749fb6cba65e6873@mail.gmail.com> <20061107181808.GC26591@spearce.org> <20061107182636.GD26591@spearce.org> <20061107185648.GE26591@spearce.org> <20061107231130.GA5141@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 05:19:26 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061107231130.GA5141@steel.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31115>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhfqN-0001HP-GR for gcvg-git@gmane.org; Wed, 08 Nov
 2006 06:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754287AbWKHFTU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 00:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754288AbWKHFTU
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 00:19:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53439 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1754285AbWKHFTT
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 00:19:19 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GhfqH-00077K-En; Wed, 08 Nov 2006 00:19:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 37F5420E487; Wed,  8 Nov 2006 00:19:15 -0500 (EST)
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

Alex Riesen <fork0@t-online.de> wrote:
> I couldn't help noticing that the interface to the packs data is
> a bit complex:
> 
>     unsigned char *use_pack(struct packed_git *p,
> 			    struct pack_window **window,
> 			    unsigned long offset,
> 			    unsigned int *left);
>     void unuse_pack(struct pack_window **w);
> 
> Or am I missing something very obvious, and something like this
> is just not feasible for some reasons?

The use counter.  Every time someone asks for a pointer into the
pack they need to lock that window into memory to prevent us from
garbage collecting it by unmapping it to make room for another
window that the application needs.
 
> I was almost about to move your code into unpack_object_header_gently,
> but ... The header isn't that big, is it? It is variable in the pack,
> but the implementation of the parser is at the moment restricted by
> the type we use for object size (unsigned long for the particular
> platform). For example:

All true.  However what happens when the header spans two windows?
Lets say I have the first 4 MiB mapped and the next 4 MiB mapped in
a different window; these are not necessarily at the same locations
within memory.  Now if an object header is split over these two
then some bytes are at the end of the first window and the rest
are at the start of the next window.

I can't just say "make sure we have at least X bytes available
before starting to decode the header, as to do that in this case
we'd have to unmap BOTH windows and remap a new one which keeps
that very small header fully contiguous in memory.  That's thrashing
the VM page tables for really no benefit.
 
> (BTW, current unpack_object_header_gently does not use it's len
> argument to check if there actually is enough data to hold at least
> minimal header. Is the size of mapped data checked for correctness
> somewhere before?)

Yes.  Somewhere.  I think we make sure there's at least 20 bytes
in the pack remaining before we start to decode a header.  We must
have at least 20 as that's the trailing SHA1 checksum of the entire
pack. :-)

-- 

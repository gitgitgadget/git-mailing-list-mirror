X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: win2k/cygwin cannot handle even moderately sized packs
Date: Wed, 8 Nov 2006 14:37:55 +0100
Message-ID: <81b0412b0611080537k1087be66x1a4a9686b43d7b46@mail.gmail.com>
References: <45507965.3010806@peralex.com> <eiq9vm$l7c$1@sea.gmane.org>
	 <81b0412b0611070928l7be83e08kbfc9657937fe7c92@mail.gmail.com>
	 <20061107174859.GB26591@spearce.org>
	 <81b0412b0611071013j51254a40s749fb6cba65e6873@mail.gmail.com>
	 <20061107181808.GC26591@spearce.org>
	 <20061107182636.GD26591@spearce.org>
	 <20061107185648.GE26591@spearce.org>
	 <20061107231130.GA5141@steel.home>
	 <20061108051914.GB28498@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 13:38:23 +0000 (UTC)
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iERN3dnv8H8bLWQKszZqMSclCg58kMfDtHNdXwaR/3LRlLOEFBwZNlGPWxkIBXdzycfhiLSR46zMG5cVWHE0/5Rhv3QVdDeBtOLWFP49xxk6LVEYNHMIsF9vAdpa3rJhgPe2lZcf0rxMBaOryRfGKcoOZoMFFx+qjbjR3hbbSM4=
In-Reply-To: <20061108051914.GB28498@spearce.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31139>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghncv-0008B7-Ei for gcvg-git@gmane.org; Wed, 08 Nov
 2006 14:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965756AbWKHNh6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 08:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965757AbWKHNh6
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 08:37:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:1430 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S965756AbWKHNh5
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 08:37:57 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1518407ugc for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 05:37:56 -0800 (PST)
Received: by 10.78.160.2 with SMTP id i2mr9753456hue.1162993075856; Wed, 08
 Nov 2006 05:37:55 -0800 (PST)
Received: by 10.78.128.2 with HTTP; Wed, 8 Nov 2006 05:37:55 -0800 (PST)
To: "Shawn Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

> > I couldn't help noticing that the interface to the packs data is
> > a bit complex:
> >
> >     unsigned char *use_pack(struct packed_git *p,
> >                           struct pack_window **window,
> >                           unsigned long offset,
> >                           unsigned int *left);
> >     void unuse_pack(struct pack_window **w);
> >
> > Or am I missing something very obvious, and something like this
> > is just not feasible for some reasons?
>
> The use counter.  Every time someone asks for a pointer into the
> pack they need to lock that window into memory to prevent us from
> garbage collecting it by unmapping it to make room for another
> window that the application needs.

I think the counters can be kept in struct packed_git somewhere. Given mmap
granularity, and the fact that not all of the pack is used in normal case
(and the granularity help us in the worst case) the memory used up by the
page counters shouldn't be too much.

> > I was almost about to move your code into unpack_object_header_gently,
> > but ... The header isn't that big, is it? It is variable in the pack,
> > but the implementation of the parser is at the moment restricted by
> > the type we use for object size (unsigned long for the particular
> > platform). For example:
>
> All true.  However what happens when the header spans two windows?
> Lets say I have the first 4 MiB mapped and the next 4 MiB mapped in
> a different window; these are not necessarily at the same locations
> within memory.  Now if an object header is split over these two
> then some bytes are at the end of the first window and the rest
> are at the start of the next window.

Assuming these are adjacent windows, we can just increment counters on the
all touched pages (at least the two together) and return the pointer into
the lowest page. Otherwise - time for garbage collection (why produce the
garbage at all, btw?) and remap.

> I can't just say "make sure we have at least X bytes available
> before starting to decode the header, as to do that in this case
> we'd have to unmap BOTH windows and remap a new one which keeps
> that very small header fully contiguous in memory.  That's thrashing
> the VM page tables for really no benefit.

You can't mmap less than a page, can you? So it's actually never a small
portion, but at least 4k on x86.

> > (BTW, current unpack_object_header_gently does not use it's len
> > argument to check if there actually is enough data to hold at least
> > minimal header. Is the size of mapped data checked for correctness
> > somewhere before?)
>
> Yes.  Somewhere.  I think we make sure there's at least 20 bytes
> in the pack remaining before we start to decode a header.  We must
> have at least 20 as that's the trailing SHA1 checksum of the entire
> pack. :-)


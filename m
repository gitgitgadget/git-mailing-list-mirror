X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 13:14:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612111258050.3515@woody.osdl.org>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
 <200612112128.06485.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612111238560.3515@woody.osdl.org>
 <200612112154.56166.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 11 Dec 2006 21:15:08 +0000 (UTC)
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612112154.56166.Josef.Weidendorfer@gmx.de>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34038>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtsUH-0008Uy-LY for gcvg-git@gmane.org; Mon, 11 Dec
 2006 22:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761798AbWLKVO5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 16:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761779AbWLKVO5
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 16:14:57 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37576 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1759486AbWLKVO4
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 16:14:56 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBBLEiID003371
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 11
 Dec 2006 13:14:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBBLEggl007682; Mon, 11 Dec
 2006 13:14:43 -0800
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org



On Mon, 11 Dec 2006, Josef Weidendorfer wrote:
> 
> So the implementation in Qt's QProcess is a little bit pessimistic, probably
> to make it work fine with other UNIXs out there.

I suspect it may actually have been performance-optimized for Linux-2.4, 
where the pipe buffer size was one page (so if you got a full 4kB on x86, 
you'd know that the buffer was fully emptied).

And it actually does end up depending on the load too. For example, the 
4kB can also happen to match the default buffer size in stdio (or in the 
QT IO buffering equivalent), and in that case you know that any _writer_ 
that uses stdio buffering will usually use that as the blocksize, so you 
have reasons beyond the kernel to think that maybe a certain particular 
blocksize is more common than others.

And if that's the case, then if you know that _usually_ the read() would 
return -EAGAIN, then it's actually better to return to the main loop and 
select(), on the assumption that quite often, the select will be the right 
thing (and if it isn't, it will just return immediately anyway, and you 
can do the second read).

In other words, it's really a "tuning thing" that depends on the IO 
patterns of the apps involved, and the underlying pattern of the OS can 
affect it too.

Of course, most of the time it doesn't make _that_ much of a difference, 
especially when system calls are reasonably cheap (and they largely are, 
under Linux). So you can certainly see the effects of this, but the 
effects will vary so much on the load and other issues that it's hard to 
say that there is "one correct way" to do things.

For example, very subtle issues can be at play:

 - using a larger buffer and having fewer system calls can be 
   advantageous in many cases. But certainly not always.

   HOWEVER. If you have two processes that both do very little with the 
   data (generating it _or_ using it), and process switching is cheap 
   thanks to address space identifiers or clever TLB's, then a small 
   buffer may actually be much better, if it means that the whole working 
   set fits in the L2 cache.

   So a large buffer with fewer system calls may actually be _bad_, if 
   only because it causes things to go to L3 or memory. In contrast, if 
   you can re-use a smaller buffer, you'll stay in the L2 cache better. 

   Same goes for the L1 cache too, but that's really only noticeable for 
   true micro-benchmarks. Sadly, people often do performance analysis with 
   microbenches, so they can actually tune their setup for something that 
   is NOT what people actually see in real life.

   In general, if you re-use your buffer, try to keep it small enough that 
   it stays hot in the L2 can be a good thing. Using 8kB or 16kB buffers 
   and 64-128 system calls can actually be a lot BETTER than using a 1MB 
   buffer and a single system call.

   Examples of this is stdio. Making your stdio buffers bigger simply 
   often isn't a good idea. The system call cost of flushing the buffer 
   simply isn't likely to be the highest cost.

 - real-time or fairness issues. Sometimes you are better off doing a 
   round-robin thing in the main select() loop over 10 smaller buffers 
   than over ten big buffers (or over a single mainloop call-out that 
   keeps doing read() until the buffer is entirely empty). 

   This is not likely to be an issue with qgit-like behaviour (whether you 
   process a 4kB buffer or 64kB buffer in one go is simply not going to 
   make a visible difference to a user interface), but it can make a 
   difference for "server" apps with latency issues. You do not want one 
   busy client to basically freeze out all the other clients by just 
   keeping its queue filled all teh time.

   So returning to the main loop may actually be the right thing after 
   each read(), not for performance reasons, but because it gives a nicer 
   load pattern. It may perform _worse_, but it may well give a smoother 
   feel to the system!

 - simplicity. The main select() loop does the looping anyway, so avoiding 
   looping in the callouts simplifies the system. And since it's not 
   necessarily the right thing to do to loop in the individual routines 
   _anyway_ (see above), why not?

So I don't think there is a right answer here. I suspect QProcess does ok.


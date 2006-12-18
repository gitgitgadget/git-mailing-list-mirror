X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Mon, 18 Dec 2006 15:28:48 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>
References: <86y7p57y05.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
 <86r6uw9azn.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181625140.18171@xanadu.home>
 <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
 <8664c896xv.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 18 Dec 2006 23:31:35 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <8664c896xv.fsf@blue.stonehenge.com>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34763>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwRul-0005aH-OP for gcvg-git@gmane.org; Tue, 19 Dec
 2006 00:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754768AbWLRX25 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 18:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754769AbWLRX25
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 18:28:57 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58236 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1754768AbWLRX24
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006 18:28:56 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBINSoID027929
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 18
 Dec 2006 15:28:50 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBINSm7n016143; Mon, 18 Dec
 2006 15:28:49 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org



On Mon, 18 Dec 2006, Randal L. Schwartz wrote:
> 
> Linus> You're running this under OS X, aren't you? It's a pig of an OS, but 
> Linus> "almost one hour" vs "25 seconds" is still unreasonable.
> 
> I agree!

The only thing that comes to mind is

 - some actual difference in how the pack looks. Although I don't really 
   see that. I re-pack both my own private kernel repos and the kernel.org 
   one fairly often, and usually with a pretty recent git. I don't think 
   any of the packing heuristics have changed in a long time. And I just 
   checked: the kernel.org pack-file (the big one) unpacks quickly too.

 - SHA1 library differences. Maybe OpenSSL on OS X sucks? I still don't 
   see the difference being _that_ big, but whatever..

 - OS X "mmap()" performance really really sucks.

   We do end up doing a _log_ of small mmaps in the "Resolving .." stage. 
   On Linux, the strace looks like

	write(2, "Resolving 316071 deltas.\n", 25) = 25
	mmap(NULL, 2619, PROT_READ, MAP_PRIVATE, 3, 0x4c000) = 0x2aaf13be2000
	munmap(0x2aaf13be2000, 2619)            = 0
	mmap(NULL, 2848, PROT_READ, MAP_PRIVATE, 3, 0x4c000) = 0x2aaf13be2000
	munmap(0x2aaf13be2000, 2848)            = 0
	mmap(NULL, 2988, PROT_READ, MAP_PRIVATE, 3, 0x4c000) = 0x2aaf13be2000
	munmap(0x2aaf13be2000, 2988)            = 0
	write(2, "   0% (2/316071) done\r", 22) = 22
	mmap(NULL, 3336, PROT_READ, MAP_PRIVATE, 3, 0x4c000) = 0x2aaf13be2000
	munmap(0x2aaf13be2000, 3336)            = 0
	mmap(NULL, 3471, PROT_READ, MAP_PRIVATE, 3, 0x4c000) = 0x2aaf13be2000
	munmap(0x2aaf13be2000, 3471)            = 0
	mmap(NULL, 3611, PROT_READ, MAP_PRIVATE, 3, 0x4c000) = 0x2aaf13be2000
	munmap(0x2aaf13be2000, 3611)            = 0
	...

   and it's entirely possible that mmap() really does suck *ss on OS X. 
   Those small mmap's go on for a _loong_ time.

I've heard of other operations being slow on OS X - and two orders of 
magnitude really isn't unthinkable. I don't think people always seem to 
really understand how _good_ Linux is, and how much faster it can be. It's 
not just "Windows XP" sucks. Quite often it's literally "Linux is just 
damn fast".

Sadly, that causes problems when the main developers don't even see any 
issues, just because the Linux kernel environment makes things look really 
really cheap. Even when it isn't always cheap on other platforms.

Nico - have you looked at perhaps making the index-pack.c "mmap()" usage 
do chunking? Or just mmap the whole damn thing once? Linux is fast, but 
even Linux will be faster if you just mmap it once ;)


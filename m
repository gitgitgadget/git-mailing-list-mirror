From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: bug: git-repack -a -d produces broken pack on NFS
Date: Fri, 28 Apr 2006 16:18:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604281549380.3701@g5.osdl.org>
References: <20060427213207.GA6709@steel.home> <Pine.LNX.4.64.0604271500500.3701@g5.osdl.org>
 <20060428222750.GA6462@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 29 01:19:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZcF3-0000DP-4R
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 01:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWD1XTJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 19:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWD1XTJ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 19:19:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16539 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932492AbWD1XTI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Apr 2006 19:19:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3SNIstH026559
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 28 Apr 2006 16:18:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3SNIrua024476;
	Fri, 28 Apr 2006 16:18:54 -0700
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060428222750.GA6462@steel.home>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19288>



On Sat, 29 Apr 2006, Alex Riesen wrote:
>
> mount option). But this _is_ that very same interface, and "PCI error"
> looks nasty. Ok, looking at the card... Seats kinda skewed in the
> slot, pressing on it... Wow! (lights go out):
> 
>     Apr 29 00:13:35 tigra kernel: eth1: Link wake-up event 0x00020b
>     Apr 29 00:13:35 tigra kernel: eth1: PCI error 0xf00000
>     Apr 29 00:13:39 tigra kernel: NETDEV WATCHDOG: eth1: transmit timed out
>     Apr 29 00:13:39 tigra kernel: eth1: Transmit timed out, status 0x000000, resetting...
>     Apr 29 00:13:39 tigra kernel: eth1: DSPCFG accepted after 0 usec.
>     Apr 29 00:13:39 tigra kernel: eth1: Setting full-duplex based on negotiated link capability.

Ok, that "PCI error" meaning is not entirely clear, but it sounds like 
noise on the line. The driver just has a comment saying

        /* Hmmmmm, it's not clear how to recover from PCI faults. */

and it's actually pretty possible (and even likely) that whatever 
corrupted the pack-file happened on the _send_ side, so by the time we get 
a PCI error report, there's already a packet out the door that likely has 
corrupted data.

Now, corrupted data would normally be caught by the UDP checksum, but:

 - a lot of modern cards do the IP checksum on the card. Whether the 
   natsemi driver does or not, I have no clue. If it does, it would always 
   make the checksum match the (corrupted) data.

 - the IP-level checksums are really quite weak. Realistically, you really 
   really _really_ want to have link-layer checksums working, but since 
   the link-level checksum is _always_ computed by the card (and since a 
   PCI error would have corrupted the packet data that the card saw), 
   link-level checksums will always have the same error that the data got, 
   and pass.

   So even if we did the UDP checksum in software, it has a reasonable 
   chance of not triggering. It's just 16 bits, and not a _good_ 16 bits 
   at that.

Anyway, definitely looks hw-induced.

> Hmm... Ok, apologies everyone, I'm just lazy and stupid.

Having flaky hw is just unhappy. I'm glad git caught it quickly.

> Still, would be nice not to loose a repository just because
> user is an idiot.

Well, there's two sides to this:

 - packs are very much designed to be very very dense. That means that 
   even the _slightest_ corruption will likely totally destroy them. Even 
   a single-bit flip likely causes massive damage to an archive.

   This is a direct and unavoidable consequence of compression and 
   density.  A less dense format automatically has a lot more redundant 
   data, and the less dense it is, the more likely you can recover from 
   single-bit errors (or even worse ones).

   So this is the downside to compression and packing. All forms of 
   compression (and we do both traditional stream-compression with zlib 
   and aggressive delta compression between objects) inevitably make the 
   effects of corruption much worse, and much harder to recover from.

   That's the bad part.

 - The good part is that replication is obviously trivial, and git is 
   inherently very good at making incremental backups.

Now, we could try to have something that tries to recover as much of a 
corrupted pack-file as possible. Right now, git-unpack-objects just dies 
(as early as possible) if the pack is corrupt. Having some mode where it 
tries to recover from errors and continue would probably be a good 
debugging and recovery tool.

		Linus

X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Theodore Tso <tytso@mit.edu>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Tue, 19 Dec 2006 00:11:08 -0500
Message-ID: <20061219051108.GA29405@thunk.org>
References: <86y7p57y05.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org> <86r6uw9azn.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181625140.18171@xanadu.home> <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org> <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org> <Pine.LNX.4.64.0612181906450.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 05:35:41 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1440 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 00:35:14 EST
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612181906450.18171@xanadu.home>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34785>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwXdH-0004Kn-SB for gcvg-git@gmane.org; Tue, 19 Dec
 2006 06:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752578AbWLSFfP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 00:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbWLSFfP
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 00:35:15 -0500
Received: from thunk.org ([69.25.196.29]:45315 "EHLO thunker.thunk.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1752566AbWLSFfO
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 00:35:14 -0500
Received: from root (helo=candygram.thunk.org) by thunker.thunk.org with
 local-esmtps  (tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1
 (Debian)) id 1GwXJx-00066U-U9; Tue, 19 Dec 2006 00:15:22 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
 (envelope-from <tytso@thunk.org>) id 1GwXFs-0008Rm-NS; Tue, 19 Dec 2006
 00:11:08 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

On Mon, Dec 18, 2006 at 07:13:40PM -0500, Nicolas Pitre wrote:
> Maybe.  However the mmap() may occur on section of the pack file which 
> has just been written to in order to write even more, always to the same 
> file.  On Linux this is fast because the mmap'd data is likely to still 
> be in the cache.
> 
> I guess this could be turned into a malloc()/read()/free() with no 
> trouble.

Actually, depending on the size of the chunk, even on Linux
malloc/read/free can be faster than the mmap/munmap, because
mmap/munmap calls involve page table manipulations, and even on Linux
that is often slower or dead even with the memory copy involved with
using malloc/read.  Even when reading huge chunks of Canon Raw File
data at a time, I found (experimentally) that it was no faster to use
mmap() compared to read().  And for small chunks of data, malloc/read
will definitely win out over mmap(), since the page table operations
and resulting page faults completely trump the cost of copying the
bytes from the page cache to the read() buffer.


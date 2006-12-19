X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Tue, 19 Dec 2006 01:39:30 -0500
Message-ID: <20061219063930.GA2511@spearce.org>
References: <86y7p57y05.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org> <86r6uw9azn.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181625140.18171@xanadu.home> <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org> <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org> <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 06:40:11 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061219051108.GA29405@thunk.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34788>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwYdw-0003vv-14 for gcvg-git@gmane.org; Tue, 19 Dec
 2006 07:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752724AbWLSGjm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 01:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752802AbWLSGjm
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 01:39:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54544 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752724AbWLSGjk (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 01:39:40 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GwYdQ-0000gC-DA; Tue, 19 Dec 2006 01:39:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 12DC320FB65; Tue, 19 Dec 2006 01:39:31 -0500 (EST)
To: Theodore Tso <tytso@mit.edu>
Sender: git-owner@vger.kernel.org

Theodore Tso <tytso@mit.edu> wrote:
> On Mon, Dec 18, 2006 at 07:13:40PM -0500, Nicolas Pitre wrote:
> > Maybe.  However the mmap() may occur on section of the pack file which 
> > has just been written to in order to write even more, always to the same 
> > file.  On Linux this is fast because the mmap'd data is likely to still 
> > be in the cache.
> > 
> > I guess this could be turned into a malloc()/read()/free() with no 
> > trouble.
> 
> Actually, depending on the size of the chunk, even on Linux
> malloc/read/free can be faster than the mmap/munmap, because
> mmap/munmap calls involve page table manipulations, and even on Linux
> that is often slower or dead even with the memory copy involved with
> using malloc/read.  Even when reading huge chunks of Canon Raw File
> data at a time, I found (experimentally) that it was no faster to use
> mmap() compared to read().  And for small chunks of data, malloc/read
> will definitely win out over mmap(), since the page table operations
> and resulting page faults completely trump the cost of copying the
> bytes from the page cache to the read() buffer.

This is why git-fast-import mmaps 128 MiB blocks from the file at
a time.  The mmap region is usually much larger than the file itself;
the application appends to the file via write() then goes back
and rereads data when necessary via the already established mmap.
Its rare for the application to need to unmap/remap a different block
so there really isn't very much page table manipulation overhead.

Why isn't git-index-pack doing the same?  Is there some hidden glitch
in some OS somewhere that has a problem with overmapping a file and
appending into it via write()?  I've done that on Mac OS X, Linux,
BSDi, Solaris...  never had a problem.

-- 

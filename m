X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Theodore Tso <tytso@mit.edu>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Tue, 19 Dec 2006 11:19:19 -0500
Message-ID: <20061219161919.GA16980@thunk.org>
References: <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org> <86r6uw9azn.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181625140.18171@xanadu.home> <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org> <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org> <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org> <20061219063930.GA2511@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 16:29:06 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061219063930.GA2511@spearce.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34833>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwhpr-0008B0-VL for gcvg-git@gmane.org; Tue, 19 Dec
 2006 17:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932821AbWLSQ25 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 11:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbWLSQ24
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 11:28:56 -0500
Received: from thunk.org ([69.25.196.29]:44067 "EHLO thunker.thunk.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1753030AbWLSQ24
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 11:28:56 -0500
Received: from root (helo=candygram.thunk.org) by thunker.thunk.org with
 local-esmtp   (Exim 4.50 #1 (Debian)) id 1Gwhth-0000a3-Q1; Tue, 19 Dec 2006
 11:32:58 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
 (envelope-from <tytso@thunk.org>) id 1GwhgV-0002CV-TY; Tue, 19 Dec 2006
 11:19:19 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Tue, Dec 19, 2006 at 01:39:30AM -0500, Shawn Pearce wrote:
> This is why git-fast-import mmaps 128 MiB blocks from the file at
> a time.  The mmap region is usually much larger than the file itself;
> the application appends to the file via write() then goes back
> and rereads data when necessary via the already established mmap.
> Its rare for the application to need to unmap/remap a different block
> so there really isn't very much page table manipulation overhead.

Yes, but unless you are using the (non-portable, Linux specific)
MAP_POPULATE flag to mmap, each time you touch a new page, you end up
taking a page fault; and so malloc/read/free might *still* be faster.
I'd encourage you to make the change and benchmark it; the results may
be surprising.  I played with this with dcraw, the Canon Raw File
converter a while back (before MAP_POPULATE was added), where I found
that with a linear access pattern, if you are reading the entire file,
it's stil marginally faster to use read() over mmap(), because with
dcraw taking a page fault every 4k of raw file, the system time was
significantly higher.

So the main reason to use mamp, as Linus puts it, is if the management
overhead of needing to read lots of small bits of the file makes the
use of malloc/read to be a pain in the *ss, then go for it.  But don't
assume that you'll get better performance; in my experience, even on
the hyper-performant Linus kernel, mmap() in general only barely
breaks even with read().  On other systems, things are probably going
to be even worse.


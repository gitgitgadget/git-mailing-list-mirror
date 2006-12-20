X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Tue, 19 Dec 2006 20:58:07 -0500
Message-ID: <20061220015807.GB27638@spearce.org>
References: <86r6uw9azn.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181625140.18171@xanadu.home> <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org> <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org> <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org> <20061219063930.GA2511@spearce.org> <20061219161919.GA16980@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 01:58:31 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061219161919.GA16980@thunk.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34891>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwqiw-00065z-5E for gcvg-git@gmane.org; Wed, 20 Dec
 2006 02:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932956AbWLTB6R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 20:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932968AbWLTB6Q
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 20:58:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52708 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932954AbWLTB6P (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 20:58:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GwqiV-0002K5-4Y; Tue, 19 Dec 2006 20:57:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 548B220FB65; Tue, 19 Dec 2006 20:58:08 -0500 (EST)
To: Theodore Tso <tytso@mit.edu>
Sender: git-owner@vger.kernel.org

Theodore Tso <tytso@mit.edu> wrote:
> On Tue, Dec 19, 2006 at 01:39:30AM -0500, Shawn Pearce wrote:
> > This is why git-fast-import mmaps 128 MiB blocks from the file at
> > a time.  The mmap region is usually much larger than the file itself;
> > the application appends to the file via write() then goes back
> > and rereads data when necessary via the already established mmap.
> > Its rare for the application to need to unmap/remap a different block
> > so there really isn't very much page table manipulation overhead.
> 
> Yes, but unless you are using the (non-portable, Linux specific)
> MAP_POPULATE flag to mmap, each time you touch a new page, you end up
> taking a page fault; and so malloc/read/free might *still* be faster.
> I'd encourage you to make the change and benchmark it; the results may
> be surprising.  I played with this with dcraw, the Canon Raw File
> converter a while back (before MAP_POPULATE was added), where I found
> that with a linear access pattern, if you are reading the entire file,
> it's stil marginally faster to use read() over mmap(), because with
> dcraw taking a page fault every 4k of raw file, the system time was
> significantly higher.

Interesting.  Lots of good reasons to probably just use pread()
in there instead of mmap.  For one thing git-fast-import doesn't
go back and hit the already written pack data very often. Its own
in memory caches usually perform very well.

-- 

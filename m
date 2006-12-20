X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Tue, 19 Dec 2006 20:54:32 -0500
Message-ID: <20061220015431.GA27638@spearce.org>
References: <Pine.LNX.4.64.0612181625140.18171@xanadu.home> <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org> <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org> <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org> <20061219063930.GA2511@spearce.org> <20061219161919.GA16980@thunk.org> <Pine.LNX.4.64.0612190855300.3479@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 01:55:00 +0000 (UTC)
Cc: Theodore Tso <tytso@mit.edu>, Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612190855300.3479@woody.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34890>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwqfW-0005gs-Hi for gcvg-git@gmane.org; Wed, 20 Dec
 2006 02:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932935AbWLTByl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 20:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932937AbWLTByl
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 20:54:41 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52567 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932935AbWLTByk (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 20:54:40 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gwqf1-000298-LS; Tue, 19 Dec 2006 20:54:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 9AA4320FB65; Tue, 19 Dec 2006 20:54:32 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> On Tue, 19 Dec 2006, Theodore Tso wrote:
> > 
> > So the main reason to use mamp, as Linus puts it, is if the management
> > overhead of needing to read lots of small bits of the file makes the
> > use of malloc/read to be a pain in the *ss, then go for it.
> 
> An example of this in git is the regular pack-file accesses. We're MUCH 
> better off just mmap'ing the whole pack-file (or at least big chunks of 
> it) and not having to maintain difficult structures of "this is where I 
> read that part of the file into memory", or read _big_ chunks when 
> quite often we just use a few kB of it.
> 
> So mmap for pack-files does make sense, but probably only when you can 
> mmap big chunks, and are going to access much smaller (random) parts of 
> it.

Yes, exactly.

git-fast-import mmaps the pack file for this very reason.  It every
so often needs to go back and reread a tree object which has expired
from its own in-memory LRU cache.  This usually doesn't happen
very often, but when it does we don't know where we are going to
jump to get data from.  mmaping a huge segment of the pack file
(or the whole thing if its reasonably small) works for this case as
the OS buffer cache can just take care of it for us.  But as Linus
pointed out mmap and write() aren't safe on some systems.  Arrrgh.

However git-fast-import would probably work just as well (or maybe
slightly better) with pread().  I really should port that code
forward to current Git, use pread() instead, and submit the patch
to Junio.  But nobody really showed a lot of interest.


My sliding window pack-file access implementation (that I'm currently
rewriting on top of current Git) tries to work in very large chunks,
by default its 32 MiB per chunk, but its user/repository configurable
so kernel hackers may just set it to 256 MiB and continue to get
one large mmap for quite some time to come.  Of course I would
also like to get that to autoselect the window size rather than
just hardcode it.  :-)

The implementation would prefer a very small number (<8) of very
large chunks (>32 MiB), but is designed to more gracefully degrade
on huge packs on limited address space systems (e.g. Windows 32 bit)
then the current code does.

-- 

X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: win2k/cygwin cannot handle even moderately sized packs
Date: Wed, 8 Nov 2006 12:11:31 -0500
Message-ID: <20061108171131.GA13487@spearce.org>
References: <eiq9vm$l7c$1@sea.gmane.org> <81b0412b0611070928l7be83e08kbfc9657937fe7c92@mail.gmail.com> <20061107174859.GB26591@spearce.org> <81b0412b0611071013j51254a40s749fb6cba65e6873@mail.gmail.com> <20061107181808.GC26591@spearce.org> <20061107182636.GD26591@spearce.org> <20061107185648.GE26591@spearce.org> <20061107231130.GA5141@steel.home> <20061108051914.GB28498@spearce.org> <81b0412b0611080537k1087be66x1a4a9686b43d7b46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 17:12:14 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <81b0412b0611080537k1087be66x1a4a9686b43d7b46@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31146>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghqxr-00027k-NX for gcvg-git@gmane.org; Wed, 08 Nov
 2006 18:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754594AbWKHRLh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 12:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753379AbWKHRLh
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 12:11:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:2238 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1754594AbWKHRLf
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 12:11:35 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GhqxT-0008Rd-CG; Wed, 08 Nov 2006 12:11:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 8AB8820E487; Wed,  8 Nov 2006 12:11:31 -0500 (EST)
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

Alex Riesen <raa.lkml@gmail.com> wrote:
> >The use counter.  Every time someone asks for a pointer into the
> >pack they need to lock that window into memory to prevent us from
> >garbage collecting it by unmapping it to make room for another
> >window that the application needs.
> 
> I think the counters can be kept in struct packed_git somewhere. Given mmap
> granularity, and the fact that not all of the pack is used in normal case
> (and the granularity help us in the worst case) the memory used up by the
> page counters shouldn't be too much.

We already have a counter in struct packed_git (pack_use_cnt),
but this counter and struct permits only one mmap per pack.
We actually want at least two, but really four sliding windows
per pack.  Here's why:

The commits are at the front of the pack, trees are somewhere just
behind them, and the blobs are behind that.  The objects are also
loosely ordered by time, so the further back in the commit graph
you go the associated data is closer to the end of the pack file.

If a pack file is larger than our mmap unit (32 MiB in my
implementation) then we will mmap it in at least two different
non-contiguous windows.  In the case of the Linux kernel pack
(>128 MiB now) that's at least 4 windows to mmap the entire file.

If we are a commit parsing application (merge-base, blame, log,
rev-list, etc...) we need to walk back along the commit DAG to
identify objects of interest.  So we need the front of the pack
mmap'd.  But if we have a path filter than we also need to mmap the
middle of the pack to get access to the trees; and if we need blob
data than we need to mmap near the back too to get those.

So really an application wants 2-3 sliding windows of a pack file;
one focused on the front covering the unparsed commits; one slightly
behind that focused on the trees; and one further back focused on
the blobs.  Oh and you may actually need a 4th to do delta base
decompression.  If you work with less than 4 sliding windows then
you are going to be thrashing the page tables somewhat as you toss
out one window to load another, then toss that window out just to
go back and reaccess the one you previously tossed.

If the sliding window size is large enough that nearly all commits
and trees fit into it then this is mostly a non-issue.  Heck the
git.git pack is hovering around 10 MiB these days; that's less than
one window.  But when the pack is larger than a couple of windows
this really starts to matter...  and that's specifically the type
of repository this feature is designed for.

> >All true.  However what happens when the header spans two windows?
> >Lets say I have the first 4 MiB mapped and the next 4 MiB mapped in
> >a different window; these are not necessarily at the same locations
> >within memory.  Now if an object header is split over these two
> >then some bytes are at the end of the first window and the rest
> >are at the start of the next window.
> 
> Assuming these are adjacent windows, we can just increment counters on the
> all touched pages (at least the two together) and return the pointer into
> the lowest page. Otherwise - time for garbage collection (why produce the
> garbage at all, btw?) and remap.

They are adjacent in the pack file but not necessarily in virtual memory!

I'm just asking the OS to return me a mapping for a chunk of a file;
I'm not also trying to make them contiguous in virtual memory.

Making adjacent pack file chunks contiguous in virtual memory is even
more code and probably going to cause problems at runtime.  How do
we know what area of virtual memory is mostly unused on any given
platform?  Any application that I have seen that tries to manage
its own virtual memory layout is usually full of platform specific
hacks to make it work everywhere. Lets not go there with Git.

The garbage creation is to account for the 2-4 windows required
by most applications.  Most of the time each window is unused;
we really only have two windows in use during delta decompression,
at all other times we really only have 1 window in use.  The commit
parsing applications don't keep the commit window in use when they
go access a tree or a blob.

Consequently we want the garbage there.  Actually I shouldn't have
used garbage: the correct term would be LRU managed cache.  :-)
When we need a new window and we would exceed our maximum limit
(128 MiB in my implementation) we unmap the least recently used
window which is not currently in use.

> >I can't just say "make sure we have at least X bytes available
> >before starting to decode the header, as to do that in this case
> >we'd have to unmap BOTH windows and remap a new one which keeps
> >that very small header fully contiguous in memory.  That's thrashing
> >the VM page tables for really no benefit.
> 
> You can't mmap less than a page, can you? So it's actually never a small
> portion, but at least 4k on x86.

No.  But we always mmap even more than that per window; e.g. 32
MiB.  Since the header is way smaller than 4k we're talking about
unmapping two 32 MiB windows and remapping one of them just one
page earlier to get the whole object header in a contiguous region.
I'm not a kernel hacker (nor do I pretended to be) but from what I
know of the x86 page table structure that's not exactly the fastest
operation we can ask the system to perform.  :)

I could be wrong.  It may not matter.  But I think its crazy to
unmap otherwise valid mappings just because 2 bytes are on the
wrong side of an arbitrary boundary.

-- 

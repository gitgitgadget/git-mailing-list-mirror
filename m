X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: jgit performance update
Date: Sun, 3 Dec 2006 17:59:48 -0500
Message-ID: <20061203225947.GD15965@spearce.org>
References: <20061203045953.GE26668@spearce.org> <200612031455.48032.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 23:00:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612031455.48032.robin.rosenberg.lists@dewire.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33149>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr0JP-0008Vc-Vf for gcvg-git@gmane.org; Sun, 03 Dec
 2006 23:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760148AbWLCW7w (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 17:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760149AbWLCW7w
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 17:59:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51914 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1760148AbWLCW7w
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 17:59:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gr0Ix-0003ht-Sn; Sun, 03 Dec 2006 17:59:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 AB7ED20FB7F; Sun,  3 Dec 2006 17:59:48 -0500 (EST)
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> So, just go on to the next case. I added filtering on filenames (yes, 
> CVS-induced brain damage, I should track the content. next version. filenames 
> are so much handier to work with). That gives me 4.5s to retrieve a filtered 
> history (from 10800 commits).Half of the time is spent in re-sorting tree 
> entries. Is that really necessary?

Yea, I was looking at that code while doing the other performance
improvements and thought it might start to become a bottleneck. I
guess I was right.

What is happening here is jgit wants to store the items in the tree
in name ordering, but Git stores the items in the tree sorted such
that subtrees sort with a '/' on the end of their name.  This is a
different ordering...

The reason I'm resorting them is so we can find an entry without
knowing what its type is first.  Looks like that's going to have
to change somehow.
 
> Most of java's slowness comes from the programmers using it. (Lutz Prechelt. 
> Technical opinion: comparing Java vs. C/C++ efficiency differences to 
> interpersonal differences. ACM, Vol 42,#10, 1999)

Yes, that was clearly the case here with jgit!  :-)

_This_ programmer made jgit slow.  Learned from the mistake, and
made it faster.
 
> > One of the biggest annoyances has been the fact that although Java 
> > 1.4 offers a way to mmap a file into the process, the overhead to
> > access that data seems to be far higher than just reading the file
> > content into a very large byte array, especially if we are going
> > to access that file content multiple times.  So jgit performs worse
> > than core Git early on while it copies everything from the OS buffer
> > cache into the Java process, but then performs reasonably well once
> > the internal cache is hot.  On the other hand using the mmap call
> > reduces early latency but hurts the access times so much that we're
> > talking closer to 3s average read times for the same log operation.
> 
> Have you tried that with difference JVM's?

No, I'm on Mac OS X so I don't have a huge JVM selection (that I
know of).  And I haven't tried jgit or egit on any other system yet.

-- 

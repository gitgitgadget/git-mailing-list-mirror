X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Fast access git-rev-list output: some OS knowledge required
Date: Wed, 6 Dec 2006 15:18:16 -0500
Message-ID: <20061206201816.GF20320@spearce.org>
References: <e5bfff550612061124jcd0d94em47793710866776e7@mail.gmail.com> <20061206192800.GC20320@spearce.org> <e5bfff550612061134r3725dcbu2ff2dd6284fcd651@mail.gmail.com> <20061206194258.GD20320@spearce.org> <20061206195142.GE20320@spearce.org> <e5bfff550612061208g6e4003e7ifa7dbd5ed69180c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 20:18:29 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <e5bfff550612061208g6e4003e7ifa7dbd5ed69180c9@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33517>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs3Dn-0000SX-IC for gcvg-git@gmane.org; Wed, 06 Dec
 2006 21:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937610AbWLFUSW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 15:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937612AbWLFUSV
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 15:18:21 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56373 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937611AbWLFUST (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 15:18:19 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gs3DG-0002Ac-Tu; Wed, 06 Dec 2006 15:17:55 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 4290A20FB7F; Wed,  6 Dec 2006 15:18:16 -0500 (EST)
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

Marco Costalba <mcostalba@gmail.com> wrote:
> On 12/6/06, Shawn Pearce <spearce@spearce.org> wrote:
> >Shawn Pearce <spearce@spearce.org> wrote:
> >
> >Perhaps there is some fast IPC API supported by Qt that you could
> >use to run the revision listing outside of the main UI process,
> >to eliminate the bottlenecks you are seeing and remove the problems
> >noted above?  One that doesn't involve reading from a pipe I mean...
> >
> 
> Qt it's very fast in reading from files, also git-rev-list is fast in
> write to a file...the problem is I would not want the file to be saved
> on disk, but stay cached in the OS memory for the few seconds needed
> to be written and read back, and then deleted. It's a kind of shared
> memory at the end. But I don't know how to realize it.

On a modern Linux (probably your largest target audience) a small
file which has a very short lifespan (few seconds) is unlikey to
hit the platter.  Most filesystems will put the data into buffer
cache and delay writing to disk because temporary files are so
common on UNIX.

Though our resident Linux experts may chime in with more details...
 
> Also let git-rev-list to write directly in qgit process address space
> would be nice, indeed very nice.

And ugly.  :-)

SysV IPC (shared memory, semaphores) are messy and difficult to
get right.  mmap against a random file in the filesystem tends
to work better on those systems which support it well, provided
that the file isn't on a network mount.  But again you still need
semaphores or something like them to control access to the data in
the mmap'd region.

I was thinking that maybe if Qt had a bounded buffer available for
use between a process and its child, that you could use that to run
your own "qgit-rev-list" child and get the data back more quickly,
without the need for a temporary file.  But it doesn't look like
they have one.  Oh well.


Your current temporary file approach is probably the best you can
get, and has the simplest possible implementation.  Doing better
would require linking against libgit.a, and getting the core Git
hackers to make at least the revision machinery more useful in a
library setting.

-- 

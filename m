From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 0/17] Sliding window mmap for packfiles.
Date: Sun, 24 Dec 2006 04:49:59 -0500
Message-ID: <20061224094959.GA7814@spearce.org>
References: <20061223073317.GA9837@spearce.org> <38b2ab8a0612240056k152344ael891e9b0b9f8cbc47@mail.gmail.com> <20061224090508.GF7443@spearce.org> <38b2ab8a0612240136r559376d4s14af3123f762a45d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 10:50:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyPzl-0002r2-3B
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 10:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWLXJuG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 04:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963AbWLXJuF
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 04:50:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60178 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbWLXJuE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 04:50:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GyPzU-0005er-6X; Sun, 24 Dec 2006 04:50:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2547120FB65; Sun, 24 Dec 2006 04:49:59 -0500 (EST)
To: Francis Moreau <francis.moro@gmail.com>
Content-Disposition: inline
In-Reply-To: <38b2ab8a0612240136r559376d4s14af3123f762a45d@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35352>

Francis Moreau <francis.moro@gmail.com> wrote:
> On 12/24/06, Shawn Pearce <spearce@spearce.org> wrote:
> >However with this series even a 32 bit OS which only permits
> >processes to have at most 2 GiB of address space (2 GiB split
> >between kernel space and userspace) can access packfiles up
> >to 4 GiB in size.  That seems to be the split most OSes wind
> >up using, if they didn't push it out to 3.2 GiB like Linux
> >and Solaris have done.
> >
> 
> Does it still needed for 64 bit OS ?

Not really.  Almost any reasonable 64 bit OS which is also running
a Git compiled for 64 bit userspace would be able to mmap multiple
4 GiB packfiles without this series.
 
> if not, can the overhead (if there is a significant one) implied by
> your rework be avoid for such cases ?

The overhead is rather low.  I did try hard to make it only a handful
of machine instructions worth of additional work, and even then I
tried to ammortize those over relatively large blocks of data to
reduce the impact.  But yes, there is an overhead over the current
shipping version of Git.

However at least some of the overhead can be avoided by setting
core.packedGitWindowSize and core.packedGitLimit to higher values.
This will allow the implementation to mmap() larger windows of the
packfiles and retain a greater number of windows in memory at once.

If core.packedGitWindowSize is larger than your largest packfile
then most of the code will just "shutoff" and won't get in the way.
Its default is 32 MiB (see Documentation/config.txt).

I think the additional overhead added by this series is neglible
and worth the more graceful degredation it allows when virtual
address space becomes limited.

-- 
Shawn.

From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 17:32:26 -0400
Message-ID: <20061018213225.GD19194@spearce.org>
References: <20061018053647.GA3507@coredump.intra.peff.net> <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org> <20061018185225.GU20017@pasky.or.cz> <20061018185907.GV20017@pasky.or.cz> <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610181510510.1971@xanadu.home> <20061018191834.GA18829@spearce.org> <Pine.LNX.4.64.0610181525410.1971@xanadu.home> <20061018204626.GA19194@spearce.org> <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 23:32:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJ1g-0000GW-FQ
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422992AbWJRVcd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422994AbWJRVcd
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:32:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33184 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1422992AbWJRVcc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 17:32:32 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GaJ1W-0004Sw-BM; Wed, 18 Oct 2006 17:32:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5BF3C20E42A; Wed, 18 Oct 2006 17:32:26 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29271>

Linus Torvalds <torvalds@osdl.org> wrote:
> On Wed, 18 Oct 2006, Shawn Pearce wrote:
> >
> > I guess its my turn then to work in the mmap window code, huh?  :-)
> 
> There are bigger reasons to _never_ allow packs to contain deltas to 
> outside of themselves:
> 
>  - there's no point. 
>  - it's a bad design. 

That and all of the other reasons you cited in your message are
why I haven't finished trying to use some sort of dictionary based
compression for packing objects.

On the other hand we've already seen how packs >1.5 GiB in size
(certainly well within the 4 GiB limitation in the current index
file format) cannot be repacked by git-repack-objects on a 32
bit address space as the entire pack file is mmap'd on one shot.
After the kernel space of ~1 GiB and the pack file at ~1.5 GiB
there's very little address space left for the application code.

My comment that you quoted was about mmap'ing the pack files in
large chunks (around 64-128 MiB at a time, but configurable from
.git/config) rather than as an entire massive mapping.  It had
absolutely nothing to do about changing the pack file format, the
index format, or any other on disk format.  Although it would add
a new pair of configuration options to .git/config.  Is that change
too radical?  :-)

With such a change the Git and Linux kernel repositories would both
still mmap in one chunk but much larger projects like Mozilla or
very large pack files coming out of git-fastimport would actually
be usable on 32 bit architectures without running into address space
limitations so quickly.  Git would also be slightly more usable for
some people who have a lot of very uncompressable data stored in Git.


Unless of course you are actively working on a fix for the Linux
kernel so that we can actually have all 4 GiB of virtual address
space available for the userspace git-repack-objects process.
Or have some sort of secret plan to upgrade everyone who uses Git
to 64 bit processors which support 64 bit address spaces...

-- 
Shawn.

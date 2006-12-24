From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/7] Switch git_mmap to use pread.
Date: Sun, 24 Dec 2006 15:13:04 -0500
Message-ID: <20061224201304.GA631@spearce.org>
References: <487c7d0ea81f2f82f330e277e0aea38a66ca7cfe.1166939109.git.spearce@spearce.org> <20061224054547.GB8146@spearce.org> <Pine.LNX.4.63.0612241407250.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 21:13:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyZik-0005nb-9j
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 21:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbWLXUNM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 15:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbWLXUNM
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 15:13:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54050 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbWLXUNL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 15:13:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GyZiN-000274-Cc; Sun, 24 Dec 2006 15:12:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1A2CF20FB65; Sun, 24 Dec 2006 15:13:04 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612241407250.19693@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35371>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 24 Dec 2006, Shawn O. Pearce wrote:
> > Now that Git depends on pread in index-pack its safe to say we can
> > also depend on it within the git_mmap emulation we activate when
> > NO_MMAP is set.  On most systems pread should be slightly faster
> > than an lseek/read/lseek sequence as its one system call vs. three
> > system calls.
> 
> I don't think it matters much. The _only_ platform we really use NO_MMAP 
> (other than for testing) is Windows, and AFAICT it does not have pread(), 
> so it is emulated by lseek/read/lseek anyway.
> 
> But it's a cleanup, and it deletes more lines than it adds, so Ack from 
> me.

Right - that's why I did it.  I was already in there doing other work
and discovered that we had a lot of lines just to avoid using pread.
Initially that may have been because we were trying to avoid using
it, but now that one of our more important tools (index-pack)
depends on it... ;-)

I'm actually thinking of doing a NO_PACK_MMAP, especially for systems
like Mac OS X where the mmap() of small chunks appears to perform
so poorly.  Setting NO_PACK_MMAP and just using smaller windows
(1 MiB) might be worthwhile.  Though in that case we may just want
to compile with NO_MMAP.

-- 
Shawn.

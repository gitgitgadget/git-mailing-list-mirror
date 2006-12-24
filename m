From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 11/17] Fully activate the sliding window pack access.
Date: Sat, 23 Dec 2006 21:35:30 -0500
Message-ID: <20061224023530.GC7443@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org> <20061223073428.GL9837@spearce.org> <Pine.LNX.4.64.0612231038410.3671@woody.osdl.org> <7vodpuqtuf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 03:35:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyJDI-0004H0-LJ
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 03:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbWLXCfg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 21:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753284AbWLXCfg
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 21:35:36 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48720 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbWLXCfg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 21:35:36 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GyJCT-0004wo-Ts; Sat, 23 Dec 2006 21:34:57 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 96B3C20FB65; Sat, 23 Dec 2006 21:35:30 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodpuqtuf.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35337>

Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> > Hmm. You seem to default the window size to 32MB.
> >
> > Maybe I'm reading that code wrong, but I think that's a bit sad.
> >
> > So I'd argue that if you fall back to read() (or pread) instead of mmap, 
> > the 32MB thing is way too big.
> >
> > So maybe you should make the default depend on NO_MMAP (although it would 
> > seem that the default Makefile makes Cygwin actually default to using mmap 
> > these days, so maybe it's not a big deal).
> 
> I agree that 32MB is too big for emulated mmap().

Yes, I agree too.  I'll submit some additional patches on top of
the existing 17 patch series (which I see is already in 'pu').

> We might want
> to further enhance the new use_pack() API so that the caller can
> say how much it expects to consume, to help pread() based
> emulation avoid reading unnecessary data.

I'm not sure that is worthwhile right now.

The only two callers who know how many bytes they expect is
pack-objects (during delta/whole reuse) and verify-pack (during the
SHA1 check of the packfile itself).  Both are maintenance commands
where preventing a read overshoot in the case of NO_MMAP is probably
not worthwhile, especially as both need to read every byte anyway.

-- 
Shawn.

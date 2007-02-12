From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: how to speed up "git log"?
Date: Mon, 12 Feb 2007 01:06:41 -0500
Message-ID: <20070212060641.GC699@spearce.org>
References: <200702111252.28393.bruno@clisp.org> <Pine.LNX.4.63.0702111745170.22628@wbgn013.biozentrum.uni-wuerzburg.de> <200702120041.27419.bruno@clisp.org> <200702120059.17676.robin.rosenberg.lists@dewire.com> <7vmz3kaugq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Bruno Haible <bruno@clisp.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 07:07:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGUL6-0005Ua-RU
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 07:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933014AbXBLGGz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 01:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933018AbXBLGGy
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 01:06:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35330 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933014AbXBLGGy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 01:06:54 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGUKq-0003M2-G8; Mon, 12 Feb 2007 01:06:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 59EBE20FBAE; Mon, 12 Feb 2007 01:06:41 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vmz3kaugq.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39372>

Junio C Hamano <junkio@cox.net> wrote:
> I doubt it -- sliding mmap() in the current git, while is a good
> change overall for handling really huge repos, would most likely
> perform poorer than the fixed mmap() in 1.4.4 series on
> platforms with slow mmap(), most notably on MacOS X.
> 
> It _might_ be possible that turning some sliding mmap() calls
> into pread() makes it perform better on MacOS X.
> 
> I wonder what happens it git is compiled with NO_MMAP there...

So I ran three trials, v1.5.0-rc4-26-gcc46a74 with and without
NO_MMAP against v1.4.4.4 on a freshly repacked git.git.

v150-mmap:
        3.33 real         3.12 user         0.05 sys
        3.32 real         3.12 user         0.05 sys
        3.34 real         3.12 user         0.05 sys

v150-nommap:
        3.46 real         3.13 user         0.16 sys
        3.43 real         3.13 user         0.16 sys
        3.46 real         3.13 user         0.16 sys

v1444-mmap:
        3.30 real         3.09 user         0.05 sys
        3.30 real         3.09 user         0.05 sys
        3.25 real         3.09 user         0.04 sys

CFLAGS="-O2"; the above timings are three representative samples
out of 10 runs each, all hot cache.

Clearly the sliding mmap window isn't hurting us in this case by
very much, and NO_MMAP really isn't helping matters at all.

-- 
Shawn.

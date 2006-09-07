From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 3/5] autoconf: Preliminary check for working mmap
Date: Thu, 7 Sep 2006 01:58:04 -0400
Message-ID: <20060907055803.GE31580@spearce.org>
References: <200609050054.24279.jnareb@gmail.com> <200609050056.52590.jnareb@gmail.com> <7vy7szjjal.fsf@assigned-by-dhcp.cox.net> <edidlp$d3d$1@sea.gmane.org> <20060905030929.GA29865@spearce.org> <7vu03mkiei.fsf@assigned-by-dhcp.cox.net> <20060905062531.GA30496@spearce.org> <7v1wqqkbbv.fsf@assigned-by-dhcp.cox.net> <20060906034054.GB30598@spearce.org> <7vodtt8l6v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 09:14:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLE5i-0003h6-Is
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 09:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWIGHOW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 03:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWIGHOW
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 03:14:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59863 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750749AbWIGHOV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 03:14:21 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GLE5Y-0004s9-I3; Thu, 07 Sep 2006 03:14:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B2E97212695; Thu,  7 Sep 2006 01:58:04 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodtt8l6v.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26607>

Junio C Hamano <junkio@cox.net> wrote:
> Well, if you are talking about git.git t/ directory, I bet that
> "the full test suite" easily fits in a single window so much of
> the new code is not exercised, unless you have a runtime option
> to make use of very tiny window (32kB would be nice) for testing
> ;-).

Heh.  t/ passed which meant basic rev listing and verify-pack
appeared OK.  I hardcoded the window size to be 2*getpagesize() (8192
bytes on my Mac OS X system) and started beating up Git against its
own 8 MiB pack.  The window code opened a ton of windows at once as
the PACK_MAX_SZ was 128 MiB.  So I hardcoded that to be 16384 bytes.
And the code worked right against the 8 MiB Git pack by opening
only 4 windows at once and closing the least-recently-used one.

I can easily parameterize both values in .git/config; there's no
real reason for them to be hardcoded.  That should make it easier
to craft some new test cases that push the windowing code.

> > I am going to rebase the changes to the 64 bit index in `pu`
> > and clean up my history.  Its currently one massive commit with
> > lots of changes that should be broken down into slightly more
> > digestable chunks.
> 
> Breaking things up would be nice.  Do you have a good testcase
> out of Mozilla repository that _needs_ 64-bit index?  The code
> in "pu" uses 64-bit index only 32-bit offset cannot describe the
> pack, so I only tested with an artificial case with the kernel
> archive with .idx converted with convert-idx to 64-bit.
> 

Not really.  We know the Mozilla pack decompressed is around 20 GiB.
I could decompress it and repack it using no deltas; that should
exceed 4 GiB.  It will take quite some time to run the decompression
and delta inflates, especially with the highly-compressed 450 MiB
pack Jon Smirl sent me.  I can do that kind of testing maybe later
next week after I get my new amd64 system built.

-- 
Shawn.

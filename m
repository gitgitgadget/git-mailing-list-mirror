From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 17:52:19 -0400
Message-ID: <20061018215219.GG19194@spearce.org>
References: <20061018185225.GU20017@pasky.or.cz> <20061018185907.GV20017@pasky.or.cz> <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610181510510.1971@xanadu.home> <20061018191834.GA18829@spearce.org> <Pine.LNX.4.64.0610181525410.1971@xanadu.home> <20061018204626.GA19194@spearce.org> <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org> <20061018213225.GD19194@spearce.org> <7vlkndz4fr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 23:52:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJKt-0004Gu-Uq
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 23:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423021AbWJRVwY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 17:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423020AbWJRVwY
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 17:52:24 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:8868 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1423021AbWJRVwX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 17:52:23 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GaJKl-0005y5-Ud; Wed, 18 Oct 2006 17:52:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3711320E42A; Wed, 18 Oct 2006 17:52:20 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkndz4fr.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29281>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > ...  Although it would add
> > a new pair of configuration options to .git/config.  Is that change
> > too radical?  :-)
> 
> I wonder what you would need the configuration options for.
> 
> If mmap() pack works well, it works well, and if it is broken
> nobody has reason to enable it.  The code should be able to
> adjust the mmap window to appropriate size itself and its
> automatic adjustment does not even have to be the absolute
> optimum (since the user would not know what the optimum would be
> anyway), so maybe your configuration options would not be
> "enable" nor "window-size" -- and I am puzzled as to what they

All very true.

However what do we do about the case where we mmap over 1 GiB worth
of pack data (because the mmap succeeds and we have at least that
much in .pack and .idx files) and then the application starts to
demand a lot of memory via malloc?  At some point malloc will return
NULL, xmalloc will die(), and that's the end of the program.

If the user was able to set the maximum threshold of how much data
we mmap then they could initially prevent us from mmap'ing over 1 GiB;
instead using a smaller upper limit like 512 MiB.

Of course as I write this I think the better solution to this
problem is to simply modify xmalloc (and friends) so that if the
underlying malloc returned NULL and we have a large amount of stuff
mmap'd from packs we try releasing some of the unused pack windows
and retry the malloc before die()'ing.


The other configuration option is the size of the mmap window.
This should by default be at least 32 MiB, probably closer to
128 MiB.  But its nice to be able to force it as low as a single
system page to setup test cases in the t/ directory for the mmap
window code.

Earlier this summer we discussed this exact issue and said this
value probably needs to be configurable if only to facilitate the
unit tests.

-- 
Shawn.

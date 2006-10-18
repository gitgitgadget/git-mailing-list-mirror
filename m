From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 18:11:10 -0400
Message-ID: <20061018221110.GI19194@spearce.org>
References: <20061018185225.GU20017@pasky.or.cz> <20061018185907.GV20017@pasky.or.cz> <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610181510510.1971@xanadu.home> <20061018191834.GA18829@spearce.org> <Pine.LNX.4.64.0610181525410.1971@xanadu.home> <20061018204626.GA19194@spearce.org> <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org> <20061018214143.GF19194@spearce.org> <Pine.LNX.4.64.0610181455570.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 00:11:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJdC-0007rT-2P
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 00:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423065AbWJRWLS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 18:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbWJRWLS
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 18:11:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53926 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751408AbWJRWLR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 18:11:17 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GaJd0-00081L-Fc; Wed, 18 Oct 2006 18:11:10 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0668720E42A; Wed, 18 Oct 2006 18:11:11 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610181455570.3962@g5.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29290>

Linus Torvalds <torvalds@osdl.org> wrote:
> On Wed, 18 Oct 2006, Shawn Pearce wrote:
> > 
> > Actually there is a point to storing thin packs.  When I pull from
> > a remote repo (or push to a remote repo) a huge number of objects
> > and the target disk that is about to receive that huge number of
> > loose objects is slooooooooow I would rather just store the thin
> > pack then store the loose objects.
> > 
> > Ideally that thin pack would be repacked (along with the other
> > existing packs) as quickly as possible into a self-contained pack.
> > But that of course is unlikely to happen in practice; especially
> > on a push.
> 
> I'm really nervous about keeping thin packs around. 
> 
> But a possibly good (and fairly simple) alternative would be to just 
> create a non-thin pack on the receiving side. Right now we unpack into a 
> lot of loose objects, but it should be possible to instead "unpack" into a 
> non-thin pack.
> 
> In other words, we could easily still use the thin pack for communication, 
> we'd just "fill it out" on the receiving side.

Funny, I had the same thought.  :-)

We already know how many objects are coming in on a thin pack;
its right there in the header.  We could just have some threshold
at which we start writing a full pack rather than unpacking.

Writing such a full pack would be a simple matter of copying the
input stream out to a temporary pack, but sticking any delta bases
into a table in memory.  At the end of the data stream if we have any
delta bases which weren't actually in that pack then find them and
copy them onto the end, update the header and recompute the checksum.
git-fastimport does some of that already, though its trivial code...

Worst case scenario would be the incoming thin pack is 100% deltas
as we would need to copy in a base object for every object mentioned
in the pack.

-- 
Shawn.

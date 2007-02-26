From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH] commit-tree: bump MAX_PARENTS to 128
Date: Mon, 26 Feb 2007 09:31:42 -0500
Message-ID: <20070226143142.GA1390@spearce.org>
References: <20070226121557.GA18114@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 15:31:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLgtS-0008Hv-44
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 15:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbXBZObt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 09:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbXBZObt
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 09:31:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35296 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030269AbXBZObs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 09:31:48 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HLgtB-0006k5-IE; Mon, 26 Feb 2007 09:31:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D96F920FBAE; Mon, 26 Feb 2007 09:31:42 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070226121557.GA18114@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40623>

Jeff King <peff@peff.net> wrote:
> This limit doesn't seem to come into effect anywhere else; it's simply
> an arbitrary limit to make memory allocation easier. It's used to
> declare a single static array of 20-byte hashes, so this increase wastes
> about 2K.

I don't really see a problem with this, however:

The pack v4 code that Nico and I are working on was planning on
taking a very useful optimization for any commit with less than 64
parents (or maybe 128, I'd have to go back to look at my notes).
We would fall back to a less optimal storage for these large
octopus commits.  Of course the fallback strategy (which is really
just the current OBJ_COMMIT packing) is still more space efficient
than making multiple commits to express the octopus, so pushing
this limit up higher would save space better.  Oh, and these types
of octopus merges aren't very frequent either.  ;-)

git-bisect can bisect these large octopuses, but it needs to search
every parent commit in the merge.  It cannot perform a binary search
through them.  Getting massive octopuses makes it harder for the
user to bisect.


I'm thinking maybe this should just change to a dynamic allocation
and let the caller feed however many parents they want.  Most people
don't make an octopus very often, and when they do they really mean
to do it, such as the case you just described.

Unless Dscho/Nico/Junio/Linus/etc. know of some other limitation
lurking within Git.  My recollection is that only git-commit-tree
and git-gui knew about this 16 parent limit.  And the latter only
knows about the limit so that can prevent the user from doing an
octopus merge that overflowed git-commit-tree's limit.  Be nice if
git-gui has no limit.  ;-)

-- 
Shawn.

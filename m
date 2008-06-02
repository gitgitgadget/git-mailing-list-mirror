From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Adding a cache of commit to patch-id pairs to speed up git-cherry
Date: Mon, 2 Jun 2008 11:56:44 -0400
Message-ID: <20080602155644.GL12896@spearce.org>
References: <7f9d599f0806012054y33b4fc10ha109aa4afbc7ca78@mail.gmail.com> <alpine.DEB.1.00.0806020649110.13507@racer.site.net> <20080602064218.GA15144@sigill.intra.peff.net> <7f9d599f0806020735g30722893mb8efed41a6544ab5@mail.gmail.com> <alpine.DEB.1.00.0806021635220.13507@racer.site.net> <7f9d599f0806020849g567461b2kecd65dbd35d3dc3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Mon Jun 02 17:58:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3CPz-0001tX-AV
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 17:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045AbYFBP47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 11:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753329AbYFBP46
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 11:56:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46322 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbYFBP46 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 11:56:58 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K3COm-0005lo-CM; Mon, 02 Jun 2008 11:56:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A770620FBAE; Mon,  2 Jun 2008 11:56:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7f9d599f0806020849g567461b2kecd65dbd35d3dc3b@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83538>

Geoffrey Irving <irving@naml.us> wrote:
> On Mon, Jun 2, 2008 at 8:37 AM, Johannes Schindelin
> > Another issue that just hit me: this cache is append-only, so if it grows
> > too large, you have no other option than to scratch and recreate it.
> > Maybe this needs porcelain support, too?  (git gc?)
> 
> If so, the correct operation is to go through the hash and remove
> entries that refer to commits that no longer exist.  I can add this if
> you want.  Hopefully somewhere along the way git-gc constructs an easy
> to traverse list of extant commits, and this will be straightforward.

git-gc doesn't make such a list.  Down deep with git-pack-objects
(which is called by git-repack, which is called by git-gc) yes,
we do make the list of commits that we can find as reachable, and
thus should stay in the repository.  But that is really low-level
plumbing.  Wedging a SHA1->SHA1 hashmap gc task down into that is
not a good idea.

Instead you'll need to implement something that does `git rev-list
--all -g` (or the internal equivilant) and then remove any entries
in your hashmap that aren't in that result set.  That's not going
to be very cheap.

Given how small entries are (what, 40 bytes?) I'd only want to bother
with that collection process if the estimated potential wasted space
was over 1M (26,000 entries) or some reasonable threshold like that.

E.g. we could just set the GC for this to be once every 26,000
additions, and only during git-gc.  Yea, you might waste about 1M
worth of space before we clean up.  Big deal, I'll bet you have
more than that in loose unreachable objects laying around from
git-rebase -i usage.  ;-)

-- 
Shawn.

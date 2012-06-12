From: Jeff King <peff@peff.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Tue, 12 Jun 2012 13:54:38 -0400
Message-ID: <20120612175438.GB16522@sigill.intra.peff.net>
References: <20120611183414.GD20134@sigill.intra.peff.net>
 <20120611211401.GA21775@thunk.org>
 <20120611213948.GB32061@sigill.intra.peff.net>
 <20120611221439.GE21775@thunk.org>
 <20120611222308.GA10476@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206112024110.23555@xanadu.home>
 <20120612171048.GB12706@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121326490.23555@xanadu.home>
 <20120612173214.GA16014@sigill.intra.peff.net>
 <alpine.LFD.2.02.1206121345500.23555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ted Ts'o <tytso@mit.edu>, Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 19:54:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeVIj-0006Dw-6P
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 19:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539Ab2FLRyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 13:54:41 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:51218
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752644Ab2FLRyk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 13:54:40 -0400
Received: (qmail 23205 invoked by uid 107); 12 Jun 2012 17:54:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jun 2012 13:54:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jun 2012 13:54:38 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1206121345500.23555@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199821>

On Tue, Jun 12, 2012 at 01:49:26PM -0400, Nicolas Pitre wrote:

> > Then those objects will remain in the cruft pack. Which is why, as I
> > said, it is not generally safe to just delete a cruft pack.
> 
> ... and my reply was about the needed changes to still make cruft packs 
> always crufty even if some of its content suddenly becomes useful again.

I think we are somehow missing each other's point, then. My point is
that you do not _need_ to make the cruft packs 100% cruft. You can
tolerate the duplicated objects until they are pruned.

Earlier in the thread, I outlined another scheme by which you could
repack and avoid the duplicates. It does not require changes to git's
object lookup process, because it would involve manually feeding the
list of cruft objects to pack-objects (which will pack what you ask it,
regardless of whether the objects are in other packs).

> > However, when you do a full repack, those objects will be copied into 
> > the new pack (because they are referenced). Which is why I am claiming 
> > that it is safe to remove cruft packs at that point.
> 
> Yes, but then there is no point marking such packs as cruft if at any 
> moment they can become useful again.

How do you know to keep the packs around and expire them after 2 weeks
if they are not marked in some way? Otherwise you would delete them as
part of a "git gc", pushing the reachable objects into the new pack and
the unreachable objects into a new cruft pack. IOW, you need some way of
keeping the expiration date on the unreachable objects, or they will
keep getting "refreshed" by each gc.

-Peff

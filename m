From: Jeff King <peff@peff.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Mon, 11 Jun 2012 18:35:46 -0400
Message-ID: <20120611223546.GA10619@sigill.intra.peff.net>
References: <87vcixaoxe.fsf@thomas.inf.ethz.ch>
 <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
 <20120611172732.GB16086@thunk.org>
 <20120611183414.GD20134@sigill.intra.peff.net>
 <20120611211401.GA21775@thunk.org>
 <20120611213948.GB32061@sigill.intra.peff.net>
 <20120611221439.GE21775@thunk.org>
 <20120611222308.GA10476@sigill.intra.peff.net>
 <20120611222843.GF21775@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 12 00:36:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeDDP-0006Rp-9d
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 00:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139Ab2FKWfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 18:35:50 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:50484
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321Ab2FKWft (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 18:35:49 -0400
Received: (qmail 11439 invoked by uid 107); 11 Jun 2012 22:35:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jun 2012 18:35:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2012 18:35:46 -0400
Content-Disposition: inline
In-Reply-To: <20120611222843.GF21775@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199748>

On Mon, Jun 11, 2012 at 06:28:43PM -0400, Ted Ts'o wrote:

> On Mon, Jun 11, 2012 at 06:23:08PM -0400, Jeff King wrote:
> > 
> > I'm more specifically worried about large objects which are no better in
> > packs than they are in loose form (e.g., video files). This strategy is
> > a regression, since we are not saving space by putting them in a pack,
> > but we are keeping them around much longer. It also makes it harder to
> > just run "git prune" to get rid of large objects (since prune will never
> > kill off a pack), or to manually delete files from the object database.
> > You have to run "git gc --prune=now" instead, so it can make a new pack
> > and throw away the old bits (or run "git repack -ad").
> 
> If we're really worried about this, we could set a threshold and only
> pack small objects in the cruft packs.

I think I'd be more inclined to just ignore it. It is only prolonging
the lifetime of the files by a finite amount (and we are discussing
dropping that finite amount anyway). And as a bonus, this strategy could
potentially allow an optimization that would make large files better in
this case: if we notice that a pack has _only_ unreachable objects, we
can simply mark it as ".cruft" without actually repacking it. Coupled
with the recent-ish code to stream large blobs directly to packs, that
means a large blob which becomes unreachable would not ever be
rewritten.

> > No! That's exactly what I was worried about with the name. It is _not_
> > safe to do so. It's only safe after you have done a full repack to
> > rescue any non-cruft objects.
> 
> Well, yes.  I was thinking it would be safe thing to do after a "git
> gc" didn't result in enough space savings.  This would require that a
> git repack always rescue objects from cruft packs even if the -a/-A
> options are not specified, but since we're doing a full reachability
> scan, that should slow down git gc much, right?

Doing "git gc" will always repack everything, IIRC. It is "git gc
--auto" which will make small incremental packs. I think we do a full
reachability analysis so we can prune there, but that is something I
think we should stop doing. It is typically orders of magnitude slower
than the incremental repack.

-Peff

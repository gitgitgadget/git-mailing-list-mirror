From: Jeff King <peff@peff.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Mon, 11 Jun 2012 18:23:08 -0400
Message-ID: <20120611222308.GA10476@sigill.intra.peff.net>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
 <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch>
 <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
 <20120611172732.GB16086@thunk.org>
 <20120611183414.GD20134@sigill.intra.peff.net>
 <20120611211401.GA21775@thunk.org>
 <20120611213948.GB32061@sigill.intra.peff.net>
 <20120611221439.GE21775@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 12 00:23:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeD12-0005Mh-Ak
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 00:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517Ab2FKWXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 18:23:12 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:50467
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381Ab2FKWXL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 18:23:11 -0400
Received: (qmail 11137 invoked by uid 107); 11 Jun 2012 22:23:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jun 2012 18:23:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2012 18:23:08 -0400
Content-Disposition: inline
In-Reply-To: <20120611221439.GE21775@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199746>

On Mon, Jun 11, 2012 at 06:14:39PM -0400, Ted Ts'o wrote:

> > Speaking of which, what is the mtime of the newly created cruft pack? Is
> > it the current mtime? Then those unreachable objects will stick for
> > another 2 weeks, instead of being back-dated to their pack's date. You
> > could back-date to the mtime of the most recent deleted pack, but that
> > would still prolong the life of objects from the older packs. It may be
> > acceptable to just ignore the issue, though; they will expire
> > eventually.
> 
> Well, we have that problem today when "git pack-objects
> --unpack-unreachable" explodes unreferenced objects --- they are
> written with the current mtime.

No, we don't; they get the mtime of the pack they are coming from (and
if the pack is older than pruneExpire, they are not exploded at all,
since they would just be pruned immediately anyway).

So an exploded object might have only a day or an hour to live after the
explosion, but with your strategy they always get two weeks.

> I assume you're worried about pre-existing loose objects that get
> collected up into a new cruft pack, since they would get the extra two
> weeks of life.  Given how much more efficient storing the cruft
> objects in a pack, I think ignoring the issue is what makes the most
> amount of sense, since it's a one-time extension, and the extra
> objects really won't do any harm.

I'm more specifically worried about large objects which are no better in
packs than they are in loose form (e.g., video files). This strategy is
a regression, since we are not saving space by putting them in a pack,
but we are keeping them around much longer. It also makes it harder to
just run "git prune" to get rid of large objects (since prune will never
kill off a pack), or to manually delete files from the object database.
You have to run "git gc --prune=now" instead, so it can make a new pack
and throw away the old bits (or run "git repack -ad").

> One last thought: if a sysadmin is really hard up for space, (and if
> the cruft objects include some really big sound or video files) one
> advantage of labelling the cruft packs explicitly is that someone who
> really needs the space could potentially find the oldest cruft files
> and delete them, since they would be tagged for easy findability.

No! That's exactly what I was worried about with the name. It is _not_
safe to do so. It's only safe after you have done a full repack to
rescue any non-cruft objects.

-Peff

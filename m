From: Jeff King <peff@peff.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Mon, 11 Jun 2012 14:34:14 -0400
Message-ID: <20120611183414.GD20134@sigill.intra.peff.net>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
 <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch>
 <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
 <20120611172732.GB16086@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 11 20:34:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9RW-0001LA-Bm
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 20:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031Ab2FKSeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 14:34:18 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:50228
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755Ab2FKSeR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 14:34:17 -0400
Received: (qmail 6954 invoked by uid 107); 11 Jun 2012 18:34:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jun 2012 14:34:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2012 14:34:14 -0400
Content-Disposition: inline
In-Reply-To: <20120611172732.GB16086@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199692>

On Mon, Jun 11, 2012 at 01:27:32PM -0400, Ted Ts'o wrote:

> The 4.5 megabytes of loose objects packed down to a 224k "cruft" repo,
> and 768k worth of private development objects.
> 
> So depending on how you would want to do the comparison, probably the
> fairest thing to say is that I had a total "good" packs totally about
> 16 megs, and the loose cruft objects was an additional 4.5 megabytes.

OK, so that 4.5 is at least a respectable percentage of the total repo
size. I suspect it may be worse for small repos in that sense, because
the 4.5 megabytes is not "how big is this repo" but probably "how much
work did you do in this repo in the last 2 weeks". Which should be a
constant with respect to the total size of the repo.

However, for a very busy repo (e.g., one used for automated integration
testing or similar), the "how much work" number could be quite high.

We ran into this at github due to our "merge this" button, which does
test-merges to see if a pull request can be merged cleanly. Whenever the
upstream branch is updated, all of the outstanding pull requests get
re-tested, and the old test-merge objects become unreferenced.  We ended
up dropping pruneExpire to 1 day to keep the cruft to a minimum.

> >   1. You run "git repack -Ad". It makes A.pack, with stuff you want,
> >   and B.pack, with unreachable junk. They both get a timestamp of
> >   "now".
> > 
> >   2. A day passes. You run "git repack -Ad" again. It makes C.pack,
> >   the new stuff you want, and repacks all of B.pack along with the
> >   new expired cruft from A.pack, making D.pack. B.pack can go away.
> >   D.pack gets a timestamp of "now".
> 
> Hmm, yes.  What we'd really want to do is to make D.pack contain those
> items that were are newly unreachable, not including the objects in
> B.pack, and keep B.pack around until the expiry window goes by.  But
> that's a much more complicated thing, and the proof-of-concept
> algorithm I had outlined wouldn't do that.

Right. When dumping the list of unreachable objects from pack-objects,
you'd want to tell it to ignore objects from any pack that contained
only unreachable objects in the first place.

Except that is perhaps not quite right, either. Because if a pack has
100 objects, but you happen to re-reference 1 of them, you'd probably
want to leave it (even though that re-referenced one is now duplicated,
the savings aren't worth the trouble of repacking the cruft objects).
Of course, what is the N that makes it worth the trouble? Now you're
getting into heuristics.

You _could_ make a separate cruft pack for each pack that you repack. So
if I have A.pack and B.pack, I'd pack all of the reachable objects into
C.pack, and then make D.pack containing the unreachable objects from
A.pack, and E.pack with the unreachable objects from B.pack. And then
set the mtime of the cruft packs to that of their parent packs.

And then the next time you pack, repacking D and E would probably be a
no-op that preserves mtime, but might create a new pack that ejects some
now-reachable object.

To implement that, I think your --list-unreachable would just have to
print a list of "<pack-mtime> <sha1>" pairs, and then you would pack
each set with an identical mtime (or even a "close enough" mtime within
some slop).

But yet, this is all getting complicated. :)

> > I think solving it for good would involve a separate list of
> > per-object expiration dates. Obviously we get that easily with loose
> > objects (since it is one object per file).
> 
> Well, either that or we need to teach git-repack the difference
> between packs that are expected to contain good stuff, and packs that
> contain cruft, and to not copy "old cruft" to new packs, so the old
> pack can finally get nuked 2 weeks (or whatever the expire window
> might happen to be) later.

That is harder because those objects may become re-reachable during that
window. So I think you don't want to deal with "expected to contain..."
but rather "what does it contain now?". The latter is easy to figure out
by doing a reachability analysis (which we do as part of the repack
anyway).

-Peff

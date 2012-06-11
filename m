From: Jeff King <peff@peff.net>
Subject: Re: Keeping unreachable objects in a separate pack instead of loose?
Date: Mon, 11 Jun 2012 17:39:48 -0400
Message-ID: <20120611213948.GB32061@sigill.intra.peff.net>
References: <E1SdhJ9-0006B1-6p@tytso-glaptop.cam.corp.google.com>
 <bb7062f387c9348f702acb53803589f1.squirrel@webmail.uio.no>
 <87vcixaoxe.fsf@thomas.inf.ethz.ch>
 <20120611153103.GA16086@thunk.org>
 <20120611160824.GB12773@sigill.intra.peff.net>
 <20120611172732.GB16086@thunk.org>
 <20120611183414.GD20134@sigill.intra.peff.net>
 <20120611211401.GA21775@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 11 23:40:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeCLD-0001Re-00
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 23:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab2FKVjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 17:39:52 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:50418
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840Ab2FKVjv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 17:39:51 -0400
Received: (qmail 10302 invoked by uid 107); 11 Jun 2012 21:39:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jun 2012 17:39:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2012 17:39:48 -0400
Content-Disposition: inline
In-Reply-To: <20120611211401.GA21775@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199736>

On Mon, Jun 11, 2012 at 05:14:01PM -0400, Ted Ts'o wrote:

> On Mon, Jun 11, 2012 at 02:34:14PM -0400, Jeff King wrote:
> > You _could_ make a separate cruft pack for each pack that you repack. So
> > if I have A.pack and B.pack, I'd pack all of the reachable objects into
> > C.pack, and then make D.pack containing the unreachable objects from
> > A.pack, and E.pack with the unreachable objects from B.pack. And then
> > set the mtime of the cruft packs to that of their parent packs.
> > 
> > And then the next time you pack, repacking D and E would probably be a
> > no-op that preserves mtime, but might create a new pack that ejects some
> > now-reachable object.
> > 
> > To implement that, I think your --list-unreachable would just have to
> > print a list of "<pack-mtime> <sha1>" pairs, and then you would pack
> > each set with an identical mtime (or even a "close enough" mtime within
> > some slop)....
> 
> How about this instead?  We distinguish between cruft packs and "real"
> packs by the filename.  So we have "cruft-<SHA1>.{idx,pack}" and
> "pack-<SHA1>.{idx.pack}".
> 
> Normally, git will look at any pack in the pack directory that has an
> .idx and .pack extension, but during repack operation, it will by only
> look in the pack-* packs first.  If it can't find an object there, it
> will then fall back to trying to fetch the object from the cruft-*
> packs, and if it finds the object, it copies it into the new pack
> which is creating, thus "rescueing" an object which reappears during
> the expiry window.  This should be a relatively rare event, and if it
> happens, the object will be in two packs, a pack-* pack and a cruft-*
> pack, but that's OK.

You don't need to do anything magical for the object lookup process of
pack-objects. By definition, the unreachable objects will not be
included in the new pack you are creating, because it is only packing
reachable things. So the cruft pack does not have to be a fallback at
all; it is a regular pack from the object lookup perspective.

The important differences from the current behavior would be:

  1. In pack-objects, do not explode (or if just listing, do not list)
     objects from cruft packs.

  2. In repack, make a new pack from the list of unreachable objects.

  3. During "repack -Ad", prune cruft packs only if they are older than
     an expiration date.

And then you'd end up with a new cruft pack each time. You could just
mark it with a ".cruft" file (similar to the existing ".keep" files),
and you don't have to worry about changing the pack-* name.

> So since git pack-objects isn't even looking in the cruft-* packs
> except when it needs to rescue an object, the objects in the cruft-*
> packs won't get copied, and we won't need to have per-object mtimes.
> It also means it will go faster since it's not copying the cruft-*
> packs at all, and possibly not even looking at them.

Yeah. It doesn't eliminate duplicates, but that may not be worth caring
about. I find the "cruft" marking a little hacky, because it is only
"objects in here _may_ be cruft", but as long as that is understood, it
is OK (and it is understood in the sequence above; "repack -Ad" is safe
because it knows that it would have repacked any non-cruft).

You would have to be careful with "repack -d" (without the "-a"). It
would not be necessarily be safe to remove cruft packs, because you
might not have rescued the objects. However, AFAICT "repack -d" does not
currently delete packs at all, so this would be no different.

> It does imply that we may accumulate a new cruft-<SHA1> pack each time
> we run git gc, but users shouldn't be running git gc all that often
> anyway.  And even if they do run it all the time, it will still be
> more efficient than keeping the unreachable objects as loose objects.

Yeah, it would be nice to keep it all in a single pack, but that means
doing the I/O on rewriting the cruft packs each time. And figuring out
some way of handling the mtime in such a way that we don't keep
refreshing the age during each gc.

Speaking of which, what is the mtime of the newly created cruft pack? Is
it the current mtime? Then those unreachable objects will stick for
another 2 weeks, instead of being back-dated to their pack's date. You
could back-date to the mtime of the most recent deleted pack, but that
would still prolong the life of objects from the older packs. It may be
acceptable to just ignore the issue, though; they will expire
eventually.

-Peff

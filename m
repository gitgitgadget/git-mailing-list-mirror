From: Jeff King <peff@peff.net>
Subject: Re: generation numbers
Date: Fri, 8 Jul 2011 18:57:25 -0400
Message-ID: <20110708225725.GA16047@sigill.intra.peff.net>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com>
 <20110706150103.GA2693@thunk.org>
 <20110706181200.GD17978@sigill.intra.peff.net>
 <201107062046.43820.jnareb@gmail.com>
 <20110707185908.GB12044@sigill.intra.peff.net>
 <7vliw9hoky.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 09 00:57:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QfJzK-0001Mm-UO
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jul 2011 00:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527Ab1GHW53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jul 2011 18:57:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58402
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512Ab1GHW52 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2011 18:57:28 -0400
Received: (qmail 11375 invoked by uid 107); 8 Jul 2011 22:57:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Jul 2011 18:57:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2011 18:57:25 -0400
Content-Disposition: inline
In-Reply-To: <7vliw9hoky.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176807>

On Thu, Jul 07, 2011 at 12:34:37PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > You could "cheat" and instead of storing the sha1 of a blob object in
> > the notes tree, use the lower 32 bits to store an actual value. I don't
> > think that currently breaks any assumptions in the notes code, but it
> > definitely is against the intent of it.
> 
> I highly suspect that it would break fsck rather badly.  You may not even
> be able to repack a repository with such a notes tree.

True. I think you would have to do the file-mode hack that Jakub
suggested. But that's getting pretty gross. If something isn't big
enough to be in a blob, and especially if we are just caching, it would
be nice to have some lighter-weight caching mechanism.

> > For a local lookup cache, I would use a fixed-size binary integer just
> > to keep the lookup data structure simple (then you know the width of
> > each record ahead of time). For a generation commit header, obviously we
> > would go with the ascii representation as we do for other headers.

So I implemented something like this today. In fact, it's a generic[1]
fast persistent object-data mapping for data of a fixed size. The
on-disk representation is a stream of pairs: binary sha1s followed by
their fixed-size data. Lookup is by binary search (using sha1_entry_pos,
which makes this more or less the same as pack-index lookups).

There's a separate in-memory lookaside table that receives updates.
These are stored as a hash[2] because except for the first run, this
will typically be much smaller than the disk version, and we care more
about insertion speed here. When git exits, the memory and disk versions
are merged into a new cache which atomically replaces the old version
via rename().

Here are the timings I came up with using it on top of my depth-first
contains algorithm.  All runs are for "git tag --contains HEAD~1000" in
the linux-2.6 repo. All times are best-of-five unless otherwise noted.

To get a baseline, I measured the algorithm with no cutoff at all (i.e.,
ffc4b80 in pu), and then with a cutoff based on timestamp with one day
of slop (i.e., de9f14e in pu):

  none:
    real    0m3.139s
    user    0m3.044s
    sys     0m0.092s

  timestamp:
    real    0m0.027s
    user    0m0.024s
    sys     0m0.000s

We can use the "timestamp" value as our goal; it's fast, but not
necessarily correct in the face of skew (and it's about as fast as we
would expect a generation header inside the commit to perform). We can
use "none" as a lower goalpost. It's correct, but slow. If we're slower
than it, then we have totally failed.

Then I tried doing a generation-based cutoff, caching the generations
via notes-cache. Here are those timings:

  notes (1st run):
    real    0m14.153s
    user    0m7.868s
    sys     0m5.392s

  notes (before repack):
    real    0m0.102s
    user    0m0.076s
    sys     0m0.024s

  notes (after repack):
    real    0m0.090s
    user    0m0.072s
    sys     0m0.016s

It's pretty painful to actually generate the cache, mostly because we
end up writing a ton of tree and blob objects. The objects directory
balloons from 503M to 1.1G after that run. Repacking brings that down to
a mere 524M, or 21M spent on the cache.  Not shown in these timings is
the painfully slow "git gc" it took to get there.

So there's a nice speedup over the no-cutoff case, but we're still 3
times as slow as the timestamp case. And the sheer amount of object
cruft (both in terms of wasted space, and wasted time writing and
repacking) is ugly.

Next up is the custom object-cache code:

  custom (1st run):
    real    0m3.769s
    user    0m3.404s
    sys     0m0.360s

  custom:
    real    0m0.035s
    user    0m0.028s
    sys     0m0.004s

You can see that the first run is a bit slower, as we have to touch
every commit to figure out the generations. But it also highlights how
much of the notes-cache version is spent not actually figuring out the
generations, but rather just writing the notes tree.

Subsequent runs are pretty darn fast. It's a tiny bit slower than using
the timestamps, but it's within the noise. The resulting cache file is
5.9M.

So it seems like a good direction to pursue. The only downside I see is
that we may be slower operating in a read-only repository in which
nobody has generated any cache yet. But that seems like a bit of a crazy
case, and even then, it's on par with the no-cutoff-at-all case, so it's
really not that bad. And it's guaranteed to be correct in the face of
skew, as opposed to the fast timestamp case.

-Peff

[1] I intentionally wrote the object caching code in a very generic,
    data-agnostic way. I have a patch series to speed up git-cherry by
    caching patch-ids of commits against their parents. It uses
    notes-cache and already provides some speedup, but I'd like to see
    if I can make it faster with the new code.

[2] Instead of writing my own hash, I hacked decorate.[ch] to have
    "value" semantics. I.e., you can now store values of arbitrary size.
    The existing semantics of storing a "void *" are easy to do on top
    of that. I noticed that fast-export is already encoding uint32_t's
    inside the pointers. This makes that a little more supported, and
    also means that the same hack will work for data larger than a void
    pointer (e.g., patch-id caching will need 20 bytes).

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Fri, 9 Aug 2013 18:16:15 -0400
Message-ID: <20130809221615.GA7160@sigill.intra.peff.net>
References: <7v61vihg6k.fsf@alter.siamese.dyndns.org>
 <CALkWK0kmx8bi1ZT1CSk+iVnmmQJV4bNu1D7h1AHnRk7_TfhJ3Q@mail.gmail.com>
 <7va9ksbqpl.fsf@alter.siamese.dyndns.org>
 <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
 <7v61vgazp5.fsf@alter.siamese.dyndns.org>
 <CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
 <7vwqnw7z47.fsf@alter.siamese.dyndns.org>
 <CALkWK0=nerszb3_YA8P=qXbfAd4Y1rNsHXhfVKzwtj-x80iqkg@mail.gmail.com>
 <20130809110000.GD18878@sigill.intra.peff.net>
 <CALkWK0nSC-Aty55QO+DrM5Zf2t=DK8iMfbhv_HD44Z_m8d19Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 00:16:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7uyt-0007ry-3l
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 00:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031306Ab3HIWQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 18:16:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:50863 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031204Ab3HIWQR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 18:16:17 -0400
Received: (qmail 1810 invoked by uid 102); 9 Aug 2013 22:16:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Aug 2013 17:16:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Aug 2013 18:16:15 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0nSC-Aty55QO+DrM5Zf2t=DK8iMfbhv_HD44Z_m8d19Pg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232044>

On Fri, Aug 09, 2013 at 07:04:23PM +0530, Ramkumar Ramachandra wrote:

> I'll raise some (hopefully interesting) points. Let's take the example
> of a simple push: I start send-pack, which in turn starts receive_pack
> on the server and connects its stdin/stdout to it (using git_connect).
> Now, it reads the (sha1, ref) pairs it receives on stdin and spawns
> pack-objects --stdout with the right arguments as the response, right?
> Overall, nothing special: just pack-objects invoked with specific
> arguments.
> 
> How does pack-objects work? ll_find_deltas() spawns some worker
> threads to find_deltas(). This is where this get fuzzy for me: it
> calls try_delta() in a nested loop, trying to find the smallest delta,
> right? I'm not sure whether the interfaces it uses to read objects
> differentiates between packed deltas versus packed undeltified objects
> versus loose objects at all.

You are missing a step in the preparation of the delta list. If we
already have a delta on-disk, we will check whether it is usable and
keep a note in the list (see check_object). Then when we
prepare the list of objects to delta, it is omitted from the list (see
prepare_pack).

That is why you may see a much smaller number objects in the progress
eye candy for "Compressing objects..." than we are actually sending.

> Now, the main problem I see is that a pack has to be self-contained: I
> can't have an object "bar" which is a delta against an object that is
> not present in the pack, right? Therefore no matter what the server
> already has, I have to prepare deltas only against the data that I'm
> sending across.

As Junio mentioned, that is what "--thin" is about; the sender omits the
base and the receiver adds it back in ("index-pack --fix-thin"). And if
you think about it, that is likely where most of Martin's "317 packs
turned into 8MB" space savings are coming from.

Somebody pushes X, which deltas against Y. They send only the delta for
X->Y, but the receiver stores that delta plus a full copy of Y, even
though we already have Y in another pack. Repacking throws away the
extra copy of Y.

And that is why something like Junio's suggestion of "do not traverse
history; just concatenate the packs and throw away duplicate objects"
might be helpful. You would not find new deltas, but you would get rid
of these duplicate objects, and doing so would be relatively cheap.

Another solution could involve not writing the duplicate of Y in the
first place. The reason we do not store thin-packs on disk is that you
run into problems with cycles in the delta graph (e.g., A deltas against
B, which deltas against C, which deltas against A; at one point you had
a full copy of one object which let you create the cycle, but you later
deleted it as redundant with the delta, and now you cannot reconstruct
any of the objects).

You could possibly solve this with cycle detection, though it would be
complicated (you need to do it not just when getting rid of objects, but
when sending a pack, to make sure you don't send a cycle of deltas that
the other end cannot use). You _might_ be able to get by with a kind of
"two-level" hack: consider your main pack as "group A" and newly pushed
packs as "group B". Allow storing thin deltas on disk from group B
against group A, but never the reverse (nor within group B). That makes
sure you don't have cycles, and it eliminates even more I/O than any
repacking solution (because you never write the extra copy of Y to disk
in the first place). But I can think of two problems:

  1. You still want to repack more often than every 300 packs, because
     having many packs cost both in space, but also in object lookup
     time (we can do a log(N) search through each pack index, but have
     to search linearly through the set of indices).

  2. As you accumulate group B packs with new objects, the deltas that
     people send will tend to be against objects in group B. They are
     closer to the tip of history, and therefore make better deltas for
     history built on top.

That's all just off the top of my head. There are probably other flaws,
too, as I haven't considered it too hard. But if you are really
concerned about I/O on a busy repo (and I think for hosting sites, it is
a real problem), the best-performing solution will probably not involve
packs at all, but some kind of delta-capable storage that you can
incrementally add to without rewriting the whole repository. The
downside is that it would be significantly more complicated.

> > Of course we may have to reconstruct deltas for trees in order to find
> > the correct set of objects (i.e., the history traversal). But that is a
> > separate phase from generating the pack's object content, and we do not
> > reuse any of the traversal work in later phases.
> 
> I see. Are we talking about tree-walk.c here? This is not unique to
> packing at all; we need to do this kind of traversal for any git
> operation that digs into older history, no? I recall a discussion
> about using generation numbers to speed up the walk: I tried playing
> with your series (where you use a cache to keep the generation
> numbers), but got nowhere. Does it make sense to think about speeding
> up the walk (how?).

It's actually list-objects.c, and no, it is not unique to packing (you
can run the same code with "git rev-list --objects"). The CPU time for such
a traversal is generally spent in:

  1. Accessing commit objects data from disk (this shows up as libz in
     perf runs).

  2. Accessing tree object data from disk (libz again).

  3. Reconstructing tree deltas (this shows up as memcpy in perf, but of
     course we have to access base objects, which increases item 2).

  4. Converting sha1s into "struct object" via hash table lookup
     (lookup_object in perf).

Generation numbers can make some commit walks faster by cutting off the
traversal early. But they don't really apply here, for a few reasons.
One, our worst case is actually a full clone or prune, and there is no
cutoff; we must go down to the roots. Two, we use commit timestamps as a
proxy for generation numbers. Most of the traversal algorithms use the
timestamps in a priority queue, and are written such that we always get
the right answer in the face of skewed timestamps, but we may go deeper
than necessary if they are skewed. The exception is the depth-first
"tag --contains" algorithm, which typically goes to the roots (and if
you limit on timestamp, will give the wrong answer in the face of skew).
And that is the algorithm that is sped up by having generation numbers.

So I do not think they help with (1). You can speed up (1) by storing
commit information in a more readily accessible format (e.g., see the
"commit metapack" patches I posted in March or April of this year). But
you cannot win all that much here. Try "git rev-list --all" on the
kernel versus "git rev-list --objects --all". The former touches only
the commits, and takes about 5 seconds. The latter touches all objects
and takes about 30 seconds. So even if you could make the commit access
and traversal instantaneous, you could save only 5 out of 30 seconds.

For (2), I experimented with leaving tree objects uncompressed in the
pack. It does help (and you do not lose much space, because tree objects
compress horribly, as they are mostly random sha1 bytes). But not that
much.

For (3), we keep a cache of delta bases to avoid re-accessing the same
tree bases over and over. Usually this works fine, but I can into a case
recently where "rev-list --objects" was halved by bumping
core.deltabasecachelimit from its default of 16m to 128m (this
particular repository had some large trees, and a very odd pattern of
merges that I think made the locality of tree access very poor).

Which leaves (4), the hash lookup. We have to do a _lot_ of these,
because we have to look up each entry of each tree. So we end up looking
up the same sha1s over and over again (e.g., we see that "Makefile" is at
sha1 "1234abcd", and we output it. Then we go to the tree of the parent
commit, and we look at its "Makefile" entry. Guess where it almost
certainly still points, because any given commit only touches a handful
of paths?).

There have been several attempts to make this faster. Micro-optimizing
hashcmp, which helps a little. I looked at quadratic probing in the hash
table, and Junio looked at cuckoo hashing.  Neither provided good
results. I looked at exploiting locality of the repeated lookups, which
resulted in 9a41448.

But ultimately, something like reachability bitmaps is going to perform
a lot better, because you can avoid doing the traversal at all. Another
solution which we've discussed but AFAIK nobody has ever implemented is
having a cache to show which entries changed between two trees (e.g.,
the tree of a commit and the tree of one of its children). That would
let us skip the repeated hash lookups (you would know whether you
already processed the child's tree and its entries, and if so, you know
that you only need to process the differences to get complete coverage).


That rambled off topic a bit and got long. But you seem to have a lot of
questions in this area, so the simplest thing seemed to be to just dump
the current state of affairs. I hope it is useful.

-Peff

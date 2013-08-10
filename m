From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Sat, 10 Aug 2013 05:38:28 -0400
Message-ID: <20130810093827.GA2518@sigill.intra.peff.net>
References: <7va9ksbqpl.fsf@alter.siamese.dyndns.org>
 <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
 <7v61vgazp5.fsf@alter.siamese.dyndns.org>
 <CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
 <7vwqnw7z47.fsf@alter.siamese.dyndns.org>
 <CALkWK0=nerszb3_YA8P=qXbfAd4Y1rNsHXhfVKzwtj-x80iqkg@mail.gmail.com>
 <20130809110000.GD18878@sigill.intra.peff.net>
 <CALkWK0nSC-Aty55QO+DrM5Zf2t=DK8iMfbhv_HD44Z_m8d19Pg@mail.gmail.com>
 <20130809221615.GA7160@sigill.intra.peff.net>
 <CALkWK0kpqyxTyai2Lue7=D4z0kvhxuxKdYSWekT22zUhRis0Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 11:38:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V85dH-0003Y2-FI
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 11:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968509Ab3HJJic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 05:38:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:55293 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968504Ab3HJJia (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 05:38:30 -0400
Received: (qmail 3170 invoked by uid 102); 10 Aug 2013 09:38:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Aug 2013 04:38:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Aug 2013 05:38:28 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0kpqyxTyai2Lue7=D4z0kvhxuxKdYSWekT22zUhRis0Og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232081>

On Sat, Aug 10, 2013 at 02:12:46PM +0530, Ramkumar Ramachandra wrote:

> First off, thanks for the fabulous writeup. I hope more contributors
> read this, and get interested in tackling the problems.

You're welcome. I'll just respond to a few questions/points you raised
in your response:

> Yeah, I read about the --thin option. However, it's only for
> network-packs (i.e --stdout; why?). Also, is it turned on by default?
> The documentation says so, but I ran it and found that the value of
> thin is 0 in builtin/push.c:316. What is going on?

I'm not sure whether "push --thin" actually does anything anymore. It
looks like we always turn on thin-packs for the git transport in
transport_get, and have ever since 9b28851 (Push code for transport
library, 2007-09-10). And you cannot turn off thin-packing with
"--no-thin".

So I suspect it is historical cruft at this point.

> > And if
> > you think about it, that is likely where most of Martin's "317 packs
> > turned into 8MB" space savings are coming from.
> 
> Thin packs have nothing to do with git-exproll per-se, but I think I
> understand why pack generations work.

I think it matters in terms of understanding the workload, and why the
repo benefits from repacking. In a normal git repo that accumulates
packs via incremental "git repack" (e.g., by running "gc --auto" until
we hit the pack limit), you will not have duplicate objects (only
objects which could be delta'd across the pack boundary but are not).
But if you accumulate packs by repeated thin-pack pushing, you will have
good deltas, but extra copies of base objects.

> > And that is why something like Junio's suggestion of "do not traverse
> > history; just concatenate the packs and throw away duplicate objects"
> > might be helpful. You would not find new deltas, but you would get rid
> > of these duplicate objects, and doing so would be relatively cheap.
> 
> ... but we've already determined that git pack-objects does a good job
> of reusing deltas, so I'm not sure what we can do over and above this.

If I understand the proposal correctly, the problem space is something
like:

  A fully packed repository is the best way to store objects, both in
  terms of space efficiency and for delta reuse when clients fetch from
  us. But it is too expensive to do a full repack after each push. What
  makes it expensive, and how can we get around that?

I think the answer to "why is it expensive" is two-fold:

  1. We spend a lot of CPU on history traversal. Even if we have only 10
     new commits to pack, we have to traverse the _whole_ history to
     generate the pack.

  2. We spend some CPU on delta compression. This scales nicely (10
     commits means we only do deltas for those 10 commits).

  3. We do a lot of I/O, as we rewrite the whole of the old pack content
     into the new pack, along with the extra objects (so again, we might
     rewrite millions of objects just to add 10 more to the pack).

I do not think (2) is that big a deal. It scales nicely already, and the
deltas you get are worth it (and you would have to compute them on the
fly for the next clone anyway). But (1) and (3) are bad, because they
are based on the size of the repository, not the size of the new
content.

If we were to simply append the objects from the new packs onto
the big, old pack, dropping any duplicates but retaining the deltas we
have, we would make (1) and (3) go away. Our pack probably wouldn't be
as good as a "real" repack, as it would potentially contain unreachable
objects, and we might miss some delta opportunities. But we could
cheaply run the "concatenate" repack after each push, and then do a real
repack less frequently.

I am not sure if that is exactly what Junio is proposing. There are some
logistical complications (fixing up the pack header and footer, along
with the filename, and updating the pack index).

> >   1. You still want to repack more often than every 300 packs, because
> >      having many packs cost both in space, but also in object lookup
> >      time (we can do a log(N) search through each pack index, but have
> >      to search linearly through the set of indices).
> 
> Once you narrow it down to a pack-index, you can bisect it since the
> table is sorted. How do you find the right pack-index though? Do I
> have to do the bisection-search on each one to see if the object
> exists? Can this be improved by generating a global index for all
> packs that contains packfile-name in addition to offset for each
> object?

Right. The bisection-search is the "log(N)" I mention above; you can do
that on each pack index. But you have to search the packs linearly,
since there is no indication of which pack the object might be found in.

A global index would solve that. Right now, the way to create such an
index is "git repack -ad". :)

But there is nothing to say that we could not have a meta-index on top
of the existing pack indices (however it does introduce complications
with lifetimes, as right now we can delete redundant packs and their
indices).

> >   2. As you accumulate group B packs with new objects, the deltas that
> >      people send will tend to be against objects in group B. They are
> >      closer to the tip of history, and therefore make better deltas for
> >      history built on top.
> 
> Actually, I'm not sure it's worth the additional complexity at all.

Oh, I'm not either. I was mostly thinking out loud. :)

> Keeping packs self-contained means that simpler code and easier
> isolation in the face of corruption: the space isn't a big trade-off,
> unless there are lots of really tiny packs (in which case we
> consolidate them into larger packs).

Exactly. The system right now is simple and robust, even if it has some
inefficiencies.

> The way I see it, we'll be saving on some IO by creating thin packs.
> But the trade-off seems to be quite heavy: self-contained packs means
> that I can just mmap() that pack-index, look for objects and apply
> deltas without bothering about any other packs. Thin packs means that
> I'll have to mmap() a lot more than one pack-index, and spend a lot
> more time searching for the base object to apply the delta to, right?

Yes. Right now when we search for a base, we know it is in the same
pack. So right now if you have N packs, we might do N binary searches to
look up a single object. But with cross-pack deltas, we might do N
searches per delta link; an object with a 50-deep delta chain might do
50N such lookups.

So any solution along these lines would probably want to have a global
index for the thin packs, or some other way of mitigating this.

> I think packs are an excellent solution. The reason is quite simple:
> if you use incremental delta storage, those deltas will be useless
> (aka. completely suboptimal) after a few days of additional data.
> Generating effective deltas is an expensive operation that involves
> lining up objects using heuristics (like size), and sliding windows
> over them to get the most optimal delta. If you generate lots of
> suboptimal deltas, pack-objects can't reuse them and your server will
> not be able to do network operations effectively.

I don't know that the deltas are useless or suboptimal after a few days.
Yes, we might have better deltas if we did a full repack, but I think it
would very much depend on the workload and the quality of deltas the
clients are pushing to you.

However, there is one thing we didn't talk about yet: the direction of
deltas. When we repack, we try to store the most recent items as bases,
and then delta going further back in history. This makes accessing
recent objects (which most workloads should do more of) cheaper, and I
imagine it helps with the delta base cache, too (since we traverse
backwards in time).

But deltas you get from other packs may not be in that order (in fact,
if they are from thin packs, they are almost certainly in the opposite
order, as the server and client have some shared objects that are older,
and then the client pushes a delta for the new object against the old).

> Interesting point: tree objects cannot be compressed: if I do one
> file/directory rename, the old 20-byte hash and new 20-byte hash have
> no relationship to each other: so, we're wasting time trying to find
> patterns (for compression) in trees. But yeah, eliminating tree
> compression might not help much, because there are so few trees: on a
> typical repository, there are very few renames.

There are a lot of trees in a typical repository. The breakdown of
objects in the kernel is:

  blob   992707 (30%)
  commit 417959 (13%)
  tree  1898643 (57%)

The reason there are more trees than blobs is that the sha1 changes
cascade through the hierarchy. If you put a new blob in foo/bar/baz,
we need to update the foo/bar, foo, and root trees.

I think dropping tree compression _does_ help; it's just that zlib
inflation is already reasonably fast, and our time is dominated by the
hash table performance. I posted some numbers a while back here:

  http://article.gmane.org/gmane.comp.version-control.git/212278

It uses about 3% more disk space, but "--objects" traversals are about
10-20% faster.

I didn't measure the time to _create_ packs, though. We would be
avoiding zlib deflate there, which is much more expensive than inflate.
Still, I don't think that zlib is all that big a deal when creating
packs; most of the time goes to the traversal and to looking for deltas.

-Peff

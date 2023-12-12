Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1AAA0
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 00:03:34 -0800 (PST)
Received: (qmail 9291 invoked by uid 109); 12 Dec 2023 08:03:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Dec 2023 08:03:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12287 invoked by uid 111); 12 Dec 2023 08:03:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Dec 2023 03:03:33 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Dec 2023 03:03:32 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 05/24] midx: implement `DISP` chunk
Message-ID: <20231212080332.GC1117953@coredump.intra.peff.net>
References: <cover.1701198172.git.me@ttaylorr.com>
 <c52d7e7b27a9add4f58b8334db4fe4498af1c90f.1701198172.git.me@ttaylorr.com>
 <xmqqjzpv4ecg.fsf@gitster.g>
 <ZW95WSErCXvkfrAG@nand.local>
 <xmqqlea4nofm.fsf@gitster.g>
 <ZXPRL5yCTQKr0k7e@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXPRL5yCTQKr0k7e@nand.local>

On Fri, Dec 08, 2023 at 09:30:07PM -0500, Taylor Blau wrote:

> > I did wonder how expensive to recompute and validate the "distinct"
> > information (in other words, is it too expensive for the consumers
> > of an existing midx file to see which packs are distinct on demand
> > before they stream contents out of the underlying packs?), as the
> > way the packs are marked as distinct looked rather error prone (you
> > can very easily list packfiles with overlaps with "+" prefix and the
> > DISK chunk writer does not even notice that you lied to it).  As long
> > as "git fsck" catches when two packs that are marked as distinct share
> > an object, that is OK, but the arrangement did look rather brittle
> > to me.
> 
> It's likely too expensive to do on the reading side for every
> pack-objects operation or MIDX load.

This made me think a bit. Obviously we can check for disjointedness in
O(n log k), where n is the total number of objects and k is the number
of packs, by doing a k-merge of the sorted lists. But that's a
non-starter, because we may be serving a request that is much smaller
than all "n" objects (e.g., any small fetch, but also even clones when
the pack contains a bunch of irrelevant objects).

But we can relax our condition a bit. The packs only need to be disjoint
with respect to the set of objects that we are going to output (we'll
call that "m"). So at the very least, you can do O(mk) lookups (each one
itself "log n", of course). We know that the work is already going to
be linear in "m". In theory we want to generally keep "k" small, but
part of the point of using midx in this way is to let "k" grow a bit.
So that might turn out pretty bad in practice.

So let's take one more step back. One thing I didn't feel like I saw
either in this patch or the cover letter is exactly why we care about
disjointedness. IIRC, the main issue is making sure that for any object
X we send verbatim, it is either a non-delta or its delta base is
viable. And the two reasons I can think of for the base to be non-viable
are:

  1. We are not sending the base at all.

  2. The base is in another pack, and we are worried about creating a
     cycle (i.e., in pack A we have X as a delta against Y, and in pack
     B we have Y as a delta against X, and we send both deltas).

We already deal with (1) for the single-pack case by finding the base
object offset, converting it to a pack position, and then making sure
that position is also marked for verbatim reuse.

The interesting one is (2), which is new for midx (since a single pack
cannot have two copies of an object). But I'm not sure if it's possible.
The verbatim reuse code depends on using bitmaps in the first place. And
there is already a preference-order to the packs in the midx bitmaps.

That is, we'll choose all of the objects for pack A over any duplicates
in B, and duplicates from B over C, and so on. If we likewise try
verbatim reuse in that order, then we know that an object in pack A can
never have a base that is selected from pack B or C (because if they do
have duplicates, we'd have selected A's copy to put in the midx bitmap).
And likewise, a copy of an object in pack B will always have its base
either in A or B, but never in C.

So it kind of seems to me that this would "just work" if
try_partial_reuse() did something like for the midx case:

  - convert offset of base object into an object id hash using the pack
    revindex (similar to offset_to_pack_pos)

  - look up the object id in the midx to get a pack/offset combo

  - use the midx revindex to convert that into a bit position

  - check if that bit is marked for verbatim reuse

The assumption there is that in the second step, the midx has resolved
duplicates by putting all of pack A before pack B, and so on, as above.
It also assumes that we are trying verbatim reuse in the same order
(though a different order would not produce wrong results, it would only
result in less verbatim reuse).

All of which makes me think I'm missing some other case that is a
problem. While I wait for you to explain it, though, let's continue our
thought experiment for a moment.

If we assume that any cross-pack deltas are a problem, we could always
just skip them for verbatim reuse. That is, once we look up the object
id in the midx, we can see if it's in the same pack we're currently
processing. If not, we could punt and let the non-verbatim code paths
handle it as usual.

That still leaves the problem of realizing we skipped over a chunk of
the packfile (say we are pulling object X from pack B, and it is a delta
of Y, but we already decided to reuse Y from pack A). But the reuse code
already has to accommodate gaps. I think it happens naturally in
write_reused_pack_one(), where we feed the actual byte offsets into
record_reused_object(). You'd have to take some care not to go past gaps
in the blind copy that happens write_reused_pack_verbatim(). So you
might need to mark the first such gap somehow (if it's hard, I'd suggest
just skipping write_reused_pack_verbatim() entirely; it is a fairly
minor optimization compared to the rest of it).

And of course there's a bunch of hard work teaching all of those
functions about midx's and multiple packs in the first place, but you
already had to do all that in the latter part of your series, and it
would still be applicable.

OK, this is the part where you tell me what I'm missing. ;)

-Peff

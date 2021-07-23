Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A7FC432BE
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 10:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C65160EE2
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 10:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhGWJUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:20:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:55630 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231740AbhGWJUO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 05:20:14 -0400
Received: (qmail 11069 invoked by uid 109); 23 Jul 2021 10:00:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Jul 2021 10:00:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23925 invoked by uid 111); 23 Jul 2021 10:00:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jul 2021 06:00:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jul 2021 06:00:47 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 13/24] pack-bitmap: read multi-pack bitmaps
Message-ID: <YPqTTwqifHIWZRsn@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <7d44ba6299c06c956d5ac8ba01a0288d109c3cae.1624314293.git.me@ttaylorr.com>
 <YPgF4X2PeFvBuJXm@coredump.intra.peff.net>
 <YPinPFW50Mj8cVkP@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPinPFW50Mj8cVkP@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 07:01:16PM -0400, Taylor Blau wrote:

> > OK, this new function is used in load_bitmap(), which is used for both
> > pack and midx bitmaps. So if we have a midx bitmap, we'll
> > unconditionally load the revindex here. But:
> >
> >   - why do we then load individual pack revindexes? I can believe it may
> >     be necessary to meet the assumptions of some other part of the code,
> >     but it would be nice to have a comment giving us some clue.
> 
> Good suggestion. We will need to reference the reverse index belonging
> to individual packs in a few locations in pack-objects (for e.g.,
> write_reuse_object() calls offset_to_pack_pos(), and
> pack_pos_to_offset(), both with arbitrary packs, not just the preferred
> one).
> 
> I left the comment vague; something along the lines of "lots of routines
> in pack-objects will need these structures to be ready to use".

Makes sense. I think we _could_ be lazy-loading them, but IIRC only some
of the revindex functions are happy to lazy-load. It's definitely fine
to punt on that for now with a comment.

> I think there's room for improvement there, since for e.g., `git
> rev-list --count --objects --use-bitmap-index` doesn't need to load the
> reverse indexes. But that's already the case with classic bitmaps, too,
> which eagerly call load_pack_revindex().

Right. I think our solution there was to make loading the revindex
really cheap (open+mmap, rather than the in-core generation). I'm
definitely happy to call that fast enough for now, and if somebody wants
to benchmark and micro-optimize cases where we can avoid loading them,
we can do that later.

> > In practice I think even 2^31 objects is pretty out-of-reach, but it may
> > be worth changing the return type (and the callers), or even just
> > catching the overflow with an assertion.
> 
> Possibly, but keep in mind that the former is basically the same
> refactor as we did with the "tell me whether this object was found via
> this extra pointer". But bitmap_position() has a lot more callers than
> that, so the plumbing required would be a little more prevalent.
> 
> So I'd be content to just punt on it for now, if you'd be OK with it.

Yeah, I think it's fine to leave it out of this series. It's not new,
and we can revisit it later.

> > Could this ever be fooled if we had a preferred pack with 0 objects in
> > it? I don't know why we would have such a thing, but just trying to
> > think of cases where our assumptions might not hold (and what bad things
> > could happen).
> 
> An empty preferred pack would cause a problem, yes. The solution is
> two-fold (and incorporated into the reroll that I plan on sending
> shortly):
> 
>   - When the user specifies --preferred-pack, the MIDX code must make
>     sure that the given pack is non-empty. That's a new patch, and
>     basically adds a new conditional (to check the pack itself) and a
>     test (to make sure that we catch the case we are trying to prevent).
> 
>   - When the user doesn't specify --preferred-pack (and instead asks us
>     to infer one for them) we want to select not just the oldest pack,
>     but the oldest *non-empty* pack. That is folded into the "midx:
>     infer preferred pack when not given one" patch.

Oh good, I said something useful. ;) The fix you outlined sounds
sensible.

> > > +			if (bitmap_is_midx(bitmap_git)) {
> > > +				/*
> > > +				 * Can't reuse from a non-preferred pack (see
> > > +				 * above).
> > > +				 */
> > > +				if (pos + offset >= objects_nr)
> > > +					continue;
> > > +			}
> > > +			try_partial_reuse(bitmap_git, pack, pos + offset, reuse, &w_curs);
> >
> > ...and this likewise makes sure we never go past that first pack. Good.
> >
> > I think this "continue" could actually be a "break", as the loop is
> > iterating over "offset" (and "pos + offset" always gets larger). In
> > fact, it could break out of the outer loop as well (which is
> > incrementing "pos"). It's probably a pretty small efficiency in
> > practice, though.
> 
> Yeah; you're right. And we'll save up to BITS_IN_EWORD cycles of this
> loop. (I wonder if smart-enough compilers will realize the same
> optimization that you did and turn that `continue` into a `break`
> automatically, but that's neither here nor there).

If you break all the way out, then it saves iterating over all of those
other words that are not in the first pack, too. I.e., if your bitmap
has 10 million bits (for a 10-million object clone), but your first pack
only has a million objects in it, we'll call try_partial_reuse() 9
million extra times.

Fortunately, each call is super cheap, because the first thing it does
is check if the requested bit is past the end of the pack. Which kind of
makes me wonder if we could simplify this further by just letting
try_partial_reuse() tell us when there's no point going further:

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 02948e8c78..b84b55c4f3 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1308,7 +1308,11 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	return NULL;
 }
 
-static void try_partial_reuse(struct bitmap_index *bitmap_git,
+/*
+ * -1 means "stop trying further objects"; 0 means we may or may not have
+ * reused, but you can keep feeding bits.
+ */
+static int try_partial_reuse(struct bitmap_index *bitmap_git,
 			      struct packed_git *pack,
 			      size_t pos,
 			      struct bitmap *reuse,
@@ -1342,12 +1346,12 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 	 */
 
 	if (pos >= pack->num_objects)
-		return; /* not actually in the pack or MIDX preferred pack */
+		return -1; /* not actually in the pack or MIDX preferred pack */
 
 	offset = delta_obj_offset = pack_pos_to_offset(pack, pos);
 	type = unpack_object_header(pack, w_curs, &offset, &size);
 	if (type < 0)
-		return; /* broken packfile, punt */
+		return -1; /* broken packfile, punt */
 
 	if (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA) {
 		off_t base_offset;
@@ -1364,9 +1368,9 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 		base_offset = get_delta_base(pack, w_curs, &offset, type,
 					     delta_obj_offset);
 		if (!base_offset)
-			return;
+			return 0;
 		if (offset_to_pack_pos(pack, base_offset, &base_pos) < 0)
-			return;
+			return 0;
 
 		/*
 		 * We assume delta dependencies always point backwards. This
@@ -1378,7 +1382,7 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 		 * odd parameters.
 		 */
 		if (base_pos >= pos)
-			return;
+			return 0;
 
 		/*
 		 * And finally, if we're not sending the base as part of our
@@ -1389,13 +1393,14 @@ static void try_partial_reuse(struct bitmap_index *bitmap_git,
 		 * object_entry code path handle it.
 		 */
 		if (!bitmap_get(reuse, base_pos))
-			return;
+			return 0;
 	}
 
 	/*
 	 * If we got here, then the object is OK to reuse. Mark it.
 	 */
 	bitmap_set(reuse, pos);
+	return 0;
 }
 
 static uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git)
@@ -1449,22 +1454,20 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	for (; i < result->word_alloc; ++i) {
 		eword_t word = result->words[i];
 		size_t pos = (i * BITS_IN_EWORD);
+		int ret;
 
 		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
 			if ((word >> offset) == 0)
 				break;
 
 			offset += ewah_bit_ctz64(word >> offset);
-			if (bitmap_is_midx(bitmap_git)) {
-				/*
-				 * Can't reuse from a non-preferred pack (see
-				 * above).
-				 */
-				if (pos + offset >= objects_nr)
-					continue;
-			}
-			try_partial_reuse(bitmap_git, pack, pos + offset, reuse, &w_curs);
+			ret = try_partial_reuse(bitmap_git, pack, pos + offset,
+						reuse, &w_curs);
+			if (ret < 0)
+				break;
 		}
+		if (ret < 0)
+			break;
 	}
 
 	unuse_pack(&w_curs);

The double-ret check is kind of ugly, though I suspect compilers
optimize it pretty well. The alternative is a "goto" to a label just
past the loop (also ugly, but easily explained with a comment).

> > > @@ -1511,8 +1749,13 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
> > >  		struct object_id oid;
> > >  		struct object_entry *oe;
> > >
> > > -		nth_packed_object_id(&oid, bitmap_git->pack,
> > > -				     pack_pos_to_index(bitmap_git->pack, i));
> > > +		if (bitmap_is_midx(bitmap_git))
> > > +			nth_midxed_object_oid(&oid,
> > > +					      bitmap_git->midx,
> > > +					      pack_pos_to_midx(bitmap_git->midx, i));
> > > +		else
> > > +			nth_packed_object_id(&oid, bitmap_git->pack,
> > > +					     pack_pos_to_index(bitmap_git->pack, i));
> > >  		oe = packlist_find(mapping, &oid);
> >
> > Could this be using nth_bitmap_object_oid()? I guess not, because we are
> > feeding from pack_pos_to_*. I'm not sure if another helper function is
> > worth it (pack_pos_to_bitmap_index() or something?).
> 
> You're right that we can't call nth_bitmap_object_oid here directly,
> sadly. But I think your suggestion for pack_pos_to_bitmap_index() (or
> similar) would only benefit this caller, since most places that dispatch
> conditionally to either pack_pos_to_{midx,index} want to pass the result
> to a different function depending on which branch they took.
> 
> Definitely possible that I missed another case that would help, but that
> was what I came up with after just a quick glance.

Yeah, looking around, I don't see another opportunity. So the benefits
are pretty minimal. We could do:

  index_pos = bitmap_is_midx(bitmap_git) ?
              pack_pos_to_midx(bitmap_git->midx, i) :
	      pack_pos_to_index(bitmap_git->pack, i);
  nth_bitmap_object_oid(&oid, bitmap_git, index_pos);

but that is not buying much. I'm content to leave it.

-Peff

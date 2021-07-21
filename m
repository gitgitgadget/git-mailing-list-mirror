Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BEBC12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6FA160E08
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 11:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbhGULPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 07:15:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:53140 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237505AbhGUKwR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 06:52:17 -0400
Received: (qmail 2345 invoked by uid 109); 21 Jul 2021 11:32:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jul 2021 11:32:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3818 invoked by uid 111); 21 Jul 2021 11:32:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jul 2021 07:32:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jul 2021 07:32:49 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 13/24] pack-bitmap: read multi-pack bitmaps
Message-ID: <YPgF4X2PeFvBuJXm@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <7d44ba6299c06c956d5ac8ba01a0288d109c3cae.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d44ba6299c06c956d5ac8ba01a0288d109c3cae.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 06:25:31PM -0400, Taylor Blau wrote:

> This prepares the code in pack-bitmap to interpret the new multi-pack
> bitmaps described in Documentation/technical/bitmap-format.txt, which
> mostly involves converting bit positions to accommodate looking them up
> in a MIDX.
> 
> Note that there are currently no writers who write multi-pack bitmaps,
> and that this will be implemented in the subsequent commit.

There's quite a lot going on in this one, of course, but most of it
looks right. A few hunks did puzzle me:

> @@ -302,12 +377,18 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
>  		return -1;
>  	}
>  
> -	if (bitmap_git->pack) {
> +	if (bitmap_git->pack || bitmap_git->midx) {
> +		/* ignore extra bitmap file; we can only handle one */
>  		warning("ignoring extra bitmap file: %s", packfile->pack_name);
>  		close(fd);
>  		return -1;
>  	}
>  
> +	if (!is_pack_valid(packfile)) {
> +		close(fd);
> +		return -1;
> +	}
> +

What's this extra is_pack_valid() doing? I wouldn't expect many changes
at all to this non-midx code path (aside from the "did we already load a
midx bitmap" in the earlier part of the hunk, which makes sense).

> -static int load_pack_bitmap(struct bitmap_index *bitmap_git)
> +static int load_reverse_index(struct bitmap_index *bitmap_git)
> +{
> +	if (bitmap_is_midx(bitmap_git)) {
> +		uint32_t i;
> +		int ret;
> +
> +		ret = load_midx_revindex(bitmap_git->midx);
> +		if (ret)
> +			return ret;
> +
> +		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
> +			if (prepare_midx_pack(the_repository, bitmap_git->midx, i))
> +				die(_("load_reverse_index: could not open pack"));
> +			ret = load_pack_revindex(bitmap_git->midx->packs[i]);
> +			if (ret)
> +				return ret;
> +		}
> +		return 0;
> +	}
> +	return load_pack_revindex(bitmap_git->pack);
> +}

OK, this new function is used in load_bitmap(), which is used for both
pack and midx bitmaps. So if we have a midx bitmap, we'll
unconditionally load the revindex here. But:

  - why do we then load individual pack revindexes? I can believe it may
    be necessary to meet the assumptions of some other part of the code,
    but it would be nice to have a comment giving us some clue.

  - in open_midx_bitmap_1(), we also unconditionally load the midx
    reverse index. I think that will always happen before us here (we
    cannot load_bitmap() a bitmap that has not been opened). So is this
    load_midx_revindex() call always a noop?

> +static int open_bitmap(struct repository *r,
> +		       struct bitmap_index *bitmap_git)
> +{
> +	assert(!bitmap_git->map);
> +
> +	if (!open_midx_bitmap(r, bitmap_git))
> +		return 0;
> +	return open_pack_bitmap(r, bitmap_git);
> +}

We always prefer a midx bitmap over a pack one. That makes sense, since
that means we can leave old pack bitmaps in place when generating midx
bitmaps, if we choose to.

>  static int bitmap_position(struct bitmap_index *bitmap_git,
>  			   const struct object_id *oid)
>  {
> -	int pos = bitmap_position_packfile(bitmap_git, oid);
> +	int pos;
> +	if (bitmap_is_midx(bitmap_git))
> +		pos = bitmap_position_midx(bitmap_git, oid);
> +	else
> +		pos = bitmap_position_packfile(bitmap_git, oid);
>  	return (pos >= 0) ? pos : bitmap_position_extended(bitmap_git, oid);
>  }

Makes sense. Not new in your patch, but this "int" return is fudging the
same 32-bit space we were talking about elsewhere (i.e., "pos" really
could be 2^32, or even more due to extended objects).

In practice I think even 2^31 objects is pretty out-of-reach, but it may
be worth changing the return type (and the callers), or even just
catching the overflow with an assertion.

> @@ -752,8 +911,13 @@ static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
>  		struct object *object = roots->item;
>  		roots = roots->next;
>  
> -		if (find_pack_entry_one(object->oid.hash, bitmap_git->pack) > 0)
> -			return 1;
> +		if (bitmap_is_midx(bitmap_git)) {
> +			if (bsearch_midx(&object->oid, bitmap_git->midx, NULL))
> +				return 1;
> +		} else {
> +			if (find_pack_entry_one(object->oid.hash, bitmap_git->pack) > 0)
> +				return 1;
> +		}
>  	}

Makes sense. TBH, I am not sure this in_bitmapped_pack() function is all
that useful. It is used only as part of a heuristic to avoid bitmaps
when we don't have coverage of any "have" commits. But I'm not sure that
heuristic is actually useful.

Anyway, we should definitely not get into ripping it out here. This
series is complicated enough. :) Just a note for possible future work.

>  	if (pos < bitmap_num_objects(bitmap_git)) {
> -		off_t ofs = pack_pos_to_offset(pack, pos);
> +		struct packed_git *pack;
> +		off_t ofs;
> +
> +		if (bitmap_is_midx(bitmap_git)) {
> +			uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, pos);
> +			uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
> +
> +			pack = bitmap_git->midx->packs[pack_id];
> +			ofs = nth_midxed_offset(bitmap_git->midx, midx_pos);
> +		} else {
> +			pack = bitmap_git->pack;
> +			ofs = pack_pos_to_offset(pack, pos);
> +		}
> +

All of the hunks like this make perfect sense. The big problem would be
if we _missed_ a place that needed conversion to handle midx. But the
nice thing is that it would segfault quickly in such an instance. So
there I'm mostly relying on test coverage, plus our experience running
with this code at scale.

>  static void try_partial_reuse(struct bitmap_index *bitmap_git,
> +			      struct packed_git *pack,
>  			      size_t pos,
>  			      struct bitmap *reuse,
>  			      struct pack_window **w_curs)
>  {
> -	off_t offset, header;
> +	off_t offset, delta_obj_offset;

I'm OK with all of this in one big patch. But I suspect you _could_
just put:

  if (bitmap_git->midx)
	return; /* partial reuse not implemented for midx yet */

to start with, and then actually implement it later. I call out this
code in particular just because it's got a lot of subtleties (the
"reuse" bits are much more intimate with the assumptions of packs and
bitmaps than most other code).

I'm not sure if it's worth the trouble at this point or not.

>  	enum object_type type;
>  	unsigned long size;
>  
> -	if (pos >= bitmap_num_objects(bitmap_git))
> -		return; /* not actually in the pack or MIDX */
> +	/*
> +	 * try_partial_reuse() is called either on (a) objects in the
> +	 * bitmapped pack (in the case of a single-pack bitmap) or (b)
> +	 * objects in the preferred pack of a multi-pack bitmap.
> +	 * Importantly, the latter can pretend as if only a single pack
> +	 * exists because:
> +	 *
> +	 *   - The first pack->num_objects bits of a MIDX bitmap are
> +	 *     reserved for the preferred pack, and
> +	 *
> +	 *   - Ties due to duplicate objects are always resolved in
> +	 *     favor of the preferred pack.
> +	 *
> +	 * Therefore we do not need to ever ask the MIDX for its copy of
> +	 * an object by OID, since it will always select it from the
> +	 * preferred pack. Likewise, the selected copy of the base
> +	 * object for any deltas will reside in the same pack.
> +	 *
> +	 * This means that we can reuse pos when looking up the bit in
> +	 * the reuse bitmap, too, since bits corresponding to the
> +	 * preferred pack precede all bits from other packs.
> +	 */
>  
> -	offset = header = pack_pos_to_offset(bitmap_git->pack, pos);
> -	type = unpack_object_header(bitmap_git->pack, w_curs, &offset, &size);
> +	if (pos >= pack->num_objects)
> +		return; /* not actually in the pack or MIDX preferred pack */

It feels weird to go from bitmap_num_objects() back to
pack->num_objects. But I agree it's the right thing for the "pretend as
if only a single pack exists" reasons given above.

> +static uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git)
> +{
> +	struct multi_pack_index *m = bitmap_git->midx;
> +	if (!m)
> +		BUG("midx_preferred_pack: requires non-empty MIDX");
> +	return nth_midxed_pack_int_id(m, pack_pos_to_midx(bitmap_git->midx, 0));
> +}

This part is really subtle. We infer the preferred pack by looking at
the pack of the 0th bit position. In general that works, since that's
part of the definition of the preferred pack.

Could this ever be fooled if we had a preferred pack with 0 objects in
it? I don't know why we would have such a thing, but just trying to
think of cases where our assumptions might not hold (and what bad things
could happen).

> +	if (bitmap_is_midx(bitmap_git))
> +		pack = bitmap_git->midx->packs[midx_preferred_pack(bitmap_git)];
> +	else
> +		pack = bitmap_git->pack;
> +	objects_nr = pack->num_objects;
> +
>  	while (i < result->word_alloc && result->words[i] == (eword_t)~0)
>  		i++;
>  
> -	/* Don't mark objects not in the packfile */
> +	/*
> +	 * Don't mark objects not in the packfile or preferred pack. This bitmap
> +	 * marks objects eligible for reuse, but the pack-reuse code only
> +	 * understands how to reuse a single pack. Since the preferred pack is
> +	 * guaranteed to have all bases for its deltas (in a multi-pack bitmap),
> +	 * we use it instead of another pack. In single-pack bitmaps, the choice
> +	 * is made for us.
> +	 */
>  	if (i > objects_nr / BITS_IN_EWORD)
>  		i = objects_nr / BITS_IN_EWORD;

OK, so this clamps our "quick" contiguous set of bits to the number of
objects in the preferred pack. Makes sense. And then we hit the
object-by-object loop below...

> @@ -1213,7 +1437,15 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
>  				break;
>  
>  			offset += ewah_bit_ctz64(word >> offset);
> -			try_partial_reuse(bitmap_git, pos + offset, reuse, &w_curs);
> +			if (bitmap_is_midx(bitmap_git)) {
> +				/*
> +				 * Can't reuse from a non-preferred pack (see
> +				 * above).
> +				 */
> +				if (pos + offset >= objects_nr)
> +					continue;
> +			}
> +			try_partial_reuse(bitmap_git, pack, pos + offset, reuse, &w_curs);

...and this likewise makes sure we never go past that first pack. Good.

I think this "continue" could actually be a "break", as the loop is
iterating over "offset" (and "pos + offset" always gets larger). In
fact, it could break out of the outer loop as well (which is
incrementing "pos"). It's probably a pretty small efficiency in
practice, though.

> @@ -1511,8 +1749,13 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
>  		struct object_id oid;
>  		struct object_entry *oe;
>  
> -		nth_packed_object_id(&oid, bitmap_git->pack,
> -				     pack_pos_to_index(bitmap_git->pack, i));
> +		if (bitmap_is_midx(bitmap_git))
> +			nth_midxed_object_oid(&oid,
> +					      bitmap_git->midx,
> +					      pack_pos_to_midx(bitmap_git->midx, i));
> +		else
> +			nth_packed_object_id(&oid, bitmap_git->pack,
> +					     pack_pos_to_index(bitmap_git->pack, i));
>  		oe = packlist_find(mapping, &oid);

Could this be using nth_bitmap_object_oid()? I guess not, because we are
feeding from pack_pos_to_*. I'm not sure if another helper function is
worth it (pack_pos_to_bitmap_index() or something?).

> @@ -1575,7 +1831,31 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
>  				break;
>  
>  			offset += ewah_bit_ctz64(word >> offset);
> -			pos = base + offset;
> +
> +			if (bitmap_is_midx(bitmap_git)) {
> +				uint32_t pack_pos;
> +				uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, base + offset);
> +				uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
> +				off_t offset = nth_midxed_offset(bitmap_git->midx, midx_pos);
> +
> +				pack = bitmap_git->midx->packs[pack_id];
> +
> +				if (offset_to_pack_pos(pack, offset, &pack_pos) < 0) {
> +					struct object_id oid;
> +					nth_midxed_object_oid(&oid, bitmap_git->midx, midx_pos);
> +
> +					die(_("could not find %s in pack #%"PRIu32" at offset %"PRIuMAX),
> +					    oid_to_hex(&oid),
> +					    pack_id,
> +					    (uintmax_t)offset);
> +				}
> +
> +				pos = pack_pos;
> +			} else {
> +				pack = bitmap_git->pack;
> +				pos = base + offset;
> +			}
> +
>  			total += pack_pos_to_offset(pack, pos + 1) -
>  				 pack_pos_to_offset(pack, pos);
>  		}

In the midx case, we have to go from midx-bitmap-pos to midx-index-pos,
to then get the pack/ofs combo, which then gives us a real "pos" in the
pack. I don't think there's a faster way to do it (and this is still
much faster than looking up objects in the pack only to check their
revindex).

But then with the result, we compare the offset of "pos" and "pos + 1".
We need to know "pos" to find "pos + 1". But in the midx case, don't we
already have the offset of "pos" (it is "offset" in the bitmap_is_midx()
conditional, which is shadowing the completely unrelated "offset" in the
outer loop).

We could reuse it, saving ourselves an extra round-trip of pack_pos to
index_pos to offset. It would just mean stuffing the "total +=" line
into the two sides of the conditional.

> +off_t bitmap_pack_offset(struct bitmap_index *bitmap_git, uint32_t pos)
> +{
> +	if (bitmap_is_midx(bitmap_git))
> +		return nth_midxed_offset(bitmap_git->midx,
> +					 pack_pos_to_midx(bitmap_git->midx, pos));
> +	return nth_packed_object_offset(bitmap_git->pack,
> +					pack_pos_to_index(bitmap_git->pack, pos));
> +}

Does anybody call this function? I don't see any users by the end of the
series.

-Peff

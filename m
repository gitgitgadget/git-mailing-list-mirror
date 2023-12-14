Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB892C6B9
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XsQSDYNi"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d9f879f784so60644a34.2
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592675; x=1703197475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IH/3jJZSH1yuHnsBAD5VZnKewlomdJS+VanA6yTZaGo=;
        b=XsQSDYNisJp+d/t3t7ajE1VocQ+4fuHM1/SRBSeC/t7b3Nj5ZCYluOrXeOBABsQRND
         S/XJSFWlt0Y+1kbcj97aXFKUHxHIQVfCmY/7tZlCcNJK/MPAUWPKRTBkCFlGviz33zFT
         PzoVQXB8jiBH1VXpN44MFsYnwD5hVMezCoNbvgP9UTh49nJh102bp9IlAhykJDs6rZAl
         VKLfWC4g02VMBQCWlahXdOWbefuDcACCZEPuC8LaDfr+xeldZttLl8ary20k20rBRF7H
         TnCV6QSwn64CDntfYABuJf9AfzvVppvF7uBXxlUwDjdUS+IEjnQifg4BUMmLD3UAPqn/
         g0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592675; x=1703197475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IH/3jJZSH1yuHnsBAD5VZnKewlomdJS+VanA6yTZaGo=;
        b=NxgVQgVF+IgcjNNMgcIsSldzheVjKgQ/rdNYvU8kF/2u80BEKMO1xovxhQ8DK85kVO
         9WZ5atv10PYAfV+aRg4mE5OBkQsF8qgELyG+l1Loyrd9h61KUHabPWZTH2f+vU4/QXRh
         VwGFfIfdNHwkwV/E3JoNYxNca2ef+V8QSUJzy/DcY8sNOYg+MakzWJHEnuZasQCzhsSI
         d+In4h4PlBMK4Wr3viEUi8zPAjIEKWw+V0DbPi9nOy3daigREEG32hXVMYQL3grWQ7zn
         mMHYJZM0xVW9gHxFyjm7mQdLBkubAsglPjtk2Y86E+D9BkUKApUKvhpHzbQOpw0jIWzH
         JZug==
X-Gm-Message-State: AOJu0YzxGlbI57ysyU6WQH5pz98KIiS2pgKtx3QRMnR5UxU0JHhBzwpE
	wFwYbeQRrpCJI56K/EvKV1Gf/S+1hS/qERJ1A4bNEA==
X-Google-Smtp-Source: AGHT+IER+43TX+GL6LORx6kt/ZjRybvc5k6m9yPDWsTvfpSkism7NtXEokOPGP07ZzSISsmdEDEtkA==
X-Received: by 2002:a9d:7f14:0:b0:6d9:e37f:5c44 with SMTP id j20-20020a9d7f14000000b006d9e37f5c44mr10747723otq.57.1702592674986;
        Thu, 14 Dec 2023 14:24:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q17-20020a056830019100b006d87ae1b15dsm3347348ota.62.2023.12.14.14.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:34 -0800 (PST)
Date: Thu, 14 Dec 2023 17:24:34 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 21/26] pack-bitmap: prepare to mark objects from multiple
 packs for reuse
Message-ID: <3e3625aebe58e2c8048f9decb80c28c84b6cb0b4.1702592604.git.me@ttaylorr.com>
References: <cover.1701198172.git.me@ttaylorr.com>
 <cover.1702592603.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1702592603.git.me@ttaylorr.com>

Now that the pack-objects code is equipped to handle reusing objects
from multiple packs, prepare the pack-bitmap code to mark objects from
multiple packs as reuse candidates.

In order to prepare the pack-bitmap code for this change, remove the
same set of assumptions we unwound in previous commits from the helper
function `reuse_partial_packfile_from_bitmap_1()`, in preparation for it
to be called in a loop over the set of bitmapped packs in a following
commit.

Most importantly, we can no longer assume that the bit position
corresponding to the first object in a given reuse pack candidate is at
the beginning of the bitmap itself.

For the single pack that this assumption is still true for (in MIDX
bitmaps, this is the preferred pack, in single-pack bitmaps it is the
pack the bitmap is tied to), we can still use our whole-words
optimization.

But for all subsequent packs, we can not make use of this optimization,
since it assumes that all delta bases are being sent from the same pack,
which would break if we are sending OFS_DELTAs down to the client. To
understand why, consider two packs, P1 and P2 where:

  - P1 has object A which is a delta on base B
  - P2 has its own copy of B, in addition to other objects

Suppose that the MIDX which covers P1 and P2 selected its copy of A from
P1, but selected its copy of B from P2. Since A is a delta of B, but the
base was selected from a different pack, sending the bytes corresponding
to A as an OFS_DELTA verbatim from P1 would be incorrect, since we don't
guarantee that B is in the same place relative to A in the generated
pack as in P1.

For now, we detect and reject these cross-pack deltas by searching for
the (pack_id, offset) pair for the delta's base object (using the same
pack_id as the pack containing the delta'd object) in the MIDX. If we
find a match, that means that the MIDX did indeed pick the base object
from the same pack, and we are OK to reuse the delta.

If we don't find a match, however, that means that the base object was
selected from a different pack in the MIDX, and we can let the slower
path handle re-delta'ing our candidate object.

In the future, there are a couple of other things we could do, namely:

  - Turn any cross-pack deltas (which are stored as OFS_DELTAs) into
    REF_DELTAs. We already do this today when reusing an OFS_DELTA
    without `--delta-base-offset` enabled, so it's not a huge stretch to
    do the same for cross-pack deltas even when `--delta-base-offset` is
    enabled.

    This would work, but would obviously result in larger-than-necessary
    packs, as we in theory *could* represent these cross-pack deltas by
    patching an existing OFS_DELTA. But it's not clear how much that
    would matter in practice. I suspect it would have a lot to do with
    how you pack your repository in the first place.

  - Finally, we could patch OFS_DELTAs across packs in a similar fashion
    as we do today for OFS_DELTAs within a single pack on either side of
    a gap. This would result in the smallest packs of the three options
    here, but implementing this would be more involved.

    At minimum, you'd have to keep the reusable chunks list for all
    reused packs, not just the one we're currently processing. And you'd
    have to ensure that any bases which are a part of cross-pack deltas
    appear before the delta. I think this is possible to do, but would
    require assembling the reusable chunks list potentially in a
    different order than they appear in the source packs.

For now, let's pursue the simplest approach and reject any cross-pack
deltas.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 172 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 106 insertions(+), 66 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1682f99596..242a5908f7 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1841,8 +1841,10 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
  * -1 means "stop trying further objects"; 0 means we may or may not have
  * reused, but you can keep feeding bits.
  */
-static int try_partial_reuse(struct bitmapped_pack *pack,
-			     size_t pos,
+static int try_partial_reuse(struct bitmap_index *bitmap_git,
+			     struct bitmapped_pack *pack,
+			     size_t bitmap_pos,
+			     uint32_t pack_pos,
 			     struct bitmap *reuse,
 			     struct pack_window **w_curs)
 {
@@ -1850,33 +1852,10 @@ static int try_partial_reuse(struct bitmapped_pack *pack,
 	enum object_type type;
 	unsigned long size;
 
-	/*
-	 * try_partial_reuse() is called either on (a) objects in the
-	 * bitmapped pack (in the case of a single-pack bitmap) or (b)
-	 * objects in the preferred pack of a multi-pack bitmap.
-	 * Importantly, the latter can pretend as if only a single pack
-	 * exists because:
-	 *
-	 *   - The first pack->num_objects bits of a MIDX bitmap are
-	 *     reserved for the preferred pack, and
-	 *
-	 *   - Ties due to duplicate objects are always resolved in
-	 *     favor of the preferred pack.
-	 *
-	 * Therefore we do not need to ever ask the MIDX for its copy of
-	 * an object by OID, since it will always select it from the
-	 * preferred pack. Likewise, the selected copy of the base
-	 * object for any deltas will reside in the same pack.
-	 *
-	 * This means that we can reuse pos when looking up the bit in
-	 * the reuse bitmap, too, since bits corresponding to the
-	 * preferred pack precede all bits from other packs.
-	 */
+	if (pack_pos >= pack->p->num_objects)
+		return -1; /* not actually in the pack */
 
-	if (pos >= pack->p->num_objects)
-		return -1; /* not actually in the pack or MIDX preferred pack */
-
-	offset = delta_obj_offset = pack_pos_to_offset(pack->p, pos);
+	offset = delta_obj_offset = pack_pos_to_offset(pack->p, pack_pos);
 	type = unpack_object_header(pack->p, w_curs, &offset, &size);
 	if (type < 0)
 		return -1; /* broken packfile, punt */
@@ -1884,6 +1863,7 @@ static int try_partial_reuse(struct bitmapped_pack *pack,
 	if (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA) {
 		off_t base_offset;
 		uint32_t base_pos;
+		uint32_t base_bitmap_pos;
 
 		/*
 		 * Find the position of the base object so we can look it up
@@ -1897,20 +1877,44 @@ static int try_partial_reuse(struct bitmapped_pack *pack,
 					     delta_obj_offset);
 		if (!base_offset)
 			return 0;
-		if (offset_to_pack_pos(pack->p, base_offset, &base_pos) < 0)
-			return 0;
 
-		/*
-		 * We assume delta dependencies always point backwards. This
-		 * lets us do a single pass, and is basically always true
-		 * due to the way OFS_DELTAs work. You would not typically
-		 * find REF_DELTA in a bitmapped pack, since we only bitmap
-		 * packs we write fresh, and OFS_DELTA is the default). But
-		 * let's double check to make sure the pack wasn't written with
-		 * odd parameters.
-		 */
-		if (base_pos >= pos)
-			return 0;
+		offset_to_pack_pos(pack->p, base_offset, &base_pos);
+
+		if (bitmap_is_midx(bitmap_git)) {
+			/*
+			 * Cross-pack deltas are rejected for now, but could
+			 * theoretically be supported in the future.
+			 *
+			 * We would need to ensure that we're sending both
+			 * halves of the delta/base pair, regardless of whether
+			 * or not the two cross a pack boundary. If they do,
+			 * then we must convert the delta to an REF_DELTA to
+			 * refer back to the base in the other pack.
+			 * */
+			if (midx_pair_to_pack_pos(bitmap_git->midx,
+						  pack->pack_int_id,
+						  base_offset,
+						  &base_bitmap_pos) < 0) {
+				return 0;
+			}
+		} else {
+			if (offset_to_pack_pos(pack->p, base_offset,
+					       &base_pos) < 0)
+				return 0;
+			/*
+			 * We assume delta dependencies always point backwards.
+			 * This lets us do a single pass, and is basically
+			 * always true due to the way OFS_DELTAs work. You would
+			 * not typically find REF_DELTA in a bitmapped pack,
+			 * since we only bitmap packs we write fresh, and
+			 * OFS_DELTA is the default). But let's double check to
+			 * make sure the pack wasn't written with odd
+			 * parameters.
+			 */
+			if (base_pos >= pack_pos)
+				return 0;
+			base_bitmap_pos = pack->bitmap_pos + base_pos;
+		}
 
 		/*
 		 * And finally, if we're not sending the base as part of our
@@ -1920,14 +1924,14 @@ static int try_partial_reuse(struct bitmapped_pack *pack,
 		 * to REF_DELTA on the fly. Better to just let the normal
 		 * object_entry code path handle it.
 		 */
-		if (!bitmap_get(reuse, pack->bitmap_pos + base_pos))
+		if (!bitmap_get(reuse, base_bitmap_pos))
 			return 0;
 	}
 
 	/*
 	 * If we got here, then the object is OK to reuse. Mark it.
 	 */
-	bitmap_set(reuse, pack->bitmap_pos + pos);
+	bitmap_set(reuse, bitmap_pos);
 	return 0;
 }
 
@@ -1937,36 +1941,72 @@ static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
 {
 	struct bitmap *result = bitmap_git->result;
 	struct pack_window *w_curs = NULL;
-	size_t i = 0;
+	size_t pos = pack->bitmap_pos / BITS_IN_EWORD;
 
-	while (i < result->word_alloc && result->words[i] == (eword_t)~0)
-		i++;
+	if (!pack->bitmap_pos) {
+		/*
+		 * If we're processing the first (in the case of a MIDX, the
+		 * preferred pack) or the only (in the case of single-pack
+		 * bitmaps) pack, then we can reuse whole words at a time.
+		 *
+		 * This is because we know that any deltas in this range *must*
+		 * have their bases chosen from the same pack, since:
+		 *
+		 * - In the single pack case, there is no other pack to choose
+		 *   them from.
+		 *
+		 * - In the MIDX case, the first pack is the preferred pack, so
+		 *   all ties are broken in favor of that pack (i.e. the one
+		 *   we're currently processing). So any duplicate bases will be
+		 *   resolved in favor of the pack we're processing.
+		 */
+		while (pos < result->word_alloc &&
+		       pos < pack->bitmap_nr / BITS_IN_EWORD &&
+		       result->words[pos] == (eword_t)~0)
+			pos++;
+		memset(reuse->words, 0xFF, pos * sizeof(eword_t));
+	}
 
-	/*
-	 * Don't mark objects not in the packfile or preferred pack. This bitmap
-	 * marks objects eligible for reuse, but the pack-reuse code only
-	 * understands how to reuse a single pack. Since the preferred pack is
-	 * guaranteed to have all bases for its deltas (in a multi-pack bitmap),
-	 * we use it instead of another pack. In single-pack bitmaps, the choice
-	 * is made for us.
-	 */
-	if (i > pack->p->num_objects / BITS_IN_EWORD)
-		i = pack->p->num_objects / BITS_IN_EWORD;
-
-	memset(reuse->words, 0xFF, i * sizeof(eword_t));
-
-	for (; i < result->word_alloc; ++i) {
-		eword_t word = result->words[i];
-		size_t pos = (i * BITS_IN_EWORD);
+	for (; pos < result->word_alloc; pos++) {
+		eword_t word = result->words[pos];
 		size_t offset;
 
-		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
-			if ((word >> offset) == 0)
+		for (offset = 0; offset < BITS_IN_EWORD; offset++) {
+			size_t bit_pos;
+			uint32_t pack_pos;
+
+			if (word >> offset == 0)
 				break;
 
 			offset += ewah_bit_ctz64(word >> offset);
-			if (try_partial_reuse(pack, pos + offset,
-					      reuse, &w_curs) < 0) {
+
+			bit_pos = pos * BITS_IN_EWORD + offset;
+			if (bit_pos < pack->bitmap_pos)
+				continue;
+			if (bit_pos >= pack->bitmap_pos + pack->bitmap_nr)
+				goto done;
+
+			if (bitmap_is_midx(bitmap_git)) {
+				uint32_t midx_pos;
+				off_t ofs;
+
+				midx_pos = pack_pos_to_midx(bitmap_git->midx, bit_pos);
+				ofs = nth_midxed_offset(bitmap_git->midx, midx_pos);
+
+				if (offset_to_pack_pos(pack->p, ofs, &pack_pos) < 0)
+					BUG("could not find object in pack %s "
+					    "at offset %"PRIuMAX" in MIDX",
+					    pack_basename(pack->p), (uintmax_t)ofs);
+			} else {
+				pack_pos = cast_size_t_to_uint32_t(st_sub(bit_pos, pack->bitmap_pos));
+				if (pack_pos >= pack->p->num_objects)
+					BUG("advanced beyond the end of pack %s (%"PRIuMAX" > %"PRIu32")",
+					    pack_basename(pack->p), (uintmax_t)pack_pos,
+					    pack->p->num_objects);
+			}
+
+			if (try_partial_reuse(bitmap_git, pack, bit_pos,
+					      pack_pos, reuse, &w_curs) < 0) {
 				/*
 				 * try_partial_reuse indicated we couldn't reuse
 				 * any bits, so there is no point in trying more
-- 
2.43.0.102.ga31d690331.dirty


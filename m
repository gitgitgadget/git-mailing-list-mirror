Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VzUPdWqp"
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A970198D
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:47 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77a453eb01cso311571685a.0
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198526; x=1701803326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oe0M/K9IEuvFNDS0SqHzhQrVS8Rynou0B7htzngm67E=;
        b=VzUPdWqp8R+aiA0jN9vIObiQhvtkEBzr3/FHB/M76gkdIPbdPUpHR2E8iy0ZfZNpXU
         Lsw+7HtEEtglm6F+LbZoyh4qPtNkOx09Vx1fmuIIl0tBltNw9Fy6bSjh5ahKJqF/Pxbq
         gvdPkssdpcxaw5YhDEwT9iED8HRiuPljYMnS5Q1cHOm6XRIAOpH9u4FyrsI6iPkMBkUv
         pUTelLmDt0oOQ4bvYGoHXSthveCLoDdYYUHSQUFle3trYk9ncMRVnJQGxcITymPd8DLn
         xZtzzBJCVe8cbv9xiixCyGMQ9RQcPlUp0OX5b0yJnaTBGCbpKPXDINjRBpdYUmnATYAU
         1maA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198526; x=1701803326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oe0M/K9IEuvFNDS0SqHzhQrVS8Rynou0B7htzngm67E=;
        b=E2tDfaidBn0JxyZ0swJ5kjhTup83je7VMdCZYDYzvntcuqEQ6VyoLC7gsJiKrYVJoP
         +uKGuAEI3hQaBUqwnQpNfUWdfuHgDCQ9/rosoLVL45m/M0iVPGrts+gJsnGb1hYOWEIe
         eXRzfvJ7/VreNeA4+q8AFI0z9K46jUUMdw3nXkJV6JzBVE05BPb5Zz7Zu6QpBb5glZ5W
         m9OjhnnO2Uk5UeALUxXs7ksD6to5cEbsqLPvm5JKjuVpDjWA9g7/sfejGkpBULW/tN0e
         pGUefQtPte0PEMvB8JUL9YYGxnlM6nKLuY2Er5ypX+y7kyWau4U8IB6irhhDQ8g4TEtF
         UcmA==
X-Gm-Message-State: AOJu0YxOGoENDga8TvY1lgi8Q2TA0LsWpla6cB4GEDvl8o0a9KB7oexU
	uiIqRPABtEID3Ob3e1kjE+Y6dsAIks3bPg/xZ6w=
X-Google-Smtp-Source: AGHT+IFFPr/RYubkQXaptnXUmKcaXLsuNQ+fj7YFmyeLLN4iljBtRLlBNY0QmJ3jSjprj3ZnXHlUFQ==
X-Received: by 2002:ae9:ee05:0:b0:77d:645a:85e7 with SMTP id i5-20020ae9ee05000000b0077d645a85e7mr14906765qkg.42.1701198526221;
        Tue, 28 Nov 2023 11:08:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id de8-20020a05620a370800b0077d78afc513sm3468060qkb.110.2023.11.28.11.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:46 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:45 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 19/24] pack-bitmap: prepare to mark objects from multiple
 packs for reuse
Message-ID: <176c4c95ac90a37b9ccf684e39126836d2cadc97.1701198172.git.me@ttaylorr.com>
References: <cover.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1701198172.git.me@ttaylorr.com>

Now that the pack-objects code is equipped to handle reusing objects
from multiple packs, prepare the pack-bitmap code to mark objects from
multiple packs as reuse candidates.

In order to prepare the pack-bitmap code for this change, remove the
same set of assumptions we unwound in previous commits from the helper
function `reuse_partial_packfile_from_bitmap_1()`, in preparation for it
to be called in a loop over the set of disjoint packs in a following
commit.

Specifically, remove the assumption that the bit position corresponding
to the first object in a given reuse pack candidate is at a word
boundary. Like in previous commits, we have to walk up to the first word
boundary before marking whole words at a time for reuse. Unlike in
previous commits, however, we have to keep track of whether all of the
objects in the run-up to the first word boundary are wanted in the
resulting pack. This is because we cannot blindly reuse whole words at a
time unless we know for certain that we are sending all bases for any
objects stored as deltas within each word.

Once we're on a word boundary (provided that we want a complete prefix
of objects from the pack), we can then reuse the same "whole-words"
optimization from previous patches, marking all of the bits in a single
word at a time.

Any remaining objects (either from a partial word corresponding to
objects at the end of a pack, or starting from the middle of the pack if
we do not have a complete prefix) are dealt with individually via
try_partial_reuse(), which (among other things) ensures that we are
sending the necessary bases for all objects packed as OFS_DELTA or
REF_DELTA.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 113 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 93 insertions(+), 20 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 670deec909..be53fc6da5 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1940,36 +1940,109 @@ static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
 {
 	struct bitmap *result = bitmap_git->result;
 	struct pack_window *w_curs = NULL;
-	size_t i = 0;
+	size_t pos, offset;
+	unsigned complete_prefix = 1;
 
-	while (i < result->word_alloc && result->words[i] == (eword_t)~0)
-		i++;
+	pos = pack->bitmap_pos / BITS_IN_EWORD;
+	offset = pack->bitmap_pos % BITS_IN_EWORD;
 
 	/*
-	 * Don't mark objects not in the packfile or preferred pack. This bitmap
-	 * marks objects eligible for reuse, but the pack-reuse code only
-	 * understands how to reuse a single pack. Since the preferred pack is
-	 * guaranteed to have all bases for its deltas (in a multi-pack bitmap),
-	 * we use it instead of another pack. In single-pack bitmaps, the choice
-	 * is made for us.
+	 * If the position of our first object is not on a word
+	 * boundary, check all bits individually until we reach the
+	 * first word boundary.
+	 *
+	 * If no bits are missing between pack->bitmap_pos and the next
+	 * word boundary, then we can move by whole words instead of by
+	 * individual objects. If one or more of the objects are missing
+	 * in that range, we must evaluate each subsequent object
+	 * individually in order to exclude deltas whose base we are not
+	 * sending, etc.
 	 */
-	if (i > pack->p->num_objects / BITS_IN_EWORD)
-		i = pack->p->num_objects / BITS_IN_EWORD;
+	if (offset) {
+		/*
+		 * Scan to the next word boundary, or through the last
+		 * object in this bitmap, whichever occurs earlier.
+		 */
+		size_t last;
+		eword_t word = result->words[pos];
+		if (pack->bitmap_nr < BITS_IN_EWORD - offset)
+			last = offset + pack->bitmap_nr;
+		else
+			last = BITS_IN_EWORD;
 
-	memset(reuse->words, 0xFF, i * sizeof(eword_t));
+		for (; offset < last; offset++) {
+			size_t pack_pos;
+			if (word >> offset == 0) {
+				complete_prefix = 0;
+				continue;
+			}
 
-	for (; i < result->word_alloc; ++i) {
-		eword_t word = result->words[i];
-		size_t pos = (i * BITS_IN_EWORD);
-		size_t offset;
+			offset += ewah_bit_ctz64(word >> offset);
 
-		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
-			if ((word >> offset) == 0)
+			pack_pos = pos * BITS_IN_EWORD + offset;
+			pack_pos -= pack->bitmap_pos;
+
+			try_partial_reuse(pack, pack_pos, reuse, &w_curs);
+			if (!bitmap_get(reuse, pos + pack->bitmap_pos))
+				complete_prefix = 0;
+		}
+
+		pos++;
+	}
+
+	if (complete_prefix) {
+		/*
+		 * If we are using all of the objects at the beginning
+		 * of this pack, we can safely reuse objects in eword_t
+		 * sized chunks, since we are guaranteed to send all
+		 * potential delta bases.
+		 *
+		 * Scan the nearest word boundaries within range of this
+		 * pack's bit positions. If the pack does not start on a
+		 * word boundary, skip to the next boundary, since we
+		 * have already checked above.
+		 */
+		size_t start = pos;
+		size_t word_end = (pack->bitmap_pos + pack->bitmap_nr) / BITS_IN_EWORD;
+		while (start <= pos && pos < word_end &&
+		       pos < result->word_alloc &&
+		       result->words[pos] == (eword_t)~0)
+			pos++;
+		memset(reuse->words + start, 0xFF, (pos - start) * sizeof(eword_t));
+	}
+
+	/*
+	 * At this point, we know that we are at an eword boundary,
+	 * either because:
+	 *
+	 *   - we started at one and used zero or more whole words
+	 *     following pack->bitmap_pos
+	 *
+	 *   - we started in between two word boundaries, advanced
+	 *     forward to the next word boundary, and then used zero or
+	 *     more (assuming a complete prefix) whole words following.
+	 */
+	for (; pos < result->word_alloc; pos++) {
+		eword_t word = result->words[pos];
+
+		for (offset = 0; offset < BITS_IN_EWORD; offset++) {
+			size_t bit_pos, pack_pos;
+			if (word >> offset == 0)
 				break;
 
 			offset += ewah_bit_ctz64(word >> offset);
-			if (try_partial_reuse(pack, pos + offset,
-					      reuse, &w_curs) < 0) {
+
+			bit_pos = pos * BITS_IN_EWORD + offset;
+			if (bit_pos >= pack->bitmap_pos + pack->bitmap_nr)
+				goto done;
+
+			pack_pos = bit_pos - pack->bitmap_pos;
+			if (pack_pos >= pack->p->num_objects)
+				BUG("advanced beyond the end of pack %s (%"PRIuMAX" > %"PRIu32")",
+				    pack_basename(pack->p), (uintmax_t)pack_pos,
+				    pack->p->num_objects);
+
+			if (try_partial_reuse(pack, pack_pos, reuse, &w_curs) < 0) {
 				/*
 				 * try_partial_reuse indicated we couldn't reuse
 				 * any bits, so there is no point in trying more
-- 
2.43.0.24.g980b318f98


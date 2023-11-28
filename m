Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KRIFk0JR"
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A921C3
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:42 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77d90497b86so184410185a.0
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198521; x=1701803321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbKNY7VNNH+QCW70ZspylXD6r6Zjz9ZM4nRfzSIaKf4=;
        b=KRIFk0JR3s2PZOZZ+U8XvECgp/JmR3zGCGTRJP8uDOKAsV3DMMKuYZo1HJQQzCYH4c
         SZCqErDdkG6U+4P9m20r9DVQsWTS6MIdmwOTDJNW83DTR5XjbHPOfwwVv4PPLOCc+vR/
         WoEPs1rmy6D1nk3PCNsnl4/J5tFPTRAlvfup+lCAWG4cX7UARTlTvQxLVxdFMMGmGdJt
         s+hNYwvymNs4LJykDts9otWzILcnqR3JgmGB7M5rnhAUFqzPLVF1SO0yeSu2lZCsMgQ2
         l1htOkK7hC3vXtoL7Xefuf+8Xc3oh3ZEUVnCpgt4TJWJfGMIy69g0x4zKGtKCI+syork
         Y4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198521; x=1701803321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbKNY7VNNH+QCW70ZspylXD6r6Zjz9ZM4nRfzSIaKf4=;
        b=DQYmYzMPIwK4yX4B8rexb4bKN/d30NXRGqmej0X466CL2WjkeyrRwBHrc3rmJENuBl
         xG0su9AzFOV1OSshrNOrYAXDavqhuuJgPPvxiaWkTe4geIWyr4wOWUs8mBuDAkzgRTVJ
         iVKJ4mtgE5SDKY4Is+734fIDQyWASSorZWnffck2dv1wJf0noVVUJDe4qeAYEfU15CDB
         HnlhdctXJzLEc4WLzarxpHF6ttKzQrCzYxY5TJ/6WoEbsSSEfyJLCu2m+4/mPQzFwGxv
         0tTiIVSQ2GuwdDQv3MZyLms9uILpQRmVcFR0aPPgOmV+NSgwZUgCBd/Z6vjO7CzQx+as
         J6SQ==
X-Gm-Message-State: AOJu0YzDqJM/a7wdXG5gYGr/sDreugLWY8xDGwtgazRRoAuen/iF2+Qd
	9zGIwFzFEy3ZaIYqCbj/5eP73u0D1hkeTWHkbe8=
X-Google-Smtp-Source: AGHT+IHks86Jl2+dFFRowpcz9ARa1ei7WhDjOqPmzqLwsNMJMXYjxIKXvXoz23XWptWyT7JcypR77w==
X-Received: by 2002:a05:620a:1455:b0:77d:73fd:c79 with SMTP id i21-20020a05620a145500b0077d73fd0c79mr15964483qkl.53.1701198520953;
        Tue, 28 Nov 2023 11:08:40 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bi40-20020a05620a31a800b0077da68b8801sm2066973qkb.65.2023.11.28.11.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:40 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:40 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 17/24] pack-objects: prepare `write_reused_pack_verbatim()`
 for multi-pack reuse
Message-ID: <1f766648df5f80a178d6eae31cb25fc8484ef84e.1701198172.git.me@ttaylorr.com>
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

The function `write_reused_pack_verbatim()` within
`builtin/pack-objects.c` is responsible for writing out a continuous
set of objects beginning at the start of the reuse packfile.

In the existing implementation, we did something like:

    while (pos < reuse_packfile_bitmap->word_alloc &&
           reuse_packfile_bitmap->words[pos] == (eword_t)~0)
      pos++;

    if (pos)
      /* write first `pos * BITS_IN_WORD` objects from pack */

as an optimization to record a single chunk for the longest continuous
prefix of objects wanted out of the reuse pack, instead of having a
chunk for each individual object. For more details, see bb514de356
(pack-objects: improve partial packfile reuse, 2019-12-18).

In order to retain this optimization in a multi-pack reuse world, we can
no longer assume that the first object in a pack is on a word boundary
in the bitmap storing the set of reusable objects.

Assuming that all objects from the beginning of the reuse packfile up to
the object corresponding to the first bit on a word boundary are part of
the result, consume whole words at a time until the last whole word
belonging to the reuse packfile. Copy those objects to the resulting
packfile, and track that we reused them by recording a single chunk.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 73 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b5e6f6377a..e37509568b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1098,31 +1098,78 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 
 static size_t write_reused_pack_verbatim(struct bitmapped_pack *reuse_packfile,
 					 struct hashfile *out,
-					 off_t pack_start UNUSED,
+					 off_t pack_start,
 					 struct pack_window **w_curs)
 {
-	size_t pos = 0;
+	size_t pos = reuse_packfile->bitmap_pos;
+	size_t end;
 
-	while (pos < reuse_packfile_bitmap->word_alloc &&
-			reuse_packfile_bitmap->words[pos] == (eword_t)~0)
-		pos++;
+	if (pos % BITS_IN_EWORD) {
+		size_t word_pos = (pos / BITS_IN_EWORD);
+		size_t offset = pos % BITS_IN_EWORD;
+		size_t last;
+		eword_t word = reuse_packfile_bitmap->words[word_pos];
 
-	if (pos) {
-		off_t to_write;
+		if (offset + reuse_packfile->bitmap_nr < BITS_IN_EWORD)
+			last = offset + reuse_packfile->bitmap_nr;
+		else
+			last = BITS_IN_EWORD;
 
-		written = (pos * BITS_IN_EWORD);
-		to_write = pack_pos_to_offset(reuse_packfile->p, written)
-			- sizeof(struct pack_header);
+		for (; offset < last; offset++) {
+			if (word >> offset == 0)
+				return word_pos;
+			if (!bitmap_get(reuse_packfile_bitmap,
+					word_pos * BITS_IN_EWORD + offset))
+				return word_pos;
+		}
+
+		pos += BITS_IN_EWORD - (pos % BITS_IN_EWORD);
+	}
+
+	/*
+	 * Now we're going to copy as many whole eword_t's as possible.
+	 * "end" is the index of the last whole eword_t we copy, but
+	 * there may be additional bits to process. Those are handled
+	 * individually by write_reused_pack().
+	 *
+	 * Begin by advancing to the first word boundary in range of the
+	 * bit positions occupied by objects in "reuse_packfile". Then
+	 * pick the last word boundary in the same range. If we have at
+	 * least one word's worth of bits to process, continue on.
+	 */
+	end = reuse_packfile->bitmap_pos + reuse_packfile->bitmap_nr;
+	if (end % BITS_IN_EWORD)
+		end -= end % BITS_IN_EWORD;
+	if (pos >= end)
+		return reuse_packfile->bitmap_pos / BITS_IN_EWORD;
+
+	while (pos < end &&
+	       reuse_packfile_bitmap->words[pos / BITS_IN_EWORD] == (eword_t)~0)
+		pos += BITS_IN_EWORD;
+
+	if (pos > end)
+		pos = end;
+
+	if (reuse_packfile->bitmap_pos < pos) {
+		off_t pack_start_off = pack_pos_to_offset(reuse_packfile->p, 0);
+		off_t pack_end_off = pack_pos_to_offset(reuse_packfile->p,
+							pos - reuse_packfile->bitmap_pos);
+
+		written += pos - reuse_packfile->bitmap_pos;
 
 		/* We're recording one chunk, not one object. */
-		record_reused_object(sizeof(struct pack_header), 0);
+		record_reused_object(pack_start_off,
+				     pack_start_off - (hashfile_total(out) - pack_start));
 		hashflush(out);
 		copy_pack_data(out, reuse_packfile->p, w_curs,
-			sizeof(struct pack_header), to_write);
+			pack_start_off, pack_end_off - pack_start_off);
 
 		display_progress(progress_state, written);
 	}
-	return pos;
+	if (pos % BITS_IN_EWORD)
+		BUG("attempted to jump past a word boundary to %"PRIuMAX,
+		    (uintmax_t)pos);
+	return pos / BITS_IN_EWORD;
 }
 
 static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
-- 
2.43.0.24.g980b318f98


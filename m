Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73FE66AC4
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0dSclZ5q"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d9f879f784so60338a34.2
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592645; x=1703197445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lt9BCHjvdrmObONlTkDEC+OLN2lDb4n9PEi2jy5LUrs=;
        b=0dSclZ5qlfX44SmLucj43/mdzJAshHwCgEezrWOlLgS734dTgxJp7rY1+6Y4O7ih91
         LKP4HGq9rWQfMJkSVOKoV63SD41PttUo6CD0R7KAQCEFVMLYz9DtqZ2WT6aYl1dhGGRG
         2rpBe5G6rAJDcnQFlR7BLAF6NkFKdSzDNspcJiGx8AH0+uQmbPjrxv0aiuea+4dH4n1h
         4O8TkhPd9HniSbi4+kCNAoICMicJujX8XsYZlmpT6S88Y5AgCKmJbSvbq1pFrdmJLb5D
         klX/Tbrl91+nXus4MYxtpGyRiYEoxNwkFvhvHqMpTaMZnHJe9qTqHTYowPVkvxv4s7hF
         fJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592645; x=1703197445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lt9BCHjvdrmObONlTkDEC+OLN2lDb4n9PEi2jy5LUrs=;
        b=FDd6rMXIBSB7VKuqX99jWalKUzlnbOhiTRyhfj0x0/tHQjDYoMbW0TqGKg5ZreIMMm
         yWdFgR1tiVDn3RqHuPY4sGWQv50rvbRX6gcGpo2PV95ZlgnzYqSUIN9+KZbz/KxUgu5k
         ihvxJSymwqQl1GnI+kZPrLGmP5RzdolnQme4e0B+qRZdXuig15tMmb1WuAhDyUIIcSeT
         7CaPGEyUjv4x8mCyb3MiBSxrkuD5CzZkk1/hVMg3PPMwF6DqIn+k7OzKUCet/8XFj1gz
         bkE8rulD1eQAEZiyZMHdDUDCz0R0vB+VQ3zLjqQneslbT/Ho/pihtOronLvheAKkJAAz
         KsQw==
X-Gm-Message-State: AOJu0YxuG3Xm2yj13ReJuBtLv33Q7jZaiA98I9VAuhAlkxNlJDyhX943
	/oOwZoN+IINfaUL6WjIzrIBT1W2eQfZ3ZgvYCnST4w==
X-Google-Smtp-Source: AGHT+IGOVzyHRaunzRx8BM1ChCZ5VzOp3+kyGJS5FgtIZ/JNs3bbSAazbwDZOXCgHQSSSepJ7I202g==
X-Received: by 2002:a9d:6a10:0:b0:6d9:e01c:6b79 with SMTP id g16-20020a9d6a10000000b006d9e01c6b79mr10756559otn.30.1702592645492;
        Thu, 14 Dec 2023 14:24:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id da15-20020a0568306a8f00b006ce28044207sm1098118otb.58.2023.12.14.14.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:05 -0800 (PST)
Date: Thu, 14 Dec 2023 17:24:04 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/26] pack-bitmap: return multiple packs via
 `reuse_partial_packfile_from_bitmap()`
Message-ID: <f551892bab54f855556ca6a35168717285ce4e75.1702592604.git.me@ttaylorr.com>
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

Further prepare for enabling verbatim pack-reuse over multiple packfiles
by changing the signature of reuse_partial_packfile_from_bitmap() to
populate an array of `struct bitmapped_pack *`'s instead of a pointer to
a single packfile.

Since the array we're filling out is sized dynamically[^1], add an
additional `size_t *` parameter which will hold the number of reusable
packs (equal to the number of elements in the array).

Note that since we still have not implemented true multi-pack reuse,
these changes aren't propagated out to the rest of the caller in
builtin/pack-objects.c.

In the interim state, we expect that the array has a single element, and
we use that element to fill out the static `reuse_packfile` variable
(which is a bog-standard `struct packed_git *`). Future commits will
continue to push this change further out through the pack-objects code.

[^1]: That is, even though we know the number of packs which are
  candidates for pack-reuse, we do not know how many of those
  candidates we can actually reuse.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 9 +++++++--
 pack-bitmap.c          | 6 ++++--
 pack-bitmap.h          | 5 +++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c3df6d9657..87e16636a8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3940,14 +3940,19 @@ static int pack_options_allow_reuse(void)
 
 static int get_object_list_from_bitmap(struct rev_info *revs)
 {
+	struct bitmapped_pack *packs = NULL;
+	size_t packs_nr = 0;
+
 	if (!(bitmap_git = prepare_bitmap_walk(revs, 0)))
 		return -1;
 
 	if (pack_options_allow_reuse())
-		reuse_partial_packfile_from_bitmap(bitmap_git, &reuse_packfile,
+		reuse_partial_packfile_from_bitmap(bitmap_git, &packs,
+						   &packs_nr,
 						   &reuse_packfile_bitmap);
 
-	if (reuse_packfile) {
+	if (packs) {
+		reuse_packfile = packs[0].p;
 		reuse_packfile_objects = bitmap_popcount(reuse_packfile_bitmap);
 		if (!reuse_packfile_objects)
 			BUG("expected non-empty reuse bitmap");
diff --git a/pack-bitmap.c b/pack-bitmap.c
index c75a83e9cc..4d5a484678 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2001,7 +2001,8 @@ static int bitmapped_pack_cmp(const void *va, const void *vb)
 }
 
 void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
-					struct packed_git **packfile_out,
+					struct bitmapped_pack **packs_out,
+					size_t *packs_nr_out,
 					struct bitmap **reuse_out)
 {
 	struct repository *r = the_repository;
@@ -2069,7 +2070,8 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	 * need to be handled separately.
 	 */
 	bitmap_and_not(result, reuse);
-	*packfile_out = packs[0].p;
+	*packs_out = packs;
+	*packs_nr_out = packs_nr;
 	*reuse_out = reuse;
 }
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index ab3fdcde6b..7a12a2ce81 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -78,8 +78,9 @@ int test_bitmap_hashes(struct repository *r);
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 					 int filter_provided_objects);
 uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git);
-void reuse_partial_packfile_from_bitmap(struct bitmap_index *,
-					struct packed_git **packfile,
+void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
+					struct bitmapped_pack **packs_out,
+					size_t *packs_nr_out,
 					struct bitmap **reuse_out);
 int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping,
 			     kh_oid_map_t *reused_bitmaps, int show_progress);
-- 
2.43.0.102.ga31d690331.dirty


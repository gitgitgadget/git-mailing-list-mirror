Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D182C695
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iv/kuNnS"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6da4e123a96so76392a34.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592666; x=1703197466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=szECaOx7WJurAk3hx1kksvbITTjbggMIrpyIu8xsP6k=;
        b=iv/kuNnSKVPrwPtiTpGqoC6NCFnJ22wFg4ePu1buQtB9O8WZ2D1bZNcXkkAHNv+f8l
         oNT7pJbhRlDo9wx117L47DoecgDPVHidYIUfui07OJFuR6/PSFm21vFpyRu37BJDH+GE
         oVZUGzBEtms72xOlDMEin1mxx6qXbSyNbVfQxmqHc+otiwOGUMwNHAC7+D1GhnSOssJ+
         WpEbyo8twANSqh2mwcMIZ1EV2O0ig9G+7dfNjqSjrGcnBOEtkwmthjUfb2hyvA2bgt+r
         8WerNORK3tK8BBXdeVJDD42O3FdLC3qKMjml0H7vGrN9wzpHzMVHKWBHwATaoG23Sn/n
         Naog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592666; x=1703197466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szECaOx7WJurAk3hx1kksvbITTjbggMIrpyIu8xsP6k=;
        b=KLEC/TNymn7QNlcQFmM2wtpQfLBu0jMfJoJdQIm9YJmWD/jyXlaxCW1n4vBL+bJLKL
         Cy/pENpT3BsDT+MlwWQhw9lqFXv/F/y/hMM1MZVW8kJcoD/UnIe/nIOvfRMGjROliIML
         PtTu86qJ1AavJCBxx0cDLyZpICVDL1SI9uR0Ap1yvY63KtSDDHL28GC8dmhXYxA2btQG
         sJ4kBBTN1N2cRGT4ed0slSdJAFVtYxb3Uva2xn9I3mz8+cXyzQzZd5rADledOXirrCnL
         npEzSjKQpsy4kY8VyZ3Gz2z2O+KFxxwIeW6njuehrUAwbd9lD4twZckSlWh05p9KfTll
         7GdQ==
X-Gm-Message-State: AOJu0YyYCYaJvLKt0rRvHB71h17HdnEVjz+Qv8nt20ykBPvhek+HlJ3R
	SLg9n2ZKYMLrZu+P80HYCsU998/lJrYk2CAkgD7unA==
X-Google-Smtp-Source: AGHT+IEs6FV2lIfI9LVcmaHEfP+VMwuDfO2dxHWdCjyWLao/6rBdWLXVmLWmBTOxVGpVhpJkABpnsQ==
X-Received: by 2002:a05:6830:457:b0:6da:4a6c:44a7 with SMTP id d23-20020a056830045700b006da4a6c44a7mr869197otc.27.1702592666415;
        Thu, 14 Dec 2023 14:24:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g4-20020a9d6c44000000b006d879b8e68csm3343902otq.69.2023.12.14.14.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:26 -0800 (PST)
Date: Thu, 14 Dec 2023 17:24:25 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 18/26] midx: implement `midx_preferred_pack()`
Message-ID: <ab0456a71e5385c772c385d727e74e9fddf30669.1702592604.git.me@ttaylorr.com>
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

When performing a binary search over the objects in a MIDX's bitmap
(i.e. in pseudo-pack order), the reader reconstructs the pseudo-pack
ordering using a combination of (a) the preferred pack, (b) the pack's
lexical position in the MIDX based on pack names, and (c) the object
offset within the pack.

In order to perform this binary search, the reader must know the
identity of the preferred pack. This could be stored in the MIDX, but
isn't for historical reasons, mostly because it can easily be inferred
at read-time by looking at the object in the first bit position and
finding out which pack it was selected from in the MIDX, like so:

    nth_midxed_pack_int_id(m, pack_pos_to_midx(m, 0));

In midx_to_pack_pos() which performs this binary search, we look up the
identity of the preferred pack before each search. This is relatively
quick, since it involves two table-driven lookups (one in the MIDX's
revindex for `pack_pos_to_midx()`, and another in the MIDX's object
table for `nth_midxed_pack_int_id()`).

But since the preferred pack does not change after the MIDX is written,
it is safe to cache this value on the MIDX itself.

Write a helper to do just that, and rewrite all of the existing
call-sites that care about the identity of the preferred pack in terms
of this new helper.

This will prepare us for a subsequent patch where we will need to binary
search through the MIDX's pseudo-pack order multiple times.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c                    | 20 ++++++++++++++++++++
 midx.h                    |  2 ++
 pack-bitmap.c             | 17 +++++++----------
 pack-bitmap.h             |  1 -
 pack-revindex.c           |  4 +++-
 t/helper/test-read-midx.c | 13 +++++--------
 6 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/midx.c b/midx.c
index beaf0c0de4..85e1c2cd12 100644
--- a/midx.c
+++ b/midx.c
@@ -21,6 +21,7 @@
 #include "refs.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "pack-revindex.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -177,6 +178,8 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 
 	m->num_packs = get_be32(m->data + MIDX_BYTE_NUM_PACKS);
 
+	m->preferred_pack_idx = -1;
+
 	cf = init_chunkfile(NULL);
 
 	if (read_table_of_contents(cf, m->data, midx_size,
@@ -460,6 +463,23 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 	return midx_locate_pack(m, idx_or_pack_name, NULL);
 }
 
+int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
+{
+	if (m->preferred_pack_idx == -1) {
+		if (load_midx_revindex(m) < 0) {
+			m->preferred_pack_idx = -2;
+			return -1;
+		}
+
+		m->preferred_pack_idx =
+			nth_midxed_pack_int_id(m, pack_pos_to_midx(m, 0));
+	} else if (m->preferred_pack_idx == -2)
+		return -1; /* no revindex */
+
+	*pack_int_id = m->preferred_pack_idx;
+	return 0;
+}
+
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local)
 {
 	struct multi_pack_index *m;
diff --git a/midx.h b/midx.h
index 89c5aa637e..f87a8fff26 100644
--- a/midx.h
+++ b/midx.h
@@ -29,6 +29,7 @@ struct multi_pack_index {
 	unsigned char num_chunks;
 	uint32_t num_packs;
 	uint32_t num_objects;
+	int preferred_pack_idx;
 
 	int local;
 
@@ -74,6 +75,7 @@ int midx_contains_pack(struct multi_pack_index *m,
 		       const char *idx_or_pack_name);
 int midx_locate_pack(struct multi_pack_index *m, const char *idx_or_pack_name,
 		     uint32_t *pos);
+int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
 
 /*
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 4d5a484678..1682f99596 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -338,7 +338,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	struct stat st;
 	char *bitmap_name = midx_bitmap_filename(midx);
 	int fd = git_open(bitmap_name);
-	uint32_t i;
+	uint32_t i, preferred_pack;
 	struct packed_git *preferred;
 
 	if (fd < 0) {
@@ -393,7 +393,12 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		}
 	}
 
-	preferred = bitmap_git->midx->packs[midx_preferred_pack(bitmap_git)];
+	if (midx_preferred_pack(bitmap_git->midx, &preferred_pack) < 0) {
+		warning(_("could not determine MIDX preferred pack"));
+		goto cleanup;
+	}
+
+	preferred = bitmap_git->midx->packs[preferred_pack];
 	if (!is_pack_valid(preferred)) {
 		warning(_("preferred pack (%s) is invalid"),
 			preferred->pack_name);
@@ -1926,14 +1931,6 @@ static int try_partial_reuse(struct bitmapped_pack *pack,
 	return 0;
 }
 
-uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git)
-{
-	struct multi_pack_index *m = bitmap_git->midx;
-	if (!m)
-		BUG("midx_preferred_pack: requires non-empty MIDX");
-	return nth_midxed_pack_int_id(m, pack_pos_to_midx(bitmap_git->midx, 0));
-}
-
 static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git,
 						 struct bitmapped_pack *pack,
 						 struct bitmap *reuse)
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 7a12a2ce81..179b343912 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -77,7 +77,6 @@ int test_bitmap_hashes(struct repository *r);
 
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 					 int filter_provided_objects);
-uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git);
 void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 					struct bitmapped_pack **packs_out,
 					size_t *packs_nr_out,
diff --git a/pack-revindex.c b/pack-revindex.c
index acf1dd9786..7dc6c776d5 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -542,7 +542,9 @@ int midx_to_pack_pos(struct multi_pack_index *m, uint32_t at, uint32_t *pos)
 	 * implicitly is preferred (and includes all its objects, since ties are
 	 * broken first by pack identifier).
 	 */
-	key.preferred_pack = nth_midxed_pack_int_id(m, pack_pos_to_midx(m, 0));
+	if (midx_preferred_pack(key.midx, &key.preferred_pack) < 0)
+		return error(_("could not determine preferred pack"));
+
 
 	found = bsearch(&key, m->revindex_data, m->num_objects,
 			sizeof(*m->revindex_data), midx_pack_order_cmp);
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index e48557aba1..4acae41bb9 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -6,6 +6,7 @@
 #include "pack-bitmap.h"
 #include "packfile.h"
 #include "setup.h"
+#include "gettext.h"
 
 static int read_midx_file(const char *object_dir, int show_objects)
 {
@@ -79,7 +80,7 @@ static int read_midx_checksum(const char *object_dir)
 static int read_midx_preferred_pack(const char *object_dir)
 {
 	struct multi_pack_index *midx = NULL;
-	struct bitmap_index *bitmap = NULL;
+	uint32_t preferred_pack;
 
 	setup_git_directory();
 
@@ -87,16 +88,12 @@ static int read_midx_preferred_pack(const char *object_dir)
 	if (!midx)
 		return 1;
 
-	bitmap = prepare_bitmap_git(the_repository);
-	if (!bitmap)
-		return 1;
-	if (!bitmap_is_midx(bitmap)) {
-		free_bitmap_index(bitmap);
+	if (midx_preferred_pack(midx, &preferred_pack) < 0) {
+		warning(_("could not determine MIDX preferred pack"));
 		return 1;
 	}
 
-	printf("%s\n", midx->pack_names[midx_preferred_pack(bitmap)]);
-	free_bitmap_index(bitmap);
+	printf("%s\n", midx->pack_names[preferred_pack]);
 	return 0;
 }
 
-- 
2.43.0.102.ga31d690331.dirty


Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A4366ACB
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MfawSoxB"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ba1be5ad0aso51708b6e.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592686; x=1703197486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CkXBRJmZ/gCGMW3Z/EKezE9boZCgs6DFU8gHUaHQTCk=;
        b=MfawSoxBZBEPOA3GAY7Zl/NXok/W5BEhWfBE/p1WioG92I+oWYE2OB82nF/X3CZ3QL
         hkEhNgdoMuha3Jd17Qj0ErcfN8FZJ7KXAqVz6FZmXLIDwM6+1tC4X/NWpY9eMDB4lia+
         SbvpRGn/Ud0+QVCCIFsn3qEh0BuJ3Nt2ab/BmfAlYo16Gr/T0QjP7UyACj8gTkzMWqDO
         vJBuwqokH0KcuRBsVPkADwUvqIbM3dOlv7s2MANIatKFqRNmJmOmxAtgUiF8SRD1FHa0
         JRRGKfVqdnW3Qv20ZajH/22V8Aj/QYb3dxdwLixpvtJDtlgdIWKgvAxlcdJ8heGD1e+b
         GjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592686; x=1703197486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkXBRJmZ/gCGMW3Z/EKezE9boZCgs6DFU8gHUaHQTCk=;
        b=iRtXeZr4Knq6tPg8cjIVMTYF7f2ac9LNyCHhFQ4OBgwpDvGeBReL00GgrFaBxZ5CrR
         3RAmO46qaE3S8t04ow13dfL+4VYUfMmtpTX4tEbqTZb7oh0dYZ1MXGN3OGnL6zIf5OIb
         0BBc/SnhC1pHJ32aHjV2SMzYM3wlUUbrN8QYOlPdp86XW6Yxr5tjoB1DZRn86pjxwEZX
         Bl8LmICAoupZ5w0/b3+EPzZkH0caZopkTI837JDKFUm9FTjKeW19kLPqtkZ7I58LQO0B
         4LKfBedh9kqPBJtmUPHWK8VVVG5raUV64KsGKJ5R+68/QN88Lve3xHezuSulVAYfmgQ+
         n32g==
X-Gm-Message-State: AOJu0YwrCljEH0X31e+bhgYpAwM8V4gYYyLjA548JothEoVhwptahV/8
	XFdCKXTBjV4uSUx6t+TaTfh0JI5tVBMKgvhWjsWRyw==
X-Google-Smtp-Source: AGHT+IGbZ5eqjFMV+bV96YXxwsh/65EcEVZz3RYoGMn1zM0EW2jAcR9EMLnExHO2gFel5/xpHGQs9g==
X-Received: by 2002:a05:6808:f91:b0:3b8:b063:5d65 with SMTP id o17-20020a0568080f9100b003b8b0635d65mr12166463oiw.76.1702592685700;
        Thu, 14 Dec 2023 14:24:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i26-20020a54409a000000b003b2e2d134a5sm3562554oii.35.2023.12.14.14.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:45 -0800 (PST)
Date: Thu, 14 Dec 2023 17:24:44 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 25/26] pack-bitmap: enable reuse from all bitmapped packs
Message-ID: <7002cf08fe301f1de28137b798fab3c8c32337fa.1702592604.git.me@ttaylorr.com>
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

Now that both the pack-bitmap and pack-objects code are prepared to
handle marking and using objects from multiple bitmapped packs for
verbatim reuse, allow marking objects from all bitmapped packs as
eligible for reuse.

Within the `reuse_partial_packfile_from_bitmap()` function, we no longer
only mark the pack whose first object is at bit position zero for reuse,
and instead mark any pack contained in the MIDX as a reuse candidate.

Provide a handful of test cases in a new script (t5332) exercising
interesting behavior for multi-pack reuse to ensure that we performed
all of the previous steps correctly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/pack.txt |  16 ++-
 builtin/pack-objects.c        |   6 +-
 pack-bitmap.c                 |  34 ++++--
 pack-bitmap.h                 |   3 +-
 t/t5332-multi-pack-reuse.sh   | 203 ++++++++++++++++++++++++++++++++++
 5 files changed, 245 insertions(+), 17 deletions(-)
 create mode 100755 t/t5332-multi-pack-reuse.sh

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index fe100d0fb7..9c630863e6 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -28,11 +28,17 @@ all existing objects. You can force recompression by passing the -F option
 to linkgit:git-repack[1].
 
 pack.allowPackReuse::
-	When true or "single", and when reachability bitmaps are enabled,
-	pack-objects will try to send parts of the bitmapped packfile
-	verbatim. This can reduce memory and CPU usage to serve fetches,
-	but might result in sending a slightly larger pack. Defaults to
-	true.
+	When true or "single", and when reachability bitmaps are
+	enabled, pack-objects will try to send parts of the bitmapped
+	packfile verbatim. When "multi", and when a multi-pack
+	reachability bitmap is available, pack-objects will try to send
+	parts of all packs in the MIDX.
++
+	If only a single pack bitmap is available, and
+	`pack.allowPackReuse` is set to "multi", reuse parts of just the
+	bitmapped packfile. This can reduce memory and CPU usage to
+	serve fetches, but might result in sending a slightly larger
+	pack. Defaults to true.
 
 pack.island::
 	An extended regular expression configuring a set of delta
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 684698f679..5d3c42035b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -232,6 +232,7 @@ static int use_bitmap_index = -1;
 static enum {
 	NO_PACK_REUSE = 0,
 	SINGLE_PACK_REUSE,
+	MULTI_PACK_REUSE,
 } allow_pack_reuse = SINGLE_PACK_REUSE;
 static enum {
 	WRITE_BITMAP_FALSE = 0,
@@ -3251,6 +3252,8 @@ static int git_pack_config(const char *k, const char *v,
 		if (res < 0) {
 			if (!strcasecmp(v, "single"))
 				allow_pack_reuse = SINGLE_PACK_REUSE;
+			else if (!strcasecmp(v, "multi"))
+				allow_pack_reuse = MULTI_PACK_REUSE;
 			else
 				die(_("invalid pack.allowPackReuse value: '%s'"), v);
 		} else if (res) {
@@ -4029,7 +4032,8 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 		reuse_partial_packfile_from_bitmap(bitmap_git,
 						   &reuse_packfiles,
 						   &reuse_packfiles_nr,
-						   &reuse_packfile_bitmap);
+						   &reuse_packfile_bitmap,
+						   allow_pack_reuse == MULTI_PACK_REUSE);
 
 	if (reuse_packfiles) {
 		reuse_packfile_objects = bitmap_popcount(reuse_packfile_bitmap);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 242a5908f7..229a11fb00 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2040,7 +2040,8 @@ static int bitmapped_pack_cmp(const void *va, const void *vb)
 void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 					struct bitmapped_pack **packs_out,
 					size_t *packs_nr_out,
-					struct bitmap **reuse_out)
+					struct bitmap **reuse_out,
+					int multi_pack_reuse)
 {
 	struct repository *r = the_repository;
 	struct bitmapped_pack *packs = NULL;
@@ -2064,15 +2065,30 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 				free(packs);
 				return;
 			}
+
 			if (!pack.bitmap_nr)
-				continue; /* no objects from this pack */
-			if (pack.bitmap_pos)
-				continue; /* not preferred pack */
+				continue;
+
+			if (!multi_pack_reuse && pack.bitmap_pos) {
+				/*
+				 * If we're only reusing a single pack, skip
+				 * over any packs which are not positioned at
+				 * the beginning of the MIDX bitmap.
+				 *
+				 * This is consistent with the existing
+				 * single-pack reuse behavior, which only reuses
+				 * parts of the MIDX's preferred pack.
+				 */
+				continue;
+			}
 
 			ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
 			memcpy(&packs[packs_nr++], &pack, sizeof(pack));
 
 			objects_nr += pack.p->num_objects;
+
+			if (!multi_pack_reuse)
+				break;
 		}
 
 		QSORT(packs, packs_nr, bitmapped_pack_cmp);
@@ -2080,10 +2096,10 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
 
 		packs[packs_nr].p = bitmap_git->pack;
-		packs[packs_nr].bitmap_pos = 0;
 		packs[packs_nr].bitmap_nr = bitmap_git->pack->num_objects;
+		packs[packs_nr].bitmap_pos = 0;
 
-		objects_nr = packs[packs_nr++].p->num_objects;
+		objects_nr = packs[packs_nr++].bitmap_nr;
 	}
 
 	word_alloc = objects_nr / BITS_IN_EWORD;
@@ -2091,10 +2107,8 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		word_alloc++;
 	reuse = bitmap_word_alloc(word_alloc);
 
-	if (packs_nr != 1)
-		BUG("pack reuse not yet implemented for multiple packs");
-
-	reuse_partial_packfile_from_bitmap_1(bitmap_git, packs, reuse);
+	for (i = 0; i < packs_nr; i++)
+		reuse_partial_packfile_from_bitmap_1(bitmap_git, &packs[i], reuse);
 
 	if (bitmap_is_empty(reuse)) {
 		free(packs);
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 179b343912..c7dea13217 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -80,7 +80,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 					struct bitmapped_pack **packs_out,
 					size_t *packs_nr_out,
-					struct bitmap **reuse_out);
+					struct bitmap **reuse_out,
+					int multi_pack_reuse);
 int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping,
 			     kh_oid_map_t *reused_bitmaps, int show_progress);
 void free_bitmap_index(struct bitmap_index *);
diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
new file mode 100755
index 0000000000..2ba788b042
--- /dev/null
+++ b/t/t5332-multi-pack-reuse.sh
@@ -0,0 +1,203 @@
+#!/bin/sh
+
+test_description='pack-objects multi-pack reuse'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-bitmap.sh
+
+objdir=.git/objects
+packdir=$objdir/pack
+
+test_pack_reused () {
+	test_trace2_data pack-objects pack-reused "$1"
+}
+
+test_packs_reused () {
+	test_trace2_data pack-objects packs-reused "$1"
+}
+
+
+# pack_position <object> </path/to/pack.idx
+pack_position () {
+	git show-index >objects &&
+	grep "$1" objects | cut -d" " -f1
+}
+
+test_expect_success 'preferred pack is reused for single-pack reuse' '
+	test_config pack.allowPackReuse single &&
+
+	for i in A B
+	do
+		test_commit "$i" &&
+		git repack -d || return 1
+	done &&
+
+	git multi-pack-index write --bitmap &&
+
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
+		git pack-objects --stdout --revs --all >/dev/null &&
+
+	test_pack_reused 3 <trace2.txt &&
+	test_packs_reused 1 <trace2.txt
+'
+
+test_expect_success 'enable multi-pack reuse' '
+	git config pack.allowPackReuse multi
+'
+
+test_expect_success 'reuse all objects from subset of bitmapped packs' '
+	test_commit C &&
+	git repack -d &&
+
+	git multi-pack-index write --bitmap &&
+
+	cat >in <<-EOF &&
+	$(git rev-parse C)
+	^$(git rev-parse A)
+	EOF
+
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
+		git pack-objects --stdout --revs <in >/dev/null &&
+
+	test_pack_reused 6 <trace2.txt &&
+	test_packs_reused 2 <trace2.txt
+'
+
+test_expect_success 'reuse all objects from all packs' '
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
+		git pack-objects --stdout --revs --all >/dev/null &&
+
+	test_pack_reused 9 <trace2.txt &&
+	test_packs_reused 3 <trace2.txt
+'
+
+test_expect_success 'reuse objects from first pack with middle gap' '
+	for i in D E F
+	do
+		test_commit "$i" || return 1
+	done &&
+
+	# Set "pack.window" to zero to ensure that we do not create any
+	# deltas, which could alter the amount of pack reuse we perform
+	# (if, for e.g., we are not sending one or more bases).
+	D="$(git -c pack.window=0 pack-objects --all --unpacked $packdir/pack)" &&
+
+	d_pos="$(pack_position $(git rev-parse D) <$packdir/pack-$D.idx)" &&
+	e_pos="$(pack_position $(git rev-parse E) <$packdir/pack-$D.idx)" &&
+	f_pos="$(pack_position $(git rev-parse F) <$packdir/pack-$D.idx)" &&
+
+	# commits F, E, and D, should appear in that order at the
+	# beginning of the pack
+	test $f_pos -lt $e_pos &&
+	test $e_pos -lt $d_pos &&
+
+	# Ensure that the pack we are constructing sorts ahead of any
+	# other packs in lexical/bitmap order by choosing it as the
+	# preferred pack.
+	git multi-pack-index write --bitmap --preferred-pack="pack-$D.idx" &&
+
+	cat >in <<-EOF &&
+	$(git rev-parse E)
+	^$(git rev-parse D)
+	EOF
+
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
+		git pack-objects --stdout --delta-base-offset --revs <in >/dev/null &&
+
+	test_pack_reused 3 <trace2.txt &&
+	test_packs_reused 1 <trace2.txt
+'
+
+test_expect_success 'reuse objects from middle pack with middle gap' '
+	rm -fr $packdir/multi-pack-index* &&
+
+	# Ensure that the pack we are constructing sort into any
+	# position *but* the first one, by choosing a different pack as
+	# the preferred one.
+	git multi-pack-index write --bitmap --preferred-pack="pack-$A.idx" &&
+
+	cat >in <<-EOF &&
+	$(git rev-parse E)
+	^$(git rev-parse D)
+	EOF
+
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
+		git pack-objects --stdout --delta-base-offset --revs <in >/dev/null &&
+
+	test_pack_reused 3 <trace2.txt &&
+	test_packs_reused 1 <trace2.txt
+'
+
+test_expect_success 'omit delta with uninteresting base (same pack)' '
+	git repack -adk &&
+
+	test_seq 32 >f &&
+	git add f &&
+	test_tick &&
+	git commit -m "delta" &&
+	delta="$(git rev-parse HEAD)" &&
+
+	test_seq 64 >f &&
+	test_tick &&
+	git commit -a -m "base" &&
+	base="$(git rev-parse HEAD)" &&
+
+	test_commit other &&
+
+	git repack -d &&
+
+	have_delta "$(git rev-parse $delta:f)" "$(git rev-parse $base:f)" &&
+
+	git multi-pack-index write --bitmap &&
+
+	cat >in <<-EOF &&
+	$(git rev-parse other)
+	^$base
+	EOF
+
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
+		git pack-objects --stdout --delta-base-offset --revs <in >/dev/null &&
+
+	# We can only reuse the 3 objects corresponding to "other" from
+	# the latest pack.
+	#
+	# This is because even though we want "delta", we do not want
+	# "base", meaning that we have to inflate the delta/base-pair
+	# corresponding to the blob in commit "delta", which bypasses
+	# the pack-reuse mechanism.
+	#
+	# The remaining objects from the other pack are similarly not
+	# reused because their objects are on the uninteresting side of
+	# the query.
+	test_pack_reused 3 <trace2.txt &&
+	test_packs_reused 1 <trace2.txt
+'
+
+test_expect_success 'omit delta from uninteresting base (cross pack)' '
+	cat >in <<-EOF &&
+	$(git rev-parse $base)
+	^$(git rev-parse $delta)
+	EOF
+
+	P="$(git pack-objects --revs $packdir/pack <in)" &&
+
+	git multi-pack-index write --bitmap --preferred-pack="pack-$P.idx" &&
+
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
+		git pack-objects --stdout --delta-base-offset --all >/dev/null &&
+
+	packs_nr="$(find $packdir -type f -name "pack-*.pack" | wc -l)" &&
+	objects_nr="$(git rev-list --count --all --objects)" &&
+
+	test_pack_reused $(($objects_nr - 1)) <trace2.txt &&
+	test_packs_reused $packs_nr <trace2.txt
+'
+
+test_done
-- 
2.43.0.102.ga31d690331.dirty


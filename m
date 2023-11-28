Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EKZBdRCO"
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5002619B7
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:58 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-67a12079162so25628056d6.1
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198537; x=1701803337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PiEG9Jo34bwgYs5P7LAA1JzjVLTB5iGtzHWSpByPLeE=;
        b=EKZBdRCOdmEePikDu/rDfpnsShIqjigJo0tQippx6YIV9QI2AuQRf26ghBKCdEczeC
         cC3LxmJmRv59AtjjMX3EF8XmWJw5Zi8kfnF7HOF9ziZ3ATtFTbXBUHIjEBnD9VKw/jeA
         S+zMnZDjr/fJTIX/wBfqtJWdtxDSnAsEP4kx6RMRxunaPLGTquNLFII2vTJzsSB1x5s8
         mc7B8Md1+HufCnYIjkaDaRokxmXTxtEOp8MgbmgFF9rC2Qf4Isol7Rtn8jKtSca6VRAo
         ITFXKx/1EUoQVAbViBNn9pPlxTVsLMBfnU+hQElbBKo3pLGCL1RwlBCeXegcrhoiiqbl
         5O3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198537; x=1701803337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiEG9Jo34bwgYs5P7LAA1JzjVLTB5iGtzHWSpByPLeE=;
        b=SQ+hw9HQik6FnBiRa12oQ9QMAKUHw6AmHtvSogcPp3WTp7mW0/oFKsODoN+wnGOWvR
         GQH2xeNqgDbCPjIh3rjrq21gp6/csO3OecEight9XypAd23N4RbAHiLnhuP83Il6OV5F
         1U+6e6/cEow++hoXukyYnj7nW7FDiX2LnI9csaK8DBp8SoXTSjImEMvFpyi4h6DUPI6l
         wThFo1hvjfVxQXyzG8aqdIBcfje2b98aTqi3rZRWKToSrP7HX3MmPZmyDv8C/pbi6B9N
         gkGpaczTejtblEcm1l1Yk+TX4SIglLYqqaML6WOJn5FCZnI6AFdTx+tashANtNktXqYI
         Lsyw==
X-Gm-Message-State: AOJu0YwVmVlszDN0pvQiZAJeCMefvJX/305bbtq62EPEISacyedV8/49
	XDVAr6vEPL2wjGP+Tskj0qqSZrFIqQX/NwuDJh4=
X-Google-Smtp-Source: AGHT+IHGTHIuC7CpnyMAhwCQca5yauPxGSGuj5a56b54gvzEYRsz7Y9X3haIpkt5rUdq1B5ObP1N3w==
X-Received: by 2002:ad4:4690:0:b0:66d:65a9:8a17 with SMTP id pl16-20020ad44690000000b0066d65a98a17mr16957596qvb.2.1701198537219;
        Tue, 28 Nov 2023 11:08:57 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 10-20020ad45baa000000b0067a21a7397bsm3919911qvq.12.2023.11.28.11.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:56 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:56 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 23/24] pack-bitmap: reuse objects from all disjoint packs
Message-ID: <7345e3946743cd098a57c384436a3f44592e5fc6.1701198172.git.me@ttaylorr.com>
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

Now that both the pack-bitmap and pack-objects code are prepared to
handle marking and using objects from multiple disjoint packs for
verbatim reuse, allow marking objects from all disjoint packs as
eligible for reuse.

Within the `reuse_partial_packfile_from_bitmap()` function, we no longer
only mark the pack whose first object is at bit position zero for reuse,
and instead mark any pack which is flagged as disjoint by the MIDX as a
reuse candidate. If no such packs exist (i.e because we are reading a
MIDX written before the "DISP" chunk was introduced), then treat the
preferred pack as disjoint for the purposes of reuse. This is a safe
assumption to make since all duplicate objects are resolved in favor of
the preferred pack.

Provide a handful of test cases in a new script (t5332) exercising
interesting behavior for multi-pack reuse to ensure that we performed
all of the previous steps correctly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/pack.txt |   6 +-
 builtin/pack-objects.c        |   6 +-
 pack-bitmap.c                 |  73 +++++++++---
 pack-bitmap.h                 |   3 +-
 t/t5332-multi-pack-reuse.sh   | 219 ++++++++++++++++++++++++++++++++++
 5 files changed, 290 insertions(+), 17 deletions(-)
 create mode 100755 t/t5332-multi-pack-reuse.sh

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index fe100d0fb7..9fe48d41c9 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -30,7 +30,11 @@ to linkgit:git-repack[1].
 pack.allowPackReuse::
 	When true or "single", and when reachability bitmaps are enabled,
 	pack-objects will try to send parts of the bitmapped packfile
-	verbatim. This can reduce memory and CPU usage to serve fetches,
+	verbatim. When "multi", and when a multi-pack reachability bitmap is
+	available, pack-objects will try to send parts of all packs marked as
+	disjoint by the MIDX. If only a single pack bitmap is available, and
+	`pack.allowPackReuse` is set to "multi", reuse parts of just the
+	bitmapped packfile. This can reduce memory and CPU usage to serve fetches,
 	but might result in sending a slightly larger pack. Defaults to
 	true.
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4853e91251..43b77bff7c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -233,6 +233,7 @@ static int use_bitmap_index = -1;
 static enum {
 	NO_PACK_REUSE = 0,
 	SINGLE_PACK_REUSE,
+	MULTI_PACK_REUSE,
 } allow_pack_reuse = SINGLE_PACK_REUSE;
 static enum {
 	WRITE_BITMAP_FALSE = 0,
@@ -3253,6 +3254,8 @@ static int git_pack_config(const char *k, const char *v,
 		if (res < 0) {
 			if (!strcasecmp(v, "single"))
 				allow_pack_reuse = SINGLE_PACK_REUSE;
+			else if (!strcasecmp(v, "multi"))
+				allow_pack_reuse = MULTI_PACK_REUSE;
 			else
 				die(_("invalid pack.allowPackReuse value: '%s'"), v);
 		} else if (res) {
@@ -4032,7 +4035,8 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 		reuse_partial_packfile_from_bitmap(bitmap_git,
 						   &reuse_packfiles,
 						   &reuse_packfiles_nr,
-						   &reuse_packfile_bitmap);
+						   &reuse_packfile_bitmap,
+						   allow_pack_reuse == MULTI_PACK_REUSE);
 
 	if (reuse_packfiles) {
 		reuse_packfile_objects = bitmap_popcount(reuse_packfile_bitmap);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index be53fc6da5..561690c679 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2061,10 +2061,19 @@ static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git
 	unuse_pack(&w_curs);
 }
 
+static void make_disjoint_pack(struct bitmapped_pack *out, struct packed_git *p)
+{
+	out->p = p;
+	out->bitmap_pos = 0;
+	out->bitmap_nr = p->num_objects;
+	out->disjoint = 1;
+}
+
 void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 					struct bitmapped_pack **packs_out,
 					size_t *packs_nr_out,
-					struct bitmap **reuse_out)
+					struct bitmap **reuse_out,
+					int multi_pack_reuse)
 {
 	struct repository *r = the_repository;
 	struct bitmapped_pack *packs = NULL;
@@ -2088,24 +2097,62 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 				free(packs);
 				return;
 			}
-			if (!pack.bitmap_nr)
-				continue; /* no objects from this pack */
-			if (pack.bitmap_pos)
-				continue; /* not preferred pack */
+
+			if (!pack.disjoint)
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
+		}
+
+		if (!packs_nr) {
+			/*
+			 * Old MIDXs (i.e. those written before the "DISP" chunk
+			 * existed) will not have any packs marked as disjoint.
+			 *
+			 * But we still want to perform pack reuse with the
+			 * special "preferred pack" as before. To do this, form
+			 * the singleton set containing just the preferred pack,
+			 * which is trivially disjoint with itself.
+			 *
+			 * Moreover, the MIDX is guaranteed to resolve duplicate
+			 * objects in favor of the copy in the preferred pack
+			 * (if one exists). Thus, we can safely perform pack
+			 * reuse on this pack.
+			 */
+			uint32_t preferred_pack_pos;
+			struct packed_git *preferred_pack;
+
+			preferred_pack_pos = midx_preferred_pack(bitmap_git);
+			preferred_pack = bitmap_git->midx->packs[preferred_pack_pos];
+
+			ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
+
+			make_disjoint_pack(&packs[packs_nr], preferred_pack);
+			objects_nr = packs[packs_nr++].p->num_objects;
 		}
 	} else {
 		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
 
-		packs[packs_nr].p = bitmap_git->pack;
-		packs[packs_nr].bitmap_pos = 0;
-		packs[packs_nr].bitmap_nr = bitmap_git->pack->num_objects;
-		packs[packs_nr].disjoint = 1;
-
+		make_disjoint_pack(&packs[packs_nr], bitmap_git->pack);
 		objects_nr = packs[packs_nr++].p->num_objects;
 	}
 
@@ -2114,10 +2161,8 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		word_alloc++;
 	reuse = bitmap_word_alloc(word_alloc);
 
-	if (packs_nr != 1)
-		BUG("pack reuse not yet implemented for multiple packs");
-
-	reuse_partial_packfile_from_bitmap_1(bitmap_git, packs, reuse);
+	for (i = 0; i < packs_nr; i++)
+		reuse_partial_packfile_from_bitmap_1(bitmap_git, &packs[i], reuse);
 
 	if (!bitmap_popcount(reuse)) {
 		free(packs);
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 901a3b86ed..8bb316ce52 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -81,7 +81,8 @@ uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git);
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
index 0000000000..a9bd3870e6
--- /dev/null
+++ b/t/t5332-multi-pack-reuse.sh
@@ -0,0 +1,219 @@
+#!/bin/sh
+
+test_description='pack-objects multi-pack reuse'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-bitmap.sh
+. "$TEST_DIRECTORY"/lib-disjoint.sh
+
+objdir=.git/objects
+packdir=$objdir/pack
+
+all_packs () {
+	find $packdir -type f -name "*.idx" | sed -e 's/^.*\/\([^\/]\)/\1/g'
+}
+
+all_disjoint () {
+	all_packs | sed -e 's/^/+/g'
+}
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
+test_expect_success 'setup' '
+	git config pack.allowPackReuse multi
+'
+
+test_expect_success 'preferred pack is reused without packs marked disjoint' '
+	test_commit A &&
+	test_commit B &&
+
+	A="$(echo A | git pack-objects --unpacked --delta-base-offset $packdir/pack)" &&
+	B="$(echo B | git pack-objects --unpacked --delta-base-offset $packdir/pack)" &&
+
+	git prune-packed &&
+
+	git multi-pack-index write --bitmap &&
+
+	test_must_not_be_disjoint "pack-$A.pack" &&
+	test_must_not_be_disjoint "pack-$B.pack" &&
+
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
+		git pack-objects --stdout --revs --all >/dev/null &&
+
+	test_pack_reused 3 <trace2.txt &&
+	test_packs_reused 1 <trace2.txt
+'
+
+test_expect_success 'reuse all objects from subset of disjoint packs' '
+	test_commit C &&
+
+	C="$(echo C | git pack-objects --unpacked --delta-base-offset $packdir/pack)" &&
+
+	git prune-packed &&
+
+	cat >in <<-EOF &&
+	pack-$A.idx
+	+pack-$B.idx
+	+pack-$C.idx
+	EOF
+	git multi-pack-index write --bitmap --stdin-packs <in &&
+
+	test_must_not_be_disjoint "pack-$A.pack" &&
+	test_must_be_disjoint "pack-$B.pack" &&
+	test_must_be_disjoint "pack-$C.pack" &&
+
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
+		git pack-objects --stdout --revs --all >/dev/null &&
+
+	test_pack_reused 6 <trace2.txt &&
+	test_packs_reused 2 <trace2.txt
+'
+
+test_expect_success 'reuse all objects from all disjoint packs' '
+	rm -fr $packdir/multi-pack-index* &&
+
+	all_disjoint >in &&
+	git multi-pack-index write --bitmap --stdin-packs <in &&
+
+	test_must_be_disjoint "pack-$A.pack" &&
+	test_must_be_disjoint "pack-$B.pack" &&
+	test_must_be_disjoint "pack-$C.pack" &&
+
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
+		git pack-objects --stdout --revs --all >/dev/null &&
+
+	test_pack_reused 9 <trace2.txt &&
+	test_packs_reused 3 <trace2.txt
+'
+
+test_expect_success 'reuse objects from first disjoint pack with middle gap' '
+	test_commit D &&
+	test_commit E &&
+	test_commit F &&
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
+	all_disjoint >in &&
+	git multi-pack-index write --bitmap --preferred-pack="pack-$D.idx" \
+		--stdin-packs <in &&
+
+	test_must_be_disjoint pack-$A.pack &&
+	test_must_be_disjoint pack-$B.pack &&
+	test_must_be_disjoint pack-$C.pack &&
+	test_must_be_disjoint pack-$D.pack &&
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
+test_expect_success 'reuse objects from middle disjoint pack with middle gap' '
+	rm -fr $packdir/multi-pack-index* &&
+
+	# Ensure that the pack we are constructing sort into any
+	# position *but* the first one, by choosing a different pack as
+	# the preferred one.
+	all_disjoint >in &&
+	git multi-pack-index write --bitmap --preferred-pack="pack-$A.idx" \
+		--stdin-packs <in &&
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
+test_expect_success 'omit delta with uninteresting base' '
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
+	all_disjoint >in &&
+	git multi-pack-index write --bitmap --stdin-packs <in &&
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
+	# Even though all packs are marked disjoint, we can only reuse
+	# the 3 objects corresponding to "other" from the latest pack.
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
+test_done
-- 
2.43.0.24.g980b318f98


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262C8C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 01:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244290AbhLNBzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 20:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243560AbhLNBzs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 20:55:48 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7603C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 17:55:47 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id d2so15582687qki.12
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 17:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4/3GqYZimI8Q7oV2z7favpU5VYXh8rajLCSGRRI7MHM=;
        b=ZsAFfr9/5eq+1WbjABg0w60Xi3HFEAxWdq1G3HWZ3Ch3zuCQxkVcjfWXTCgUOivK/L
         IKu068b2N6zJ3/EvmMlE16ZKyHzT+VKBn8p3chxPKf+CPZeLllBXxptme9lKH/iWAmz1
         kXdZHBsrS7ARFtJSS7foSlsrs+pOPB0KvOH8EeMzCTLOVo6DaEHVEK+cUYwWMpasttJl
         Dvk1+pggB9+KJ7G6XQnzXsRQfi7SKPggDK19docVkq+4fBRIaMAW6k1woMKnvc5m5AOa
         2Pe4fD9Eahd4g7JeXI5v9BRNONWXM0Cq7QIhwHkwVOG32/3NbKjbdia+y5MuCbAY8hqQ
         eQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4/3GqYZimI8Q7oV2z7favpU5VYXh8rajLCSGRRI7MHM=;
        b=KOcMsn7ck2Brj/4pgvz3TeMJyu19ETmcNY5DESAaPADwwEl961DO0vm6XoBIauyCvQ
         puttQJkHw3SRAOFOeBiqn7zpgKBX6yodkY4oTyDXX6VXUJonT94x032pJ6My3AdmTe4z
         cVQC0S7eq4icSjOdy681Fz+TcxM59eEmTQ5lj/SdeYhbeB/xkAIMZqkdRsPpC0trOeYz
         SW24fDTuckDZVOqDmoyEs2Ga+DGEOWa2aVMs8ceeAtS2KgoBLF7hVKSUD0C+809gjPUQ
         Vg84h4NM/7B+K+Zy6UzZwdY7DbZicRr8h75dYiV9xFbbXprcKNwHhePzPn0tKYNPG/xA
         K7fQ==
X-Gm-Message-State: AOAM5314BSyQB2jvkQViUYuYom7qTAMQfEOzqIf6JylDQLIUT64iDhQf
        CLDFKu1zU3ZDXHt5BHH3bVqSNTRwSIa8mTVA
X-Google-Smtp-Source: ABdhPJxXpxmd1lLh0PcKvzl9Ft+9pz4j5iWru8TAXHIioeCoMrOoWhLIwQHhsiKFng1FfZe27+lszQ==
X-Received: by 2002:a05:620a:2413:: with SMTP id d19mr1795143qkn.82.1639446946722;
        Mon, 13 Dec 2021 17:55:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s6sm7084651qko.43.2021.12.13.17.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 17:55:46 -0800 (PST)
Date:   Mon, 13 Dec 2021 20:55:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, stolee@gmail.com
Subject: [PATCH v2 8/8] midx: read `RIDX` chunk when present
Message-ID: <993bfa8dd8480e74d64f657539b0c518ad155e5c.1639446906.git.me@ttaylorr.com>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1639446906.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1639446906.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a MIDX contains the new `RIDX` chunk, ensure that the reverse index
is read from it instead of the on-disk .rev file. Since we need to
encode the object order in the MIDX itself for correctness reasons,
there is no point in storing the same data again outside of the MIDX.

So, this patch stops writing separate .rev files, and reads it out of
the MIDX itself. This is possible to do with relatively little new code,
since the format of the RIDX chunk is identical to the data in the .rev
file. In other words, we can implement this by pointing the
`revindex_data` field at the reverse index chunk of the MIDX instead of
the .rev file without any other changes.

Note that we have two knobs that are adjusted for the new tests:
GIT_TEST_MIDX_WRITE_REV and GIT_TEST_MIDX_READ_RIDX. The former controls
whether the MIDX .rev is written at all, and the latter controls whether
we read the MIDX's RIDX chunk.

Both are necessary to ensure that the test added at the beginning of
this series continues to work. This is because we always need to write
the RIDX chunk in the MIDX in order to change its checksum, but we want
to make sure reading the existing .rev file still works (since the RIDX
chunk takes precedence by default).

Arguably this isn't a very interesting mode to test, because the
precedence rules mean that we'll always read the RIDX chunk over the
.rev file. But it makes it impossible for a user to induce corruption in
their repository by adjusting the test knobs (since if we had an
either/or knob they could stop writing the RIDX chunk, allowing them to
tweak the MIDX's object order without changing its checksum).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c                            |  6 +++++-
 midx.h                            |  1 +
 pack-revindex.c                   | 17 +++++++++++++++++
 t/lib-bitmap.sh                   |  4 ++--
 t/t5326-multi-pack-bitmaps.sh     |  5 +++++
 t/t5327-multi-pack-bitmaps-rev.sh | 23 +++++++++++++++++++++++
 t/t7700-repack.sh                 |  4 ----
 7 files changed, 53 insertions(+), 7 deletions(-)
 create mode 100755 t/t5327-multi-pack-bitmaps-rev.sh

diff --git a/midx.c b/midx.c
index d3179e9c02..9aba13b5b1 100644
--- a/midx.c
+++ b/midx.c
@@ -162,6 +162,9 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 
 	pair_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets);
 
+	if (git_env_bool("GIT_TEST_MIDX_READ_RIDX", 1))
+		pair_chunk(cf, MIDX_CHUNKID_REVINDEX, &m->chunk_revindex);
+
 	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
 
 	CALLOC_ARRAY(m->pack_names, m->num_packs);
@@ -1429,7 +1432,8 @@ static int write_midx_internal(const char *object_dir,
 	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	free_chunkfile(cf);
 
-	if (flags & MIDX_WRITE_REV_INDEX)
+	if (flags & MIDX_WRITE_REV_INDEX &&
+	    git_env_bool("GIT_TEST_MIDX_WRITE_REV", 0))
 		write_midx_reverse_index(midx_name.buf, midx_hash, &ctx);
 	if (flags & MIDX_WRITE_BITMAP) {
 		if (write_midx_bitmap(midx_name.buf, midx_hash, &ctx,
diff --git a/midx.h b/midx.h
index b7d79a515c..22e8e53288 100644
--- a/midx.h
+++ b/midx.h
@@ -36,6 +36,7 @@ struct multi_pack_index {
 	const unsigned char *chunk_oid_lookup;
 	const unsigned char *chunk_object_offsets;
 	const unsigned char *chunk_large_offsets;
+	const unsigned char *chunk_revindex;
 
 	const char **pack_names;
 	struct packed_git **packs;
diff --git a/pack-revindex.c b/pack-revindex.c
index bd15ebad03..08dc160167 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -298,9 +298,26 @@ int load_midx_revindex(struct multi_pack_index *m)
 {
 	struct strbuf revindex_name = STRBUF_INIT;
 	int ret;
+
 	if (m->revindex_data)
 		return 0;
 
+	if (m->chunk_revindex) {
+		/*
+		 * If the MIDX `m` has a `RIDX` chunk, then use its contents for
+		 * the reverse index instead of trying to load a separate `.rev`
+		 * file.
+		 *
+		 * Note that we do *not* set `m->revindex_map` here, since we do
+		 * not want to accidentally call munmap() in the middle of the
+		 * MIDX.
+		 */
+		trace2_data_string("load_midx_revindex", the_repository,
+				   "source", "midx");
+		m->revindex_data = (const uint32_t *)m->chunk_revindex;
+		return 0;
+	}
+
 	trace2_data_string("load_midx_revindex", the_repository,
 			   "source", "rev");
 
diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
index 0a35daf939..f5eaa9cf68 100644
--- a/t/lib-bitmap.sh
+++ b/t/lib-bitmap.sh
@@ -291,7 +291,7 @@ test_rev_exists () {
 }
 
 midx_bitmap_core () {
-	rev_kind="${1:-rev}"
+	rev_kind="${1:-midx}"
 
 	setup_bitmap_history
 
@@ -435,7 +435,7 @@ midx_bitmap_core () {
 }
 
 midx_bitmap_partial_tests () {
-	rev_kind="${1:-rev}"
+	rev_kind="${1:-midx}"
 
 	test_expect_success 'setup partial bitmaps' '
 		test_commit packed &&
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 100ac90d15..8c92acb0ce 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -9,6 +9,11 @@ test_description='exercise basic multi-pack bitmap functionality'
 GIT_TEST_MULTI_PACK_INDEX=0
 GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
 
+GIT_TEST_MIDX_WRITE_REV=0
+GIT_TEST_MIDX_READ_RIDX=1
+export GIT_TEST_MIDX_WRITE_REV
+export GIT_TEST_MIDX_READ_RIDX
+
 midx_bitmap_core
 
 bitmap_reuse_tests() {
diff --git a/t/t5327-multi-pack-bitmaps-rev.sh b/t/t5327-multi-pack-bitmaps-rev.sh
new file mode 100755
index 0000000000..d30ba632c8
--- /dev/null
+++ b/t/t5327-multi-pack-bitmaps-rev.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description='exercise basic multi-pack bitmap functionality (.rev files)'
+
+. ./test-lib.sh
+. "${TEST_DIRECTORY}/lib-bitmap.sh"
+
+# We'll be writing our own midx and bitmaps, so avoid getting confused by the
+# automatic ones.
+GIT_TEST_MULTI_PACK_INDEX=0
+GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
+
+# Unlike t5326, this test exercise multi-pack bitmap functionality where the
+# object order is stored in a separate .rev file.
+GIT_TEST_MIDX_WRITE_REV=1
+GIT_TEST_MIDX_READ_RIDX=0
+export GIT_TEST_MIDX_WRITE_REV
+export GIT_TEST_MIDX_READ_RIDX
+
+midx_bitmap_core rev
+midx_bitmap_partial_tests rev
+
+test_done
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 0260ad6f0e..3ee56cefd3 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -311,16 +311,13 @@ test_expect_success 'cleans up MIDX when appropriate' '
 		checksum=$(midx_checksum $objdir) &&
 		test_path_is_file $midx &&
 		test_path_is_file $midx-$checksum.bitmap &&
-		test_path_is_file $midx-$checksum.rev &&
 
 		test_commit repack-3 &&
 		GIT_TEST_MULTI_PACK_INDEX=0 git repack -Adb --write-midx &&
 
 		test_path_is_file $midx &&
 		test_path_is_missing $midx-$checksum.bitmap &&
-		test_path_is_missing $midx-$checksum.rev &&
 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
-		test_path_is_file $midx-$(midx_checksum $objdir).rev &&
 
 		test_commit repack-4 &&
 		GIT_TEST_MULTI_PACK_INDEX=0 git repack -Adb &&
@@ -353,7 +350,6 @@ test_expect_success '--write-midx with preferred bitmap tips' '
 		test_line_count = 1 before &&
 
 		rm -fr $midx-$(midx_checksum $objdir).bitmap &&
-		rm -fr $midx-$(midx_checksum $objdir).rev &&
 		rm -fr $midx &&
 
 		# instead of constructing the snapshot ourselves (c.f., the test
-- 
2.34.1.25.gb3157a20e6

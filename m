Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE51C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 20:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2316B60FF0
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 20:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbhF2Uzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 16:55:33 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34608 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235487AbhF2Uzd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 16:55:33 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 6E11F1F8C6;
        Tue, 29 Jun 2021 20:53:05 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 0/5] optimizations for many alternates
Date:   Tue, 29 Jun 2021 20:53:00 +0000
Message-Id: <20210629205305.7100-1-e@80x24.org>
In-Reply-To: <20210627024718.25383-1-e@80x24.org>
References: <20210627024718.25383-1-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 has better naming for 3/5, fix test for sha256 in 5/5
Thanks to René and Junio for feedback so far.

Eric Wong (5):
  speed up alt_odb_usable() with many alternates
  avoid strlen via strbuf_addstr in link_alt_odb_entry
  make object_directory.loose_objects_subdir_seen a bitmap
  oidcpy_with_padding: constify `src' arg
  oidtree: a crit-bit tree for odb_loose_cache

 Makefile                |   3 +
 alloc.c                 |   6 ++
 alloc.h                 |   1 +
 cbtree.c                | 167 ++++++++++++++++++++++++++++++++++++++++
 cbtree.h                |  56 ++++++++++++++
 hash.h                  |   2 +-
 object-file.c           |  69 ++++++++++-------
 object-name.c           |  28 +++----
 object-store.h          |  24 +++++-
 object.c                |   2 +
 oidtree.c               |  94 ++++++++++++++++++++++
 oidtree.h               |  29 +++++++
 t/helper/test-oidtree.c |  47 +++++++++++
 t/helper/test-tool.c    |   1 +
 t/helper/test-tool.h    |   1 +
 t/t0069-oidtree.sh      |  52 +++++++++++++
 16 files changed, 533 insertions(+), 49 deletions(-)
 create mode 100644 cbtree.c
 create mode 100644 cbtree.h
 create mode 100644 oidtree.c
 create mode 100644 oidtree.h
 create mode 100644 t/helper/test-oidtree.c
 create mode 100755 t/t0069-oidtree.sh

Interdiff against v1:
diff --git a/object-file.c b/object-file.c
index d33b84c4a4..6c397fb4f1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2463,16 +2463,17 @@ struct oidtree *odb_loose_cache(struct object_directory *odb,
 {
 	int subdir_nr = oid->hash[0];
 	struct strbuf buf = STRBUF_INIT;
-	size_t BM_SIZE = sizeof(odb->loose_objects_subdir_seen[0]) * CHAR_BIT;
+	size_t word_bits = bitsizeof(odb->loose_objects_subdir_seen[0]);
+	size_t word_index = subdir_nr / word_bits;
+	size_t mask = 1 << (subdir_nr % word_bits);
 	uint32_t *bitmap;
-	uint32_t bit = 1 << (subdir_nr % BM_SIZE);
 
 	if (subdir_nr < 0 ||
-	    subdir_nr >= ARRAY_SIZE(odb->loose_objects_subdir_seen) * BM_SIZE)
+	    subdir_nr >= bitsizeof(odb->loose_objects_subdir_seen))
 		BUG("subdir_nr out of range");
 
-	bitmap = &odb->loose_objects_subdir_seen[subdir_nr / BM_SIZE];
-	if (*bitmap & bit)
+	bitmap = &odb->loose_objects_subdir_seen[word_index];
+	if (*bitmap & mask)
 		return &odb->loose_objects_cache;
 
 	strbuf_addstr(&buf, odb->path);
@@ -2480,7 +2481,7 @@ struct oidtree *odb_loose_cache(struct object_directory *odb,
 				    append_loose_object,
 				    NULL, NULL,
 				    &odb->loose_objects_cache);
-	*bitmap |= bit;
+	*bitmap |= mask;
 	strbuf_release(&buf);
 	return &odb->loose_objects_cache;
 }
diff --git a/t/helper/test-oidtree.c b/t/helper/test-oidtree.c
index 44bb2e7c29..e0da13eea3 100644
--- a/t/helper/test-oidtree.c
+++ b/t/helper/test-oidtree.c
@@ -13,6 +13,7 @@ int cmd__oidtree(int argc, const char **argv)
 	struct oidtree ot = OIDTREE_INIT;
 	struct strbuf line = STRBUF_INIT;
 	int nongit_ok;
+	int algo = GIT_HASH_UNKNOWN;
 
 	setup_git_directory_gently(&nongit_ok);
 
@@ -21,20 +22,21 @@ int cmd__oidtree(int argc, const char **argv)
 		struct object_id oid;
 
 		if (skip_prefix(line.buf, "insert ", &arg)) {
-			if (get_oid_hex(arg, &oid))
-				die("not a hexadecimal oid: %s", arg);
+			if (get_oid_hex_any(arg, &oid) == GIT_HASH_UNKNOWN)
+				die("insert not a hexadecimal oid: %s", arg);
+			algo = oid.algo;
 			oidtree_insert(&ot, &oid);
 		} else if (skip_prefix(line.buf, "contains ", &arg)) {
 			if (get_oid_hex(arg, &oid))
-				die("not a hexadecimal oid: %s", arg);
+				die("contains not a hexadecimal oid: %s", arg);
 			printf("%d\n", oidtree_contains(&ot, &oid));
 		} else if (skip_prefix(line.buf, "each ", &arg)) {
-			char buf[GIT_SHA1_HEXSZ  + 1] = { '0' };
+			char buf[GIT_MAX_HEXSZ + 1] = { '0' };
 			memset(&oid, 0, sizeof(oid));
 			memcpy(buf, arg, strlen(arg));
-			buf[GIT_SHA1_HEXSZ] = 0;
+			buf[hash_algos[algo].hexsz] = 0;
 			get_oid_hex_any(buf, &oid);
-			oid.algo = GIT_HASH_SHA1;
+			oid.algo = algo;
 			oidtree_each(&ot, &oid, strlen(arg), print_oid, NULL);
 		} else if (!strcmp(line.buf, "destroy"))
 			oidtree_destroy(&ot);
diff --git a/t/t0069-oidtree.sh b/t/t0069-oidtree.sh
index bb4229210c..0594f57c81 100755
--- a/t/t0069-oidtree.sh
+++ b/t/t0069-oidtree.sh
@@ -10,9 +10,9 @@ echoid () {
 	do
 		echo "$1"
 		shift
-	done | awk -v prefix="$prefix" '{
+	done | awk -v prefix="$prefix" -v ZERO_OID=$ZERO_OID '{
 		printf("%s%s", prefix, $0);
-		need = 40 - length($0);
+		need = length(ZERO_OID) - length($0);
 		for (i = 0; i < need; i++)
 			printf("0");
 		printf "\n";

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1347E21847
	for <e@80x24.org>; Wed,  2 May 2018 00:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753459AbeEBA0p (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 20:26:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37660 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753420AbeEBA0g (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 May 2018 20:26:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CC99E60B36;
        Wed,  2 May 2018 00:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525220795;
        bh=6/Lat8/wiIC9YpnlBXgmVAfkfEbM8cRZR6fJgCQ4O9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=WhWLmpb1sj0G4+xxxvtPO5F2af2ch66S6rj8Hl6618Toa3zR18E8SAogqTuBUiBZZ
         hHGcSOR6LYvOwGBJBtyNYcp5GkGdh4d4AetDEXGq2cqcLJMNR2WSKSz9ulEuEZ/WsN
         reQ6TAueSaLaWNb38MIfJ7XRMEDuIiGm4F7Mz4GWg+NyweMOaVJyUV9w0YJz7OXile
         QTCNNOU2Vpe2J44fk0kkSj4YE9hzlR9+sA12PwTePSh40ms3Smd0XBwXwg/xiuy5Li
         LSCCWYdgSRxlLXi1w1wx8cALs7CASjeO/LOsGg+pq72vLbedzeM6It7Rqv/eiqdVbN
         KX8Hfjvyngm/Ec6jKPB6fgQaCDLx7fa3a7LFeZ9B/calxMN591rDucudYog5tfoB2q
         pd2/XhaBpkWlhHPaAQaXsqlSnCJX+f7G9nYJwSlW3R55HopJHhYd7X01IpJinfMwAn
         yeEOLrRvri+yMR4r8Ne5TKqm/s/mGQGi22hHbRutGMNBBIIIXF4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 15/42] split-index: convert struct split_index to object_id
Date:   Wed,  2 May 2018 00:25:43 +0000
Message-Id: <20180502002610.915892-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180502002610.915892-1-sandals@crustytoothpaste.net>
References: <20180502002610.915892-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the base_sha1 member of struct split_index to use struct
object_id and rename it base_oid.  Include cache.h to make the structure
visible.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/rev-parse.c              |  4 ++--
 read-cache.c                     | 22 +++++++++++-----------
 split-index.c                    | 10 +++++-----
 split-index.h                    |  4 +++-
 t/helper/test-dump-split-index.c |  2 +-
 5 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 36b2087782..55c0b90441 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -887,8 +887,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				if (read_cache() < 0)
 					die(_("Could not read the index"));
 				if (the_index.split_index) {
-					const unsigned char *sha1 = the_index.split_index->base_sha1;
-					const char *path = git_path("sharedindex.%s", sha1_to_hex(sha1));
+					const struct object_id *oid = &the_index.split_index->base_oid;
+					const char *path = git_path("sharedindex.%s", oid_to_hex(oid));
 					strbuf_reset(&buf);
 					puts(relative_path(path, prefix, &buf));
 				}
diff --git a/read-cache.c b/read-cache.c
index 10f1c6bb8a..f47666b975 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1878,7 +1878,7 @@ int read_index_from(struct index_state *istate, const char *path,
 	uint64_t start = getnanotime();
 	struct split_index *split_index;
 	int ret;
-	char *base_sha1_hex;
+	char *base_oid_hex;
 	char *base_path;
 
 	/* istate->initialized covers both .git/index and .git/sharedindex.xxx */
@@ -1889,7 +1889,7 @@ int read_index_from(struct index_state *istate, const char *path,
 	trace_performance_since(start, "read cache %s", path);
 
 	split_index = istate->split_index;
-	if (!split_index || is_null_sha1(split_index->base_sha1)) {
+	if (!split_index || is_null_oid(&split_index->base_oid)) {
 		post_read_index_from(istate);
 		return ret;
 	}
@@ -1899,12 +1899,12 @@ int read_index_from(struct index_state *istate, const char *path,
 	else
 		split_index->base = xcalloc(1, sizeof(*split_index->base));
 
-	base_sha1_hex = sha1_to_hex(split_index->base_sha1);
-	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_sha1_hex);
+	base_oid_hex = oid_to_hex(&split_index->base_oid);
+	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
 	ret = do_read_index(split_index->base, base_path, 1);
-	if (hashcmp(split_index->base_sha1, split_index->base->sha1))
+	if (hashcmp(split_index->base_oid.hash, split_index->base->sha1))
 		die("broken index, expect %s in %s, got %s",
-		    base_sha1_hex, base_path,
+		    base_oid_hex, base_path,
 		    sha1_to_hex(split_index->base->sha1));
 
 	freshen_shared_index(base_path, 0);
@@ -2499,7 +2499,7 @@ static int write_shared_index(struct index_state *istate,
 	ret = rename_tempfile(temp,
 			      git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
 	if (!ret) {
-		hashcpy(si->base_sha1, si->base->sha1);
+		hashcpy(si->base_oid.hash, si->base->sha1);
 		clean_shared_index_files(sha1_to_hex(si->base->sha1));
 	}
 
@@ -2554,13 +2554,13 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	if (!si || alternate_index_output ||
 	    (istate->cache_changed & ~EXTMASK)) {
 		if (si)
-			hashclr(si->base_sha1);
+			oidclr(&si->base_oid);
 		ret = do_write_locked_index(istate, lock, flags);
 		goto out;
 	}
 
 	if (getenv("GIT_TEST_SPLIT_INDEX")) {
-		int v = si->base_sha1[0];
+		int v = si->base_oid.hash[0];
 		if ((v & 15) < 6)
 			istate->cache_changed |= SPLIT_INDEX_ORDERED;
 	}
@@ -2575,7 +2575,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 
 		temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
 		if (!temp) {
-			hashclr(si->base_sha1);
+			oidclr(&si->base_oid);
 			ret = do_write_locked_index(istate, lock, flags);
 			goto out;
 		}
@@ -2595,7 +2595,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	/* Freshen the shared index only if the split-index was written */
 	if (!ret && !new_shared_index) {
 		const char *shared_index = git_path("sharedindex.%s",
-						    sha1_to_hex(si->base_sha1));
+						    oid_to_hex(&si->base_oid));
 		freshen_shared_index(shared_index, 1);
 	}
 
diff --git a/split-index.c b/split-index.c
index 3eb8ff1b43..660c75f31f 100644
--- a/split-index.c
+++ b/split-index.c
@@ -18,12 +18,12 @@ int read_link_extension(struct index_state *istate,
 	struct split_index *si;
 	int ret;
 
-	if (sz < 20)
+	if (sz < the_hash_algo->rawsz)
 		return error("corrupt link extension (too short)");
 	si = init_split_index(istate);
-	hashcpy(si->base_sha1, data);
-	data += 20;
-	sz -= 20;
+	hashcpy(si->base_oid.hash, data);
+	data += the_hash_algo->rawsz;
+	sz -= the_hash_algo->rawsz;
 	if (!sz)
 		return 0;
 	si->delete_bitmap = ewah_new();
@@ -45,7 +45,7 @@ int write_link_extension(struct strbuf *sb,
 			 struct index_state *istate)
 {
 	struct split_index *si = istate->split_index;
-	strbuf_add(sb, si->base_sha1, 20);
+	strbuf_add(sb, si->base_oid.hash, the_hash_algo->rawsz);
 	if (!si->delete_bitmap && !si->replace_bitmap)
 		return 0;
 	ewah_serialize_strbuf(si->delete_bitmap, sb);
diff --git a/split-index.h b/split-index.h
index 43d66826eb..7a435ca2c9 100644
--- a/split-index.h
+++ b/split-index.h
@@ -1,12 +1,14 @@
 #ifndef SPLIT_INDEX_H
 #define SPLIT_INDEX_H
 
+#include "cache.h"
+
 struct index_state;
 struct strbuf;
 struct ewah_bitmap;
 
 struct split_index {
-	unsigned char base_sha1[20];
+	struct object_id base_oid;
 	struct index_state *base;
 	struct ewah_bitmap *delete_bitmap;
 	struct ewah_bitmap *replace_bitmap;
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index 4e2fdb5e30..754e9bb624 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -20,7 +20,7 @@ int cmd__dump_split_index(int ac, const char **av)
 		printf("not a split index\n");
 		return 0;
 	}
-	printf("base %s\n", sha1_to_hex(si->base_sha1));
+	printf("base %s\n", oid_to_hex(&si->base_oid));
 	for (i = 0; i < the_index.cache_nr; i++) {
 		struct cache_entry *ce = the_index.cache[i];
 		printf("%06o %s %d\t%s\n", ce->ce_mode,

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D99CC43462
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C352A611CD
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 01:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhDZBER (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 21:04:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41788 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231547AbhDZBEO (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Apr 2021 21:04:14 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E0BA66078B;
        Mon, 26 Apr 2021 01:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1619399013;
        bh=xrnAGywGAiGF0vGjhXoBwcaquBN4cpeEEzYm4IAnHoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Z6ZdDrogp+ScrcbC+VHUkJfn4mPL7Ikd/CA1nmp0J3sMa4WIjm7GvEemGnXMPy2iR
         0nWdVn7a+SlsVmmY6S1aFNvVqhmLEoJHOZozBd6jmgqxt+TNJIgS+A1mVKHaS8AiuK
         jsA1C4ahr4WWdACHqLO2eM5fm1QdlKoKWycTiLtB5jl0lAoVh7rxPrT4wYdWum74u1
         VAtAdjWcIvCSChaILHhgCLIRXLdIP/oRQYUbwwDRgHCVI4LqN6VvnBmJzBRjH0Jd1d
         P/oyp+Zs24Cn+ZNW9I9F3H525egR9Z3Lzm3fK1Dg6CzDcmd3GPV6+DRcmUEn9nudZY
         rFI0HkRaf+wrj/5APA8vY9rAcNx61GmmlQPDvNvgB75CeuyIAnameIOGTZWXE40pOz
         QJi0kYVRgI/Um83xQY/nyZiQKEVF51pPMJqpiVS2kGMWt4NoBKXX2keXagcWrGuuUp
         zGOtcsu1iOGHk2X4po9dcvpztiQAPpmpIZ6G1r1TtlpJtoLPULV
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/13] hash: set, copy, and use algo field in struct object_id
Date:   Mon, 26 Apr 2021 01:02:55 +0000
Message-Id: <20210426010301.1093562-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d
In-Reply-To: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
References: <20210426010301.1093562-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that struct object_id has an algorithm field, we should populate it.
This will allow us to handle object IDs in any supported algorithm and
distinguish between them.  Ensure that the field is written whenever we
write an object ID by storing it explicitly every time we write an
object.  Set values for the empty blob and tree values as well.

In addition, use the algorithm field to compare object IDs.  Note that
because we zero-initialize struct object_id in many places throughout
the codebase, we default to the default algorithm in cases where the
algorithm field is zero rather than explicitly initialize all of those
locations.

This leads to a branch on every comparison, but the alternative is to
compare the entire buffer each time and padding the buffer for SHA-1.
That alternative ranges up to 3.9% worse than this approach on the perf
t0001, t1450, and t1451.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.h        | 42 +++++++++++++++++++++++++++++++++++-------
 hex.c         |  9 ++++++---
 notes.c       |  3 +++
 object-file.c | 15 +++++++++++----
 4 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/hash.h b/hash.h
index c8f03d8aee..0e85e448ed 100644
--- a/hash.h
+++ b/hash.h
@@ -192,36 +192,56 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 
 extern const struct object_id null_oid;
 
-static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
+static inline int hashcmp_algop(const unsigned char *sha1, const unsigned char *sha2, const struct git_hash_algo *algop)
 {
 	/*
 	 * Teach the compiler that there are only two possibilities of hash size
 	 * here, so that it can optimize for this case as much as possible.
 	 */
-	if (the_hash_algo->rawsz == GIT_MAX_RAWSZ)
+	if (algop->rawsz == GIT_MAX_RAWSZ)
 		return memcmp(sha1, sha2, GIT_MAX_RAWSZ);
 	return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
 }
 
-static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
+static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
-	return hashcmp(oid1->hash, oid2->hash);
+	return hashcmp_algop(sha1, sha2, the_hash_algo);
 }
 
-static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
+static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
+{
+	const struct git_hash_algo *algop;
+	if (!oid1->algo)
+		algop = the_hash_algo;
+	else
+		algop = &hash_algos[oid1->algo];
+	return hashcmp_algop(oid1->hash, oid2->hash, algop);
+}
+
+static inline int hasheq_algop(const unsigned char *sha1, const unsigned char *sha2, const struct git_hash_algo *algop)
 {
 	/*
 	 * We write this here instead of deferring to hashcmp so that the
 	 * compiler can properly inline it and avoid calling memcmp.
 	 */
-	if (the_hash_algo->rawsz == GIT_MAX_RAWSZ)
+	if (algop->rawsz == GIT_MAX_RAWSZ)
 		return !memcmp(sha1, sha2, GIT_MAX_RAWSZ);
 	return !memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
 }
 
+static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
+{
+	return hasheq_algop(sha1, sha2, the_hash_algo);
+}
+
 static inline int oideq(const struct object_id *oid1, const struct object_id *oid2)
 {
-	return hasheq(oid1->hash, oid2->hash);
+	const struct git_hash_algo *algop;
+	if (!oid1->algo)
+		algop = the_hash_algo;
+	else
+		algop = &hash_algos[oid1->algo];
+	return hasheq_algop(oid1->hash, oid2->hash, algop);
 }
 
 static inline int is_null_oid(const struct object_id *oid)
@@ -237,6 +257,7 @@ static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
 static inline void oidcpy(struct object_id *dst, const struct object_id *src)
 {
 	memcpy(dst->hash, src->hash, GIT_MAX_RAWSZ);
+	dst->algo = src->algo;
 }
 
 static inline struct object_id *oiddup(const struct object_id *src)
@@ -254,11 +275,13 @@ static inline void hashclr(unsigned char *hash)
 static inline void oidclr(struct object_id *oid)
 {
 	memset(oid->hash, 0, GIT_MAX_RAWSZ);
+	oid->algo = hash_algo_by_ptr(the_hash_algo);
 }
 
 static inline void oidread(struct object_id *oid, const unsigned char *hash)
 {
 	memcpy(oid->hash, hash, the_hash_algo->rawsz);
+	oid->algo = hash_algo_by_ptr(the_hash_algo);
 }
 
 static inline int is_empty_blob_sha1(const unsigned char *sha1)
@@ -281,6 +304,11 @@ static inline int is_empty_tree_oid(const struct object_id *oid)
 	return oideq(oid, the_hash_algo->empty_tree);
 }
 
+static inline void oid_set_algo(struct object_id *oid, const struct git_hash_algo *algop)
+{
+	oid->algo = hash_algo_by_ptr(algop);
+}
+
 const char *empty_tree_oid_hex(void);
 const char *empty_blob_oid_hex(void);
 
diff --git a/hex.c b/hex.c
index da51e64929..e7af18fe55 100644
--- a/hex.c
+++ b/hex.c
@@ -69,7 +69,10 @@ int get_sha1_hex(const char *hex, unsigned char *sha1)
 int get_oid_hex_algop(const char *hex, struct object_id *oid,
 		      const struct git_hash_algo *algop)
 {
-	return get_hash_hex_algop(hex, oid->hash, algop);
+	int ret = get_hash_hex_algop(hex, oid->hash, algop);
+	if (!ret)
+		oid_set_algo(oid, algop);
+	return ret;
 }
 
 /*
@@ -80,7 +83,7 @@ int get_oid_hex_any(const char *hex, struct object_id *oid)
 {
 	int i;
 	for (i = GIT_HASH_NALGOS - 1; i > 0; i--) {
-		if (!get_hash_hex_algop(hex, oid->hash, &hash_algos[i]))
+		if (!get_oid_hex_algop(hex, oid, &hash_algos[i]))
 			return i;
 	}
 	return GIT_HASH_UNKNOWN;
@@ -95,7 +98,7 @@ int parse_oid_hex_algop(const char *hex, struct object_id *oid,
 			const char **end,
 			const struct git_hash_algo *algop)
 {
-	int ret = get_hash_hex_algop(hex, oid->hash, algop);
+	int ret = get_oid_hex_algop(hex, oid, algop);
 	if (!ret)
 		*end = hex + algop->hexsz;
 	return ret;
diff --git a/notes.c b/notes.c
index a44b25858f..135ea13ba1 100644
--- a/notes.c
+++ b/notes.c
@@ -455,6 +455,8 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		CALLOC_ARRAY(l, 1);
 		oidcpy(&l->key_oid, &object_oid);
 		oidcpy(&l->val_oid, &entry.oid);
+		oid_set_algo(&l->key_oid, the_hash_algo);
+		oid_set_algo(&l->val_oid, the_hash_algo);
 		if (note_tree_insert(t, node, n, l, type,
 				     combine_notes_concatenate))
 			die("Failed to load %s %s into notes tree "
@@ -484,6 +486,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 				strbuf_addch(&non_note_path, '/');
 			}
 			strbuf_addstr(&non_note_path, entry.path);
+			oid_set_algo(&entry.oid, the_hash_algo);
 			add_non_note(t, strbuf_detach(&non_note_path, NULL),
 				     entry.mode, entry.oid.hash);
 		}
diff --git a/object-file.c b/object-file.c
index 1d8c82fa99..d4ba0c4a4f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -57,16 +57,20 @@
 
 const struct object_id null_oid;
 static const struct object_id empty_tree_oid = {
-	EMPTY_TREE_SHA1_BIN_LITERAL
+	.hash = EMPTY_TREE_SHA1_BIN_LITERAL,
+	.algo = GIT_HASH_SHA1,
 };
 static const struct object_id empty_blob_oid = {
-	EMPTY_BLOB_SHA1_BIN_LITERAL
+	.hash = EMPTY_BLOB_SHA1_BIN_LITERAL,
+	.algo = GIT_HASH_SHA1,
 };
 static const struct object_id empty_tree_oid_sha256 = {
-	EMPTY_TREE_SHA256_BIN_LITERAL
+	.hash = EMPTY_TREE_SHA256_BIN_LITERAL,
+	.algo = GIT_HASH_SHA256,
 };
 static const struct object_id empty_blob_oid_sha256 = {
-	EMPTY_BLOB_SHA256_BIN_LITERAL
+	.hash = EMPTY_BLOB_SHA256_BIN_LITERAL,
+	.algo = GIT_HASH_SHA256,
 };
 
 static void git_hash_sha1_init(git_hash_ctx *ctx)
@@ -93,6 +97,7 @@ static void git_hash_sha1_final_oid(struct object_id *oid, git_hash_ctx *ctx)
 {
 	git_SHA1_Final(oid->hash, &ctx->sha1);
 	memset(oid->hash + GIT_SHA1_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA1_RAWSZ);
+	oid->algo = GIT_HASH_SHA1;
 }
 
 
@@ -124,6 +129,7 @@ static void git_hash_sha256_final_oid(struct object_id *oid, git_hash_ctx *ctx)
 	 * but keep it in case we extend the hash size again.
 	 */
 	memset(oid->hash + GIT_SHA256_RAWSZ, 0, GIT_MAX_RAWSZ - GIT_SHA256_RAWSZ);
+	oid->algo = GIT_HASH_SHA256;
 }
 
 static void git_hash_unknown_init(git_hash_ctx *ctx)
@@ -2340,6 +2346,7 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 		if (namelen == the_hash_algo->hexsz - 2 &&
 		    !hex_to_bytes(oid.hash + 1, de->d_name,
 				  the_hash_algo->rawsz - 1)) {
+			oid_set_algo(&oid, the_hash_algo);
 			if (obj_cb) {
 				r = obj_cb(&oid, path->buf, data);
 				if (r)

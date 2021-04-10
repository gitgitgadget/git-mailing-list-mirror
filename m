Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7319DC43460
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C585611AE
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 15:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhDJPWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 11:22:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58496 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234821AbhDJPWt (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 10 Apr 2021 11:22:49 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B8B8D60794;
        Sat, 10 Apr 2021 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618068155;
        bh=znn25feY31pix1KiyuDTLum2Nr8D1uYgIYUwV9vnOUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Rv2COi9hJfx8MLR54RIaSbVay/Ys489gRDPnX6nQa9Ekp15/Un3K4YkKKjOTyE8cT
         ibuOI2MTPzLYoCKQER5vg4oJE6hgTVIng8fkP7h3DJ9nnC5QtFbktKojXVacbwxF2x
         /GPqHS31lR7nph7ZmqQ5LNsty6U1stKY4d6foEfz29c7zz1SUo+k2kTE6ZPSXS7THx
         Ichop3xgq6HJXE8+X2RkLQyvgmdYpyIBJKU8FLiHMVcmaApfYomgP9j9mJ4cNamJ4e
         r0YHHhJAdnvVc9Sr2fHNChBDaV3/rh2a5aCO4N5D3xkAGwomfBZa1Wi5pJrwOfRBPU
         oLAu2wUuVAOEEd625/aAr0l9wU0izyGRlYSaap8wVG1PAoR7pE4+39KLcKfTmYiSx0
         AIEX4lf7bbyi8qZcwf8pCr62zJdHHdRCiZvDrbeO9cgF5FBcCrzYSEaBoUyofF6tWr
         OqJqmontinkhhVP4NykSgM3BnU2A6gcoCFdwj3YCQYJHznxDmqY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 08/15] cache: compare the entire buffer for struct object_id
Date:   Sat, 10 Apr 2021 15:21:33 +0000
Message-Id: <20210410152140.3525040-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf
In-Reply-To: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, when we compare two object IDs, we have to take a branch to
determine what the hash size is supposed to be.  The compiler can
optimize well for a single length, but has trouble when there are two
possible lengths.

There is, however, an alternative: we can ensure that we always compare
the full length of the hash buffer, but in turn we must zero the
remainder of the buffer when using SHA-1; otherwise, we'll end up with
incompatible junk at the end of otherwise equivalent object IDs that
will prevent them from matching.  This is an acceptable tradeoff,
because we generally read an object ID in once, but then compare it
against others multiple times.

This latter approach also has some benefits as well: since we will have
annotated every location in which we load an object ID into an instance
of struct object_id, if we want to set the hash algorithm for the object
ID, we can do so at the same time.

Adopt this latter approach, since it provides us greater flexibility and
lets us read and store object IDs for multiple algorithms at once.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.h        | 13 ++++++++++---
 hex.c         |  9 ++++++---
 notes.c       |  3 +++
 object-file.c |  1 +
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/hash.h b/hash.h
index c8f03d8aee..04eba5c56b 100644
--- a/hash.h
+++ b/hash.h
@@ -205,7 +205,7 @@ static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 
 static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
 {
-	return hashcmp(oid1->hash, oid2->hash);
+	return memcmp(oid1->hash, oid2->hash, GIT_MAX_RAWSZ);
 }
 
 static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
@@ -221,7 +221,7 @@ static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
 
 static inline int oideq(const struct object_id *oid1, const struct object_id *oid2)
 {
-	return hasheq(oid1->hash, oid2->hash);
+	return !memcmp(oid1->hash, oid2->hash, GIT_MAX_RAWSZ);
 }
 
 static inline int is_null_oid(const struct object_id *oid)
@@ -258,7 +258,9 @@ static inline void oidclr(struct object_id *oid)
 
 static inline void oidread(struct object_id *oid, const unsigned char *hash)
 {
-	memcpy(oid->hash, hash, the_hash_algo->rawsz);
+	size_t rawsz = the_hash_algo->rawsz;
+	memcpy(oid->hash, hash, rawsz);
+	memset(oid->hash + rawsz, 0, GIT_MAX_RAWSZ - rawsz);
 }
 
 static inline int is_empty_blob_sha1(const unsigned char *sha1)
@@ -281,6 +283,11 @@ static inline int is_empty_tree_oid(const struct object_id *oid)
 	return oideq(oid, the_hash_algo->empty_tree);
 }
 
+static inline void oid_pad_buffer(struct object_id *oid, const struct git_hash_algo *algop)
+{
+	memset(oid->hash + algop->rawsz, 0, GIT_MAX_RAWSZ - algop->rawsz);
+}
+
 const char *empty_tree_oid_hex(void);
 const char *empty_blob_oid_hex(void);
 
diff --git a/hex.c b/hex.c
index da51e64929..5fa3e71cb9 100644
--- a/hex.c
+++ b/hex.c
@@ -69,7 +69,10 @@ int get_sha1_hex(const char *hex, unsigned char *sha1)
 int get_oid_hex_algop(const char *hex, struct object_id *oid,
 		      const struct git_hash_algo *algop)
 {
-	return get_hash_hex_algop(hex, oid->hash, algop);
+	int ret = get_hash_hex_algop(hex, oid->hash, algop);
+	if (!ret)
+		oid_pad_buffer(oid, algop);
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
index a44b25858f..1dfe9e2b9f 100644
--- a/notes.c
+++ b/notes.c
@@ -455,6 +455,8 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		CALLOC_ARRAY(l, 1);
 		oidcpy(&l->key_oid, &object_oid);
 		oidcpy(&l->val_oid, &entry.oid);
+		oid_pad_buffer(&l->key_oid, the_hash_algo);
+		oid_pad_buffer(&l->val_oid, the_hash_algo);
 		if (note_tree_insert(t, node, n, l, type,
 				     combine_notes_concatenate))
 			die("Failed to load %s %s into notes tree "
@@ -484,6 +486,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 				strbuf_addch(&non_note_path, '/');
 			}
 			strbuf_addstr(&non_note_path, entry.path);
+			oid_pad_buffer(&entry.oid, the_hash_algo);
 			add_non_note(t, strbuf_detach(&non_note_path, NULL),
 				     entry.mode, entry.oid.hash);
 		}
diff --git a/object-file.c b/object-file.c
index 3f43c376e7..8e338247cc 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2352,6 +2352,7 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 		if (namelen == the_hash_algo->hexsz - 2 &&
 		    !hex_to_bytes(oid.hash + 1, de->d_name,
 				  the_hash_algo->rawsz - 1)) {
+			oid_pad_buffer(&oid, the_hash_algo);
 			if (obj_cb) {
 				r = obj_cb(&oid, path->buf, data);
 				if (r)

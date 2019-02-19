Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3EF81F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbfBSAGe (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:34 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34666 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732180AbfBSAFu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:05:50 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C5EEA61093;
        Tue, 19 Feb 2019 00:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534748;
        bh=wTHoHyTD2SVqw5ztN6aS0tHPrvdfQzbjIN5dFKDYhZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=rIQhII2Tz9zWwHV4j6s+9/UeolDEk8pREfy0+dXraH/gml3VfQmL85C5CxXvT3CN9
         UJRoHuWC0xWG3DfQ22kGDK4kjGoCqozy2vOgWa+TL2UaSbKl7gE4QIdFDqnxSZMsw9
         za2ctIDB9tLchUTEpTrAjA9RSPMX12KMb0UZj7neuqF2Z0s3Mfl5ASKGL2ZeXS0vtC
         Aq8xTd52G/HKyNHb0AVSOyqC2rDsmfPjFl4oEMOhnkGC2zU+dSOBdLW4fz2ppSnoYw
         6eEqN8/SmPbCljPEYd7xPEimz7VppKEv3DGucqPBnu8yOSf3hJ+qZM2fyxpT98NyC9
         WBhvxA5kQjQ6KSa8wGlNUkAYzZxHUDEDGx2OCVIsj4/TqM77t+JmLFSmkX5Lf6QbHP
         wdWW7F7cTNPI6nZNCoRl+ZByARhYyrEFymUZrxyrzB3h6DStaUSa2bgAksCLeA4on2
         oOFVylhsexLyfu2JNNSQpc9xVXHZoFiQ66BuORM/iWWBewlrIoR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 10/35] notes: make hash size independent
Date:   Tue, 19 Feb 2019 00:05:01 +0000
Message-Id: <20190219000526.476553-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch out various uses of the GIT_SHA1_* constants with GIT_MAX_*
constants for allocations and the_hash_algo for general parsing.  Update
a comment to no longer be SHA-1 specific.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 notes.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/notes.c b/notes.c
index 7f7cc4d511..5457bd70c6 100644
--- a/notes.c
+++ b/notes.c
@@ -67,8 +67,9 @@ struct non_note {
 
 #define GET_NIBBLE(n, sha1) ((((sha1)[(n) >> 1]) >> ((~(n) & 0x01) << 2)) & 0x0f)
 
-#define KEY_INDEX (GIT_SHA1_RAWSZ - 1)
-#define FANOUT_PATH_SEPARATORS ((GIT_SHA1_HEXSZ / 2) - 1)
+#define KEY_INDEX (the_hash_algo->rawsz - 1)
+#define FANOUT_PATH_SEPARATORS (the_hash_algo->rawsz - 1)
+#define FANOUT_PATH_SEPARATORS_MAX ((GIT_MAX_HEXSZ / 2) - 1)
 #define SUBTREE_SHA1_PREFIXCMP(key_sha1, subtree_sha1) \
 	(memcmp(key_sha1, subtree_sha1, subtree_sha1[KEY_INDEX]))
 
@@ -198,7 +199,7 @@ static void note_tree_remove(struct notes_tree *t,
 		struct leaf_node *entry)
 {
 	struct leaf_node *l;
-	struct int_node *parent_stack[GIT_SHA1_RAWSZ];
+	struct int_node *parent_stack[GIT_MAX_RAWSZ];
 	unsigned char i, j;
 	void **p = note_tree_search(t, &tree, &n, entry->key_oid.hash);
 
@@ -394,6 +395,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 	void *buf;
 	struct tree_desc desc;
 	struct name_entry entry;
+	const unsigned hashsz = the_hash_algo->rawsz;
 
 	buf = fill_tree_descriptor(&desc, &subtree->val_oid);
 	if (!buf)
@@ -401,7 +403,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		     oid_to_hex(&subtree->val_oid));
 
 	prefix_len = subtree->key_oid.hash[KEY_INDEX];
-	if (prefix_len >= GIT_SHA1_RAWSZ)
+	if (prefix_len >= hashsz)
 		BUG("prefix_len (%"PRIuMAX") is out of range", (uintmax_t)prefix_len);
 	if (prefix_len * 2 < n)
 		BUG("prefix_len (%"PRIuMAX") is too small", (uintmax_t)prefix_len);
@@ -411,7 +413,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		struct leaf_node *l;
 		size_t path_len = strlen(entry.path);
 
-		if (path_len == 2 * (GIT_SHA1_RAWSZ - prefix_len)) {
+		if (path_len == 2 * (hashsz - prefix_len)) {
 			/* This is potentially the remainder of the SHA-1 */
 
 			if (!S_ISREG(entry.mode))
@@ -419,7 +421,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 				goto handle_non_note;
 
 			if (hex_to_bytes(object_oid.hash + prefix_len, entry.path,
-					 GIT_SHA1_RAWSZ - prefix_len))
+					 hashsz - prefix_len))
 				goto handle_non_note; /* entry.path is not a SHA1 */
 
 			type = PTR_TYPE_NOTE;
@@ -439,7 +441,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 			 * except for the last byte, where we write
 			 * the length:
 			 */
-			memset(object_oid.hash + len, 0, GIT_SHA1_RAWSZ - len - 1);
+			memset(object_oid.hash + len, 0, hashsz - len - 1);
 			object_oid.hash[KEY_INDEX] = (unsigned char)len;
 
 			type = PTR_TYPE_SUBTREE;
@@ -527,15 +529,15 @@ static unsigned char determine_fanout(struct int_node *tree, unsigned char n,
 	return fanout + 1;
 }
 
-/* hex SHA1 + 19 * '/' + NUL */
-#define FANOUT_PATH_MAX GIT_SHA1_HEXSZ + FANOUT_PATH_SEPARATORS + 1
+/* hex oid + '/' between each pair of hex digits + NUL */
+#define FANOUT_PATH_MAX GIT_MAX_HEXSZ + FANOUT_PATH_SEPARATORS_MAX + 1
 
 static void construct_path_with_fanout(const unsigned char *sha1,
 		unsigned char fanout, char *path)
 {
 	unsigned int i = 0, j = 0;
 	const char *hex_sha1 = sha1_to_hex(sha1);
-	assert(fanout < GIT_SHA1_RAWSZ);
+	assert(fanout < the_hash_algo->rawsz);
 	while (fanout) {
 		path[i++] = hex_sha1[j++];
 		path[i++] = hex_sha1[j++];
@@ -637,10 +639,10 @@ static inline int matches_tree_write_stack(struct tree_write_stack *tws,
 
 static void write_tree_entry(struct strbuf *buf, unsigned int mode,
 		const char *path, unsigned int path_len, const
-		unsigned char *sha1)
+		unsigned char *hash)
 {
 	strbuf_addf(buf, "%o %.*s%c", mode, path_len, path, '\0');
-	strbuf_add(buf, sha1, GIT_SHA1_RAWSZ);
+	strbuf_add(buf, hash, the_hash_algo->rawsz);
 }
 
 static void tree_write_stack_init_subtree(struct tree_write_stack *tws,
@@ -652,7 +654,7 @@ static void tree_write_stack_init_subtree(struct tree_write_stack *tws,
 	n = (struct tree_write_stack *)
 		xmalloc(sizeof(struct tree_write_stack));
 	n->next = NULL;
-	strbuf_init(&n->buf, 256 * (32 + GIT_SHA1_HEXSZ)); /* assume 256 entries per tree */
+	strbuf_init(&n->buf, 256 * (32 + the_hash_algo->hexsz)); /* assume 256 entries per tree */
 	n->path[0] = n->path[1] = '\0';
 	tws->next = n;
 	tws->path[0] = path[0];
@@ -757,7 +759,7 @@ static int write_each_note(const struct object_id *object_oid,
 		note_path[note_path_len] = '\0';
 		mode = 040000;
 	}
-	assert(note_path_len <= GIT_SHA1_HEXSZ + FANOUT_PATH_SEPARATORS);
+	assert(note_path_len <= GIT_MAX_HEXSZ + FANOUT_PATH_SEPARATORS);
 
 	/* Weave non-note entries into note entries */
 	return  write_each_non_note_until(note_path, d) ||
@@ -1137,7 +1139,7 @@ int write_notes_tree(struct notes_tree *t, struct object_id *result)
 
 	/* Prepare for traversal of current notes tree */
 	root.next = NULL; /* last forward entry in list is grounded */
-	strbuf_init(&root.buf, 256 * (32 + GIT_SHA1_HEXSZ)); /* assume 256 entries */
+	strbuf_init(&root.buf, 256 * (32 + the_hash_algo->hexsz)); /* assume 256 entries */
 	root.path[0] = root.path[1] = '\0';
 	cb_data.root = &root;
 	cb_data.next_non_note = t->first_non_note;

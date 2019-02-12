Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8821F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfBLBXY (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:24 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34244 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726986AbfBLBXW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:22 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 396D360897;
        Tue, 12 Feb 2019 01:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934601;
        bh=vPJQFoEed+gFMdDdENrb6x7nOF3lkGvACfB9M9gcPUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=fDRuUdErjnVkvCKDJD9aA4RWg5DYVlFQNvUKrgtsC6UAOwJrBqr0gxzjjxjotbIZ5
         EJEMlEhh1/By4zqGvoHjme+JxlHY6xr97V+vhmzPhLilueGtAb51yRvQE24Gsjz9B1
         293u/ZUavD9ZHhi2rHh604b2zlEGDoTkgtLYUY/pH+tuIj75YyzlZH+rXz6ibxYK0X
         wDaJ6+FLJ5REde6s5FYdkNlCg32/nx7GqLgHbXbqwVo4w8KE5/vRUQ0tJd0kMOh0HP
         DxqbpdsgtqHFxAQOI8ILCl4ToQdrFNpzKgH1OmRyQvdjq3n0V0tu2G6WGkGnlDFPk2
         395cZu/kiMfX+WFKABo06bbYc3wXPTuRbYRJ5xhNyrm4nJTgSh8R5YeQG7KnGFjKMK
         xp3jDhWer9reznshQ3gkcd9X3S58jVPe0xHIv7eadj/spoxiFbYqX4KzE9XRIGnssX
         fYXWenCA5z8vGhNT5qihIXrOo9vsqEbmaifszijPX72Jh0F85GF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 08/31] notes: make hash size independent
Date:   Tue, 12 Feb 2019 01:22:33 +0000
Message-Id: <20190212012256.1005924-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
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
index 7f7cc4d511..96647f1d2d 100644
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
+/* hex oid + one slash between each pair + NUL */
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

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E0961F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 00:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfAOAkO (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 19:40:14 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59228 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727505AbfAOAkN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Jan 2019 19:40:13 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c162:ac20:e47c:bd21])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 20C0460FE2;
        Tue, 15 Jan 2019 00:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1547512810;
        bh=1f44AQ5ZFJbrTOJEh2eE2QAl3RCBywsQXePKeGMejdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=d6nDKwSQaf1megbDU4kCq7ria8BB12xvOUWffot/Rn0uNGpBcgzFiXlqhCoA8GSIw
         5nm/Bq7nJrzWpShJ3FAnstW1/dKE7jQ3KFLM+YNj/Y+nU4ZH3zNo/gBHzu8IFNykVK
         ow6aHoBJJo1D62Ym1J+ykJHmSANymrtJxGfMw8ieKrhpRDnqbnRQFH0XFwRDNbCegP
         zXUVgom3jh8mnSuQL5PsNP325g8Lib3k4fNFm9drSYPR+WEwiFL4UCQIxRCEWLKLuq
         K7JVhi0o2MVVNn2TaFUXb9qVsByEijVbqqX/xsA/yeGvFVJ9M0LaZy6Yy1u/wm7nbt
         dnr9yEmo37Z+n/rfXp+VyS5NI0pcc6+FV3DoIo3Vbgr2ij/AI2f7EOtuL7uEAtH+XB
         sElG/BKnK1AInEQYHW8BichYVzlo/wbgn/u2ptL/hqV1zt56Damd6OIDHGQpn/oagU
         OfpS003G7SH+5tYtv63ksV3IgAqNyQDDXIel+H4usHUpmjHW6JU
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 4/5] tree-walk: store object_id in a separate member
Date:   Tue, 15 Jan 2019 00:39:44 +0000
Message-Id: <20190115003946.932078-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce
In-Reply-To: <20190115003946.932078-1-sandals@crustytoothpaste.net>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
 <20190115003946.932078-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing a tree, we read the object ID directly out of the tree
buffer. This is normally fine, but such an object ID cannot be used with
oidcpy, which copies GIT_MAX_RAWSZ bytes, because if we are using SHA-1,
there may not be that many bytes to copy.

Instead, store the object ID in a separate struct member. Since we can
no longer efficiently compute the path length, store that information as
well in struct name_entry. Ensure we only copy the object ID into the
new buffer if the path length is nonzero, as some callers will pass us
an empty path with no object ID following it, and we will not want to
read past the end of the buffer.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/grep.c         |  8 ++++----
 builtin/merge-tree.c   | 20 ++++++++++----------
 builtin/pack-objects.c |  4 ++--
 builtin/reflog.c       |  4 ++--
 cache-tree.c           |  4 ++--
 delta-islands.c        |  2 +-
 fsck.c                 |  4 ++--
 http-push.c            |  4 ++--
 list-objects.c         |  6 +++---
 match-trees.c          |  2 +-
 notes.c                |  4 ++--
 packfile.c             |  2 +-
 revision.c             |  4 ++--
 tree-diff.c            |  6 +++---
 tree-walk.c            | 11 +++++++----
 tree-walk.h            |  9 ++++++---
 tree.c                 | 10 +++++-----
 unpack-trees.c         |  6 +++---
 walker.c               |  4 ++--
 19 files changed, 60 insertions(+), 54 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index bad9c0a3d5..6fb93c0370 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -566,7 +566,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		strbuf_add(base, entry.path, te_len);
 
 		if (S_ISREG(entry.mode)) {
-			hit |= grep_oid(opt, entry.oid, base->buf, tn_len,
+			hit |= grep_oid(opt, &entry.oid, base->buf, tn_len,
 					 check_attr ? base->buf + tn_len : NULL);
 		} else if (S_ISDIR(entry.mode)) {
 			enum object_type type;
@@ -574,10 +574,10 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			void *data;
 			unsigned long size;
 
-			data = lock_and_read_oid_file(entry.oid, &type, &size);
+			data = lock_and_read_oid_file(&entry.oid, &type, &size);
 			if (!data)
 				die(_("unable to read tree (%s)"),
-				    oid_to_hex(entry.oid));
+				    oid_to_hex(&entry.oid));
 
 			strbuf_addch(base, '/');
 			init_tree_desc(&sub, data, size);
@@ -585,7 +585,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 					 check_attr, repo);
 			free(data);
 		} else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
-			hit |= grep_submodule(opt, repo, pathspec, entry.oid,
+			hit |= grep_submodule(opt, repo, pathspec, &entry.oid,
 					      base->buf, base->buf + tn_len);
 		}
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 70f6fc9167..4500c41e94 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -154,15 +154,15 @@ static void show_result(void)
 /* An empty entry never compares same, not even to another empty entry */
 static int same_entry(struct name_entry *a, struct name_entry *b)
 {
-	return	a->oid &&
-		b->oid &&
-		oideq(a->oid, b->oid) &&
+	return	!is_null_oid(&a->oid) &&
+		!is_null_oid(&b->oid) &&
+		oideq(&a->oid, &b->oid) &&
 		a->mode == b->mode;
 }
 
 static int both_empty(struct name_entry *a, struct name_entry *b)
 {
-	return !(a->oid || b->oid);
+	return is_null_oid(&a->oid) && is_null_oid(&b->oid);
 }
 
 static struct merge_list *create_entry(unsigned stage, unsigned mode, const struct object_id *oid, const char *path)
@@ -178,7 +178,7 @@ static struct merge_list *create_entry(unsigned stage, unsigned mode, const stru
 
 static char *traverse_path(const struct traverse_info *info, const struct name_entry *n)
 {
-	char *path = xmallocz(traverse_path_len(info, n));
+	char *path = xmallocz(traverse_path_len(info, n) + the_hash_algo->rawsz);
 	return make_traverse_path(path, info, n);
 }
 
@@ -192,8 +192,8 @@ static void resolve(const struct traverse_info *info, struct name_entry *ours, s
 		return;
 
 	path = traverse_path(info, result);
-	orig = create_entry(2, ours->mode, ours->oid, path);
-	final = create_entry(0, result->mode, result->oid, path);
+	orig = create_entry(2, ours->mode, &ours->oid, path);
+	final = create_entry(0, result->mode, &result->oid, path);
 
 	final->link = orig;
 
@@ -217,7 +217,7 @@ static void unresolved_directory(const struct traverse_info *info,
 
 	newbase = traverse_path(info, p);
 
-#define ENTRY_OID(e) (((e)->mode && S_ISDIR((e)->mode)) ? (e)->oid : NULL)
+#define ENTRY_OID(e) (((e)->mode && S_ISDIR((e)->mode)) ? &(e)->oid : NULL)
 	buf0 = fill_tree_descriptor(t + 0, ENTRY_OID(n + 0));
 	buf1 = fill_tree_descriptor(t + 1, ENTRY_OID(n + 1));
 	buf2 = fill_tree_descriptor(t + 2, ENTRY_OID(n + 2));
@@ -243,7 +243,7 @@ static struct merge_list *link_entry(unsigned stage, const struct traverse_info
 		path = entry->path;
 	else
 		path = traverse_path(info, n);
-	link = create_entry(stage, n->mode, n->oid, path);
+	link = create_entry(stage, n->mode, &n->oid, path);
 	link->link = entry;
 	return link;
 }
@@ -318,7 +318,7 @@ static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, s
 	}
 
 	if (same_entry(entry+0, entry+1)) {
-		if (entry[2].oid && !S_ISDIR(entry[2].mode)) {
+		if (!is_null_oid(&entry[2].oid) && !S_ISDIR(entry[2].mode)) {
 			/* We did not touch, they modified -- take theirs */
 			resolve(info, entry+1, entry+2);
 			return mask;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 24bba8147f..327d9170c4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1334,7 +1334,7 @@ static void add_pbase_object(struct tree_desc *tree,
 		if (cmp < 0)
 			return;
 		if (name[cmplen] != '/') {
-			add_object_entry(entry.oid,
+			add_object_entry(&entry.oid,
 					 object_type(entry.mode),
 					 fullname, 1);
 			return;
@@ -1345,7 +1345,7 @@ static void add_pbase_object(struct tree_desc *tree,
 			const char *down = name+cmplen+1;
 			int downlen = name_cmp_len(down);
 
-			tree = pbase_tree_get(entry.oid);
+			tree = pbase_tree_get(&entry.oid);
 			if (!tree)
 				return;
 			init_tree_desc(&sub, tree->tree_data, tree->tree_size);
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 64a8df4f25..1f1010e2d9 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -94,8 +94,8 @@ static int tree_is_complete(const struct object_id *oid)
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	complete = 1;
 	while (tree_entry(&desc, &entry)) {
-		if (!has_sha1_file(entry.oid->hash) ||
-		    (S_ISDIR(entry.mode) && !tree_is_complete(entry.oid))) {
+		if (!has_sha1_file(entry.oid.hash) ||
+		    (S_ISDIR(entry.mode) && !tree_is_complete(&entry.oid))) {
 			tree->object.flags |= INCOMPLETE;
 			complete = 0;
 		}
diff --git a/cache-tree.c b/cache-tree.c
index 190c6e5aa6..98cb66587b 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -675,7 +675,7 @@ static void prime_cache_tree_rec(struct repository *r,
 			cnt++;
 		else {
 			struct cache_tree_sub *sub;
-			struct tree *subtree = lookup_tree(r, entry.oid);
+			struct tree *subtree = lookup_tree(r, &entry.oid);
 			if (!subtree->object.parsed)
 				parse_tree(subtree);
 			sub = cache_tree_sub(it, entry.path);
@@ -724,7 +724,7 @@ int cache_tree_matches_traversal(struct cache_tree *root,
 
 	it = find_cache_tree_from_traversal(root, info);
 	it = cache_tree_find(it, ent->path);
-	if (it && it->entry_count > 0 && oideq(ent->oid, &it->oid))
+	if (it && it->entry_count > 0 && oideq(&ent->oid, &it->oid))
 		return it->entry_count;
 	return 0;
 }
diff --git a/delta-islands.c b/delta-islands.c
index 191a930705..2186bd0738 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -296,7 +296,7 @@ void resolve_tree_islands(struct repository *r,
 			if (S_ISGITLINK(entry.mode))
 				continue;
 
-			obj = lookup_object(r, entry.oid->hash);
+			obj = lookup_object(r, entry.oid.hash);
 			if (!obj)
 				continue;
 
diff --git a/fsck.c b/fsck.c
index 68502ce85b..2260adb71e 100644
--- a/fsck.c
+++ b/fsck.c
@@ -410,14 +410,14 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 			continue;
 
 		if (S_ISDIR(entry.mode)) {
-			obj = (struct object *)lookup_tree(the_repository, entry.oid);
+			obj = (struct object *)lookup_tree(the_repository, &entry.oid);
 			if (name && obj)
 				put_object_name(options, obj, "%s%s/", name,
 					entry.path);
 			result = options->walk(obj, OBJ_TREE, data, options);
 		}
 		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode)) {
-			obj = (struct object *)lookup_blob(the_repository, entry.oid);
+			obj = (struct object *)lookup_blob(the_repository, &entry.oid);
 			if (name && obj)
 				put_object_name(options, obj, "%s%s", name,
 					entry.path);
diff --git a/http-push.c b/http-push.c
index cd48590912..bb802d80ee 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1311,11 +1311,11 @@ static struct object_list **process_tree(struct tree *tree,
 	while (tree_entry(&desc, &entry))
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
-			p = process_tree(lookup_tree(the_repository, entry.oid),
+			p = process_tree(lookup_tree(the_repository, &entry.oid),
 					 p);
 			break;
 		case OBJ_BLOB:
-			p = process_blob(lookup_blob(the_repository, entry.oid),
+			p = process_blob(lookup_blob(the_repository, &entry.oid),
 					 p);
 			break;
 		default:
diff --git a/list-objects.c b/list-objects.c
index cf7f25bed3..ee6aff0cef 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -123,15 +123,15 @@ static void process_tree_contents(struct traversal_context *ctx,
 		}
 
 		if (S_ISDIR(entry.mode)) {
-			struct tree *t = lookup_tree(ctx->revs->repo, entry.oid);
+			struct tree *t = lookup_tree(ctx->revs->repo, &entry.oid);
 			t->object.flags |= NOT_USER_GIVEN;
 			process_tree(ctx, t, base, entry.path);
 		}
 		else if (S_ISGITLINK(entry.mode))
-			process_gitlink(ctx, entry.oid->hash,
+			process_gitlink(ctx, entry.oid.hash,
 					base, entry.path);
 		else {
-			struct blob *b = lookup_blob(ctx->revs->repo, entry.oid);
+			struct blob *b = lookup_blob(ctx->revs->repo, &entry.oid);
 			b->object.flags |= NOT_USER_GIVEN;
 			process_blob(ctx, b, base, entry.path);
 		}
diff --git a/match-trees.c b/match-trees.c
index c2b7329e09..18ab825bef 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -106,7 +106,7 @@ static int score_trees(const struct object_id *hash1, const struct object_id *ha
 			update_tree_entry(&two);
 		} else {
 			/* path appears in both */
-			if (!oideq(one.entry.oid, two.entry.oid)) {
+			if (!oideq(&one.entry.oid, &two.entry.oid)) {
 				/* they are different */
 				score += score_differs(one.entry.mode,
 						       two.entry.mode,
diff --git a/notes.c b/notes.c
index 25cdce28b7..7f7cc4d511 100644
--- a/notes.c
+++ b/notes.c
@@ -450,7 +450,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 
 		l = xcalloc(1, sizeof(*l));
 		oidcpy(&l->key_oid, &object_oid);
-		oidcpy(&l->val_oid, entry.oid);
+		oidcpy(&l->val_oid, &entry.oid);
 		if (note_tree_insert(t, node, n, l, type,
 				     combine_notes_concatenate))
 			die("Failed to load %s %s into notes tree "
@@ -481,7 +481,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 			}
 			strbuf_addstr(&non_note_path, entry.path);
 			add_non_note(t, strbuf_detach(&non_note_path, NULL),
-				     entry.mode, entry.oid->hash);
+				     entry.mode, entry.oid.hash);
 		}
 	}
 	free(buf);
diff --git a/packfile.c b/packfile.c
index 8c6b47cc77..e38af1a275 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2100,7 +2100,7 @@ static int add_promisor_object(const struct object_id *oid,
 			 */
 			return 0;
 		while (tree_entry_gently(&desc, &entry))
-			oidset_insert(set, entry.oid);
+			oidset_insert(set, &entry.oid);
 	} else if (obj->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *) obj;
 		struct commit_list *parents = commit->parents;
diff --git a/revision.c b/revision.c
index 13e0519c02..05fb390d55 100644
--- a/revision.c
+++ b/revision.c
@@ -67,10 +67,10 @@ static void mark_tree_contents_uninteresting(struct repository *r,
 	while (tree_entry(&desc, &entry)) {
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
-			mark_tree_uninteresting(r, lookup_tree(r, entry.oid));
+			mark_tree_uninteresting(r, lookup_tree(r, &entry.oid));
 			break;
 		case OBJ_BLOB:
-			mark_blob_uninteresting(lookup_blob(r, entry.oid));
+			mark_blob_uninteresting(lookup_blob(r, &entry.oid));
 			break;
 		default:
 			/* Subproject commit - not in this repository */
diff --git a/tree-diff.c b/tree-diff.c
index 0e54324610..4ffa00ae0c 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -239,7 +239,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 						DIFF_STATUS_ADDED;
 
 			if (tpi_valid) {
-				oid_i = tp[i].entry.oid;
+				oid_i = &tp[i].entry.oid;
 				mode_i = tp[i].entry.mode;
 			}
 			else {
@@ -280,7 +280,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 			/* same rule as in emitthis */
 			int tpi_valid = tp && !(tp[i].entry.mode & S_IFXMIN_NEQ);
 
-			parents_oid[i] = tpi_valid ? tp[i].entry.oid : NULL;
+			parents_oid[i] = tpi_valid ? &tp[i].entry.oid : NULL;
 		}
 
 		strbuf_add(base, path, pathlen);
@@ -491,7 +491,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 						continue;
 
 					/* diff(t,pi) != ø */
-					if (!oideq(t.entry.oid, tp[i].entry.oid) ||
+					if (!oideq(&t.entry.oid, &tp[i].entry.oid) ||
 					    (t.entry.mode != tp[i].entry.mode))
 						continue;
 
diff --git a/tree-walk.c b/tree-walk.c
index 1e040fc20e..56b951d3cb 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -48,7 +48,8 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
 	/* Initialize the descriptor entry */
 	desc->entry.path = path;
 	desc->entry.mode = canon_mode(mode);
-	desc->entry.oid  = (const struct object_id *)(path + len);
+	desc->entry.pathlen = len - 1;
+	hashcpy(desc->entry.oid.hash, (const unsigned char *)path + len);
 
 	return 0;
 }
@@ -107,7 +108,7 @@ static void entry_extract(struct tree_desc *t, struct name_entry *a)
 static int update_tree_entry_internal(struct tree_desc *desc, struct strbuf *err)
 {
 	const void *buf = desc->buffer;
-	const unsigned char *end = desc->entry.oid->hash + the_hash_algo->rawsz;
+	const unsigned char *end = (const unsigned char *)desc->entry.path + desc->entry.pathlen + 1 + the_hash_algo->rawsz;
 	unsigned long size = desc->size;
 	unsigned long len = end - (const unsigned char *)buf;
 
@@ -175,9 +176,11 @@ void setup_traverse_info(struct traverse_info *info, const char *base)
 		pathlen--;
 	info->pathlen = pathlen ? pathlen + 1 : 0;
 	info->name.path = base;
-	info->name.oid = (void *)(base + pathlen + 1);
-	if (pathlen)
+	info->name.pathlen = pathlen;
+	if (pathlen) {
+		hashcpy(info->name.oid.hash, (const unsigned char *)base + pathlen + 1);
 		info->prev = &dummy;
+	}
 }
 
 char *make_traverse_path(char *path, const struct traverse_info *info, const struct name_entry *n)
diff --git a/tree-walk.h b/tree-walk.h
index 196831007e..08d349c54f 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -1,11 +1,14 @@
 #ifndef TREE_WALK_H
 #define TREE_WALK_H
 
+#include "cache.h"
+
 struct strbuf;
 
 struct name_entry {
-	const struct object_id *oid;
+	struct object_id oid;
 	const char *path;
+	int pathlen;
 	unsigned int mode;
 };
 
@@ -19,12 +22,12 @@ static inline const struct object_id *tree_entry_extract(struct tree_desc *desc,
 {
 	*pathp = desc->entry.path;
 	*modep = desc->entry.mode;
-	return desc->entry.oid;
+	return &desc->entry.oid;
 }
 
 static inline int tree_entry_len(const struct name_entry *ne)
 {
-	return (const char *)ne->oid - ne->path - 1;
+	return ne->pathlen;
 }
 
 /*
diff --git a/tree.c b/tree.c
index 215d3fdc7c..7badea0009 100644
--- a/tree.c
+++ b/tree.c
@@ -84,7 +84,7 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 				continue;
 		}
 
-		switch (fn(entry.oid, base,
+		switch (fn(&entry.oid, base,
 			   entry.path, entry.mode, stage, context)) {
 		case 0:
 			continue;
@@ -95,19 +95,19 @@ static int read_tree_1(struct tree *tree, struct strbuf *base,
 		}
 
 		if (S_ISDIR(entry.mode))
-			oidcpy(&oid, entry.oid);
+			oidcpy(&oid, &entry.oid);
 		else if (S_ISGITLINK(entry.mode)) {
 			struct commit *commit;
 
-			commit = lookup_commit(the_repository, entry.oid);
+			commit = lookup_commit(the_repository, &entry.oid);
 			if (!commit)
 				die("Commit %s in submodule path %s%s not found",
-				    oid_to_hex(entry.oid),
+				    oid_to_hex(&entry.oid),
 				    base->buf, entry.path);
 
 			if (parse_commit(commit))
 				die("Invalid commit %s in submodule path %s%s",
-				    oid_to_hex(entry.oid),
+				    oid_to_hex(&entry.oid),
 				    base->buf, entry.path);
 
 			oidcpy(&oid, get_commit_tree_oid(commit));
diff --git a/unpack-trees.c b/unpack-trees.c
index 6d53cbfc86..734828fda2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -679,7 +679,7 @@ static int switch_cache_bottom(struct traverse_info *info)
 
 static inline int are_same_oid(struct name_entry *name_j, struct name_entry *name_k)
 {
-	return name_j->oid && name_k->oid && oideq(name_j->oid, name_k->oid);
+	return !is_null_oid(&name_j->oid) && !is_null_oid(&name_k->oid) && oideq(&name_j->oid, &name_k->oid);
 }
 
 static int all_trees_same_as_cache_tree(int n, unsigned long dirmask,
@@ -857,7 +857,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 		else {
 			const struct object_id *oid = NULL;
 			if (dirmask & 1)
-				oid = names[i].oid;
+				oid = &names[i].oid;
 			buf[nr_buf++] = fill_tree_descriptor(t + i, oid);
 		}
 	}
@@ -981,7 +981,7 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 	ce->ce_mode = create_ce_mode(n->mode);
 	ce->ce_flags = create_ce_flags(stage);
 	ce->ce_namelen = len;
-	oidcpy(&ce->oid, n->oid);
+	oidcpy(&ce->oid, &n->oid);
 	make_traverse_path(ce->name, info, n);
 
 	return ce;
diff --git a/walker.c b/walker.c
index 96990d84da..d74ae59c77 100644
--- a/walker.c
+++ b/walker.c
@@ -50,13 +50,13 @@ static int process_tree(struct walker *walker, struct tree *tree)
 			continue;
 		if (S_ISDIR(entry.mode)) {
 			struct tree *tree = lookup_tree(the_repository,
-							entry.oid);
+							&entry.oid);
 			if (tree)
 				obj = &tree->object;
 		}
 		else {
 			struct blob *blob = lookup_blob(the_repository,
-							entry.oid);
+							&entry.oid);
 			if (blob)
 				obj = &blob->object;
 		}

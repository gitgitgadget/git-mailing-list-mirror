From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 8/9] cache-tree: convert struct cache_tree to use object_id
Date: Sat,  3 May 2014 20:12:21 +0000
Message-ID: <1399147942-165308-9-git-send-email-sandals@crustytoothpaste.net>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 22:12:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WggIg-0004K5-33
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 22:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbaECUMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 16:12:34 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47534 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752855AbaECUMc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 May 2014 16:12:32 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EFA4A28087
	for <git@vger.kernel.org>; Sat,  3 May 2014 20:12:30 +0000 (UTC)
X-Mailer: git-send-email 2.0.0.rc0
In-Reply-To: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248049>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/commit.c       |  2 +-
 builtin/fsck.c         |  4 ++--
 cache-tree.c           | 30 +++++++++++++++---------------
 cache-tree.h           |  3 ++-
 merge-recursive.c      |  2 +-
 reachable.c            |  2 +-
 sequencer.c            |  2 +-
 test-dump-cache-tree.c |  4 ++--
 8 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9cfef6c..639f843 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1659,7 +1659,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		append_merge_tag_headers(parents, &tail);
 	}
 
-	if (commit_tree_extended(&sb, active_cache_tree->sha1, parents, sha1,
+	if (commit_tree_extended(&sb, active_cache_tree->sha1.oid, parents, sha1,
 				 author_ident.buf, sign_commit, extra)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
diff --git a/builtin/fsck.c b/builtin/fsck.c
index fc150c8..6854c81 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -587,10 +587,10 @@ static int fsck_cache_tree(struct cache_tree *it)
 		fprintf(stderr, "Checking cache tree\n");
 
 	if (0 <= it->entry_count) {
-		struct object *obj = parse_object(it->sha1);
+		struct object *obj = parse_object(it->sha1.oid);
 		if (!obj) {
 			error("%s: invalid sha1 pointer in cache-tree",
-			      sha1_to_hex(it->sha1));
+			      sha1_to_hex(it->sha1.oid));
 			return 1;
 		}
 		obj->used = 1;
diff --git a/cache-tree.c b/cache-tree.c
index 7fa524a..b7b2d06 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -219,7 +219,7 @@ int cache_tree_fully_valid(struct cache_tree *it)
 	int i;
 	if (!it)
 		return 0;
-	if (it->entry_count < 0 || !has_sha1_file(it->sha1))
+	if (it->entry_count < 0 || !has_sha1_file(it->sha1.oid))
 		return 0;
 	for (i = 0; i < it->subtree_nr; i++) {
 		if (!cache_tree_fully_valid(it->down[i]->cache_tree))
@@ -244,7 +244,7 @@ static int update_one(struct cache_tree *it,
 
 	*skip_count = 0;
 
-	if (0 <= it->entry_count && has_sha1_file(it->sha1))
+	if (0 <= it->entry_count && has_sha1_file(it->sha1.oid))
 		return it->entry_count;
 
 	/*
@@ -311,7 +311,7 @@ static int update_one(struct cache_tree *it,
 		struct cache_tree_sub *sub;
 		const char *path, *slash;
 		int pathlen, entlen;
-		const unsigned char *sha1;
+		const struct object_id *sha1;
 		unsigned mode;
 
 		path = ce->name;
@@ -327,21 +327,21 @@ static int update_one(struct cache_tree *it,
 				die("cache-tree.c: '%.*s' in '%s' not found",
 				    entlen, path + baselen, path);
 			i += sub->count;
-			sha1 = sub->cache_tree->sha1;
+			sha1 = &sub->cache_tree->sha1;
 			mode = S_IFDIR;
 			if (sub->cache_tree->entry_count < 0)
 				to_invalidate = 1;
 		}
 		else {
-			sha1 = ce->sha1;
+			sha1 = (struct object_id *)ce->sha1;
 			mode = ce->ce_mode;
 			entlen = pathlen - baselen;
 			i++;
 		}
-		if (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1)) {
+		if (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1->oid)) {
 			strbuf_release(&buffer);
 			return error("invalid object %06o %s for '%.*s'",
-				mode, sha1_to_hex(sha1), entlen+baselen, path);
+				mode, sha1_to_hex(sha1->oid), entlen+baselen, path);
 		}
 
 		/*
@@ -375,8 +375,8 @@ static int update_one(struct cache_tree *it,
 	}
 
 	if (dryrun)
-		hash_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1);
-	else if (write_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1)) {
+		hash_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1.oid);
+	else if (write_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1.oid)) {
 		strbuf_release(&buffer);
 		return -1;
 	}
@@ -432,7 +432,7 @@ static void write_one(struct strbuf *buffer, struct cache_tree *it,
 #endif
 
 	if (0 <= it->entry_count) {
-		strbuf_add(buffer, it->sha1, 20);
+		strbuf_add(buffer, it->sha1.oid, GIT_OID_RAWSZ);
 	}
 	for (i = 0; i < it->subtree_nr; i++) {
 		struct cache_tree_sub *down = it->down[i];
@@ -489,7 +489,7 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 	if (0 <= it->entry_count) {
 		if (size < 20)
 			goto free_return;
-		hashcpy(it->sha1, (const unsigned char*)buf);
+		hashcpy(it->sha1.oid, (const unsigned char*)buf);
 		buf += 20;
 		size -= 20;
 	}
@@ -612,10 +612,10 @@ int write_cache_as_tree(unsigned char *sha1, int flags, const char *prefix)
 			cache_tree_find(active_cache_tree, prefix);
 		if (!subtree)
 			return WRITE_TREE_PREFIX_ERROR;
-		hashcpy(sha1, subtree->sha1);
+		hashcpy(sha1, subtree->sha1.oid);
 	}
 	else
-		hashcpy(sha1, active_cache_tree->sha1);
+		hashcpy(sha1, active_cache_tree->sha1.oid);
 
 	if (0 <= newfd)
 		rollback_lock_file(lock_file);
@@ -629,7 +629,7 @@ static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
 	struct name_entry entry;
 	int cnt;
 
-	hashcpy(it->sha1, tree->object.sha1);
+	hashcpy(it->sha1.oid, tree->object.sha1);
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	cnt = 0;
 	while (tree_entry(&desc, &entry)) {
@@ -683,7 +683,7 @@ int cache_tree_matches_traversal(struct cache_tree *root,
 
 	it = find_cache_tree_from_traversal(root, info);
 	it = cache_tree_find(it, ent->path);
-	if (it && it->entry_count > 0 && !hashcmp(ent->sha1, it->sha1))
+	if (it && it->entry_count > 0 && !hashcmp(ent->sha1, it->sha1.oid))
 		return it->entry_count;
 	return 0;
 }
diff --git a/cache-tree.h b/cache-tree.h
index f1923ad..a65231e 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -3,6 +3,7 @@
 
 #include "tree.h"
 #include "tree-walk.h"
+#include "object.h"
 
 struct cache_tree;
 struct cache_tree_sub {
@@ -15,7 +16,7 @@ struct cache_tree_sub {
 
 struct cache_tree {
 	int entry_count; /* negative means "invalid" */
-	unsigned char sha1[20];
+	struct object_id sha1;
 	int subtree_nr;
 	int subtree_alloc;
 	struct cache_tree_sub **down;
diff --git a/merge-recursive.c b/merge-recursive.c
index 4177092..7db772d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -270,7 +270,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 			      active_nr, 0) < 0)
 		die(_("error building trees"));
 
-	result = lookup_tree(active_cache_tree->sha1);
+	result = lookup_tree(active_cache_tree->sha1.oid);
 
 	return result;
 }
diff --git a/reachable.c b/reachable.c
index 654a8c5..464c5ef 100644
--- a/reachable.c
+++ b/reachable.c
@@ -177,7 +177,7 @@ static void add_cache_tree(struct cache_tree *it, struct rev_info *revs)
 	int i;
 
 	if (it->entry_count >= 0)
-		add_one_tree(it->sha1, revs);
+		add_one_tree(it->sha1.oid, revs);
 	for (i = 0; i < it->subtree_nr; i++)
 		add_cache_tree(it->down[i]->cache_tree, revs);
 }
diff --git a/sequencer.c b/sequencer.c
index bde5f04..fe48518 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -377,7 +377,7 @@ static int is_index_unchanged(void)
 				      active_nr, 0))
 			return error(_("Unable to update cache tree\n"));
 
-	return !hashcmp(active_cache_tree->sha1, head_commit->tree->object.sha1);
+	return !hashcmp(active_cache_tree->sha1.oid, head_commit->tree->object.sha1);
 }
 
 /*
diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
index 47eab97..9d97908 100644
--- a/test-dump-cache-tree.c
+++ b/test-dump-cache-tree.c
@@ -10,7 +10,7 @@ static void dump_one(struct cache_tree *it, const char *pfx, const char *x)
 		       "invalid", x, pfx, it->subtree_nr);
 	else
 		printf("%s %s%s (%d entries, %d subtrees)\n",
-		       sha1_to_hex(it->sha1), x, pfx,
+		       sha1_to_hex(it->sha1.oid), x, pfx,
 		       it->entry_count, it->subtree_nr);
 }
 
@@ -33,7 +33,7 @@ static int dump_cache_tree(struct cache_tree *it,
 	}
 	else {
 		dump_one(it, pfx, "");
-		if (hashcmp(it->sha1, ref->sha1) ||
+		if (hashcmp(it->sha1.oid, ref->sha1.oid) ||
 		    ref->entry_count != it->entry_count ||
 		    ref->subtree_nr != it->subtree_nr) {
 			dump_one(ref, pfx, "#(ref) ");
-- 
2.0.0.rc0

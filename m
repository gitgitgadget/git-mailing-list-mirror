Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1887D1FC3E
	for <e@80x24.org>; Mon,  1 May 2017 02:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642342AbdEACaR (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:30:17 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35610 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S642312AbdEACaE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DD9AA280B0;
        Mon,  1 May 2017 02:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605802;
        bh=hs6UB7B0gNtK9O0S/cc/uMVJ8+J+sW5TwTn1Mwcb2gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fY8qUrO/A8E/Ea/KRTXR7qUhW6tgjGSr743u+69LuTC26yAz3NXmRcO2EwTvOELJi
         SGWiCubmUhT5JZIdhEp6UazdkKRgjRFZ1sGi0XStPI+A6WwjhTqN7Kwzattr/SnWby
         IB/XEEpOvynVGwJ2yX4sp1phNs1ZYHU23U/gLFpivwQim+NrD5R4QdooudTBRyM9jC
         s3Vtc9WEGbRGKAhqFjXsCFY6MZ7/HhRNi21nwApfYx8SPHvSdXJhvfAnkOajNWyRIk
         Rj6nmZSxlm4UFxpGPpHrpfE9PJBKfHraUsUcAPVBiJEi9++l7pw1co0RsAgGxdGpYr
         8cYcKhA4QYZChVeKaZSoMAfOc247KWXW4AesYFZY65uySO9pHjBUAO1lr/UJ065oYD
         ptRWoIy42xjmWiKlzKrp2cMiE/fA1oZjocEvoFYF3kKW8faGz/so8eCgOeVQF6QuEd
         CXyDqbDL4RapNvMnirPBUKXFTrAqNUtm/jmCmuXNMOSZLBoQUdu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 03/53] Convert struct cache_tree to use struct object_id
Date:   Mon,  1 May 2017 02:28:56 +0000
Message-Id: <20170501022946.258735-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the sha1 member of struct cache_tree to struct object_id by
changing the definition and applying the following semantic patch, plus
the standard object_id transforms:

@@
struct cache_tree E1;
@@
- E1.sha1
+ E1.oid.hash

@@
struct cache_tree *E1;
@@
- E1->sha1
+ E1->oid.hash

Fix up one reference to active_cache_tree which was not automatically
caught by Coccinelle.  These changes are prerequisites for converting
parse_object.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/commit.c                |  2 +-
 builtin/fsck.c                  |  4 ++--
 cache-tree.c                    | 31 ++++++++++++++++---------------
 cache-tree.h                    |  3 ++-
 merge-recursive.c               |  2 +-
 revision.c                      |  2 +-
 sequencer.c                     |  3 ++-
 t/helper/test-dump-cache-tree.c |  4 ++--
 8 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1d805f5da..8685c888f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1758,7 +1758,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		append_merge_tag_headers(parents, &tail);
 	}
 
-	if (commit_tree_extended(sb.buf, sb.len, active_cache_tree->sha1,
+	if (commit_tree_extended(sb.buf, sb.len, active_cache_tree->oid.hash,
 			 parents, oid.hash, author_ident.buf, sign_commit, extra)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
diff --git a/builtin/fsck.c b/builtin/fsck.c
index b5e13a455..c40e14de6 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -599,10 +599,10 @@ static int fsck_cache_tree(struct cache_tree *it)
 		fprintf(stderr, "Checking cache tree\n");
 
 	if (0 <= it->entry_count) {
-		struct object *obj = parse_object(it->sha1);
+		struct object *obj = parse_object(it->oid.hash);
 		if (!obj) {
 			error("%s: invalid sha1 pointer in cache-tree",
-			      sha1_to_hex(it->sha1));
+			      oid_to_hex(&it->oid));
 			errors_found |= ERROR_REFS;
 			return 1;
 		}
diff --git a/cache-tree.c b/cache-tree.c
index 345ea3596..35d507ed7 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -225,7 +225,7 @@ int cache_tree_fully_valid(struct cache_tree *it)
 	int i;
 	if (!it)
 		return 0;
-	if (it->entry_count < 0 || !has_sha1_file(it->sha1))
+	if (it->entry_count < 0 || !has_sha1_file(it->oid.hash))
 		return 0;
 	for (i = 0; i < it->subtree_nr; i++) {
 		if (!cache_tree_fully_valid(it->down[i]->cache_tree))
@@ -253,7 +253,7 @@ static int update_one(struct cache_tree *it,
 
 	*skip_count = 0;
 
-	if (0 <= it->entry_count && has_sha1_file(it->sha1))
+	if (0 <= it->entry_count && has_sha1_file(it->oid.hash))
 		return it->entry_count;
 
 	/*
@@ -340,7 +340,7 @@ static int update_one(struct cache_tree *it,
 				die("cache-tree.c: '%.*s' in '%s' not found",
 				    entlen, path + baselen, path);
 			i += sub->count;
-			sha1 = sub->cache_tree->sha1;
+			sha1 = sub->cache_tree->oid.hash;
 			mode = S_IFDIR;
 			contains_ita = sub->cache_tree->entry_count < 0;
 			if (contains_ita) {
@@ -402,12 +402,13 @@ static int update_one(struct cache_tree *it,
 		unsigned char sha1[20];
 		hash_sha1_file(buffer.buf, buffer.len, tree_type, sha1);
 		if (has_sha1_file(sha1))
-			hashcpy(it->sha1, sha1);
+			hashcpy(it->oid.hash, sha1);
 		else
 			to_invalidate = 1;
 	} else if (dryrun)
-		hash_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1);
-	else if (write_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1)) {
+		hash_sha1_file(buffer.buf, buffer.len, tree_type,
+			       it->oid.hash);
+	else if (write_sha1_file(buffer.buf, buffer.len, tree_type, it->oid.hash)) {
 		strbuf_release(&buffer);
 		return -1;
 	}
@@ -417,7 +418,7 @@ static int update_one(struct cache_tree *it,
 #if DEBUG
 	fprintf(stderr, "cache-tree update-one (%d ent, %d subtree) %s\n",
 		it->entry_count, it->subtree_nr,
-		sha1_to_hex(it->sha1));
+		oid_to_hex(&it->oid));
 #endif
 	return i;
 }
@@ -457,14 +458,14 @@ static void write_one(struct strbuf *buffer, struct cache_tree *it,
 	if (0 <= it->entry_count)
 		fprintf(stderr, "cache-tree <%.*s> (%d ent, %d subtree) %s\n",
 			pathlen, path, it->entry_count, it->subtree_nr,
-			sha1_to_hex(it->sha1));
+			oid_to_hex(&it->oid));
 	else
 		fprintf(stderr, "cache-tree <%.*s> (%d subtree) invalid\n",
 			pathlen, path, it->subtree_nr);
 #endif
 
 	if (0 <= it->entry_count) {
-		strbuf_add(buffer, it->sha1, 20);
+		strbuf_add(buffer, it->oid.hash, 20);
 	}
 	for (i = 0; i < it->subtree_nr; i++) {
 		struct cache_tree_sub *down = it->down[i];
@@ -521,7 +522,7 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 	if (0 <= it->entry_count) {
 		if (size < 20)
 			goto free_return;
-		hashcpy(it->sha1, (const unsigned char*)buf);
+		hashcpy(it->oid.hash, (const unsigned char*)buf);
 		buf += 20;
 		size -= 20;
 	}
@@ -530,7 +531,7 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
 	if (0 <= it->entry_count)
 		fprintf(stderr, "cache-tree <%s> (%d ent, %d subtree) %s\n",
 			*buffer, it->entry_count, subtree_nr,
-			sha1_to_hex(it->sha1));
+			oid_to_hex(&it->oid));
 	else
 		fprintf(stderr, "cache-tree <%s> (%d subtrees) invalid\n",
 			*buffer, subtree_nr);
@@ -641,10 +642,10 @@ int write_index_as_tree(unsigned char *sha1, struct index_state *index_state, co
 		subtree = cache_tree_find(index_state->cache_tree, prefix);
 		if (!subtree)
 			return WRITE_TREE_PREFIX_ERROR;
-		hashcpy(sha1, subtree->sha1);
+		hashcpy(sha1, subtree->oid.hash);
 	}
 	else
-		hashcpy(sha1, index_state->cache_tree->sha1);
+		hashcpy(sha1, index_state->cache_tree->oid.hash);
 
 	if (0 <= newfd)
 		rollback_lock_file(lock_file);
@@ -663,7 +664,7 @@ static void prime_cache_tree_rec(struct cache_tree *it, struct tree *tree)
 	struct name_entry entry;
 	int cnt;
 
-	hashcpy(it->sha1, tree->object.oid.hash);
+	oidcpy(&it->oid, &tree->object.oid);
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	cnt = 0;
 	while (tree_entry(&desc, &entry)) {
@@ -718,7 +719,7 @@ int cache_tree_matches_traversal(struct cache_tree *root,
 
 	it = find_cache_tree_from_traversal(root, info);
 	it = cache_tree_find(it, ent->path);
-	if (it && it->entry_count > 0 && !hashcmp(ent->oid->hash, it->sha1))
+	if (it && it->entry_count > 0 && !oidcmp(ent->oid, &it->oid))
 		return it->entry_count;
 	return 0;
 }
diff --git a/cache-tree.h b/cache-tree.h
index 41c574663..f7b9cab7e 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -1,6 +1,7 @@
 #ifndef CACHE_TREE_H
 #define CACHE_TREE_H
 
+#include "cache.h"
 #include "tree.h"
 #include "tree-walk.h"
 
@@ -15,7 +16,7 @@ struct cache_tree_sub {
 
 struct cache_tree {
 	int entry_count; /* negative means "invalid" */
-	unsigned char sha1[20];
+	struct object_id oid;
 	int subtree_nr;
 	int subtree_alloc;
 	struct cache_tree_sub **down;
diff --git a/merge-recursive.c b/merge-recursive.c
index 62decd51c..9d6fd577e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -304,7 +304,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 		return NULL;
 	}
 
-	result = lookup_tree(active_cache_tree->sha1);
+	result = lookup_tree(active_cache_tree->oid.hash);
 
 	return result;
 }
diff --git a/revision.c b/revision.c
index 7ff61ff5f..2b56c3baf 100644
--- a/revision.c
+++ b/revision.c
@@ -1249,7 +1249,7 @@ static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
 	int i;
 
 	if (it->entry_count >= 0) {
-		struct tree *tree = lookup_tree(it->sha1);
+		struct tree *tree = lookup_tree(it->oid.hash);
 		add_pending_object_with_path(revs, &tree->object, "",
 					     040000, path->buf);
 	}
diff --git a/sequencer.c b/sequencer.c
index 130cc868e..d119baa51 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -508,7 +508,8 @@ static int is_index_unchanged(void)
 		if (cache_tree_update(&the_index, 0))
 			return error(_("unable to update cache tree\n"));
 
-	return !hashcmp(active_cache_tree->sha1, head_commit->tree->object.oid.hash);
+	return !oidcmp(&active_cache_tree->oid,
+		       &head_commit->tree->object.oid);
 }
 
 static int write_author_script(const char *message)
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 7af116d49..ebf3aab22 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -10,7 +10,7 @@ static void dump_one(struct cache_tree *it, const char *pfx, const char *x)
 		       "invalid", x, pfx, it->subtree_nr);
 	else
 		printf("%s %s%s (%d entries, %d subtrees)\n",
-		       sha1_to_hex(it->sha1), x, pfx,
+		       oid_to_hex(&it->oid), x, pfx,
 		       it->entry_count, it->subtree_nr);
 }
 
@@ -32,7 +32,7 @@ static int dump_cache_tree(struct cache_tree *it,
 	}
 	else {
 		dump_one(it, pfx, "");
-		if (hashcmp(it->sha1, ref->sha1) ||
+		if (oidcmp(&it->oid, &ref->oid) ||
 		    ref->entry_count != it->entry_count ||
 		    ref->subtree_nr != it->subtree_nr) {
 			/* claims to be valid but is lying */

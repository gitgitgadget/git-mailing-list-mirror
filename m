Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3364D1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeBYVNY (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:13:24 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34000 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751979AbeBYVM7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:12:59 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 84FD360E4D;
        Sun, 25 Feb 2018 21:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593178;
        bh=QaPUTZkCjZZby/nf1qIz/llualM7N3KNqluG4zAwhNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=B4OMG8uLOVv1D4F9oX7S0253bQP3nfiHE/jKYuCSr9ruPzZxjMeCBcZAvC7rSDeCi
         tkZXn0mVWGHNbBqnFYsYW/vI6DoGMa2o9+BqX54a5csOi+qgINZuIb/MtIsVPHRIzs
         z2F3KuXOm3U6q63dy5qga64MYm9cew4Hl4bYULcBBH/sIGeu/119t39d6YQIJ3rOlc
         6/9pjExamMLO5lW6ud2S2cF8Ek3PSrzD2+KCV2lo73xCb27ndSWvCaX2CbEMu1yMwZ
         oz3ZViEadAdoTLGJqfP136LL7riPsWkjd1mbtR4GnUMGCJy6kcUonIf2En2rWRANls
         pfVcF63yU3cOWozUQVqzpZkq/F/LpRt0fznzHEBAcMkFt+aiTL4qpP85k03uie4f2X
         H+FDsPOlLMUlC/C9rCgccpw3X9g1YlEdUX4SaJ4kSZ82bSpjf3WZygm3UgqfFcIhIM
         BmPUDDfEwELWSwkxH2y76Mf3retp//vy1CAiUMZme036UmhDCSg
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 31/36] tree-walk: convert tree entry functions to object_id
Date:   Sun, 25 Feb 2018 21:12:07 +0000
Message-Id: <20180225211212.477570-32-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert get_tree_entry and find_tree_entry to take pointers to struct
object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive.c              |  4 ++--
 blame.c                |  6 ++----
 builtin/rm.c           |  2 +-
 builtin/update-index.c |  2 +-
 line-log.c             |  3 +--
 match-trees.c          |  6 +++---
 merge-recursive.c      | 12 ++++++------
 notes.c                |  2 +-
 sha1_name.c            |  7 +++----
 tree-walk.c            | 20 ++++++++++----------
 tree-walk.h            |  2 +-
 11 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/archive.c b/archive.c
index da62b2f541..1ab62d426e 100644
--- a/archive.c
+++ b/archive.c
@@ -397,8 +397,8 @@ static void parse_treeish_arg(const char **argv,
 		unsigned int mode;
 		int err;
 
-		err = get_tree_entry(tree->object.oid.hash, prefix,
-				     tree_oid.hash, &mode);
+		err = get_tree_entry(&tree->object.oid, prefix, &tree_oid,
+				     &mode);
 		if (err || !S_ISDIR(mode))
 			die("current working directory is untracked");
 
diff --git a/blame.c b/blame.c
index c1df10cdd2..3f9bd29615 100644
--- a/blame.c
+++ b/blame.c
@@ -80,7 +80,7 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
 		struct object_id blob_oid;
 		unsigned mode;
 
-		if (!get_tree_entry(commit_oid->hash, path, blob_oid.hash, &mode) &&
+		if (!get_tree_entry(commit_oid, path, &blob_oid, &mode) &&
 		    oid_object_info(&blob_oid, NULL) == OBJ_BLOB)
 			return;
 	}
@@ -502,9 +502,7 @@ static int fill_blob_sha1_and_mode(struct blame_origin *origin)
 {
 	if (!is_null_oid(&origin->blob_oid))
 		return 0;
-	if (get_tree_entry(origin->commit->object.oid.hash,
-			   origin->path,
-			   origin->blob_oid.hash, &origin->mode))
+	if (get_tree_entry(&origin->commit->object.oid, origin->path, &origin->blob_oid, &origin->mode))
 		goto error_out;
 	if (oid_object_info(&origin->blob_oid, NULL) != OBJ_BLOB)
 		goto error_out;
diff --git a/builtin/rm.c b/builtin/rm.c
index 4a2fcca27b..974a7ef5bf 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -178,7 +178,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 		 * way as changed from the HEAD.
 		 */
 		if (no_head
-		     || get_tree_entry(head->hash, name, oid.hash, &mode)
+		     || get_tree_entry(head, name, &oid, &mode)
 		     || ce->ce_mode != create_ce_mode(mode)
 		     || oidcmp(&ce->oid, &oid))
 			staged_changes = 1;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 58d1c2d282..9625d1e10a 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -592,7 +592,7 @@ static struct cache_entry *read_one_ent(const char *which,
 	int size;
 	struct cache_entry *ce;
 
-	if (get_tree_entry(ent->hash, path, oid.hash, &mode)) {
+	if (get_tree_entry(ent, path, &oid, &mode)) {
 		if (which)
 			error("%s: not in %s branch.", path, which);
 		return NULL;
diff --git a/line-log.c b/line-log.c
index 545ad0f28b..700121eb92 100644
--- a/line-log.c
+++ b/line-log.c
@@ -501,8 +501,7 @@ static void fill_blob_sha1(struct commit *commit, struct diff_filespec *spec)
 	unsigned mode;
 	struct object_id oid;
 
-	if (get_tree_entry(commit->object.oid.hash, spec->path,
-			   oid.hash, &mode))
+	if (get_tree_entry(&commit->object.oid, spec->path, &oid, &mode))
 		die("There is no path %s in the commit", spec->path);
 	fill_filespec(spec, &oid, 1, mode);
 
diff --git a/match-trees.c b/match-trees.c
index 0ca99d5162..10d6c39d47 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -269,7 +269,7 @@ void shift_tree(const struct object_id *hash1,
 		if (!*del_prefix)
 			return;
 
-		if (get_tree_entry(hash2->hash, del_prefix, shifted->hash, &mode))
+		if (get_tree_entry(hash2, del_prefix, shifted, &mode))
 			die("cannot find path %s in tree %s",
 			    del_prefix, oid_to_hex(hash2));
 		return;
@@ -296,12 +296,12 @@ void shift_tree_by(const struct object_id *hash1,
 	unsigned candidate = 0;
 
 	/* Can hash2 be a tree at shift_prefix in tree hash1? */
-	if (!get_tree_entry(hash1->hash, shift_prefix, sub1.hash, &mode1) &&
+	if (!get_tree_entry(hash1, shift_prefix, &sub1, &mode1) &&
 	    S_ISDIR(mode1))
 		candidate |= 1;
 
 	/* Can hash1 be a tree at shift_prefix in tree hash2? */
-	if (!get_tree_entry(hash2->hash, shift_prefix, sub2.hash, &mode2) &&
+	if (!get_tree_entry(hash2, shift_prefix, &sub2, &mode2) &&
 	    S_ISDIR(mode2))
 		candidate |= 2;
 
diff --git a/merge-recursive.c b/merge-recursive.c
index f58f13957e..85f8cbee99 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -370,12 +370,12 @@ static struct stage_data *insert_stage_data(const char *path,
 {
 	struct string_list_item *item;
 	struct stage_data *e = xcalloc(1, sizeof(struct stage_data));
-	get_tree_entry(o->object.oid.hash, path,
-			e->stages[1].oid.hash, &e->stages[1].mode);
-	get_tree_entry(a->object.oid.hash, path,
-			e->stages[2].oid.hash, &e->stages[2].mode);
-	get_tree_entry(b->object.oid.hash, path,
-			e->stages[3].oid.hash, &e->stages[3].mode);
+	get_tree_entry(&o->object.oid, path,
+			&e->stages[1].oid, &e->stages[1].mode);
+	get_tree_entry(&a->object.oid, path,
+			&e->stages[2].oid, &e->stages[2].mode);
+	get_tree_entry(&b->object.oid, path,
+			&e->stages[3].oid, &e->stages[3].mode);
 	item = string_list_insert(entries, path);
 	item->util = e;
 	return e;
diff --git a/notes.c b/notes.c
index ce9a8f53f8..d25121a65d 100644
--- a/notes.c
+++ b/notes.c
@@ -1012,7 +1012,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 		return;
 	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, &object_oid))
 		die("Cannot use notes ref %s", notes_ref);
-	if (get_tree_entry(object_oid.hash, "", oid.hash, &mode))
+	if (get_tree_entry(&object_oid, "", &oid, &mode))
 		die("Failed to read notes tree referenced by %s (%s)",
 		    notes_ref, oid_to_hex(&object_oid));
 
diff --git a/sha1_name.c b/sha1_name.c
index 6d4c6033c8..8b0012c253 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1529,8 +1529,7 @@ static void diagnose_invalid_oid_path(const char *prefix,
 	if (is_missing_file_error(errno)) {
 		char *fullname = xstrfmt("%s%s", prefix, filename);
 
-		if (!get_tree_entry(tree_oid->hash, fullname,
-				    oid.hash, &mode)) {
+		if (!get_tree_entry(tree_oid, fullname, &oid, &mode)) {
 			die("Path '%s' exists, but not '%s'.\n"
 			    "Did you mean '%.*s:%s' aka '%.*s:./%s'?",
 			    fullname,
@@ -1722,8 +1721,8 @@ static int get_oid_with_context_1(const char *name,
 					filename, oid->hash, &oc->symlink_path,
 					&oc->mode);
 			} else {
-				ret = get_tree_entry(tree_oid.hash, filename,
-						     oid->hash, &oc->mode);
+				ret = get_tree_entry(&tree_oid, filename, oid,
+						     &oc->mode);
 				if (ret && only_to_die) {
 					diagnose_invalid_oid_path(prefix,
 								   filename,
diff --git a/tree-walk.c b/tree-walk.c
index 521defdaa2..a60837c491 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -492,7 +492,7 @@ struct dir_state {
 	unsigned char sha1[20];
 };
 
-static int find_tree_entry(struct tree_desc *t, const char *name, unsigned char *result, unsigned *mode)
+static int find_tree_entry(struct tree_desc *t, const char *name, struct object_id *result, unsigned *mode)
 {
 	int namelen = strlen(name);
 	while (t->size) {
@@ -511,7 +511,7 @@ static int find_tree_entry(struct tree_desc *t, const char *name, unsigned char
 		if (cmp < 0)
 			break;
 		if (entrylen == namelen) {
-			hashcpy(result, oid->hash);
+			oidcpy(result, oid);
 			return 0;
 		}
 		if (name[entrylen] != '/')
@@ -519,27 +519,27 @@ static int find_tree_entry(struct tree_desc *t, const char *name, unsigned char
 		if (!S_ISDIR(*mode))
 			break;
 		if (++entrylen == namelen) {
-			hashcpy(result, oid->hash);
+			oidcpy(result, oid);
 			return 0;
 		}
-		return get_tree_entry(oid->hash, name + entrylen, result, mode);
+		return get_tree_entry(oid, name + entrylen, result, mode);
 	}
 	return -1;
 }
 
-int get_tree_entry(const unsigned char *tree_sha1, const char *name, unsigned char *sha1, unsigned *mode)
+int get_tree_entry(const struct object_id *tree_oid, const char *name, struct object_id *oid, unsigned *mode)
 {
 	int retval;
 	void *tree;
 	unsigned long size;
-	unsigned char root[20];
+	struct object_id root;
 
-	tree = read_object_with_reference(tree_sha1, tree_type, &size, root);
+	tree = read_object_with_reference(tree_oid->hash, tree_type, &size, root.hash);
 	if (!tree)
 		return -1;
 
 	if (name[0] == '\0') {
-		hashcpy(sha1, root);
+		oidcpy(oid, &root);
 		free(tree);
 		return 0;
 	}
@@ -549,7 +549,7 @@ int get_tree_entry(const unsigned char *tree_sha1, const char *name, unsigned ch
 	} else {
 		struct tree_desc t;
 		init_tree_desc(&t, tree, size);
-		retval = find_tree_entry(&t, name, sha1, mode);
+		retval = find_tree_entry(&t, name, oid, mode);
 	}
 	free(tree);
 	return retval;
@@ -671,7 +671,7 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 
 		/* Look up the first (or only) path component in the tree. */
 		find_result = find_tree_entry(&t, namebuf.buf,
-					      current_tree_oid.hash, mode);
+					      &current_tree_oid, mode);
 		if (find_result) {
 			goto done;
 		}
diff --git a/tree-walk.h b/tree-walk.h
index b6bd1b4ccf..4617deeb0e 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -79,7 +79,7 @@ struct traverse_info {
 	int show_all_errors;
 };
 
-int get_tree_entry(const unsigned char *, const char *, unsigned char *, unsigned *);
+int get_tree_entry(const struct object_id *, const char *, struct object_id *, unsigned *);
 extern char *make_traverse_path(char *path, const struct traverse_info *info, const struct name_entry *n);
 extern void setup_traverse_info(struct traverse_info *info, const char *base);
 

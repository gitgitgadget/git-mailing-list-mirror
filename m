Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81891207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046211AbdDWVhH (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:37:07 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37408 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046132AbdDWVfv (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E052E280B3;
        Sun, 23 Apr 2017 21:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983337;
        bh=xsdF5V18oiBxpF53Lojnx1ctUi8gah28vV8LZU5IBgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sl1ai99tCpA2w0EepNGm8lvgUIEURF707Hr0k7fHJ5Uk9/z0i79FElhp1Zg7YYVMw
         9bhKMcmLxXpcrbxwJBThLQQwxZQHs1Ato3AR5Hf8t9kMeqAbWgpaajCFc5kF2p5VVi
         mz6IdUN2cMur77HUD3bo+AVjF4hecSxccVixNNnmFk7Jwmw6REjgiITyNwts+s5vSL
         EGaETtMotjyFjFgujlqb25muk5VhEZzSHu+dOpETPnyLonfVx9Cqf7kl2SdciVU/hM
         7pYLLJEhJdOZL9cZb63LY7Euvm2H8bGCmHjm9ttqWTJKnLTNCgz7VJuMVfANYqHNHM
         Wrz4bmmysUXDrziAooJnN8G2VFqrWQuEYYlGs7VnBxA3Alo76bp1bP9+WCtWj4zJNp
         nh3hKCngRhs1Tcq0oHvlJhKTIHwwl2DE/No0SwkoFi99MemvVfThQISQh/fzZxykJ+
         rAax23LMZ5j1ErIDaxE7fCRoACy3bXDKsCPFNmVIqcT2Yq87yM1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 29/53] Convert lookup_blob to struct object_id
Date:   Sun, 23 Apr 2017 21:34:29 +0000
Message-Id: <20170423213453.253425-30-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert lookup_blob to take a pointer to struct object_id.

The commit was created with manual changes to blob.c and blob.h, plus
the following semantic patch:

@@
expression E1;
@@
- lookup_blob(E1.hash)
+ lookup_blob(&E1)

@@
expression E1;
@@
- lookup_blob(E1->hash)
+ lookup_blob(E1)

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 blob.c                   | 6 +++---
 blob.h                   | 2 +-
 builtin/fast-export.c    | 2 +-
 builtin/fsck.c           | 2 +-
 builtin/index-pack.c     | 2 +-
 builtin/merge-tree.c     | 2 +-
 builtin/unpack-objects.c | 2 +-
 fsck.c                   | 2 +-
 http-push.c              | 2 +-
 list-objects.c           | 2 +-
 object.c                 | 4 ++--
 reachable.c              | 2 +-
 revision.c               | 4 ++--
 tag.c                    | 2 +-
 walker.c                 | 2 +-
 15 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/blob.c b/blob.c
index 1fcb8e44b..fa2ab4f7a 100644
--- a/blob.c
+++ b/blob.c
@@ -3,11 +3,11 @@
 
 const char *blob_type = "blob";
 
-struct blob *lookup_blob(const unsigned char *sha1)
+struct blob *lookup_blob(const struct object_id *oid)
 {
-	struct object *obj = lookup_object(sha1);
+	struct object *obj = lookup_object(oid->hash);
 	if (!obj)
-		return create_object(sha1, alloc_blob_node());
+		return create_object(oid->hash, alloc_blob_node());
 	return object_as_type(obj, OBJ_BLOB, 0);
 }
 
diff --git a/blob.h b/blob.h
index 59b394eea..446061683 100644
--- a/blob.h
+++ b/blob.h
@@ -9,7 +9,7 @@ struct blob {
 	struct object object;
 };
 
-struct blob *lookup_blob(const unsigned char *sha1);
+struct blob *lookup_blob(const struct object_id *oid);
 
 int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
 
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index b4521cb62..ae36b14db 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -232,7 +232,7 @@ static void export_blob(const struct object_id *oid)
 
 	if (anonymize) {
 		buf = anonymize_blob(&size);
-		object = (struct object *)lookup_blob(oid->hash);
+		object = (struct object *)lookup_blob(oid);
 		eaten = 0;
 	} else {
 		buf = read_sha1_file(oid->hash, &type, &size);
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 543122f04..14a216ee6 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -780,7 +780,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			mode = active_cache[i]->ce_mode;
 			if (S_ISGITLINK(mode))
 				continue;
-			blob = lookup_blob(active_cache[i]->oid.hash);
+			blob = lookup_blob(&active_cache[i]->oid);
 			if (!blob)
 				continue;
 			obj = &blob->object;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2241ee68e..b75133f62 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -829,7 +829,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 	if (strict) {
 		read_lock();
 		if (type == OBJ_BLOB) {
-			struct blob *blob = lookup_blob(oid->hash);
+			struct blob *blob = lookup_blob(oid);
 			if (blob)
 				blob->object.flags |= FLAG_CHECKED;
 			else
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index cdeb6562d..bad6735c7 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -168,7 +168,7 @@ static struct merge_list *create_entry(unsigned stage, unsigned mode, const stru
 	res->stage = stage;
 	res->path = path;
 	res->mode = mode;
-	res->blob = lookup_blob(oid->hash);
+	res->blob = lookup_blob(oid);
 	return res;
 }
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 3dc5e5691..7d5efa2b3 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -249,7 +249,7 @@ static void write_object(unsigned nr, enum object_type type,
 		added_object(nr, type, buf, size);
 		free(buf);
 
-		blob = lookup_blob(obj_list[nr].oid.hash);
+		blob = lookup_blob(&obj_list[nr].oid);
 		if (blob)
 			blob->object.flags |= FLAG_WRITTEN;
 		else
diff --git a/fsck.c b/fsck.c
index e6152e4e6..ab3016c0e 100644
--- a/fsck.c
+++ b/fsck.c
@@ -365,7 +365,7 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 			result = options->walk(obj, OBJ_TREE, data, options);
 		}
 		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode)) {
-			obj = &lookup_blob(entry.oid->hash)->object;
+			obj = &lookup_blob(entry.oid)->object;
 			if (name)
 				put_object_name(options, obj, "%s%s", name,
 					entry.path);
diff --git a/http-push.c b/http-push.c
index 04568e4fb..9bb5e0648 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1315,7 +1315,7 @@ static struct object_list **process_tree(struct tree *tree,
 			p = process_tree(lookup_tree(entry.oid->hash), p);
 			break;
 		case OBJ_BLOB:
-			p = process_blob(lookup_blob(entry.oid->hash), p);
+			p = process_blob(lookup_blob(entry.oid), p);
 			break;
 		default:
 			/* Subproject commit - not in this repository */
diff --git a/list-objects.c b/list-objects.c
index f3ca6aafb..721e5fb08 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -119,7 +119,7 @@ static void process_tree(struct rev_info *revs,
 					cb_data);
 		else
 			process_blob(revs,
-				     lookup_blob(entry.oid->hash),
+				     lookup_blob(entry.oid),
 				     show, base, entry.path,
 				     cb_data);
 	}
diff --git a/object.c b/object.c
index 0208c407a..2c8d1e5d3 100644
--- a/object.c
+++ b/object.c
@@ -190,7 +190,7 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 
 	obj = NULL;
 	if (type == OBJ_BLOB) {
-		struct blob *blob = lookup_blob(oid.hash);
+		struct blob *blob = lookup_blob(&oid);
 		if (blob) {
 			if (parse_blob_buffer(blob, buffer, size))
 				return NULL;
@@ -266,7 +266,7 @@ struct object *parse_object(const unsigned char *sha1)
 			error("sha1 mismatch %s", sha1_to_hex(repl));
 			return NULL;
 		}
-		parse_blob_buffer(lookup_blob(oid.hash), NULL, 0);
+		parse_blob_buffer(lookup_blob(&oid), NULL, 0);
 		return lookup_object(sha1);
 	}
 
diff --git a/reachable.c b/reachable.c
index a8a979bd4..8ea0bdd7c 100644
--- a/reachable.c
+++ b/reachable.c
@@ -88,7 +88,7 @@ static void add_recent_object(const struct object_id *oid,
 		obj = (struct object *)lookup_tree(oid->hash);
 		break;
 	case OBJ_BLOB:
-		obj = (struct object *)lookup_blob(oid->hash);
+		obj = (struct object *)lookup_blob(oid);
 		break;
 	default:
 		die("unknown object type for %s: %s",
diff --git a/revision.c b/revision.c
index f8e0dee6d..db2de7a7a 100644
--- a/revision.c
+++ b/revision.c
@@ -62,7 +62,7 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
 			mark_tree_uninteresting(lookup_tree(entry.oid->hash));
 			break;
 		case OBJ_BLOB:
-			mark_blob_uninteresting(lookup_blob(entry.oid->hash));
+			mark_blob_uninteresting(lookup_blob(entry.oid));
 			break;
 		default:
 			/* Subproject commit - not in this repository */
@@ -1275,7 +1275,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned flags)
 		if (S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		blob = lookup_blob(ce->oid.hash);
+		blob = lookup_blob(&ce->oid);
 		if (!blob)
 			die("unable to add index blob to traversal");
 		add_pending_object_with_path(revs, &blob->object, "",
diff --git a/tag.c b/tag.c
index 79b78d358..dff251673 100644
--- a/tag.c
+++ b/tag.c
@@ -142,7 +142,7 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 	bufptr = nl + 1;
 
 	if (!strcmp(type, blob_type)) {
-		item->tagged = &lookup_blob(oid.hash)->object;
+		item->tagged = &lookup_blob(&oid)->object;
 	} else if (!strcmp(type, tree_type)) {
 		item->tagged = &lookup_tree(oid.hash)->object;
 	} else if (!strcmp(type, commit_type)) {
diff --git a/walker.c b/walker.c
index b499fcb72..3d6029c8e 100644
--- a/walker.c
+++ b/walker.c
@@ -52,7 +52,7 @@ static int process_tree(struct walker *walker, struct tree *tree)
 				obj = &tree->object;
 		}
 		else {
-			struct blob *blob = lookup_blob(entry.oid->hash);
+			struct blob *blob = lookup_blob(entry.oid);
 			if (blob)
 				obj = &blob->object;
 		}

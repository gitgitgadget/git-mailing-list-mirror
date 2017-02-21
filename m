Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20DB3201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 23:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753599AbdBUXs1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 18:48:27 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39884 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753491AbdBUXrx (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Feb 2017 18:47:53 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 853D6280BE;
        Tue, 21 Feb 2017 23:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487720866;
        bh=1m2xuC0c2/f5SxCvdnUWGHVWHYwOcVydZPd7tuNoD0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FC1VinpLvgVpc1UjCqZs9OqVajXXyOyYrZ5Q0P0hOb/t3ED3IZmOcm8FSYWuwXigd
         FQUhIUNJIEJ1J6+tlIJXjgi1gXLdqcZ3014D7+3CfNl8BUkMTh0/rZI0iujxByf54B
         LnDx7JXhxJDsVacPDRSHO9qMLpcXNg62NsDRBm2lndfqhzAYJV2wsk8+IFWYa7B0RC
         i3DtVoCGvF4CeVG9MsmrKBmmlsnS/MflX652IdxoQcDXbbjZ8pln6CU7hisZvJeSLe
         NzpN9h7aEEgj7P9ipzPkDA2iTQOde7yZ7UxcFm3TxPjD0tFSKw5SxY0vHgISUvj6mo
         z4jKCuh5AxggJTceK09P/5LNXwjG5u/AMuhyc2h8uhMcr3pE/iedZvFyj6YBEGFsIy
         rEZU1pEEKxvYsklQ+quUpYSeAaOQwUSX1opj0Dxxf2sd3+BW5z0aHdV3phj/8vVjKK
         H1bPSGcCkUy3v4+6sY9TrahTBC2+Wf6nwAWMXZsWpJYvZM6T4d9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 17/19] Convert object iteration callbacks to struct object_id
Date:   Tue, 21 Feb 2017 23:47:35 +0000
Message-Id: <20170221234737.894681-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170221234737.894681-1-sandals@crustytoothpaste.net>
References: <20170221234737.894681-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert each_loose_object_fn and each_packed_object_fn to take a pointer
to struct object_id.  Update the various callbacks.  Convert several
40-based constants to use GIT_SHA1_HEXSZ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/cat-file.c      |  8 ++++----
 builtin/count-objects.c |  4 ++--
 builtin/fsck.c          | 24 ++++++++++++------------
 builtin/pack-objects.c  |  6 +++---
 builtin/prune-packed.c  |  4 ++--
 builtin/prune.c         |  8 ++++----
 cache.h                 |  4 ++--
 reachable.c             | 30 +++++++++++++++---------------
 sha1_file.c             | 12 ++++++------
 9 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 30383e9eb4..8b85cb8cf0 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -409,20 +409,20 @@ static int batch_object_cb(const unsigned char sha1[20], void *vdata)
 	return 0;
 }
 
-static int batch_loose_object(const unsigned char *sha1,
+static int batch_loose_object(const struct object_id *oid,
 			      const char *path,
 			      void *data)
 {
-	sha1_array_append(data, sha1);
+	sha1_array_append(data, oid->hash);
 	return 0;
 }
 
-static int batch_packed_object(const unsigned char *sha1,
+static int batch_packed_object(const struct object_id *oid,
 			       struct packed_git *pack,
 			       uint32_t pos,
 			       void *data)
 {
-	sha1_array_append(data, sha1);
+	sha1_array_append(data, oid->hash);
 	return 0;
 }
 
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index a04b4f2ef3..acb05940fc 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -53,7 +53,7 @@ static void loose_garbage(const char *path)
 		report_garbage(PACKDIR_FILE_GARBAGE, path);
 }
 
-static int count_loose(const unsigned char *sha1, const char *path, void *data)
+static int count_loose(const struct object_id *oid, const char *path, void *data)
 {
 	struct stat st;
 
@@ -62,7 +62,7 @@ static int count_loose(const unsigned char *sha1, const char *path, void *data)
 	else {
 		loose_size += on_disk_bytes(st);
 		loose++;
-		if (verbose && has_sha1_pack(sha1))
+		if (verbose && has_sha1_pack(oid->hash))
 			packed_loose++;
 	}
 	return 0;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9b37606858..f76e4163ab 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -491,7 +491,7 @@ static void get_default_heads(void)
 	}
 }
 
-static struct object *parse_loose_object(const unsigned char *sha1,
+static struct object *parse_loose_object(const struct object_id *oid,
 					 const char *path)
 {
 	struct object *obj;
@@ -500,27 +500,27 @@ static struct object *parse_loose_object(const unsigned char *sha1,
 	unsigned long size;
 	int eaten;
 
-	if (read_loose_object(path, sha1, &type, &size, &contents) < 0)
+	if (read_loose_object(path, oid->hash, &type, &size, &contents) < 0)
 		return NULL;
 
 	if (!contents && type != OBJ_BLOB)
 		die("BUG: read_loose_object streamed a non-blob");
 
-	obj = parse_object_buffer(sha1, type, size, contents, &eaten);
+	obj = parse_object_buffer(oid->hash, type, size, contents, &eaten);
 
 	if (!eaten)
 		free(contents);
 	return obj;
 }
 
-static int fsck_loose(const unsigned char *sha1, const char *path, void *data)
+static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 {
-	struct object *obj = parse_loose_object(sha1, path);
+	struct object *obj = parse_loose_object(oid, path);
 
 	if (!obj) {
 		errors_found |= ERROR_OBJECT;
 		error("%s: object corrupt or missing: %s",
-		      sha1_to_hex(sha1), path);
+		      oid_to_hex(oid), path);
 		return 0; /* keep checking other objects */
 	}
 
@@ -619,26 +619,26 @@ static int fsck_cache_tree(struct cache_tree *it)
 	return err;
 }
 
-static void mark_object_for_connectivity(const unsigned char *sha1)
+static void mark_object_for_connectivity(const struct object_id *oid)
 {
-	struct object *obj = lookup_unknown_object(sha1);
+	struct object *obj = lookup_unknown_object(oid->hash);
 	obj->flags |= HAS_OBJ;
 }
 
-static int mark_loose_for_connectivity(const unsigned char *sha1,
+static int mark_loose_for_connectivity(const struct object_id *oid,
 				       const char *path,
 				       void *data)
 {
-	mark_object_for_connectivity(sha1);
+	mark_object_for_connectivity(oid);
 	return 0;
 }
 
-static int mark_packed_for_connectivity(const unsigned char *sha1,
+static int mark_packed_for_connectivity(const struct object_id *oid,
 					struct packed_git *pack,
 					uint32_t pos,
 					void *data)
 {
-	mark_object_for_connectivity(sha1);
+	mark_object_for_connectivity(oid);
 	return 0;
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8841f8b366..6e7c3a6575 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2534,17 +2534,17 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 	free(in_pack.array);
 }
 
-static int add_loose_object(const unsigned char *sha1, const char *path,
+static int add_loose_object(const struct object_id *oid, const char *path,
 			    void *data)
 {
-	enum object_type type = sha1_object_info(sha1, NULL);
+	enum object_type type = sha1_object_info(oid->hash, NULL);
 
 	if (type < 0) {
 		warning("loose object at %s could not be examined", path);
 		return 0;
 	}
 
-	add_object_entry(sha1, type, "", 0);
+	add_object_entry(oid->hash, type, "", 0);
 	return 0;
 }
 
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index 7cf900ea07..c026299e78 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -19,12 +19,12 @@ static int prune_subdir(int nr, const char *path, void *data)
 	return 0;
 }
 
-static int prune_object(const unsigned char *sha1, const char *path,
+static int prune_object(const struct object_id *oid, const char *path,
 			 void *data)
 {
 	int *opts = data;
 
-	if (!has_sha1_pack(sha1))
+	if (!has_sha1_pack(oid->hash))
 		return 0;
 
 	if (*opts & PRUNE_PACKED_DRY_RUN)
diff --git a/builtin/prune.c b/builtin/prune.c
index 8f4f052285..42633e0c6e 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -30,7 +30,7 @@ static int prune_tmp_file(const char *fullpath)
 	return 0;
 }
 
-static int prune_object(const unsigned char *sha1, const char *fullpath,
+static int prune_object(const struct object_id *oid, const char *fullpath,
 			void *data)
 {
 	struct stat st;
@@ -39,7 +39,7 @@ static int prune_object(const unsigned char *sha1, const char *fullpath,
 	 * Do we know about this object?
 	 * It must have been reachable
 	 */
-	if (lookup_object(sha1))
+	if (lookup_object(oid->hash))
 		return 0;
 
 	if (lstat(fullpath, &st)) {
@@ -50,8 +50,8 @@ static int prune_object(const unsigned char *sha1, const char *fullpath,
 	if (st.st_mtime > expire)
 		return 0;
 	if (show_only || verbose) {
-		enum object_type type = sha1_object_info(sha1, NULL);
-		printf("%s %s\n", sha1_to_hex(sha1),
+		enum object_type type = sha1_object_info(oid->hash, NULL);
+		printf("%s %s\n", oid_to_hex(oid),
 		       (type > 0) ? typename(type) : "unknown");
 	}
 	if (!show_only)
diff --git a/cache.h b/cache.h
index 29e59cbb56..724e905f7a 100644
--- a/cache.h
+++ b/cache.h
@@ -1655,7 +1655,7 @@ extern int unpack_object_header(struct packed_git *, struct pack_window **, off_
  * scratch buffer, but restored to its original contents before
  * the function returns.
  */
-typedef int each_loose_object_fn(const unsigned char *sha1,
+typedef int each_loose_object_fn(const struct object_id *oid,
 				 const char *path,
 				 void *data);
 typedef int each_loose_cruft_fn(const char *basename,
@@ -1681,7 +1681,7 @@ int for_each_loose_file_in_objdir_buf(struct strbuf *path,
  * LOCAL_ONLY flag is set).
  */
 #define FOR_EACH_OBJECT_LOCAL_ONLY 0x1
-typedef int each_packed_object_fn(const unsigned char *sha1,
+typedef int each_packed_object_fn(const struct object_id *oid,
 				  struct packed_git *pack,
 				  uint32_t pos,
 				  void *data);
diff --git a/reachable.c b/reachable.c
index d0199cace4..a8a979bd4f 100644
--- a/reachable.c
+++ b/reachable.c
@@ -58,7 +58,7 @@ struct recent_data {
 	unsigned long timestamp;
 };
 
-static void add_recent_object(const unsigned char *sha1,
+static void add_recent_object(const struct object_id *oid,
 			      unsigned long mtime,
 			      struct recent_data *data)
 {
@@ -75,37 +75,37 @@ static void add_recent_object(const unsigned char *sha1,
 	 * later processing, and the revision machinery expects
 	 * commits and tags to have been parsed.
 	 */
-	type = sha1_object_info(sha1, NULL);
+	type = sha1_object_info(oid->hash, NULL);
 	if (type < 0)
-		die("unable to get object info for %s", sha1_to_hex(sha1));
+		die("unable to get object info for %s", oid_to_hex(oid));
 
 	switch (type) {
 	case OBJ_TAG:
 	case OBJ_COMMIT:
-		obj = parse_object_or_die(sha1, NULL);
+		obj = parse_object_or_die(oid->hash, NULL);
 		break;
 	case OBJ_TREE:
-		obj = (struct object *)lookup_tree(sha1);
+		obj = (struct object *)lookup_tree(oid->hash);
 		break;
 	case OBJ_BLOB:
-		obj = (struct object *)lookup_blob(sha1);
+		obj = (struct object *)lookup_blob(oid->hash);
 		break;
 	default:
 		die("unknown object type for %s: %s",
-		    sha1_to_hex(sha1), typename(type));
+		    oid_to_hex(oid), typename(type));
 	}
 
 	if (!obj)
-		die("unable to lookup %s", sha1_to_hex(sha1));
+		die("unable to lookup %s", oid_to_hex(oid));
 
 	add_pending_object(data->revs, obj, "");
 }
 
-static int add_recent_loose(const unsigned char *sha1,
+static int add_recent_loose(const struct object_id *oid,
 			    const char *path, void *data)
 {
 	struct stat st;
-	struct object *obj = lookup_object(sha1);
+	struct object *obj = lookup_object(oid->hash);
 
 	if (obj && obj->flags & SEEN)
 		return 0;
@@ -119,22 +119,22 @@ static int add_recent_loose(const unsigned char *sha1,
 		 */
 		if (errno == ENOENT)
 			return 0;
-		return error_errno("unable to stat %s", sha1_to_hex(sha1));
+		return error_errno("unable to stat %s", oid_to_hex(oid));
 	}
 
-	add_recent_object(sha1, st.st_mtime, data);
+	add_recent_object(oid, st.st_mtime, data);
 	return 0;
 }
 
-static int add_recent_packed(const unsigned char *sha1,
+static int add_recent_packed(const struct object_id *oid,
 			     struct packed_git *p, uint32_t pos,
 			     void *data)
 {
-	struct object *obj = lookup_object(sha1);
+	struct object *obj = lookup_object(oid->hash);
 
 	if (obj && obj->flags & SEEN)
 		return 0;
-	add_recent_object(sha1, p->mtime, data);
+	add_recent_object(oid, p->mtime, data);
 	return 0;
 }
 
diff --git a/sha1_file.c b/sha1_file.c
index 777b8e8eae..6b74c7d3bc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3685,15 +3685,15 @@ static int for_each_file_in_obj_subdir(int subdir_nr,
 		strbuf_setlen(path, baselen);
 		strbuf_addf(path, "/%s", de->d_name);
 
-		if (strlen(de->d_name) == 38)  {
-			char hex[41];
-			unsigned char sha1[20];
+		if (strlen(de->d_name) == GIT_SHA1_HEXSZ - 2)  {
+			char hex[GIT_SHA1_HEXSZ+1];
+			struct object_id oid;
 
 			snprintf(hex, sizeof(hex), "%02x%s",
 				 subdir_nr, de->d_name);
-			if (!get_sha1_hex(hex, sha1)) {
+			if (!get_oid_hex(hex, &oid)) {
 				if (obj_cb) {
-					r = obj_cb(sha1, path->buf, data);
+					r = obj_cb(&oid, path->buf, data);
 					if (r)
 						break;
 				}
@@ -3805,7 +3805,7 @@ static int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn c
 			return error("unable to get sha1 of object %u in %s",
 				     i, p->pack_name);
 
-		r = cb(oid.hash, p, i, data);
+		r = cb(&oid, p, i, data);
 		if (r)
 			break;
 	}
-- 
2.11.0


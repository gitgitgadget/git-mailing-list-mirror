Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0C301F829
	for <e@80x24.org>; Mon,  1 May 2017 02:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999588AbdEACbl (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:31:41 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35868 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S642381AbdEACar (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:47 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5FE65280AF;
        Mon,  1 May 2017 02:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605810;
        bh=QSurIkEtvNtVm9ZS5KApGCEdMOS8Eo8px/1oCXZhAm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XhUL/XPKDu9rwLboFaA2mLtgl10EQzCbiix2NrYj4ZCXtW9cq7W2gqcy82X0o7ztc
         FDq3hNTGDMv87tz1p4nbehnATM7GXM8pM1AP19lK47iCrKLcZpIBbm7WtIKshjG5wG
         YnupCBpNdUM6uw8agtGZwYIlGdUJxreKFaQusAEMS0Q3j6ouvST29eufv7vINBfYEp
         81NWIKZ67LfmDsT/YTkszQ4NgdEEYXJWj4mnjxmG5fJ6KKlYYjMS4E67o8z0oy3fkO
         2dzoVYKtSFs3RT8EkG1DIQfnwyLVBemoZ4hLjoJ+FGLTSJGBcRnO3zwPAjoWr4zc+f
         lKTm2ajAqbRDbc3sysNz2052FY4esyihI0FF4aeXSWRsgvfNO/+A4AC2+cndmOePsK
         DuFD6Neb0zWp6jVljNP32NIKpHv3OvL19Z3e3wQ+cUFyeCUzriF+wlqzACRGX7mkqJ
         QYuiJkQpkUZkkXZxfgk2Ehwmk3IEvI6W7lkIChKXlzSMgPQKVLg
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 28/53] Convert remaining callers of lookup_blob to object_id
Date:   Mon,  1 May 2017 02:29:21 +0000
Message-Id: <20170501022946.258735-29-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All but a few callers of lookup_blob have been converted to struct
object_id.  Introduce a temporary, which will be removed later, into
parse_object to ease the transition, and convert the remaining callers
so that we can update lookup_blob to take struct object_id *.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/index-pack.c | 28 ++++++++++++++--------------
 builtin/merge-tree.c | 10 +++++-----
 object.c             |  9 ++++++---
 3 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index fef0025e4..2241ee68e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -785,7 +785,7 @@ static int check_collison(struct object_entry *entry)
 
 static void sha1_object(const void *data, struct object_entry *obj_entry,
 			unsigned long size, enum object_type type,
-			const unsigned char *sha1)
+			const struct object_id *oid)
 {
 	void *new_data = NULL;
 	int collision_test_needed = 0;
@@ -794,7 +794,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 
 	if (startup_info->have_repository) {
 		read_lock();
-		collision_test_needed = has_sha1_file_with_flags(sha1, HAS_SHA1_QUICK);
+		collision_test_needed = has_sha1_file_with_flags(oid->hash, HAS_SHA1_QUICK);
 		read_unlock();
 	}
 
@@ -809,31 +809,31 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 		enum object_type has_type;
 		unsigned long has_size;
 		read_lock();
-		has_type = sha1_object_info(sha1, &has_size);
+		has_type = sha1_object_info(oid->hash, &has_size);
 		if (has_type < 0)
-			die(_("cannot read existing object info %s"), sha1_to_hex(sha1));
+			die(_("cannot read existing object info %s"), oid_to_hex(oid));
 		if (has_type != type || has_size != size)
-			die(_("SHA1 COLLISION FOUND WITH %s !"), sha1_to_hex(sha1));
-		has_data = read_sha1_file(sha1, &has_type, &has_size);
+			die(_("SHA1 COLLISION FOUND WITH %s !"), oid_to_hex(oid));
+		has_data = read_sha1_file(oid->hash, &has_type, &has_size);
 		read_unlock();
 		if (!data)
 			data = new_data = get_data_from_pack(obj_entry);
 		if (!has_data)
-			die(_("cannot read existing object %s"), sha1_to_hex(sha1));
+			die(_("cannot read existing object %s"), oid_to_hex(oid));
 		if (size != has_size || type != has_type ||
 		    memcmp(data, has_data, size) != 0)
-			die(_("SHA1 COLLISION FOUND WITH %s !"), sha1_to_hex(sha1));
+			die(_("SHA1 COLLISION FOUND WITH %s !"), oid_to_hex(oid));
 		free(has_data);
 	}
 
 	if (strict) {
 		read_lock();
 		if (type == OBJ_BLOB) {
-			struct blob *blob = lookup_blob(sha1);
+			struct blob *blob = lookup_blob(oid->hash);
 			if (blob)
 				blob->object.flags |= FLAG_CHECKED;
 			else
-				die(_("invalid blob object %s"), sha1_to_hex(sha1));
+				die(_("invalid blob object %s"), oid_to_hex(oid));
 		} else {
 			struct object *obj;
 			int eaten;
@@ -845,7 +845,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			 * we do not need to free the memory here, as the
 			 * buf is deleted by the caller.
 			 */
-			obj = parse_object_buffer(sha1, type, size, buf, &eaten);
+			obj = parse_object_buffer(oid->hash, type, size, buf, &eaten);
 			if (!obj)
 				die(_("invalid %s"), typename(type));
 			if (do_fsck_object &&
@@ -960,7 +960,7 @@ static void resolve_delta(struct object_entry *delta_obj,
 		       typename(delta_obj->real_type),
 		       delta_obj->idx.oid.hash);
 	sha1_object(result->data, NULL, result->size, delta_obj->real_type,
-		    delta_obj->idx.oid.hash);
+		    &delta_obj->idx.oid);
 	counter_lock();
 	nr_resolved_deltas++;
 	counter_unlock();
@@ -1149,7 +1149,7 @@ static void parse_pack_objects(unsigned char *sha1)
 			nr_delays++;
 		} else
 			sha1_object(data, NULL, obj->size, obj->type,
-				    obj->idx.oid.hash);
+				    &obj->idx.oid);
 		free(data);
 		display_progress(progress, i+1);
 	}
@@ -1176,7 +1176,7 @@ static void parse_pack_objects(unsigned char *sha1)
 			continue;
 		obj->real_type = obj->type;
 		sha1_object(NULL, obj, obj->size, obj->type,
-			    obj->idx.oid.hash);
+			    &obj->idx.oid);
 		nr_delays--;
 	}
 	if (nr_delays)
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 5b7ab9b96..cdeb6562d 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -161,14 +161,14 @@ static int both_empty(struct name_entry *a, struct name_entry *b)
 	return !(a->oid || b->oid);
 }
 
-static struct merge_list *create_entry(unsigned stage, unsigned mode, const unsigned char *sha1, const char *path)
+static struct merge_list *create_entry(unsigned stage, unsigned mode, const struct object_id *oid, const char *path)
 {
 	struct merge_list *res = xcalloc(1, sizeof(*res));
 
 	res->stage = stage;
 	res->path = path;
 	res->mode = mode;
-	res->blob = lookup_blob(sha1);
+	res->blob = lookup_blob(oid->hash);
 	return res;
 }
 
@@ -188,8 +188,8 @@ static void resolve(const struct traverse_info *info, struct name_entry *ours, s
 		return;
 
 	path = traverse_path(info, result);
-	orig = create_entry(2, ours->mode, ours->oid->hash, path);
-	final = create_entry(0, result->mode, result->oid->hash, path);
+	orig = create_entry(2, ours->mode, ours->oid, path);
+	final = create_entry(0, result->mode, result->oid, path);
 
 	final->link = orig;
 
@@ -239,7 +239,7 @@ static struct merge_list *link_entry(unsigned stage, const struct traverse_info
 		path = entry->path;
 	else
 		path = traverse_path(info, n);
-	link = create_entry(stage, n->mode, n->oid->hash, path);
+	link = create_entry(stage, n->mode, n->oid, path);
 	link->link = entry;
 	return link;
 }
diff --git a/object.c b/object.c
index fe2222356..0208c407a 100644
--- a/object.c
+++ b/object.c
@@ -190,7 +190,7 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 
 	obj = NULL;
 	if (type == OBJ_BLOB) {
-		struct blob *blob = lookup_blob(sha1);
+		struct blob *blob = lookup_blob(oid.hash);
 		if (blob) {
 			if (parse_blob_buffer(blob, buffer, size))
 				return NULL;
@@ -251,8 +251,11 @@ struct object *parse_object(const unsigned char *sha1)
 	const unsigned char *repl = lookup_replace_object(sha1);
 	void *buffer;
 	struct object *obj;
+	struct object_id oid;
 
-	obj = lookup_object(sha1);
+	hashcpy(oid.hash, sha1);
+
+	obj = lookup_object(oid.hash);
 	if (obj && obj->parsed)
 		return obj;
 
@@ -263,7 +266,7 @@ struct object *parse_object(const unsigned char *sha1)
 			error("sha1 mismatch %s", sha1_to_hex(repl));
 			return NULL;
 		}
-		parse_blob_buffer(lookup_blob(sha1), NULL, 0);
+		parse_blob_buffer(lookup_blob(oid.hash), NULL, 0);
 		return lookup_object(sha1);
 	}
 

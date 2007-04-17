From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/3] Clean up object creation to use more common code
Date: Mon, 16 Apr 2007 21:13:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704162113220.5473@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704162041290.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 17 06:13:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdf4i-0007rP-Fe
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 06:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbXDQENt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 00:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbXDQENt
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 00:13:49 -0400
Received: from smtp.osdl.org ([65.172.181.24]:34443 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932234AbXDQENs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 00:13:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3H4DjIs016545
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Apr 2007 21:13:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3H4Dipi019807;
	Mon, 16 Apr 2007 21:13:45 -0700
In-Reply-To: <Pine.LNX.4.64.0704162041290.5473@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.954 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44717>


This replaces the fairly odd "created_object()" function that did _most_
of the object setup with a more complete "create_object()" function that
also has a more natural calling convention.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 alloc.c  |    2 +-
 blob.c   |    8 ++------
 cache.h  |   14 +++++---------
 commit.c |    8 ++------
 object.c |   14 +++++++-------
 object.h |    2 +-
 tag.c    |   10 +++-------
 tree.c   |    8 ++------
 8 files changed, 23 insertions(+), 43 deletions(-)

diff --git a/alloc.c b/alloc.c
index c73aeec..70f3c32 100644
--- a/alloc.c
+++ b/alloc.c
@@ -20,7 +20,7 @@
 
 #define DEFINE_ALLOCATOR(name, type)				\
 static unsigned int name##_allocs;				\
-struct name *alloc_##name##_node(void)				\
+void *alloc_##name##_node(void)					\
 {								\
 	static int nr;						\
 	static struct name *block;				\
diff --git a/blob.c b/blob.c
index 0a9ea41..bd7d078 100644
--- a/blob.c
+++ b/blob.c
@@ -6,12 +6,8 @@ const char *blob_type = "blob";
 struct blob *lookup_blob(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
-	if (!obj) {
-		struct blob *ret = alloc_blob_node();
-		created_object(sha1, &ret->object);
-		ret->object.type = OBJ_BLOB;
-		return ret;
-	}
+	if (!obj)
+		return create_object(sha1, OBJ_BLOB, alloc_blob_node());
 	if (!obj->type)
 		obj->type = OBJ_BLOB;
 	if (obj->type != OBJ_BLOB) {
diff --git a/cache.h b/cache.h
index aa72791..4de25cc 100644
--- a/cache.h
+++ b/cache.h
@@ -476,15 +476,11 @@ int decode_85(char *dst, const char *line, int linelen);
 void encode_85(char *buf, const unsigned char *data, int bytes);
 
 /* alloc.c */
-struct blob;
-struct tree;
-struct commit;
-struct tag;
-extern struct blob *alloc_blob_node(void);
-extern struct tree *alloc_tree_node(void);
-extern struct commit *alloc_commit_node(void);
-extern struct tag *alloc_tag_node(void);
-extern struct object *alloc_object_node(void);
+extern void *alloc_blob_node(void);
+extern void *alloc_tree_node(void);
+extern void *alloc_commit_node(void);
+extern void *alloc_tag_node(void);
+extern void *alloc_object_node(void);
 extern void alloc_report(void);
 
 /* trace.c */
diff --git a/commit.c b/commit.c
index 952095f..10466c4 100644
--- a/commit.c
+++ b/commit.c
@@ -98,12 +98,8 @@ struct commit *lookup_commit_reference(const unsigned char *sha1)
 struct commit *lookup_commit(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
-	if (!obj) {
-		struct commit *ret = alloc_commit_node();
-		created_object(sha1, &ret->object);
-		ret->object.type = OBJ_COMMIT;
-		return ret;
-	}
+	if (!obj)
+		return create_object(sha1, OBJ_COMMIT, alloc_commit_node());
 	if (!obj->type)
 		obj->type = OBJ_COMMIT;
 	return check_commit(obj, sha1, 0);
diff --git a/object.c b/object.c
index 153ebac..7bd3fec 100644
--- a/object.c
+++ b/object.c
@@ -105,11 +105,13 @@ static void grow_object_hash(void)
 	obj_hash_size = new_hash_size;
 }
 
-void created_object(const unsigned char *sha1, struct object *obj)
+void *create_object(const unsigned char *sha1, int type, void *o)
 {
+	struct object *obj = o;
+
 	obj->parsed = 0;
 	obj->used = 0;
-	obj->type = OBJ_NONE;
+	obj->type = type;
 	obj->flags = 0;
 	hashcpy(obj->sha1, sha1);
 
@@ -118,16 +120,14 @@ void created_object(const unsigned char *sha1, struct object *obj)
 
 	insert_obj_hash(obj, obj_hash, obj_hash_size);
 	nr_objs++;
+	return obj;
 }
 
 struct object *lookup_unknown_object(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
-	if (!obj) {
-		obj = alloc_object_node();
-		created_object(sha1, obj);
-		obj->type = OBJ_NONE;
-	}
+	if (!obj)
+		obj = create_object(sha1, OBJ_NONE, alloc_object_node());
 	return obj;
 }
 
diff --git a/object.h b/object.h
index bdbf0fa..c0a5fd3 100644
--- a/object.h
+++ b/object.h
@@ -47,7 +47,7 @@ extern struct object_refs *lookup_object_refs(struct object *);
 /** Internal only **/
 struct object *lookup_object(const unsigned char *sha1);
 
-void created_object(const unsigned char *sha1, struct object *obj);
+extern void *create_object(const unsigned char *sha1, int type, void *obj);
 
 /** Returns the object, having parsed it to find out what it is. **/
 struct object *parse_object(const unsigned char *sha1);
diff --git a/tag.c b/tag.c
index 56a49f4..330d287 100644
--- a/tag.c
+++ b/tag.c
@@ -20,13 +20,9 @@ struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 
 struct tag *lookup_tag(const unsigned char *sha1)
 {
-        struct object *obj = lookup_object(sha1);
-        if (!obj) {
-                struct tag *ret = alloc_tag_node();
-                created_object(sha1, &ret->object);
-                ret->object.type = OBJ_TAG;
-                return ret;
-        }
+	struct object *obj = lookup_object(sha1);
+	if (!obj)
+		return create_object(sha1, OBJ_TAG, alloc_tag_node());
 	if (!obj->type)
 		obj->type = OBJ_TAG;
         if (obj->type != OBJ_TAG) {
diff --git a/tree.c b/tree.c
index d188c0f..e5bfbce 100644
--- a/tree.c
+++ b/tree.c
@@ -127,12 +127,8 @@ int read_tree(struct tree *tree, int stage, const char **match)
 struct tree *lookup_tree(const unsigned char *sha1)
 {
 	struct object *obj = lookup_object(sha1);
-	if (!obj) {
-		struct tree *ret = alloc_tree_node();
-		created_object(sha1, &ret->object);
-		ret->object.type = OBJ_TREE;
-		return ret;
-	}
+	if (!obj)
+		return create_object(sha1, OBJ_TREE, alloc_tree_node());
 	if (!obj->type)
 		obj->type = OBJ_TREE;
 	if (obj->type != OBJ_TREE) {
-- 
1.5.1.1.107.g7a15

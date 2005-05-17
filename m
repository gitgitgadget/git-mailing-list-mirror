From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Make object contents optionally available
Date: Tue, 17 May 2005 00:56:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505170049480.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 17 07:02:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXuDN-0000Th-7n
	for gcvg-git@gmane.org; Tue, 17 May 2005 07:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVEQE6Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 00:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVEQE6K
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 00:58:10 -0400
Received: from iabervon.org ([66.92.72.58]:8454 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261697AbVEQE5G (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 00:57:06 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DXu8C-0004Ti-00; Tue, 17 May 2005 00:56:36 -0400
To: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds contents and size fields to struct object. If unpack_object is
called on an object, it will fill in the contents field with the complete
raw contents of the object. If free_object_contents is called on an
object, the contents will be freed. If contents is filled when an object
is parsed, it is not unpacked an extra time, but the contents are not
retained if they were not unpacked before parsing.

This patch also centralizes the code to unpack and check the type of
objects, making it worthwhile even without callers for the new functions.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Index: blob.c
===================================================================
--- 4fdd3c0825943d0d489ce9ca46cb853b41db3807/blob.c  (mode:100644 sha1:280f5241577ac029e9d5a7eb5bf895642b342fc8)
+++ e63ecfdf25ec8d61fe16b6c22152a2e45e60efd2/blob.c  (mode:100644 sha1:68c1adc2b1009fbc5525207b0ddaac34e9c4413b)
@@ -30,21 +30,15 @@
 
 int parse_blob(struct blob *item)
 {
-        char type[20];
-        void *buffer;
-        unsigned long size;
+	int unpacked = !!item->object.contents;
 	int ret;
 
         if (item->object.parsed)
                 return 0;
-        buffer = read_sha1_file(item->object.sha1, type, &size);
-        if (!buffer)
-                return error("Could not read %s",
-                             sha1_to_hex(item->object.sha1));
-        if (strcmp(type, blob_type))
-                return error("Object %s not a blob",
-                             sha1_to_hex(item->object.sha1));
-	ret = parse_blob_buffer(item, buffer, size);
-	free(buffer);
+	unpack_object(&item->object);
+	ret = parse_blob_buffer(item, item->object.contents, 
+			       item->object.size);
+	if (!unpacked)
+		free_object_contents(&item->object);
 	return ret;
 }
Index: commit.c
===================================================================
--- 4fdd3c0825943d0d489ce9ca46cb853b41db3807/commit.c  (mode:100644 sha1:706c7cba08ebc2100c2dbf63ed1238f39324f750)
+++ e63ecfdf25ec8d61fe16b6c22152a2e45e60efd2/commit.c  (mode:100644 sha1:38324dcc16785caa4baafb260c2fa9c0af1248a9)
@@ -69,24 +69,16 @@
 
 int parse_commit(struct commit *item)
 {
-	char type[20];
-	void *buffer;
-	unsigned long size;
+	int unpacked = !!item->object.contents;
 	int ret;
 
 	if (item->object.parsed)
 		return 0;
-	buffer = read_sha1_file(item->object.sha1, type, &size);
-	if (!buffer)
-		return error("Could not read %s",
-			     sha1_to_hex(item->object.sha1));
-	if (strcmp(type, commit_type)) {
-		free(buffer);
-		return error("Object %s not a commit",
-			     sha1_to_hex(item->object.sha1));
-	}
-	ret = parse_commit_buffer(item, buffer, size);
-	free(buffer);
+	unpack_object(&item->object);
+	ret = parse_commit_buffer(item, item->object.contents, 
+				  item->object.size);
+	if (!unpacked)
+		free_object_contents(&item->object);
 	return ret;
 }
 
Index: object.c
===================================================================
--- 4fdd3c0825943d0d489ce9ca46cb853b41db3807/object.c  (mode:100644 sha1:b5a62e7f87f24c2ab0ea83f3c445d81bcbff027a)
+++ e63ecfdf25ec8d61fe16b6c22152a2e45e60efd2/object.c  (mode:100644 sha1:3e712d5f665d22e06e310932447629b0badc6b48)
@@ -99,6 +99,34 @@
 	}
 }
 
+int unpack_object(struct object *obj)
+{
+	unsigned long mapsize;
+	void *map;
+	char type[20];
+	if (obj->contents)
+		return 0;
+	map = map_sha1_file(obj->sha1, &mapsize);
+	if (!map)
+		return error("Could not map %s",
+			     sha1_to_hex(obj->sha1));
+	obj->contents = unpack_sha1_file(map, mapsize, type, &obj->size);
+	munmap(map, mapsize);
+	if (!obj->contents)
+		return error("Could not unpack %s",
+			     sha1_to_hex(obj->sha1));
+	if (strcmp(type, obj->type))
+		return error("Object %s not a %s",
+			     sha1_to_hex(obj->sha1), obj->type);
+	return 0;
+}
+
+void free_object_contents(struct object *obj)
+{
+	free(obj->contents);
+	obj->contents = NULL;
+}
+
 struct object *parse_object(unsigned char *sha1)
 {
 	unsigned long mapsize;
Index: object.h
===================================================================
--- 4fdd3c0825943d0d489ce9ca46cb853b41db3807/object.h  (mode:100644 sha1:09700d376077b2d6136620faf6efb77ee679deeb)
+++ e63ecfdf25ec8d61fe16b6c22152a2e45e60efd2/object.h  (mode:100644 sha1:848aee6a1b9138618d5e44abf8567d2c2d3c35c1)
@@ -13,6 +13,8 @@
 	unsigned char sha1[20];
 	const char *type;
 	struct object_list *refs;
+	char *contents;
+	unsigned long size;
 };
 
 extern int nr_objs;
@@ -25,6 +27,12 @@
 /** Returns the object, having parsed it to find out what it is. **/
 struct object *parse_object(unsigned char *sha1);
 
+/** Unpacks the object into the contents field. **/
+int unpack_object(struct object *obj);
+
+/** Deallocates the unpacked contents of the object. **/
+void free_object_contents(struct object *obj);
+
 void add_ref(struct object *refer, struct object *target);
 
 void mark_reachable(struct object *obj, unsigned int mask);
Index: tag.c
===================================================================
--- 4fdd3c0825943d0d489ce9ca46cb853b41db3807/tag.c  (mode:100644 sha1:22deb243ad58b2c57fb8652fe2d08c571ee3e781)
+++ e63ecfdf25ec8d61fe16b6c22152a2e45e60efd2/tag.c  (mode:100644 sha1:7fc7960c866a2704ec8f230d24259bc331f7f209)
@@ -66,23 +66,15 @@
 
 int parse_tag(struct tag *item)
 {
-	char type[20];
-	void *data;
-	unsigned long size;
+	int unpacked = !!item->object.contents;
 	int ret;
 
 	if (item->object.parsed)
 		return 0;
-	data = read_sha1_file(item->object.sha1, type, &size);
-	if (!data)
-		return error("Could not read %s",
-			     sha1_to_hex(item->object.sha1));
-	if (strcmp(type, tag_type)) {
-		free(data);
-		return error("Object %s not a tag",
-			     sha1_to_hex(item->object.sha1));
-	}
-	ret = parse_tag_buffer(item, data, size);
-	free(data);
+	unpack_object(&item->object);
+	ret = parse_tag_buffer(item, item->object.contents, 
+			       item->object.size);
+	if (!unpacked)
+		free_object_contents(&item->object);
 	return ret;
 }
Index: tree.c
===================================================================
--- 4fdd3c0825943d0d489ce9ca46cb853b41db3807/tree.c  (mode:100644 sha1:ca800a85f771be1bd10d6575d93ca05bd3fc381c)
+++ e63ecfdf25ec8d61fe16b6c22152a2e45e60efd2/tree.c  (mode:100644 sha1:3b10428aa0a8b9da32c0deaa16edea38c74da0c0)
@@ -140,23 +140,15 @@
 
 int parse_tree(struct tree *item)
 {
-	 char type[20];
-	 void *buffer;
-	 unsigned long size;
-	 int ret;
+	int unpacked = !!item->object.contents;
+	int ret;
 
 	if (item->object.parsed)
 		return 0;
-	buffer = read_sha1_file(item->object.sha1, type, &size);
-	if (!buffer)
-		return error("Could not read %s",
-			     sha1_to_hex(item->object.sha1));
-	if (strcmp(type, tree_type)) {
-		free(buffer);
-		return error("Object %s not a tree",
-			     sha1_to_hex(item->object.sha1));
-	}
-	ret = parse_tree_buffer(item, buffer, size);
-	free(buffer);
+	unpack_object(&item->object);
+	ret = parse_tree_buffer(item, item->object.contents, 
+				item->object.size);
+	if (!unpacked)
+		free_object_contents(&item->object);
 	return ret;
 }


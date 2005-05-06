From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] don't load and decompress objects twice with parse_object()
Date: Fri, 06 May 2005 13:48:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505061326310.14033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 19:47:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU6ti-0000lv-46
	for gcvg-git@gmane.org; Fri, 06 May 2005 19:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVEFRwp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 13:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVEFRwp
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 13:52:45 -0400
Received: from relais.videotron.ca ([24.201.245.36]:19679 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261232AbVEFRuS
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 6 May 2005 13:50:18 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IG200G0NXGYUH@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 06 May 2005 13:48:35 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It turns out that parse_object() is loading and decompressing given 
object to free it just before calling the specific object parsing 
function which does mmap and decompress the same object again. This 
patch introduces the ability to parse specific objects directly from a 
memory buffer.

Without this patch, running git-fsck-cache on the kernel repositorytake:

	real    0m13.006s
	user    0m11.421s
	sys     0m1.218s

With this patch applied:

	real    0m8.060s
	user    0m7.071s
	sys     0m0.710s

The performance increase is significant, and this is kind of a 
prerequisite for sane delta object support with fsck.

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: git/tag.c
===================================================================
--- git.orig/tag.c
+++ git/tag.c
@@ -21,11 +21,8 @@
         return (struct tag *) obj;
 }
 
-int parse_tag(struct tag *item)
+int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 {
-        char type[20];
-        void *data, *bufptr;
-        unsigned long size;
 	int typelen, taglen;
 	unsigned char object[20];
 	const char *type_line, *tag_line, *sig_line;
@@ -33,20 +30,11 @@
         if (item->object.parsed)
                 return 0;
         item->object.parsed = 1;
-        data = bufptr = read_sha1_file(item->object.sha1, type, &size);
-        if (!data)
-                return error("Could not read %s",
-                             sha1_to_hex(item->object.sha1));
-        if (strcmp(type, tag_type)) {
-		free(data);
-                return error("Object %s not a tag",
-                             sha1_to_hex(item->object.sha1));
-	}
 
 	if (size < 64)
-		goto err;
+		return -1;
 	if (memcmp("object ", data, 7) || get_sha1_hex(data + 7, object))
-		goto err;
+		return -1;
 
 	item->tagged = parse_object(object);
 	if (item->tagged)
@@ -54,29 +42,47 @@
 
 	type_line = data + 48;
 	if (memcmp("\ntype ", type_line-1, 6))
-		goto err;
+		return -1;
 
 	tag_line = strchr(type_line, '\n');
 	if (!tag_line || memcmp("tag ", ++tag_line, 4))
-		goto err;
+		return -1;
 
 	sig_line = strchr(tag_line, '\n');
 	if (!sig_line)
-		goto err;
+		return -1;
 	sig_line++;
 
 	typelen = tag_line - type_line - strlen("type \n");
 	if (typelen >= 20)
-		goto err;
+		return -1;
 	taglen = sig_line - tag_line - strlen("tag \n");
 	item->tag = xmalloc(taglen + 1);
 	memcpy(item->tag, tag_line + 4, taglen);
 	item->tag[taglen] = '\0';
 
-	free(data);
 	return 0;
+}
+
+int parse_tag(struct tag *item)
+{
+        char type[20];
+        void *data;
+        unsigned long size;
+	int ret;
 
-err:
+        if (item->object.parsed)
+                return 0;
+        data = read_sha1_file(item->object.sha1, type, &size);
+        if (!data)
+                return error("Could not read %s",
+                             sha1_to_hex(item->object.sha1));
+        if (strcmp(type, tag_type)) {
+		free(data);
+                return error("Object %s not a tag",
+                             sha1_to_hex(item->object.sha1));
+	}
+	ret = parse_tag_buffer(item, data, size);
 	free(data);
-	return -1;
+	return ret;
 }
Index: git/tree.c
===================================================================
--- git.orig/tree.c
+++ git/tree.c
@@ -88,24 +88,14 @@
 	return (struct tree *) obj;
 }
 
-int parse_tree(struct tree *item)
+int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
 {
-	char type[20];
-	void *buffer, *bufptr;
-	unsigned long size;
+	void *bufptr = buffer;
 	struct tree_entry_list **list_p;
+
 	if (item->object.parsed)
 		return 0;
 	item->object.parsed = 1;
-	buffer = bufptr = read_sha1_file(item->object.sha1, type, &size);
-	if (!buffer)
-		return error("Could not read %s",
-			     sha1_to_hex(item->object.sha1));
-	if (strcmp(type, tree_type)) {
-		free(buffer);
-		return error("Object %s not a tree",
-			     sha1_to_hex(item->object.sha1));
-	}
 	list_p = &item->entries;
 	while (size) {
 		struct object *obj;
@@ -115,10 +105,8 @@
 		char *path = strchr(bufptr, ' ');
 		unsigned int mode;
 		if (size < len + 20 || !path || 
-		    sscanf(bufptr, "%o", &mode) != 1) {
-			free(buffer);
+		    sscanf(bufptr, "%o", &mode) != 1)
 			return -1;
-		}
 
 		entry = xmalloc(sizeof(struct tree_entry_list));
 		entry->name = strdup(path + 1);
@@ -144,6 +132,28 @@
 		*list_p = entry;
 		list_p = &entry->next;
 	}
-	free(buffer);
 	return 0;
 }
+
+int parse_tree(struct tree *item)
+{
+	 char type[20];
+	 void *buffer;
+	 unsigned long size;
+	 int ret;
+
+	if (item->object.parsed)
+		return 0;
+	buffer = read_sha1_file(item->object.sha1, type, &size);
+	if (!buffer)
+		return error("Could not read %s",
+			     sha1_to_hex(item->object.sha1));
+	if (strcmp(type, tree_type)) {
+		free(buffer);
+		return error("Object %s not a tree",
+			     sha1_to_hex(item->object.sha1));
+	}
+	ret = parse_tree_buffer(item, buffer, size);
+	free(buffer);
+	return ret;
+}
Index: git/blob.c
===================================================================
--- git.orig/blob.c
+++ git/blob.c
@@ -22,21 +22,29 @@
 	return (struct blob *) obj;
 }
 
+int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
+{
+        item->object.parsed = 1;
+	return 0;
+}
+
 int parse_blob(struct blob *item)
 {
         char type[20];
         void *buffer;
         unsigned long size;
+	int ret;
+
         if (item->object.parsed)
                 return 0;
-        item->object.parsed = 1;
         buffer = read_sha1_file(item->object.sha1, type, &size);
         if (!buffer)
                 return error("Could not read %s",
                              sha1_to_hex(item->object.sha1));
-	free(buffer);
         if (strcmp(type, blob_type))
                 return error("Object %s not a blob",
                              sha1_to_hex(item->object.sha1));
-	return 0;
+	ret = parse_blob_buffer(item, buffer, size);
+	free(buffer);
+	return ret;
 }
Index: git/tag.h
===================================================================
--- git.orig/tag.h
+++ git/tag.h
@@ -13,6 +13,7 @@
 };
 
 extern struct tag *lookup_tag(unsigned char *sha1);
+extern int parse_tag_buffer(struct tag *item, void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 
 #endif /* TAG_H */
Index: git/commit.c
===================================================================
--- git.orig/commit.c
+++ git/commit.c
@@ -41,24 +41,14 @@
 	return date;
 }
 
-int parse_commit(struct commit *item)
+int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 {
-	char type[20];
-	void * buffer, *bufptr;
-	unsigned long size;
+	void *bufptr = buffer;
 	unsigned char parent[20];
+
 	if (item->object.parsed)
 		return 0;
 	item->object.parsed = 1;
-	buffer = bufptr = read_sha1_file(item->object.sha1, type, &size);
-	if (!buffer)
-		return error("Could not read %s",
-			     sha1_to_hex(item->object.sha1));
-	if (strcmp(type, commit_type)) {
-		free(buffer);
-		return error("Object %s not a commit",
-			     sha1_to_hex(item->object.sha1));
-	}
 	get_sha1_hex(bufptr + 5, parent);
 	item->tree = lookup_tree(parent);
 	if (item->tree)
@@ -74,10 +64,32 @@
 		bufptr += 48;
 	}
 	item->date = parse_commit_date(bufptr);
-	free(buffer);
 	return 0;
 }
 
+int parse_commit(struct commit *item)
+{
+	char type[20];
+	void *buffer;
+	unsigned long size;
+	int ret;
+
+	if (item->object.parsed)
+		return 0;
+	buffer = read_sha1_file(item->object.sha1, type, &size);
+	if (!buffer)
+		return error("Could not read %s",
+			     sha1_to_hex(item->object.sha1));
+	if (strcmp(type, commit_type)) {
+		free(buffer);
+		return error("Object %s not a commit",
+			     sha1_to_hex(item->object.sha1));
+	}
+	ret = parse_commit_buffer(item, buffer, size);
+	free(buffer);
+	return ret;
+}
+
 void commit_list_insert(struct commit *item, struct commit_list **list_p)
 {
 	struct commit_list *new_list = xmalloc(sizeof(struct commit_list));
Index: git/object.c
===================================================================
--- git.orig/object.c
+++ git/object.c
@@ -104,6 +104,7 @@
 	unsigned long mapsize;
 	void *map = map_sha1_file(sha1, &mapsize);
 	if (map) {
+		struct object *obj;
 		char type[100];
 		unsigned long size;
 		void *buffer = unpack_sha1_file(map, mapsize, type, &size);
@@ -112,26 +113,27 @@
 			return NULL;
 		if (check_sha1_signature(sha1, buffer, size, type) < 0)
 			printf("sha1 mismatch %s\n", sha1_to_hex(sha1));
-		free(buffer);
 		if (!strcmp(type, "blob")) {
-			struct blob *ret = lookup_blob(sha1);
-			parse_blob(ret);
-			return &ret->object;
+			struct blob *blob = lookup_blob(sha1);
+			parse_blob_buffer(blob, buffer, size);
+			obj = &blob->object;
 		} else if (!strcmp(type, "tree")) {
-			struct tree *ret = lookup_tree(sha1);
-			parse_tree(ret);
-			return &ret->object;
+			struct tree *tree = lookup_tree(sha1);
+			parse_tree_buffer(tree, buffer, size);
+			obj = &tree->object;
 		} else if (!strcmp(type, "commit")) {
-			struct commit *ret = lookup_commit(sha1);
-			parse_commit(ret);
-			return &ret->object;
+			struct commit *commit = lookup_commit(sha1);
+			parse_commit_buffer(commit, buffer, size);
+			obj = &commit->object;
 		} else if (!strcmp(type, "tag")) {
-			struct tag *ret = lookup_tag(sha1);
-			parse_tag(ret);
-			return &ret->object;
+			struct tag *tag = lookup_tag(sha1);
+			parse_tag_buffer(tag, buffer, size);
+			obj = &tag->object;
 		} else {
-			return NULL;
+			obj = NULL;
 		}
+		free(buffer);
+		return obj;
 	}
 	return NULL;
 }
Index: git/tree.h
===================================================================
--- git.orig/tree.h
+++ git/tree.h
@@ -25,6 +25,8 @@
 
 struct tree *lookup_tree(unsigned char *sha1);
 
+int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
+
 int parse_tree(struct tree *tree);
 
 #endif /* TREE_H */
Index: git/blob.h
===================================================================
--- git.orig/blob.h
+++ git/blob.h
@@ -11,6 +11,8 @@
 
 struct blob *lookup_blob(unsigned char *sha1);
 
+int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
+
 int parse_blob(struct blob *item);
 
 #endif /* BLOB_H */
Index: git/commit.h
===================================================================
--- git.orig/commit.h
+++ git/commit.h
@@ -20,6 +20,8 @@
 
 struct commit *lookup_commit(unsigned char *sha1);
 
+int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size);
+
 int parse_commit(struct commit *item);
 
 void commit_list_insert(struct commit *item, struct commit_list **list_p);

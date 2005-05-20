From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/3] delta check
Date: Fri, 20 May 2005 16:59:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505201657310.4397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 23:00:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZEaU-0005si-1z
	for gcvg-git@gmane.org; Fri, 20 May 2005 22:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVETVAQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 17:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVETVAQ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 17:00:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38984 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261589AbVETU7S
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 16:59:18 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IGT00MNQ3MTDF@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 20 May 2005 16:59:18 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch adds knowledge of delta objects to fsck-cache and various
object parsing code.  A new switch to git-fsck-cache is provided to
display the maximum delta depth found in a repository.

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: git/fsck-cache.c
===================================================================
--- git.orig/fsck-cache.c
+++ git/fsck-cache.c
@@ -6,15 +6,46 @@
 #include "tree.h"
 #include "blob.h"
 #include "tag.h"
+#include "delta.h"
 
 #define REACHABLE 0x0001
 
 static int show_root = 0;
 static int show_tags = 0;
 static int show_unreachable = 0;
+static int show_max_delta_depth = 0;
 static int keep_cache_objects = 0; 
 static unsigned char head_sha1[20];
 
+static void expand_deltas(void)
+{
+	int i, max_depth = 0;
+
+	/*
+	 * To be as efficient as possible we look for delta heads and
+	 * recursively process them going backward, and parsing
+	 * resulting objects along the way.  This allows for processing
+	 * each delta objects only once regardless of the delta depth.
+	 */
+	for (i = 0; i < nr_objs; i++) {
+		struct object *obj = objs[i];
+		if (obj->parsed && !obj->delta && obj->attached_deltas) {
+			int depth = 0;
+			char type[10];
+			unsigned long size;
+			void *buf = read_sha1_file(obj->sha1, type, &size);
+			if (!buf)
+				continue;
+			depth = process_deltas(buf, size, obj->type,
+					       obj->attached_deltas);
+			if (max_depth < depth)
+				max_depth = depth;
+		}
+	}
+	if (show_max_delta_depth)
+		printf("maximum delta depth = %d\n", max_depth);
+}
+															
 static void check_connectivity(void)
 {
 	int i;
@@ -25,7 +56,12 @@
 		struct object_list *refs;
 
 		if (!obj->parsed) {
-			printf("missing %s %s\n", obj->type, sha1_to_hex(obj->sha1));
+			if (obj->delta)
+				printf("unresolved delta %s\n",
+				       sha1_to_hex(obj->sha1));
+			else
+				printf("missing %s %s\n",
+				       obj->type, sha1_to_hex(obj->sha1));
 			continue;
 		}
 
@@ -43,7 +79,12 @@
 			continue;
 
 		if (show_unreachable && !(obj->flags & REACHABLE)) {
-			printf("unreachable %s %s\n", obj->type, sha1_to_hex(obj->sha1));
+			if (obj->attached_deltas)
+				printf("foreign delta reference %s\n", 
+				       sha1_to_hex(obj->sha1));
+			else
+				printf("unreachable %s %s\n",
+				       obj->type, sha1_to_hex(obj->sha1));
 			continue;
 		}
 
@@ -201,6 +242,8 @@
 		return fsck_commit((struct commit *) obj);
 	if (obj->type == tag_type)
 		return fsck_tag((struct tag *) obj);
+	if (!obj->type && obj->delta)
+		return 0;
 	return -1;
 }
 
@@ -384,6 +427,10 @@
 			show_root = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--delta-depth")) {
+			show_max_delta_depth = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--cache")) {
 			keep_cache_objects = 1;
 			continue;
@@ -400,6 +447,8 @@
 	}
 	fsck_sha1_list();
 
+	expand_deltas();
+
 	heads = 0;
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i]; 
@@ -423,7 +472,7 @@
 	}
 
 	/*
-	 * If we've not been gived any explicit head information, do the
+	 * If we've not been given any explicit head information, do the
 	 * default ones from .git/refs. We also consider the index file
 	 * in this case (ie this implies --cache).
 	 */
Index: git/delta.c
===================================================================
--- /dev/null
+++ git/delta.c
@@ -0,0 +1,115 @@
+#include "object.h"
+#include "blob.h"
+#include "tree.h"
+#include "commit.h"
+#include "tag.h"
+#include "delta.h"
+#include "cache.h"
+#include <string.h>
+
+/* the delta object definition (it can alias any other object) */
+struct delta {
+	union {
+		struct object object;
+		struct blob blob;
+		struct tree tree;
+		struct commit commit;
+		struct tag tag;
+	} u;
+};
+
+struct delta *lookup_delta(unsigned char *sha1)
+{
+	struct object *obj = lookup_object(sha1);
+	if (!obj) {
+		struct delta *ret = xmalloc(sizeof(struct delta));
+		memset(ret, 0, sizeof(struct delta));
+		created_object(sha1, &ret->u.object);
+		return ret;
+	}
+	return (struct delta *) obj;
+}
+
+int parse_delta_buffer(struct delta *item, void *buffer, unsigned long size)
+{
+	struct object *reference;
+	struct object_list *p;
+
+	if (item->u.object.delta)
+		return 0;
+	item->u.object.delta = 1;
+	if (size <= 20)
+		return -1;
+	reference = lookup_object(buffer);
+	if (!reference) {
+		struct delta *ref = xmalloc(sizeof(struct delta));
+		memset(ref, 0, sizeof(struct delta));
+		created_object(buffer, &ref->u.object);
+		reference = &ref->u.object;
+	}
+
+	p = xmalloc(sizeof(*p));
+	p->item = &item->u.object;
+	p->next = reference->attached_deltas;
+	reference->attached_deltas = p;
+	return 0;
+}
+
+int process_deltas(void *src, unsigned long src_size, const char *src_type,
+		   struct object_list *delta_list)
+{
+	int deepest = 0;
+	do {
+		struct object *obj = delta_list->item;
+		static char type[10];
+		void *map, *delta, *buf;
+		unsigned long map_size, delta_size, buf_size;
+		map = map_sha1_file(obj->sha1, &map_size);
+		if (!map)
+			continue;
+		delta = unpack_sha1_file(map, map_size, type, &delta_size);
+		munmap(map, map_size);
+		if (!delta)
+			continue;
+		if (strcmp(type, "delta") || delta_size <= 20) {
+			free(delta);
+			continue;
+		}
+		buf = patch_delta(src, src_size,
+				  delta+20, delta_size-20,
+				  &buf_size);
+		free(delta);
+		if (!buf)
+			continue;
+		if (check_sha1_signature(obj->sha1, buf, buf_size, src_type) < 0)
+			printf("sha1 mismatch for delta %s\n", sha1_to_hex(obj->sha1));
+		if (obj->type && obj->type != src_type) {
+			error("got %s when expecting %s for delta %s",
+			      src_type, obj->type, sha1_to_hex(obj->sha1));
+			free(buf);
+			continue;
+		}
+		obj->type = src_type;
+		if (src_type == blob_type) {
+			parse_blob_buffer((struct blob *)obj, buf, buf_size);
+		} else if (src_type == tree_type) {
+			parse_tree_buffer((struct tree *)obj, buf, buf_size);
+		} else if (src_type == commit_type) {
+			parse_commit_buffer((struct commit *)obj, buf, buf_size);
+		} else if (src_type == tag_type) {
+			parse_tag_buffer((struct tag *)obj, buf, buf_size);
+		} else {
+			error("unknown object type %s", src_type);
+			free(buf);
+			continue;
+		}
+		if (obj->attached_deltas) {
+			int depth = process_deltas(buf, buf_size, src_type,
+						   obj->attached_deltas);
+			if (deepest < depth)
+				deepest = depth;
+		}
+		free(buf);
+	} while ((delta_list = delta_list->next));
+	return deepest + 1;
+}
Index: git/tag.c
===================================================================
--- git.orig/tag.c
+++ git/tag.c
@@ -13,6 +13,8 @@
                 ret->object.type = tag_type;
                 return ret;
         }
+	if (!obj->type)
+		obj->type = tag_type;
         if (obj->type != tag_type) {
                 error("Object %s is a %s, not a tree", 
                       sha1_to_hex(sha1), obj->type);
Index: git/tree.c
===================================================================
--- git.orig/tree.c
+++ git/tree.c
@@ -83,6 +83,8 @@
 		ret->object.type = tree_type;
 		return ret;
 	}
+	if (!obj->type)
+		obj->type = tree_type;
 	if (obj->type != tree_type) {
 		error("Object %s is a %s, not a tree", 
 		      sha1_to_hex(sha1), obj->type);
Index: git/blob.c
===================================================================
--- git.orig/blob.c
+++ git/blob.c
@@ -14,6 +14,8 @@
 		ret->object.type = blob_type;
 		return ret;
 	}
+	if (!obj->type)
+		obj->type = blob_type;
 	if (obj->type != blob_type) {
 		error("Object %s is a %s, not a blob", 
 		      sha1_to_hex(sha1), obj->type);
Index: git/delta.h
===================================================================
--- git.orig/delta.h
+++ git/delta.h
@@ -1,6 +1,21 @@
+#ifndef DELTA_H
+#define DELTA_H
+
+/* handling of delta buffers */
 extern void *diff_delta(void *from_buf, unsigned long from_size,
 			void *to_buf, unsigned long to_size,
 		        unsigned long *delta_size);
 extern void *patch_delta(void *src_buf, unsigned long src_size,
 			 void *delta_buf, unsigned long delta_size,
 			 unsigned long *dst_size);
+
+/* handling of delta objects */
+struct delta;
+struct object_list;
+extern struct delta *lookup_delta(unsigned char *sha1);
+extern int parse_delta_buffer(struct delta *item, void *buffer, unsigned long size);
+extern int parse_delta(struct delta *item, unsigned char sha1);
+extern int process_deltas(void *src, unsigned long src_size,
+			  const char *src_type, struct object_list *delta);
+
+#endif
Index: git/commit.c
===================================================================
--- git.orig/commit.c
+++ git/commit.c
@@ -37,6 +37,8 @@
 		ret->object.type = commit_type;
 		return ret;
 	}
+	if (!obj->type)
+		obj->type = commit_type;
 	return check_commit(obj, sha1);
 }
 
Index: git/object.c
===================================================================
--- git.orig/object.c
+++ git/object.c
@@ -4,6 +4,7 @@
 #include "commit.h"
 #include "cache.h"
 #include "tag.h"
+#include "delta.h"
 #include <stdlib.h>
 #include <string.h>
 
@@ -104,6 +105,7 @@
 	unsigned long mapsize;
 	void *map = map_sha1_file(sha1, &mapsize);
 	if (map) {
+		int is_delta;
 		struct object *obj;
 		char type[100];
 		unsigned long size;
@@ -111,9 +113,14 @@
 		munmap(map, mapsize);
 		if (!buffer)
 			return NULL;
-		if (check_sha1_signature(sha1, buffer, size, type) < 0)
+		is_delta = !strcmp(type, "delta");
+		if (!is_delta && check_sha1_signature(sha1, buffer, size, type) < 0)
 			printf("sha1 mismatch %s\n", sha1_to_hex(sha1));
-		if (!strcmp(type, "blob")) {
+		if (is_delta) {
+			struct delta *delta = lookup_delta(sha1);
+			parse_delta_buffer(delta, buffer, size);
+			obj = (struct object *) delta;
+		} else if (!strcmp(type, "blob")) {
 			struct blob *blob = lookup_blob(sha1);
 			parse_blob_buffer(blob, buffer, size);
 			obj = &blob->object;
Index: git/Makefile
===================================================================
--- git.orig/Makefile
+++ git/Makefile
@@ -36,7 +36,7 @@
 	$(INSTALL) $(PROG) $(SCRIPTS) $(dest)$(bin)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
-	 tag.o date.o index.o diff-delta.o patch-delta.o
+	 tag.o delta.o date.o index.o diff-delta.o patch-delta.o
 LIB_FILE=libgit.a
 LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h
 
Index: git/object.h
===================================================================
--- git.orig/object.h
+++ git/object.h
@@ -9,10 +9,12 @@
 struct object {
 	unsigned parsed : 1;
 	unsigned used : 1;
+	unsigned delta : 1;
 	unsigned int flags;
 	unsigned char sha1[20];
 	const char *type;
 	struct object_list *refs;
+	struct object_list *attached_deltas;
 };
 
 extern int nr_objs;

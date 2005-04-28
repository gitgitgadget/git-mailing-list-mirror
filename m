From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [4/5] Rework fsck-cache to use parse_object()
Date: Thu, 28 Apr 2005 01:13:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504280111490.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504280055180.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 07:08:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR1GH-0007cK-Ae
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 07:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVD1FN4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 01:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVD1FN4
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 01:13:56 -0400
Received: from iabervon.org ([66.92.72.58]:60420 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261991AbVD1FNr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 01:13:47 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DR1LO-0001mQ-00; Thu, 28 Apr 2005 01:13:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504280055180.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

With support for parse_object() and tags in the core, fsck_cache can just
call them, and can be simplified a bit.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: fsck-cache.c
===================================================================
--- dd06c679f8acb720976073de90a9eeabbc11e951/fsck-cache.c  (mode:100644 sha1:f9b1431dd8f4f3b426a7e410de952277aaa11401)
+++ ca8a271be1370ab0795a869c15114e566bdd15d8/fsck-cache.c  (mode:100644 sha1:280a104050b665515418c00c33af8e6b0b0e2101)
@@ -6,6 +6,7 @@
 #include "commit.h"
 #include "tree.h"
 #include "blob.h"
+#include "tag.h"
 
 #define REACHABLE 0x0001
 
@@ -21,6 +22,7 @@
 	/* Look up all the requirements, warn about missing objects.. */
 	for (i = 0; i < nr_objs; i++) {
 		struct object *obj = objs[i];
+		struct object_list *refs;
 
 		if (show_unreachable && !(obj->flags & REACHABLE)) {
 			printf("unreachable %s %s\n", obj->type, sha1_to_hex(obj->sha1));
@@ -35,101 +37,49 @@
 			printf("dangling %s %s\n", obj->type, 
 			       sha1_to_hex(obj->sha1));
 		}
+		for (refs = obj->refs; refs; refs = refs->next) {
+			if (!refs->item->parsed) {
+				printf("broken link from %s\n",
+				       sha1_to_hex(obj->sha1));
+				printf("              to %s\n",
+				       sha1_to_hex(refs->item->sha1));
+			}
+		}
 	}
 }
 
-static int fsck_tree(unsigned char *sha1, void *data, unsigned long size)
+static int fsck_tree(struct tree *item)
 {
-	struct tree *item = lookup_tree(sha1);
-	if (parse_tree(item))
-		return -1;
 	if (item->has_full_path) {
 		fprintf(stderr, "warning: fsck-cache: tree %s "
-			"has full pathnames in it\n", sha1_to_hex(sha1));
+			"has full pathnames in it\n", 
+			sha1_to_hex(item->object.sha1));
 	}
 	return 0;
 }
 
-static int fsck_commit(unsigned char *sha1, void *data, unsigned long size)
+static int fsck_commit(struct commit *commit)
 {
-	struct commit *commit = lookup_commit(sha1);
-	if (parse_commit(commit))
-		return -1;
 	if (!commit->tree)
 		return -1;
 	if (!commit->parents && show_root)
-		printf("root %s\n", sha1_to_hex(sha1));
+		printf("root %s\n", sha1_to_hex(commit->object.sha1));
 	if (!commit->date)
-		printf("bad commit date in %s\n", sha1_to_hex(sha1));
-	return 0;
-}
-
-static int fsck_blob(unsigned char *sha1, void *data, unsigned long size)
-{
-	struct blob *blob = lookup_blob(sha1);
-	blob->object.parsed = 1;
+		printf("bad commit date in %s\n", 
+		       sha1_to_hex(commit->object.sha1));
 	return 0;
 }
 
-static int fsck_tag(unsigned char *sha1, void *data, unsigned long size)
+static int fsck_tag(struct tag *tag)
 {
-	int typelen, taglen;
-	unsigned char object[20];
-	char object_hex[60];
-	const char *type_line, *tag_line, *sig_line;
-
-	if (size < 64)
-		return -1;
-	if (memcmp("object ", data, 7) || get_sha1_hex(data + 7, object))
-		return -1;
-
-	type_line = data + 48;
-	if (memcmp("\ntype ", type_line-1, 6))
-		return -1;
-
-	tag_line = strchr(type_line, '\n');
-	if (!tag_line || memcmp("tag ", ++tag_line, 4))
-		return -1;
-
-	sig_line = strchr(tag_line, '\n');
-	if (!sig_line)
-		return -1;
-	sig_line++;
-
-	typelen = tag_line - type_line - strlen("type \n");
-	if (typelen >= 20)
-		return -1;
-	taglen = sig_line - tag_line - strlen("tag \n");
-
 	if (!show_tags)
 		return 0;
 
-	strcpy(object_hex, sha1_to_hex(object));
-	printf("tagged %.*s %s (%.*s) in %s\n",
-		typelen, type_line + 5,
-		object_hex,
-		taglen, tag_line + 4,
-		sha1_to_hex(sha1));
-	return 0;
-}
-
-static int fsck_entry(unsigned char *sha1, char *tag, void *data, 
-		      unsigned long size)
-{
-	if (!strcmp(tag, "blob")) {
-		if (fsck_blob(sha1, data, size) < 0)
-			return -1;
-	} else if (!strcmp(tag, "tree")) {
-		if (fsck_tree(sha1, data, size) < 0)
-			return -1;
-	} else if (!strcmp(tag, "commit")) {
-		if (fsck_commit(sha1, data, size) < 0)
-			return -1;
-	} else if (!strcmp(tag, "tag")) {
-		if (fsck_tag(sha1, data, size) < 0)
-			return -1;
-	} else
-		return -1;
+	printf("tagged %s %s",
+	       tag->tagged->type,
+	       sha1_to_hex(tag->tagged->sha1));
+	printf(" (%s) in %s\n",
+	       tag->tag, sha1_to_hex(tag->object.sha1));
 	return 0;
 }
 
@@ -137,20 +87,17 @@
 {
 	unsigned char sha1[20];
 	if (!get_sha1_hex(hex, sha1)) {
-		unsigned long mapsize;
-		void *map = map_sha1_file(sha1, &mapsize);
-		if (map) {
-			char type[100];
-			unsigned long size;
-			void *buffer = unpack_sha1_file(map, mapsize, type, &size);
-			if (!buffer)
-				return -1;
-			if (check_sha1_signature(sha1, buffer, size, type) < 0)
-				printf("sha1 mismatch %s\n", sha1_to_hex(sha1));
-			munmap(map, mapsize);
-			if (!fsck_entry(sha1, type, buffer, size))
-				return 0;
-		}
+		struct object *obj = parse_object(sha1);
+		if (!obj)
+			return -1;
+		if (obj->type == blob_type)
+			return 0;
+		if (obj->type == tree_type)
+			return fsck_tree((struct tree *) obj);
+		if (obj->type == commit_type)
+			return fsck_commit((struct commit *) obj);
+		if (obj->type == tag_type)
+			return fsck_tag((struct tag *) obj);
 	}
 	return -1;
 }


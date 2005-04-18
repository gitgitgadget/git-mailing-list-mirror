From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [4/5] Port fsck-cache to use parsing functions
Date: Sun, 17 Apr 2005 22:40:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504172237390.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504172229240.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:37:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNM7z-0001z1-Cr
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 04:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVDRCkg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 22:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVDRCkg
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 22:40:36 -0400
Received: from iabervon.org ([66.92.72.58]:42758 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261611AbVDRCkG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 22:40:06 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNMBR-00056r-00; Sun, 17 Apr 2005 22:40:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504172229240.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This ports fsck-cache to use parsing functions. Note that performance
could be improved here by only reading each object once, but this requires
somewhat more complicated flow control.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: Makefile
===================================================================
--- 499f6cf77edad6935da0106cca4472e50fdbde34/Makefile  (mode:100644 sha1:f00a9c3c1cdbfef7e96cfa98256aad35e63131e7)
+++ 1172a9b8f45b2fd640985595cc5258db3b027828/Makefile  (mode:100644 sha1:c8908268d3c2253d3905671de5cabe4c84674128)
@@ -43,8 +43,8 @@
 cat-file: cat-file.o read-cache.o
 	$(CC) $(CFLAGS) -o cat-file cat-file.o read-cache.o $(LIBS)
 
-fsck-cache: fsck-cache.o read-cache.o
-	$(CC) $(CFLAGS) -o fsck-cache fsck-cache.o read-cache.o $(LIBS)
+fsck-cache: fsck-cache.o read-cache.o object.o commit.o tree.o blob.o
+	$(CC) $(CFLAGS) -o fsck-cache fsck-cache.o read-cache.o object.o commit.o tree.o blob.o $(LIBS)
 
 checkout-cache: checkout-cache.o read-cache.o
 	$(CC) $(CFLAGS) -o checkout-cache checkout-cache.o read-cache.o $(LIBS)
Index: fsck-cache.c
===================================================================
--- 499f6cf77edad6935da0106cca4472e50fdbde34/fsck-cache.c  (mode:100644 sha1:cff04ce34e9445cd57db9c1026040d56f045e5e7)
+++ 1172a9b8f45b2fd640985595cc5258db3b027828/fsck-cache.c  (mode:100644 sha1:2000f16efc84911a51a40664fef8a637c90e2dcc)
@@ -3,7 +3,11 @@
 #include <sys/types.h>
 #include <dirent.h>
 
-#include "revision.h"
+#include "commit.h"
+#include "tree.h"
+#include "blob.h"
+
+#define REACHABLE 0x0001
 
 static int show_unreachable = 0;
 static unsigned char head_sha1[20];
@@ -13,96 +17,54 @@
 	int i;
 
 	/* Look up all the requirements, warn about missing objects.. */
-	for (i = 0; i < nr_revs; i++) {
-		struct revision *rev = revs[i];
+	for (i = 0; i < nr_objs; i++) {
+		struct object *obj = objs[i];
 
-		if (show_unreachable && !(rev->flags & REACHABLE)) {
-			printf("unreachable %s\n", sha1_to_hex(rev->sha1));
+		if (show_unreachable && !(obj->flags & REACHABLE)) {
+			printf("unreachable %s\n", sha1_to_hex(obj->sha1));
 			continue;
 		}
 
-		switch (rev->flags & (SEEN | USED)) {
-		case 0:
-			printf("bad %s\n", sha1_to_hex(rev->sha1));
-			break;
-		case USED:
-			printf("missing %s\n", sha1_to_hex(rev->sha1));
-			break;
-		case SEEN:
-			printf("dangling %s\n", sha1_to_hex(rev->sha1));
-			break;
+		if (!obj->parsed) {
+			printf("missing %s %s\n", obj->type, 
+			       sha1_to_hex(obj->sha1));
+		}
+		if (!obj->used) {
+			printf("dangling %s %s\n", obj->type, 
+			       sha1_to_hex(obj->sha1));
 		}
 	}
 }
 
-static void mark_needs_sha1(unsigned char *parent, const char * tag, unsigned char *child)
-{
-	struct revision * child_rev = add_relationship(lookup_rev(parent), child);
-	child_rev->flags |= USED;
-}
-
-static int mark_sha1_seen(unsigned char *sha1, char *tag)
-{
-	struct revision *rev = lookup_rev(sha1);
-
-	rev->flags |= SEEN;
-	return 0;
-}
-
 static int fsck_tree(unsigned char *sha1, void *data, unsigned long size)
 {
-	int warn_old_tree = 1;
-
-	while (size) {
-		int len = 1+strlen(data);
-		unsigned char *file_sha1 = data + len;
-		char *path = strchr(data, ' ');
-		unsigned int mode;
-		if (size < len + 20 || !path || sscanf(data, "%o", &mode) != 1)
-			return -1;
-
-		/* Warn about trees that don't do the recursive thing.. */
-		if (warn_old_tree && strchr(path, '/')) {
-			fprintf(stderr, "warning: fsck-cache: tree %s has full pathnames in it\n", sha1_to_hex(sha1));
-			warn_old_tree = 0;
-		}
-
-		data += len + 20;
-		size -= len + 20;
-		mark_needs_sha1(sha1, S_ISDIR(mode) ? "tree" : "blob", file_sha1);
+	struct tree *item = lookup_tree(sha1);
+	if (parse_tree(item))
+		return -1;
+	if (item->has_full_path) {
+		fprintf(stderr, "warning: fsck-cache: tree %s "
+			"has full pathnames in it\n", sha1_to_hex(sha1));
 	}
 	return 0;
 }
 
 static int fsck_commit(unsigned char *sha1, void *data, unsigned long size)
 {
-	int parents;
-	unsigned char tree_sha1[20];
-	unsigned char parent_sha1[20];
-
-	if (memcmp(data, "tree ", 5))
+	struct commit *commit = lookup_commit(sha1);
+	if (parse_commit(commit))
 		return -1;
-	if (get_sha1_hex(data + 5, tree_sha1) < 0)
+	if (!commit->tree)
 		return -1;
-	mark_needs_sha1(sha1, "tree", tree_sha1);
-	data += 5 + 40 + 1;	/* "tree " + <hex sha1> + '\n' */
-	parents = 0;
-	while (!memcmp(data, "parent ", 7)) {
-		if (get_sha1_hex(data + 7, parent_sha1) < 0)
-			return -1;
-		mark_needs_sha1(sha1, "commit", parent_sha1);
-		data += 7 + 40 + 1; 	/* "parent " + <hex sha1> + '\n' */
-		parents++;
-	}
-	if (!parents)
+	if (!commit->parents)
 		printf("root %s\n", sha1_to_hex(sha1));
 	return 0;
 }
 
-static int fsck_entry(unsigned char *sha1, char *tag, void *data, unsigned long size)
+static int fsck_entry(unsigned char *sha1, char *tag, void *data, 
+		      unsigned long size)
 {
 	if (!strcmp(tag, "blob")) {
-		/* Nothing to check */;
+		lookup_blob(sha1); /* Nothing to check; but notice it. */
 	} else if (!strcmp(tag, "tree")) {
 		if (fsck_tree(sha1, data, size) < 0)
 			return -1;
@@ -111,7 +73,7 @@
 			return -1;
 	} else
 		return -1;
-	return mark_sha1_seen(sha1, tag);
+	return 0;
 }
 
 static int fsck_name(char *hex)
@@ -125,7 +87,8 @@
 			unsigned long size;
 			void *buffer = NULL;
 			if (!check_sha1_signature(sha1, map, mapsize))
-				buffer = unpack_sha1_file(map, mapsize, type, &size);
+				buffer = unpack_sha1_file(map, mapsize, type,
+							  &size);
 			munmap(map, mapsize);
 			if (buffer && !fsck_entry(sha1, type, buffer, size))
 				return 0;
@@ -186,7 +149,10 @@
 			continue;
 		}
 		if (!get_sha1_hex(argv[i], head_sha1)) {
-			mark_reachable(lookup_rev(head_sha1), REACHABLE);
+			struct object *obj =
+				&lookup_commit(head_sha1)->object;
+			obj->used = 1;
+			mark_reachable(obj, REACHABLE);
 			heads++;
 			continue;
 		}


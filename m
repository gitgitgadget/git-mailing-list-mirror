From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [3/5] Port rev-tree to parsing functions
Date: Sun, 17 Apr 2005 22:37:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504172236261.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504172229240.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:34:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNM5F-0001lO-Ss
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 04:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVDRChr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 22:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVDRChr
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 22:37:47 -0400
Received: from iabervon.org ([66.92.72.58]:37126 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261610AbVDRChV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 22:37:21 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNM8m-00050C-00; Sun, 17 Apr 2005 22:37:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504172229240.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This ports rev-tree to use the parsing functions introduced in the
previous patches.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: Makefile
===================================================================
--- 5ca133e1b74aee39b2124c0ec9fd51539babb5e0/Makefile  (mode:100644 sha1:773166a462f88b1c69930ce36d336d3d7badc319)
+++ 1172a9b8f45b2fd640985595cc5258db3b027828/Makefile  (mode:100644 sha1:c8908268d3c2253d3905671de5cabe4c84674128)
@@ -52,8 +52,8 @@
 diff-tree: diff-tree.o read-cache.o
 	$(CC) $(CFLAGS) -o diff-tree diff-tree.o read-cache.o $(LIBS)
 
-rev-tree: rev-tree.o read-cache.o
-	$(CC) $(CFLAGS) -o rev-tree rev-tree.o read-cache.o $(LIBS)
+rev-tree: rev-tree.o read-cache.o object.o commit.o tree.o blob.o
+	$(CC) $(CFLAGS) -o rev-tree rev-tree.o read-cache.o object.o commit.o tree.o blob.o $(LIBS)
 
 show-files: show-files.o read-cache.o
 	$(CC) $(CFLAGS) -o show-files show-files.o read-cache.o $(LIBS)
Index: rev-tree.c
===================================================================
--- 5ca133e1b74aee39b2124c0ec9fd51539babb5e0/rev-tree.c  (mode:100644 sha1:2d331b04c8243baab9546611ced07ba3439ab8ae)
+++ 1172a9b8f45b2fd640985595cc5258db3b027828/rev-tree.c  (mode:100644 sha1:38e992ac027c733f38b18932caa4032849936d05)
@@ -4,7 +4,7 @@
 #include <ctype.h>
 
 #include "cache.h"
-#include "revision.h"
+#include "commit.h"
 
 /*
  * revision.h leaves the low 16 bits of the "flags" field of the
@@ -18,38 +18,7 @@
 
 static void read_cache_file(const char *path)
 {
-	FILE *file = fopen(path, "r");
-	char line[500];
-
-	if (!file)
-		die("bad revtree cache file (%s)", path);
-
-	while (fgets(line, sizeof(line), file)) {
-		unsigned long date;
-		unsigned char sha1[20];
-		struct revision *rev;
-		const char *buf;
-
-		if (sscanf(line, "%lu", &date) != 1)
-			break;
-		buf = strchr(line, ' ');
-		if (!buf)
-			break;
-		if (get_sha1_hex(buf+1, sha1))
-			break;
-		rev = lookup_rev(sha1);
-		rev->flags |= SEEN;
-		rev->date = date;
-
-		/* parents? */
-		while ((buf = strchr(buf+1, ' ')) != NULL) {
-			unsigned char parent[20];
-			if (get_sha1_hex(buf + 1, parent))
-				break;
-			add_relationship(rev, parent);
-		}
-	}
-	fclose(file);
+	die("no revtree cache file yet");
 }
 
 /*
@@ -61,16 +30,16 @@
  * And sometimes we're only interested in "edge" commits, ie
  * places where the marking changes between parent and child.
  */
-static int interesting(struct revision *rev)
+static int interesting(struct commit *rev)
 {
-	unsigned mask = marked(rev);
+	unsigned mask = rev->object.flags;
 
 	if (!mask)
 		return 0;
 	if (show_edges) {
-		struct parent *p = rev->parent;
+		struct commit_list *p = rev->parents;
 		while (p) {
-			if (mask != marked(p->parent))
+			if (mask != p->item->object.flags)
 				return 1;
 			p = p->next;
 		}
@@ -82,6 +51,18 @@
 	return 1;
 }
 
+void process_commit(unsigned char *sha1) {
+	struct commit_list *parents;
+	struct commit *obj = lookup_commit(sha1);
+	parse_commit(obj);
+	
+	parents = obj->parents;
+	while (parents) {
+		process_commit(parents->item->object.sha1);
+		parents = parents->next;
+	}
+}
+
 /*
  * Usage: rev-tree [--edges] [--cache <cache-file>] <commit-id> [<commit-id2>]
  *
@@ -119,7 +100,7 @@
 		}
 		if (nr >= MAX_COMMITS || get_sha1_hex(arg, sha1[nr]))
 			usage("rev-tree [--edges] [--cache <cache-file>] <commit-id> [<commit-id>]");
-		parse_commit(sha1[nr]);
+		process_commit(sha1[nr]);
 		nr++;
 	}
 
@@ -127,22 +108,30 @@
 	 * Now we have the maximal tree. Walk the different sha files back to the root.
 	 */
 	for (i = 0; i < nr; i++)
-		mark_reachable(lookup_rev(sha1[i]), 1 << i);
+		mark_reachable(&lookup_commit(sha1[i])->object, 1 << i);
 
 	/*
 	 * Now print out the results..
 	 */
-	for (i = 0; i < nr_revs; i++) {
-		struct revision *rev = revs[i];
-		struct parent *p;
+	for (i = 0; i < nr_objs; i++) {
+		struct object *obj = objs[i];
+		struct commit *commit;
+		struct commit_list *p;
+
+		if (obj->type != commit_type)
+			continue;
+
+		commit = (struct commit *) obj;
 
-		if (!interesting(rev))
+		if (!interesting(commit))
 			continue;
 
-		printf("%lu %s:%d", rev->date, sha1_to_hex(rev->sha1), marked(rev));
-		p = rev->parent;
+		printf("%lu %s:%d", commit->date, sha1_to_hex(obj->sha1), 
+		       obj->flags);
+		p = commit->parents;
 		while (p) {
-			printf(" %s:%d", sha1_to_hex(p->parent->sha1), marked(p->parent));
+			printf(" %s:%d", sha1_to_hex(p->item->object.sha1), 
+			       p->item->object.flags);
 			p = p->next;
 		}
 		printf("\n");


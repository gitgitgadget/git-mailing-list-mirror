From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [5/5] Switch implementations of merge-base, port to parsing
Date: Sun, 17 Apr 2005 22:42:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504172240250.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504172229240.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:38:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNM9u-00027G-1y
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 04:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVDRCmh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 22:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVDRCmh
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 22:42:37 -0400
Received: from iabervon.org ([66.92.72.58]:47622 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261612AbVDRCmX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 22:42:23 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNMDe-0005Xi-00; Sun, 17 Apr 2005 22:42:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504172229240.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This switches to my implementation of merge-base, but with the new parsing
library.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: Makefile
===================================================================
--- 108bfb69c14c55c3c6e30a298307390c82cf1b3b/Makefile  (mode:100644 sha1:affc0e96030d4514f8306ee29020ca6bb320648f)
+++ 1172a9b8f45b2fd640985595cc5258db3b027828/Makefile  (mode:100644 sha1:c8908268d3c2253d3905671de5cabe4c84674128)
@@ -64,8 +64,8 @@
 ls-tree: ls-tree.o read-cache.o
 	$(CC) $(CFLAGS) -o ls-tree ls-tree.o read-cache.o $(LIBS)
 
-merge-base: merge-base.o read-cache.o
-	$(CC) $(CFLAGS) -o merge-base merge-base.o read-cache.o $(LIBS)
+merge-base: merge-base.o read-cache.o object.o commit.o tree.o blob.o
+	$(CC) $(CFLAGS) -o merge-base merge-base.o read-cache.o object.o commit.o tree.o blob.o $(LIBS)
 
 read-cache.o: cache.h
 show-diff.o: cache.h
Index: merge-base.c
===================================================================
--- 108bfb69c14c55c3c6e30a298307390c82cf1b3b/merge-base.c  (mode:100644 sha1:c98cad0befcf7e04fcc329d9bb7cb550506a4574)
+++ 1172a9b8f45b2fd640985595cc5258db3b027828/merge-base.c  (mode:100644 sha1:414ff419c679dba122b2f21b698c1e2c8abdd965)
@@ -1,57 +1,95 @@
+#include <stdlib.h>
 #include "cache.h"
-#include "revision.h"
+#include "commit.h"
 
-/*
- * This is stupid. We could have much better heurstics, I bet.
- */
-static int better(struct revision *new, struct revision *old)
+static struct commit *process_list(struct commit_list **list_p, int this_mark,
+				   int other_mark)
 {
-	return new->date > old->date;
+	struct commit_list *parent, *temp;
+	struct commit_list *posn = *list_p;
+	*list_p = NULL;
+	while (posn) {
+		parse_commit(posn->item);
+		if (posn->item->object.flags & this_mark) {
+			/*
+			  printf("%d already seen %s %x\n",
+			  this_mark
+			  sha1_to_hex(posn->parent->sha1),
+			  posn->parent->flags);
+			*/
+			/* do nothing; this indicates that this side
+			 * split and reformed, and we only need to
+			 * mark it once.
+			 */
+		} else if (posn->item->object.flags & other_mark) {
+			return posn->item;
+		} else {
+			/*
+			  printf("%d based on %s\n",
+			  this_mark,
+			  sha1_to_hex(posn->parent->sha1));
+			*/
+			posn->item->object.flags |= this_mark;
+			
+			parent = posn->item->parents;
+			while (parent) {
+				temp = malloc(sizeof(struct commit_list));
+				temp->next = *list_p;
+				temp->item = parent->item;
+				*list_p = temp;
+				parent = parent->next;
+			}
+		}
+		posn = posn->next;
+	}
+	return NULL;
 }
 
-static struct revision *common_parent(struct revision *rev1, struct revision *rev2)
+struct commit *common_ancestor(struct commit *rev1, struct commit *rev2)
 {
-	int i;
-	struct revision *best = NULL;
+	struct commit_list *rev1list = malloc(sizeof(struct commit_list));
+	struct commit_list *rev2list = malloc(sizeof(struct commit_list));
+
+	rev1list->item = rev1;
+	rev1list->next = NULL;
+
+	rev2list->item = rev2;
+	rev2list->next = NULL;
 
-	mark_reachable(rev1, 1);
-	mark_reachable(rev2, 2);
-	for (i = 0; i < nr_revs ;i++) {
-		struct revision *rev = revs[i];
-		if ((rev->flags & 3) != 3)
-			continue;
-		if (!best) {
-			best = rev;
-			continue;
+	while (rev1list || rev2list) {
+		struct commit *ret;
+		ret = process_list(&rev1list, 0x1, 0x2);
+		if (ret) {
+			/* XXXX free lists */
+			return ret;
+		}
+		ret = process_list(&rev2list, 0x2, 0x1);
+		if (ret) {
+			/* XXXX free lists */
+			return ret;
 		}
-		if (better(rev, best))
-			best = rev;
 	}
-	return best;
+	return NULL;
 }
 
 int main(int argc, char **argv)
 {
-	unsigned char rev1[20], rev2[20];
-	struct revision *common;
-
-	if (argc != 3 || get_sha1_hex(argv[1], rev1) || get_sha1_hex(argv[2], rev2))
-		usage("merge-base <commit1> <commit2>");
+	struct commit *rev1, *rev2, *ret;
+	unsigned char rev1key[20], rev2key[20];
 
-	/*
-	 * We will eventually want to include a revision cache file
-	 * that "rev-tree.c" has generated, since this is going to
-	 * otherwise be quite expensive for big trees..
-	 *
-	 * That's some time off, though, and in the meantime we know
-	 * that we have a solution to the eventual expense.
-	 */
-	parse_commit(rev1);
-	parse_commit(rev2);
-
-	common = common_parent(lookup_rev(rev1), lookup_rev(rev2));
-	if (!common)
-		die("no common parent found");
-	printf("%s\n", sha1_to_hex(common->sha1));
-	return 0;
+	if (argc != 3 ||
+	    get_sha1_hex(argv[1], rev1key) ||
+	    get_sha1_hex(argv[2], rev2key)) {
+		usage("merge-base <commit-id> <commit-id>");
+	}
+	rev1 = lookup_commit(rev1key);
+	rev2 = lookup_commit(rev2key);
+	ret = common_ancestor(rev1, rev2);
+	if (ret) {
+		printf("%s\n", sha1_to_hex(ret->object.sha1));
+		return 0;
+	} else {
+		return 1;
+	}
+	
 }


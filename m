From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] merge-base-rebased
Date: Thu, 14 Apr 2005 13:20:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504141318430.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504141234490.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 19:19:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM7yq-0003RW-El
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 19:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVDNRVJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 13:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVDNRVJ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 13:21:09 -0400
Received: from iabervon.org ([66.92.72.58]:32260 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261557AbVDNRUD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 13:20:03 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DM80t-0008Gp-00; Thu, 14 Apr 2005 13:20:23 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504141234490.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add a dumb-but-improvable program to find a not-too-bad commit to do a
three-way-merge of two commits.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>

Index: Makefile
===================================================================
--- 1756b578489f93999ded68ae347bef7d6063101c/Makefile  (mode:100644 sha1:b39b4ea37586693dd707d1d0750a9b580350ec50)
+++ b07fe1a7e0836e7d906c16c4f63b2e42b4a5193a/Makefile  (mode:100644 sha1:a2d920a36c1124fb0a031ae43fdd3a8106529c8f)
@@ -14,7 +14,7 @@
 
 PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
-	check-files ls-tree merge-tree
+	check-files ls-tree merge-tree merge-base
 
 all: $(PROG)
 
@@ -67,6 +67,9 @@
 merge-tree: merge-tree.o read-cache.o
 	$(CC) $(CFLAGS) -o merge-tree merge-tree.o read-cache.o $(LIBS)
 
+merge-base: merge-base.o read-cache.o
+	$(CC) $(CFLAGS) -o merge-base merge-base.o read-cache.o $(LIBS)
+
 read-cache.o: cache.h
 show-diff.o: cache.h
 
Index: merge-base.c
===================================================================
--- /dev/null  (tree:1756b578489f93999ded68ae347bef7d6063101c)
+++ b07fe1a7e0836e7d906c16c4f63b2e42b4a5193a/merge-base.c  (mode:100644 sha1:a3e885ef8e2ae761d76c3217002467d19bf75a8d)
@@ -0,0 +1,132 @@
+#include <stdlib.h>
+#include "cache.h"
+#include "revision.h"
+
+static int parse_commit(struct revision *rev)
+{
+	if (!(rev->flags & SEEN)) {
+		void *buffer, *bufptr;
+		unsigned long size;
+		char type[20];
+		unsigned char parent[20];
+
+		rev->flags |= SEEN;
+		buffer = bufptr = read_sha1_file(rev->sha1, type, &size);
+		if (!buffer || strcmp(type, "commit"))
+			return -1;
+		bufptr += 46; /* "tree " + "hex sha1" + "\n" */
+		while (!memcmp(bufptr, "parent ", 7) && 
+		       !get_sha1_hex(bufptr+7, parent)) {
+			add_relationship(rev, parent);
+			bufptr += 48;   /* "parent " + "hex sha1" + "\n" */
+		}
+		//rev->date = parse_commit_date(bufptr);
+		free(buffer);
+	}
+	return 0;
+}
+
+struct revision *common_ancestor(struct revision *rev1, struct revision *rev2)
+{
+	struct parent *parent;
+
+	struct parent *rev1list = malloc(sizeof(struct parent));
+	struct parent *rev2list = malloc(sizeof(struct parent));
+        
+	struct parent *posn, *temp;
+
+	rev1list->parent = rev1;
+	rev1list->next = NULL;
+
+	rev2list->parent = rev2;
+	rev2list->next = NULL;
+
+	while (rev1list || rev2list) {
+		posn = rev1list;
+		rev1list = NULL;
+		while (posn) {
+			parse_commit(posn->parent);
+			if (posn->parent->flags & 0x0001) {
+				/*
+				printf("1 already seen %s %x\n",
+				       sha1_to_hex(posn->parent->sha1),
+				       posn->parent->flags);
+				*/
+                                // do nothing
+			} else if (posn->parent->flags & 0x0002) {
+                                // XXXX free lists
+				return posn->parent;
+			} else {
+				/*
+				printf("1 based on %s\n",
+				       sha1_to_hex(posn->parent->sha1));
+				*/
+				posn->parent->flags |= 0x0001;
+
+				parent = posn->parent->parent;
+				while (parent) {
+					temp = malloc(sizeof(struct parent));
+					temp->next = rev1list;
+					temp->parent = parent->parent;
+					rev1list = temp;
+					parent = parent->next;
+				}
+			}
+			posn = posn->next;
+		}
+		posn = rev2list;
+		rev2list = NULL;
+		while (posn) {
+			parse_commit(posn->parent);
+			if (posn->parent->flags & 0x0002) {
+				/*
+				printf("2 already seen %s\n",
+				       sha1_to_hex(posn->parent->sha1));
+				*/
+                                // do nothing
+			} else if (posn->parent->flags & 0x0001) {
+                                // XXXX free lists
+				return posn->parent;
+			} else {
+				/*
+				printf("2 based on %s\n",
+				       sha1_to_hex(posn->parent->sha1));
+				*/
+				posn->parent->flags |= 0x0002;
+
+				parent = posn->parent->parent;
+				while (parent) {
+					temp = malloc(sizeof(struct parent));
+					temp->next = rev2list;
+					temp->parent = parent->parent;
+					rev2list = temp;
+					parent = parent->next;
+				}
+			}
+			posn = posn->next;
+		}
+	}
+	return NULL;
+}
+
+int main(int argc, char **argv)
+{
+	struct revision *rev1, *rev2, *ret;
+	unsigned char rev1key[20], rev2key[20];
+	if (argc != 3 ||
+	    get_sha1_hex(argv[1], rev1key) ||
+	    get_sha1_hex(argv[2], rev2key)) {
+		usage("mergebase <commit-id> <commit-id>");
+	}
+	rev1 = lookup_rev(rev1key);
+	rev2 = lookup_rev(rev2key);
+	ret = common_ancestor(rev1, rev2);
+	if (ret) {
+		printf("%s\n", sha1_to_hex(ret->sha1));
+		return 0;
+	} else {
+		printf("Sorry.\n");
+		return 1;
+	}
+	
+}


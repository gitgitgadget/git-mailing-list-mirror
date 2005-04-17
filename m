From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [2/5] Add merge-base
Date: Sun, 17 Apr 2005 11:27:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171124340.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504171108060.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 17:23:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNBcD-0003OP-9e
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 17:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVDQP1E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 11:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVDQP1E
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 11:27:04 -0400
Received: from iabervon.org ([66.92.72.58]:63751 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261331AbVDQP0z (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 11:26:55 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNBg1-0006b5-00; Sun, 17 Apr 2005 11:27:13 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0504171108060.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

merge-base finds one of the best common ancestors of a pair of commits. In
particular, it finds one of the ones which is fewest commits away from the
further of the heads.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: Makefile
===================================================================
--- 37a0b01b85c2999243674d48bfc71cdba0e5518e/Makefile  (mode:100644 sha1:346e3850de026485802e41e16a1180be2df85e4a)
+++ d662b707e11391f6cfe597fd4d0bf9c41d34d01a/Makefile  (mode:100644 sha1:b2ce7c5b63fffca59653b980d98379909f893d44)
@@ -14,7 +14,7 @@
 
 PROG=   update-cache show-diff init-db write-tree read-tree commit-tree \
 	cat-file fsck-cache checkout-cache diff-tree rev-tree show-files \
-	check-files ls-tree
+	check-files ls-tree merge-base
 
 SCRIPT=	parent-id tree-id git gitXnormid.sh gitadd.sh gitaddremote.sh \
 	gitcommit.sh gitdiff-do gitdiff.sh gitlog.sh gitls.sh gitlsobj.sh \
Index: merge-base.c
===================================================================
--- /dev/null  (tree:37a0b01b85c2999243674d48bfc71cdba0e5518e)
+++ d662b707e11391f6cfe597fd4d0bf9c41d34d01a/merge-base.c  (mode:100644 sha1:0f85e7d9e9a896d1142a54170ddf1159f11f9cdd)
@@ -0,0 +1,108 @@
+#include <stdlib.h>
+#include "cache.h"
+#include "revision.h"
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
+			parse_commit_object(posn->parent);
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
+			parse_commit_object(posn->parent);
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


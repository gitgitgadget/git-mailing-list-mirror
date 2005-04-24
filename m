From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Allow multiple date-ordered lists
Date: Sat, 23 Apr 2005 22:59:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504232257390.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504232230080.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 04:55:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPXH0-0001Vk-R9
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 04:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVDXC7r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 22:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVDXC7r
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 22:59:47 -0400
Received: from iabervon.org ([66.92.72.58]:23812 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262236AbVDXC7l (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 22:59:41 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPXLW-00069b-00; Sat, 23 Apr 2005 22:59:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504232230080.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Make pop_most_recent_commit() return the same objects multiple times, but only
if called with different bits to mark.

This is necessary to make merge-base work again.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>

---
commit 58ec99a22e3a8dac158d9949b0a704752991ac8a
tree 6f24c9b481d76e067d64bac1a8dbd5cf5d0dfb05
parent f4adf2687593e8d6e58ac1c4710e0385a82500e5
author Daniel Barkalow <barkalow@iabervon.org> 1114311416 -0400
committer Daniel Barkalow <barkalow@silva-tulga.(none)> 1114311416 -0400

Index: commit.c
===================================================================
--- 34933617a2e8284ffca6ab2a1b2f00d6996a58e7/commit.c  (mode:100644 sha1:0243e77cb8e839e2972a2882bb1d0719f6e3cff1)
+++ 6f24c9b481d76e067d64bac1a8dbd5cf5d0dfb05/commit.c  (mode:100644 sha1:2502688262819033f5b8ed60a7bef5eed0aa2d6a)
@@ -114,7 +114,8 @@
 	*list = ret;
 }
 
-struct commit *pop_most_recent_commit(struct commit_list **list)
+struct commit *pop_most_recent_commit(struct commit_list **list,
+				      unsigned int mark)
 {
 	struct commit *ret = (*list)->item;
 	struct commit_list *parents = ret->parents;
@@ -125,8 +126,9 @@
 
 	while (parents) {
 		struct commit *commit = parents->item;
-		if (!commit->object.parsed) {
-			parse_commit(commit);
+		parse_commit(commit);
+		if (!(commit->object.flags & mark)) {
+			commit->object.flags |= mark;
 			insert_by_date(list, commit);
 		}
 		parents = parents->next;
Index: commit.h
===================================================================
--- 34933617a2e8284ffca6ab2a1b2f00d6996a58e7/commit.h  (mode:100644 sha1:c8684d1cd07d7c9ed0af06a3f3d9e7b49fbed0a2)
+++ 6f24c9b481d76e067d64bac1a8dbd5cf5d0dfb05/commit.h  (mode:100644 sha1:d61d084c89c72f4fe79c654db721df31c4f04224)
@@ -31,6 +31,7 @@
 /** Removes the first commit from a list sorted by date, and adds all
  * of its parents.
  **/
-struct commit *pop_most_recent_commit(struct commit_list **list);
+struct commit *pop_most_recent_commit(struct commit_list **list, 
+				      unsigned int mark);
 
 #endif /* COMMIT_H */
Index: merge-base.c
===================================================================
--- 34933617a2e8284ffca6ab2a1b2f00d6996a58e7/merge-base.c  (mode:100644 sha1:0e4c58ede915aca5719bbd12ecd1945f2f300590)
+++ 6f24c9b481d76e067d64bac1a8dbd5cf5d0dfb05/merge-base.c  (mode:100644 sha1:2c40881302e586366f03ae6ac6e7c0035847e2f0)
@@ -6,29 +6,11 @@
 				   int other_mark)
 {
 	struct commit *item = (*list_p)->item;
-	
-	if (item->object.flags & this_mark) {
-		/*
-		  printf("%d already seen %s %x\n",
-		  this_mark
-		  sha1_to_hex(posn->parent->sha1),
-		  posn->parent->flags);
-		*/
-		/* do nothing; this indicates that this side
-		 * split and reformed, and we only need to
-		 * mark it once.
-		 */
-		*list_p = (*list_p)->next;
-	} else if (item->object.flags & other_mark) {
+
+	if (item->object.flags & other_mark) {
 		return item;
 	} else {
-		/*
-		  printf("%d based on %s\n",
-		  this_mark,
-		  sha1_to_hex(posn->parent->sha1));
-		*/
-		pop_most_recent_commit(list_p);
-		item->object.flags |= this_mark;
+		pop_most_recent_commit(list_p, this_mark);
 	}
 	return NULL;
 }
@@ -39,7 +21,9 @@
 	struct commit_list *rev2list = NULL;
 
 	commit_list_insert(rev1, &rev1list);
+	rev1->object.flags |= 0x1;
 	commit_list_insert(rev2, &rev2list);
+	rev2->object.flags |= 0x2;
 
 	parse_commit(rev1);
 	parse_commit(rev2);
Index: rev-list.c
===================================================================
--- 34933617a2e8284ffca6ab2a1b2f00d6996a58e7/rev-list.c  (mode:100644 sha1:1c797d24a91b44994dc11180dd61c3ecf8f93349)
+++ 6f24c9b481d76e067d64bac1a8dbd5cf5d0dfb05/rev-list.c  (mode:100644 sha1:77bfc29db1aad08ba9d7d87ce08d33d4a88e74e3)
@@ -16,7 +16,7 @@
 
 	commit_list_insert(commit, &list);
 	do {
-		struct commit *commit = pop_most_recent_commit(&list);
+		struct commit *commit = pop_most_recent_commit(&list, 0x1);
 		printf("%s\n", sha1_to_hex(commit->object.sha1));
 	} while (list);
 	return 0;


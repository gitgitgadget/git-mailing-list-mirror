From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 4/5] Replace merge-base implementation
Date: Sat, 23 Apr 2005 20:18:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504232016010.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504231953490.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 02:13:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPUkn-0007NA-2J
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 02:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVDXAS2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 20:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVDXAS2
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 20:18:28 -0400
Received: from iabervon.org ([66.92.72.58]:11783 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262200AbVDXAST (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 20:18:19 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPUpQ-00007p-00; Sat, 23 Apr 2005 20:18:28 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0504231953490.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The old implementation was a nice algorithm, but, unfortunately, it could
be confused in some cases and would not necessarily do the obvious thing
if one argument was decended from the other. This version fixes that by
changing the criterion to the most recent common ancestor.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: merge-base.c
===================================================================
--- cae140a16189361d8c9f1f7e68ef519956fd26d9/merge-base.c  (mode:100644 sha1:ac1153bc5646cb2d515ff206b759f4a79e90273a)
+++ 9b75904eab1300d83264a1840d396160482fee88/merge-base.c  (mode:100644 sha1:0e4c58ede915aca5719bbd12ecd1945f2f300590)
@@ -5,67 +5,63 @@
 static struct commit *process_list(struct commit_list **list_p, int this_mark,
 				   int other_mark)
 {
-	struct commit_list *parent, *temp;
-	struct commit_list *posn = *list_p;
-	*list_p = NULL;
-	while (posn) {
-		parse_commit(posn->item);
-		if (posn->item->object.flags & this_mark) {
-			/*
-			  printf("%d already seen %s %x\n",
-			  this_mark
-			  sha1_to_hex(posn->parent->sha1),
-			  posn->parent->flags);
-			*/
-			/* do nothing; this indicates that this side
-			 * split and reformed, and we only need to
-			 * mark it once.
-			 */
-		} else if (posn->item->object.flags & other_mark) {
-			return posn->item;
-		} else {
-			/*
-			  printf("%d based on %s\n",
-			  this_mark,
-			  sha1_to_hex(posn->parent->sha1));
-			*/
-			posn->item->object.flags |= this_mark;
-			
-			parent = posn->item->parents;
-			while (parent) {
-				temp = malloc(sizeof(struct commit_list));
-				temp->next = *list_p;
-				temp->item = parent->item;
-				*list_p = temp;
-				parent = parent->next;
-			}
-		}
-		posn = posn->next;
+	struct commit *item = (*list_p)->item;
+	
+	if (item->object.flags & this_mark) {
+		/*
+		  printf("%d already seen %s %x\n",
+		  this_mark
+		  sha1_to_hex(posn->parent->sha1),
+		  posn->parent->flags);
+		*/
+		/* do nothing; this indicates that this side
+		 * split and reformed, and we only need to
+		 * mark it once.
+		 */
+		*list_p = (*list_p)->next;
+	} else if (item->object.flags & other_mark) {
+		return item;
+	} else {
+		/*
+		  printf("%d based on %s\n",
+		  this_mark,
+		  sha1_to_hex(posn->parent->sha1));
+		*/
+		pop_most_recent_commit(list_p);
+		item->object.flags |= this_mark;
 	}
 	return NULL;
 }
 
 struct commit *common_ancestor(struct commit *rev1, struct commit *rev2)
 {
-	struct commit_list *rev1list = malloc(sizeof(struct commit_list));
-	struct commit_list *rev2list = malloc(sizeof(struct commit_list));
+	struct commit_list *rev1list = NULL;
+	struct commit_list *rev2list = NULL;
 
-	rev1list->item = rev1;
-	rev1list->next = NULL;
+	commit_list_insert(rev1, &rev1list);
+	commit_list_insert(rev2, &rev2list);
 
-	rev2list->item = rev2;
-	rev2list->next = NULL;
+	parse_commit(rev1);
+	parse_commit(rev2);
 
 	while (rev1list || rev2list) {
 		struct commit *ret;
-		ret = process_list(&rev1list, 0x1, 0x2);
-		if (ret) {
-			/* XXXX free lists */
-			return ret;
+		if (!rev1list) {
+			// process 2
+			ret = process_list(&rev2list, 0x2, 0x1);
+		} else if (!rev2list) {
+			// process 1
+			ret = process_list(&rev1list, 0x1, 0x2);
+		} else if (rev1list->item->date < rev2list->item->date) {
+			// process 2
+			ret = process_list(&rev2list, 0x2, 0x1);
+		} else {
+			// process 1
+			ret = process_list(&rev1list, 0x1, 0x2);
 		}
-		ret = process_list(&rev2list, 0x2, 0x1);
 		if (ret) {
-			/* XXXX free lists */
+			free_commit_list(rev1list);
+			free_commit_list(rev2list);
 			return ret;
 		}
 	}


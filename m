From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [4/4] Make merge-base use dates to find answer
Date: Mon, 18 Apr 2005 22:00:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504182157370.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504182139250.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 03:56:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNhyR-00036q-My
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 03:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVDSCAW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 22:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVDSCAW
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 22:00:22 -0400
Received: from iabervon.org ([66.92.72.58]:40966 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261267AbVDSCAE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 22:00:04 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNi2E-0004wf-00; Mon, 18 Apr 2005 22:00:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504182139250.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This changes merge-base to use the dates of commit to search the
history. It will find the most recent common ancestor, rather than the one
the fewest generations away. It also demonstrates scanning the history by
date.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: merge-base.c
===================================================================
--- fb7b671eb0da01b9a9998ab58b3717da9f983456/merge-base.c  (mode:100644 sha1:414ff419c679dba122b2f21b698c1e2c8abdd965)
+++ 7e5a0d93117ecadfb15de3a6bebdb1aa94234fde/merge-base.c  (mode:100644 sha1:61e408e5d158f3dde6153ccbe9ee6fbbf1136225)
@@ -5,42 +5,30 @@
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
@@ -56,16 +44,27 @@
 	rev2list->item = rev2;
 	rev2list->next = NULL;
 
+	parse_commit(rev1);
+	parse_commit(rev2);
+
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


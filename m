From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [2/4] Sorting commits by date
Date: Mon, 18 Apr 2005 21:54:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504182152000.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0504182139250.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 03:50:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNhsw-0001r4-Op
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 03:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVDSByp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 21:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVDSByp
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 21:54:45 -0400
Received: from iabervon.org ([66.92.72.58]:26118 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261264AbVDSByl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 21:54:41 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNhx2-0004Ow-00; Mon, 18 Apr 2005 21:54:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.21.0504182139250.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Functions for a date-ordered queue of commits, progressively pulled out of
the history incrementally. Linus wanted this for finding the most recent
common ancestor, and it might be relevant to logging.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>
Index: commit.c
===================================================================
--- b3cf8daf9b619ae9f06a28f42a4ae01b69729206/commit.c  (mode:100644 sha1:0099baa63971d86ee30ef2a7da25057f0f45a964)
+++ 7e5a0d93117ecadfb15de3a6bebdb1aa94234fde/commit.c  (mode:100644 sha1:ef9af397471817837e1799d72f6707e0ccc949b9)
@@ -83,3 +83,47 @@
 		free(temp);
 	}
 }
+
+static void insert_by_date(struct commit_list **list, struct commit *item)
+{
+	struct commit_list **pp = list;
+	struct commit_list *p;
+	while ((p = *pp) != NULL) {
+		if (p->item->date < item->date) {
+			break;
+		}
+		pp = &p->next;
+	}
+	struct commit_list *insert = malloc(sizeof(struct commit_list));
+	insert->next = *pp;
+	*pp = insert;
+	insert->item = item;
+}
+
+	
+void sort_by_date(struct commit_list **list)
+{
+	struct commit_list *ret = NULL;
+	while (*list) {
+		insert_by_date(&ret, (*list)->item);
+		*list = (*list)->next;
+	}
+	*list = ret;
+}
+
+struct commit *pop_most_recent_commit(struct commit_list **list)
+{
+	struct commit *ret = (*list)->item;
+	struct commit_list *parents = ret->parents;
+	struct commit_list *old = *list;
+
+	*list = (*list)->next;
+	free(old);
+
+	while (parents) {
+		parse_commit(parents->item);
+		insert_by_date(list, parents->item);
+		parents = parents->next;
+	}
+	return ret;
+}
Index: commit.h
===================================================================
--- b3cf8daf9b619ae9f06a28f42a4ae01b69729206/commit.h  (mode:100644 sha1:8cd20b046875f5f7e534b0607fdd97f330f53272)
+++ 7e5a0d93117ecadfb15de3a6bebdb1aa94234fde/commit.h  (mode:100644 sha1:35679482132ae5a6b7d72bbb684f21472470717c)
@@ -24,4 +24,8 @@
 
 void free_commit_list(struct commit_list *list);
 
+void sort_by_date(struct commit_list **list);
+
+struct commit *pop_most_recent_commit(struct commit_list **list);
+
 #endif /* COMMIT_H */


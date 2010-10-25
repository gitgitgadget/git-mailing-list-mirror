From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 04/23] notes.c: Reorder functions in preparation for next
 commit
Date: Mon, 25 Oct 2010 02:08:34 +0200
Message-ID: <1287965333-5099-5-git-send-email-johan@herland.net>
References: <1287965333-5099-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 25 02:09:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAAcs-0000Uz-2T
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 02:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746Ab0JYAJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 20:09:18 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59867 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676Ab0JYAJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 20:09:16 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT005Z4KFDGG40@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:13 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id A0BAD17990AE_CC4CAA9B	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:13 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 64758179677A_CC4CAA9F	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:12 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT004SRKFAVB20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:11 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1287965333-5099-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159897>

This patch introduces no functional change. It consists solely of reordering
functions in notes.c to avoid use-before-declaration errors after applying
the next commit in this series.

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |  146 +++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/notes.c b/notes.c
index d71c0a3..bfb3ea5 100644
--- a/notes.c
+++ b/notes.c
@@ -150,6 +150,79 @@ static struct leaf_node *note_tree_find(struct notes_tree *t,
 }
 
 /*
+ * How to consolidate an int_node:
+ * If there are > 1 non-NULL entries, give up and return non-zero.
+ * Otherwise replace the int_node at the given index in the given parent node
+ * with the only entry (or a NULL entry if no entries) from the given tree,
+ * and return 0.
+ */
+static int note_tree_consolidate(struct int_node *tree,
+	struct int_node *parent, unsigned char index)
+{
+	unsigned int i;
+	void *p = NULL;
+
+	assert(tree && parent);
+	assert(CLR_PTR_TYPE(parent->a[index]) == tree);
+
+	for (i = 0; i < 16; i++) {
+		if (GET_PTR_TYPE(tree->a[i]) != PTR_TYPE_NULL) {
+			if (p) /* more than one entry */
+				return -2;
+			p = tree->a[i];
+		}
+	}
+
+	/* replace tree with p in parent[index] */
+	parent->a[index] = p;
+	free(tree);
+	return 0;
+}
+
+/*
+ * To remove a leaf_node:
+ * Search to the tree location appropriate for the given leaf_node's key:
+ * - If location does not hold a matching entry, abort and do nothing.
+ * - Replace the matching leaf_node with a NULL entry (and free the leaf_node).
+ * - Consolidate int_nodes repeatedly, while walking up the tree towards root.
+ */
+static void note_tree_remove(struct notes_tree *t, struct int_node *tree,
+		unsigned char n, struct leaf_node *entry)
+{
+	struct leaf_node *l;
+	struct int_node *parent_stack[20];
+	unsigned char i, j;
+	void **p = note_tree_search(t, &tree, &n, entry->key_sha1);
+
+	assert(GET_PTR_TYPE(entry) == 0); /* no type bits set */
+	if (GET_PTR_TYPE(*p) != PTR_TYPE_NOTE)
+		return; /* type mismatch, nothing to remove */
+	l = (struct leaf_node *) CLR_PTR_TYPE(*p);
+	if (hashcmp(l->key_sha1, entry->key_sha1))
+		return; /* key mismatch, nothing to remove */
+
+	/* we have found a matching entry */
+	free(l);
+	*p = SET_PTR_TYPE(NULL, PTR_TYPE_NULL);
+
+	/* consolidate this tree level, and parent levels, if possible */
+	if (!n)
+		return; /* cannot consolidate top level */
+	/* first, build stack of ancestors between root and current node */
+	parent_stack[0] = t->root;
+	for (i = 0; i < n; i++) {
+		j = GET_NIBBLE(i, entry->key_sha1);
+		parent_stack[i + 1] = CLR_PTR_TYPE(parent_stack[i]->a[j]);
+	}
+	assert(i == n && parent_stack[i] == tree);
+	/* next, unwind stack until note_tree_consolidate() is done */
+	while (i > 0 &&
+	       !note_tree_consolidate(parent_stack[i], parent_stack[i - 1],
+				      GET_NIBBLE(i - 1, entry->key_sha1)))
+		i--;
+}
+
+/*
  * To insert a leaf_node:
  * Search to the tree location appropriate for the given leaf_node's key:
  * - If location is unused (NULL), store the tweaked pointer directly there
@@ -229,79 +302,6 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
 	note_tree_insert(t, new_node, n + 1, entry, type, combine_notes);
 }
 
-/*
- * How to consolidate an int_node:
- * If there are > 1 non-NULL entries, give up and return non-zero.
- * Otherwise replace the int_node at the given index in the given parent node
- * with the only entry (or a NULL entry if no entries) from the given tree,
- * and return 0.
- */
-static int note_tree_consolidate(struct int_node *tree,
-	struct int_node *parent, unsigned char index)
-{
-	unsigned int i;
-	void *p = NULL;
-
-	assert(tree && parent);
-	assert(CLR_PTR_TYPE(parent->a[index]) == tree);
-
-	for (i = 0; i < 16; i++) {
-		if (GET_PTR_TYPE(tree->a[i]) != PTR_TYPE_NULL) {
-			if (p) /* more than one entry */
-				return -2;
-			p = tree->a[i];
-		}
-	}
-
-	/* replace tree with p in parent[index] */
-	parent->a[index] = p;
-	free(tree);
-	return 0;
-}
-
-/*
- * To remove a leaf_node:
- * Search to the tree location appropriate for the given leaf_node's key:
- * - If location does not hold a matching entry, abort and do nothing.
- * - Replace the matching leaf_node with a NULL entry (and free the leaf_node).
- * - Consolidate int_nodes repeatedly, while walking up the tree towards root.
- */
-static void note_tree_remove(struct notes_tree *t, struct int_node *tree,
-		unsigned char n, struct leaf_node *entry)
-{
-	struct leaf_node *l;
-	struct int_node *parent_stack[20];
-	unsigned char i, j;
-	void **p = note_tree_search(t, &tree, &n, entry->key_sha1);
-
-	assert(GET_PTR_TYPE(entry) == 0); /* no type bits set */
-	if (GET_PTR_TYPE(*p) != PTR_TYPE_NOTE)
-		return; /* type mismatch, nothing to remove */
-	l = (struct leaf_node *) CLR_PTR_TYPE(*p);
-	if (hashcmp(l->key_sha1, entry->key_sha1))
-		return; /* key mismatch, nothing to remove */
-
-	/* we have found a matching entry */
-	free(l);
-	*p = SET_PTR_TYPE(NULL, PTR_TYPE_NULL);
-
-	/* consolidate this tree level, and parent levels, if possible */
-	if (!n)
-		return; /* cannot consolidate top level */
-	/* first, build stack of ancestors between root and current node */
-	parent_stack[0] = t->root;
-	for (i = 0; i < n; i++) {
-		j = GET_NIBBLE(i, entry->key_sha1);
-		parent_stack[i + 1] = CLR_PTR_TYPE(parent_stack[i]->a[j]);
-	}
-	assert(i == n && parent_stack[i] == tree);
-	/* next, unwind stack until note_tree_consolidate() is done */
-	while (i > 0 &&
-	       !note_tree_consolidate(parent_stack[i], parent_stack[i - 1],
-				      GET_NIBBLE(i - 1, entry->key_sha1)))
-		i--;
-}
-
 /* Free the entire notes data contained in the given tree */
 static void note_tree_free(struct int_node *tree)
 {
-- 
1.7.3.98.g5ad7d9

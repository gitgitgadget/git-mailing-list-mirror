From: Johan Herland <johan@herland.net>
Subject: [PATCH 03/18] notes.h/c: Clarify the handling of notes objects that
 are == null_sha1
Date: Wed, 29 Sep 2010 02:23:16 +0200
Message-ID: <1285719811-10871-4-git-send-email-johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 02:24:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0kTV-0001F0-J3
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 02:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068Ab0I2AYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 20:24:34 -0400
Received: from smtp.getmail.no ([84.208.15.66]:44298 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689Ab0I2AXr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 20:23:47 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9H003YUFRJTS70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Sep 2010 02:23:44 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id D3E371EEF875_CA2870FB	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 00:23:43 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 822831EEF86A_CA2870FF	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 00:23:42 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9H00IQEFRHZC10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Sep 2010 02:23:41 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1285719811-10871-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157511>

Clearly specify how combine_notes functions are expected to handle null_sha1
in input, and how they may set the result to null_sha1 in order to cause
the removal of a note.

Also document that passing note_sha1 == null_sha1 to add_note() is usually
a no-op, except in cases where combining it with an existing note yields a
new/changed result.

The only functional changes in this patch concern the handling of null_sha1
in notes_tree_insert(). Otherwise the patch consists solely of reordering
functions in notes.c to avoid use-before-declaration, and adding
documentation to notes.h.

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |  158 +++++++++++++++++++++++++++++++++-----------------------------
 notes.h |   16 ++++++-
 2 files changed, 99 insertions(+), 75 deletions(-)

diff --git a/notes.c b/notes.c
index 79fd850..9e92021 100644
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
@@ -175,7 +248,10 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
 	switch (GET_PTR_TYPE(*p)) {
 	case PTR_TYPE_NULL:
 		assert(!*p);
-		*p = SET_PTR_TYPE(entry, type);
+		if (is_null_sha1(entry->val_sha1))
+			free(entry);
+		else
+			*p = SET_PTR_TYPE(entry, type);
 		return;
 	case PTR_TYPE_NOTE:
 		switch (type) {
@@ -191,6 +267,9 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
 					    sha1_to_hex(l->val_sha1),
 					    sha1_to_hex(entry->val_sha1),
 					    sha1_to_hex(l->key_sha1));
+
+				if (is_null_sha1(l->val_sha1))
+					note_tree_remove(t, tree, n, entry);
 				free(entry);
 				return;
 			}
@@ -222,6 +301,10 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
 	/* non-matching leaf_node */
 	assert(GET_PTR_TYPE(*p) == PTR_TYPE_NOTE ||
 	       GET_PTR_TYPE(*p) == PTR_TYPE_SUBTREE);
+	if (is_null_sha1(entry->val_sha1)) { /* skip insertion of empty note */
+		free(entry);
+		return;
+	}
 	new_node = (struct int_node *) xcalloc(sizeof(struct int_node), 1);
 	note_tree_insert(t, new_node, n + 1, l, GET_PTR_TYPE(*p),
 			 combine_notes);
@@ -229,79 +312,6 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
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
diff --git a/notes.h b/notes.h
index 20db42f..79ea797 100644
--- a/notes.h
+++ b/notes.h
@@ -12,7 +12,10 @@
  * resulting SHA1 into the first SHA1 argument (cur_sha1). A non-zero return
  * value indicates failure.
  *
- * The two given SHA1s must both be non-NULL and different from each other.
+ * The two given SHA1s shall both be non-NULL and different from each other.
+ * Either of them (but not both) may be == null_sha1, which indicates an
+ * empty/non-existent note. If the resulting SHA1 (cur_sha1) is == null_sha1,
+ * the note will be removed from the notes tree.
  *
  * The default combine_notes function (you get this when passing NULL) is
  * combine_notes_concatenate(), which appends the contents of the new note to
@@ -90,6 +93,17 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 /*
  * Add the given note object to the given notes_tree structure
  *
+ * If there already exists a note for the given object_sha1, the given
+ * combine_notes function is invoked to break the tie. If not given (i.e.
+ * combine_notes == NULL), the default combine_notes function for the given
+ * notes_tree is used.
+ *
+ * Passing note_sha1 == null_sha1 indicates the addition of an
+ * empty/non-existent note. This is a (potentially expensive) no-op unless
+ * there already exists a note for the given object_sha1, AND combining that
+ * note with the empty note (using the given combine_notes function) results
+ * in a new/changed note.
+ *
  * IMPORTANT: The changes made by add_note() to the given notes_tree structure
  * are not persistent until a subsequent call to write_notes_tree() returns
  * zero.
-- 
1.7.3.98.g5ad7d9

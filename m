From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv8 07/10] Refactor notes concatenation into a flexible
 interface for combining notes
Date: Fri, 20 Nov 2009 02:39:11 +0100
Message-ID: <1258681154-2167-8-git-send-email-johan@herland.net>
References: <1258681154-2167-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 02:40:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBIU3-0004ED-Ez
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 02:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757427AbZKTBjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 20:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757384AbZKTBjm
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 20:39:42 -0500
Received: from smtp.getmail.no ([84.208.15.66]:58314 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757361AbZKTBjk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Nov 2009 20:39:40 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTD00MO7WM9SE10@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 20 Nov 2009 02:39:45 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTD00D7NWLXUY10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 20 Nov 2009 02:39:45 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.11.20.12721
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1258681154-2167-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133287>

When adding a note to an object that already has an existing note, the
current solution is to concatenate the contents of the two notes. However,
the caller may instead wish to _overwrite_ the existing note with the new
note, or maybe even _ignore_ the new note, and keep the existing one. There
might also be other ways of combining notes that are only known to the
caller.

Therefore, instead of unconditionally concatenating notes, we let the caller
specify how to combine notes, by passing in a pointer to a function for
combining notes. The caller may choose to implement its own function for
notes combining, but normally one of the following three conveniently
supplied notes combination functions will be sufficient:

- combine_notes_concatenate() combines the two notes by appending the
  contents of the new note to the contents of the existing note.

- combine_notes_overwrite() replaces the existing note with the new note.

- combine_notes_ignore() keeps the existing note, and ignores the new note.

A combine_notes function can be passed to init_notes() to choose a default
combine_notes function for that notes tree. If NULL is given, the notes tree
falls back to combine_notes_concatenate() as the ultimate default.

A combine_notes function can also be passed directly to add_note(), to
control the notes combining behaviour for a note addition in particular.
If NULL is passed, the combine_notes function registered for the given
notes tree is used.

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |  132 +++++++++++++++++++++++++++++++++++---------------------------
 notes.h |   34 +++++++++++++++-
 2 files changed, 106 insertions(+), 60 deletions(-)

diff --git a/notes.c b/notes.c
index a5d9736..19ae492 100644
--- a/notes.c
+++ b/notes.c
@@ -127,55 +127,12 @@ static struct leaf_node *note_tree_find(struct int_node *tree, unsigned char n,
 	return NULL;
 }
 
-/* Create a new blob object by concatenating the two given blob objects */
-static int concatenate_notes(unsigned char *cur_sha1,
-		const unsigned char *new_sha1)
-{
-	char *cur_msg, *new_msg, *buf;
-	unsigned long cur_len, new_len, buf_len;
-	enum object_type cur_type, new_type;
-	int ret;
-
-	/* read in both note blob objects */
-	new_msg = read_sha1_file(new_sha1, &new_type, &new_len);
-	if (!new_msg || !new_len || new_type != OBJ_BLOB) {
-		free(new_msg);
-		return 0;
-	}
-	cur_msg = read_sha1_file(cur_sha1, &cur_type, &cur_len);
-	if (!cur_msg || !cur_len || cur_type != OBJ_BLOB) {
-		free(cur_msg);
-		free(new_msg);
-		hashcpy(cur_sha1, new_sha1);
-		return 0;
-	}
-
-	/* we will separate the notes by a newline anyway */
-	if (cur_msg[cur_len - 1] == '\n')
-		cur_len--;
-
-	/* concatenate cur_msg and new_msg into buf */
-	buf_len = cur_len + 1 + new_len;
-	buf = (char *) xmalloc(buf_len);
-	memcpy(buf, cur_msg, cur_len);
-	buf[cur_len] = '\n';
-	memcpy(buf + cur_len + 1, new_msg, new_len);
-
-	free(cur_msg);
-	free(new_msg);
-
-	/* create a new blob object from buf */
-	ret = write_sha1_file(buf, buf_len, "blob", cur_sha1);
-	free(buf);
-	return ret;
-}
-
 /*
  * To insert a leaf_node:
  * Search to the tree location appropriate for the given leaf_node's key:
  * - If location is unused (NULL), store the tweaked pointer directly there
  * - If location holds a note entry that matches the note-to-be-inserted, then
- *   concatenate the two notes.
+ *   combine the two notes (by calling the given combine_notes function).
  * - If location holds a note entry that matches the subtree-to-be-inserted,
  *   then unpack the subtree-to-be-inserted into the location.
  * - If location holds a matching subtree entry, unpack the subtree at that
@@ -184,7 +141,8 @@ static int concatenate_notes(unsigned char *cur_sha1,
  *   node-to-be-inserted, and store the new int_node into the location.
  */
 static void note_tree_insert(struct int_node *tree, unsigned char n,
-		struct leaf_node *entry, unsigned char type)
+		struct leaf_node *entry, unsigned char type,
+		combine_notes_fn combine_notes)
 {
 	struct int_node *new_node;
 	struct leaf_node *l;
@@ -205,12 +163,11 @@ static void note_tree_insert(struct int_node *tree, unsigned char n,
 				if (!hashcmp(l->val_sha1, entry->val_sha1))
 					return;
 
-				if (concatenate_notes(l->val_sha1,
-						entry->val_sha1))
-					die("failed to concatenate note %s "
-					    "into note %s for object %s",
-					    sha1_to_hex(entry->val_sha1),
+				if (combine_notes(l->val_sha1, entry->val_sha1))
+					die("failed to combine notes %s and %s"
+					    " for object %s",
 					    sha1_to_hex(l->val_sha1),
+					    sha1_to_hex(entry->val_sha1),
 					    sha1_to_hex(l->key_sha1));
 				free(entry);
 				return;
@@ -233,7 +190,7 @@ static void note_tree_insert(struct int_node *tree, unsigned char n,
 			*p = NULL;
 			load_subtree(l, tree, n);
 			free(l);
-			note_tree_insert(tree, n, entry, type);
+			note_tree_insert(tree, n, entry, type, combine_notes);
 			return;
 		}
 		break;
@@ -243,9 +200,9 @@ static void note_tree_insert(struct int_node *tree, unsigned char n,
 	assert(GET_PTR_TYPE(*p) == PTR_TYPE_NOTE ||
 	       GET_PTR_TYPE(*p) == PTR_TYPE_SUBTREE);
 	new_node = (struct int_node *) xcalloc(sizeof(struct int_node), 1);
-	note_tree_insert(new_node, n + 1, l, GET_PTR_TYPE(*p));
+	note_tree_insert(new_node, n + 1, l, GET_PTR_TYPE(*p), combine_notes);
 	*p = SET_PTR_TYPE(new_node, PTR_TYPE_INTERNAL);
-	note_tree_insert(new_node, n + 1, entry, type);
+	note_tree_insert(new_node, n + 1, entry, type, combine_notes);
 }
 
 /* Free the entire notes data contained in the given tree */
@@ -331,7 +288,8 @@ static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 				l->key_sha1[19] = (unsigned char) len;
 				type = PTR_TYPE_SUBTREE;
 			}
-			note_tree_insert(node, n, l, type);
+			note_tree_insert(node, n, l, type,
+					combine_notes_concatenate);
 		}
 	}
 	free(buf);
@@ -432,7 +390,59 @@ redo:
 	return 0;
 }
 
-void init_notes(struct notes_tree *t, const char *notes_ref, int flags)
+int combine_notes_concatenate(unsigned char *cur_sha1, const unsigned char *new_sha1)
+{
+	char *cur_msg, *new_msg, *buf;
+	unsigned long cur_len, new_len, buf_len;
+	enum object_type cur_type, new_type;
+	int ret;
+
+	/* read in both note blob objects */
+	new_msg = read_sha1_file(new_sha1, &new_type, &new_len);
+	if (!new_msg || !new_len || new_type != OBJ_BLOB) {
+		free(new_msg);
+		return 0;
+	}
+	cur_msg = read_sha1_file(cur_sha1, &cur_type, &cur_len);
+	if (!cur_msg || !cur_len || cur_type != OBJ_BLOB) {
+		free(cur_msg);
+		free(new_msg);
+		hashcpy(cur_sha1, new_sha1);
+		return 0;
+	}
+
+	/* we will separate the notes by a newline anyway */
+	if (cur_msg[cur_len - 1] == '\n')
+		cur_len--;
+
+	/* concatenate cur_msg and new_msg into buf */
+	buf_len = cur_len + 1 + new_len;
+	buf = (char *) xmalloc(buf_len);
+	memcpy(buf, cur_msg, cur_len);
+	buf[cur_len] = '\n';
+	memcpy(buf + cur_len + 1, new_msg, new_len);
+	free(cur_msg);
+	free(new_msg);
+
+	/* create a new blob object from buf */
+	ret = write_sha1_file(buf, buf_len, "blob", cur_sha1);
+	free(buf);
+	return ret;
+}
+
+int combine_notes_overwrite(unsigned char *cur_sha1, const unsigned char *new_sha1)
+{
+	hashcpy(cur_sha1, new_sha1);
+	return 0;
+}
+
+int combine_notes_ignore(unsigned char *cur_sha1, const unsigned char *new_sha1)
+{
+	return 0;
+}
+
+void init_notes(struct notes_tree *t, const char *notes_ref,
+		combine_notes_fn combine_notes, int flags)
 {
 	unsigned char sha1[20], object_sha1[20];
 	unsigned mode;
@@ -450,8 +460,12 @@ void init_notes(struct notes_tree *t, const char *notes_ref, int flags)
 			notes_ref = GIT_NOTES_DEFAULT_REF;
 	}
 
+	if (!combine_notes)
+		combine_notes = combine_notes_concatenate;
+
 	t->root = (struct int_node *) xcalloc(sizeof(struct int_node), 1);
 	t->ref = notes_ref ? xstrdup(notes_ref) : NULL;
+	t->combine_notes = combine_notes;
 	t->initialized = 1;
 
 	if (flags & NOTES_INIT_EMPTY || !notes_ref ||
@@ -465,17 +479,19 @@ void init_notes(struct notes_tree *t, const char *notes_ref, int flags)
 }
 
 void add_note(struct notes_tree *t, const unsigned char *object_sha1,
-		const unsigned char *note_sha1)
+		const unsigned char *note_sha1, combine_notes_fn combine_notes)
 {
 	struct leaf_node *l;
 
 	if (!t)
 		t = &default_tree;
 	assert(t->initialized);
+	if (!combine_notes)
+		combine_notes = t->combine_notes;
 	l = (struct leaf_node *) xmalloc(sizeof(struct leaf_node));
 	hashcpy(l->key_sha1, object_sha1);
 	hashcpy(l->val_sha1, note_sha1);
-	note_tree_insert(t->root, 0, l, PTR_TYPE_NOTE);
+	note_tree_insert(t->root, 0, l, PTR_TYPE_NOTE, combine_notes);
 }
 
 const unsigned char *get_note(struct notes_tree *t,
@@ -521,7 +537,7 @@ void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 	if (!t)
 		t = &default_tree;
 	if (!t->initialized)
-		init_notes(t, NULL, 0);
+		init_notes(t, NULL, NULL, 0);
 
 	sha1 = get_note(t, object_sha1);
 	if (!sha1)
diff --git a/notes.h b/notes.h
index ea1235f..047a282 100644
--- a/notes.h
+++ b/notes.h
@@ -2,6 +2,30 @@
 #define NOTES_H
 
 /*
+ * Function type for combining two notes annotating the same object.
+ *
+ * When adding a new note annotating the same object as an existing note, it is
+ * up to the caller to decide how to combine the two notes. The decision is
+ * made by passing in a function of the following form. The function accepts
+ * two SHA1s -- of the existing note and the new note, respectively. The
+ * function then combines the notes in whatever way it sees fit, and writes the
+ * resulting SHA1 into the first SHA1 argument (cur_sha1). A non-zero return
+ * value indicates failure.
+ *
+ * The two given SHA1s are guaranteed to be non-NULL and different.
+ *
+ * The default combine_notes function (you get this when passing NULL) is
+ * combine_notes_concatenate(), which appends the contents of the new note to
+ * the contents of the existing note.
+ */
+typedef int combine_notes_fn(unsigned char *cur_sha1, const unsigned char *new_sha1);
+
+/* Common notes combinators */
+int combine_notes_concatenate(unsigned char *cur_sha1, const unsigned char *new_sha1);
+int combine_notes_overwrite(unsigned char *cur_sha1, const unsigned char *new_sha1);
+int combine_notes_ignore(unsigned char *cur_sha1, const unsigned char *new_sha1);
+
+/*
  * Notes tree object
  *
  * Encapsulates the internal notes tree structure associated with a notes ref.
@@ -13,6 +37,7 @@
 struct notes_tree {
 	struct int_node *root;
 	char *ref;
+	combine_notes_fn *combine_notes;
 	int initialized;
 };
 
@@ -36,14 +61,19 @@ struct notes_tree {
  *
  * If you pass t == NULL, the default internal notes_tree will be initialized.
  *
+ * The combine_notes function that is passed becomes the default combine_notes
+ * function for the given notes_tree. If NULL is passed, the default
+ * combine_notes function is combine_notes_concatenate().
+ *
  * Precondition: The notes_tree structure is zeroed (this can be achieved with
  * memset(t, 0, sizeof(struct notes_tree)))
  */
-void init_notes(struct notes_tree *t, const char *notes_ref, int flags);
+void init_notes(struct notes_tree *t, const char *notes_ref,
+		combine_notes_fn combine_notes, int flags);
 
 /* Add the given note object to the given notes_tree structure */
 void add_note(struct notes_tree *t, const unsigned char *object_sha1,
-		const unsigned char *note_sha1);
+		const unsigned char *note_sha1, combine_notes_fn combine_notes);
 
 /* Get the note object SHA1 containing the note data for the given object */
 const unsigned char *get_note(struct notes_tree *t,
-- 
1.6.4.304.g1365c.dirty

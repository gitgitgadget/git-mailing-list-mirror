From: Johan Herland <johan@herland.net>
Subject: [PATCHv11 10/20] Notes API: Allow multiple concurrent notes trees with
 new struct notes_tree
Date: Sun, 17 Jan 2010 22:04:27 +0100
Message-ID: <1263762277-31419-11-git-send-email-johan@herland.net>
References: <1263762277-31419-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 17 22:05:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWcJZ-0007Cz-7G
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 22:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790Ab0AQVFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 16:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754776Ab0AQVFP
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 16:05:15 -0500
Received: from smtp.getmail.no ([84.208.15.66]:56320 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754773Ab0AQVFM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jan 2010 16:05:12 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE002K2T8NY850@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:05:11 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE00CILT85S310@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:05:11 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.17.205416
X-Mailer: git-send-email 1.6.6.rc1.321.g0496e
In-reply-to: <1263762277-31419-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137325>

The new struct notes_tree encapsulates access to a specific notes tree.
It is provided to allow callers to make use of several different notes trees
simultaneously.

A struct notes_tree * parameter is added to every function in the notes API.
In all cases, NULL can be passed, in which case the fallback "default" notes
tree (default_notes_tree) is used.

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c  |   90 ++++++++++++++++++++++++++++++++++++++-----------------------
 notes.h  |   81 +++++++++++++++++++++++++++++++++++--------------------
 pretty.c |    7 +++--
 3 files changed, 112 insertions(+), 66 deletions(-)

diff --git a/notes.c b/notes.c
index 159e2c6..1cac4ef 100644
--- a/notes.c
+++ b/notes.c
@@ -50,9 +50,7 @@ struct leaf_node {
 #define SUBTREE_SHA1_PREFIXCMP(key_sha1, subtree_sha1) \
 	(memcmp(key_sha1, subtree_sha1, subtree_sha1[19]))
 
-static struct int_node root_node;
-
-static int initialized;
+struct notes_tree default_notes_tree;
 
 static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 		unsigned int n);
@@ -287,8 +285,8 @@ static int note_tree_consolidate(struct int_node *tree,
  * - Replace the matching leaf_node with a NULL entry (and free the leaf_node).
  * - Consolidate int_nodes repeatedly, while walking up the tree towards root.
  */
-static void note_tree_remove(struct int_node *tree, unsigned char n,
-		struct leaf_node *entry)
+static void note_tree_remove(struct notes_tree *t, struct int_node *tree,
+		unsigned char n, struct leaf_node *entry)
 {
 	struct leaf_node *l;
 	struct int_node *parent_stack[20];
@@ -310,7 +308,7 @@ static void note_tree_remove(struct int_node *tree, unsigned char n,
 	if (!n)
 		return; /* cannot consolidate top level */
 	/* first, build stack of ancestors between root and current node */
-	parent_stack[0] = &root_node;
+	parent_stack[0] = t->root;
 	for (i = 0; i < n; i++) {
 		j = GET_NIBBLE(i, entry->key_sha1);
 		parent_stack[i + 1] = CLR_PTR_TYPE(parent_stack[i]->a[j]);
@@ -659,14 +657,15 @@ static int write_each_note(const unsigned char *object_sha1,
 	return write_each_note_helper(d->root, note_path, mode, note_sha1);
 }
 
-void init_notes(const char *notes_ref, int flags)
+void init_notes(struct notes_tree *t, const char *notes_ref, int flags)
 {
 	unsigned char sha1[20], object_sha1[20];
 	unsigned mode;
 	struct leaf_node root_tree;
 
-	assert(!initialized);
-	initialized = 1;
+	if (!t)
+		t = &default_notes_tree;
+	assert(!t->initialized);
 
 	if (!notes_ref)
 		notes_ref = getenv(GIT_NOTES_REF_ENVIRONMENT);
@@ -675,6 +674,10 @@ void init_notes(const char *notes_ref, int flags)
 	if (!notes_ref)
 		notes_ref = GIT_NOTES_DEFAULT_REF;
 
+	t->root = (struct int_node *) xcalloc(sizeof(struct int_node), 1);
+	t->ref = notes_ref ? xstrdup(notes_ref) : NULL;
+	t->initialized = 1;
+
 	if (flags & NOTES_INIT_EMPTY || !notes_ref ||
 	    read_ref(notes_ref, object_sha1))
 		return;
@@ -684,52 +687,65 @@ void init_notes(const char *notes_ref, int flags)
 
 	hashclr(root_tree.key_sha1);
 	hashcpy(root_tree.val_sha1, sha1);
-	load_subtree(&root_tree, &root_node, 0);
+	load_subtree(&root_tree, t->root, 0);
 }
 
-void add_note(const unsigned char *object_sha1, const unsigned char *note_sha1)
+void add_note(struct notes_tree *t, const unsigned char *object_sha1,
+		const unsigned char *note_sha1)
 {
 	struct leaf_node *l;
 
-	assert(initialized);
+	if (!t)
+		t = &default_notes_tree;
+	assert(t->initialized);
 	l = (struct leaf_node *) xmalloc(sizeof(struct leaf_node));
 	hashcpy(l->key_sha1, object_sha1);
 	hashcpy(l->val_sha1, note_sha1);
-	note_tree_insert(&root_node, 0, l, PTR_TYPE_NOTE);
+	note_tree_insert(t->root, 0, l, PTR_TYPE_NOTE);
 }
 
-void remove_note(const unsigned char *object_sha1)
+void remove_note(struct notes_tree *t, const unsigned char *object_sha1)
 {
 	struct leaf_node l;
 
-	assert(initialized);
+	if (!t)
+		t = &default_notes_tree;
+	assert(t->initialized);
 	hashcpy(l.key_sha1, object_sha1);
 	hashclr(l.val_sha1);
-	return note_tree_remove(&root_node, 0, &l);
+	return note_tree_remove(t, t->root, 0, &l);
 }
 
-const unsigned char *get_note(const unsigned char *object_sha1)
+const unsigned char *get_note(struct notes_tree *t,
+		const unsigned char *object_sha1)
 {
 	struct leaf_node *found;
 
-	assert(initialized);
-	found = note_tree_find(&root_node, 0, object_sha1);
+	if (!t)
+		t = &default_notes_tree;
+	assert(t->initialized);
+	found = note_tree_find(t->root, 0, object_sha1);
 	return found ? found->val_sha1 : NULL;
 }
 
-int for_each_note(int flags, each_note_fn fn, void *cb_data)
+int for_each_note(struct notes_tree *t, int flags, each_note_fn fn,
+		void *cb_data)
 {
-	assert(initialized);
-	return for_each_note_helper(&root_node, 0, 0, flags, fn, cb_data);
+	if (!t)
+		t = &default_notes_tree;
+	assert(t->initialized);
+	return for_each_note_helper(t->root, 0, 0, flags, fn, cb_data);
 }
 
-int write_notes_tree(unsigned char *result)
+int write_notes_tree(struct notes_tree *t, unsigned char *result)
 {
 	struct tree_write_stack root;
 	struct write_each_note_data cb_data;
 	int ret;
 
-	assert(initialized);
+	if (!t)
+		t = &default_notes_tree;
+	assert(t->initialized);
 
 	/* Prepare for traversal of current notes tree */
 	root.next = NULL; /* last forward entry in list is grounded */
@@ -738,7 +754,7 @@ int write_notes_tree(unsigned char *result)
 	cb_data.root = &root;
 
 	/* Write tree objects representing current notes tree */
-	ret = for_each_note(FOR_EACH_NOTE_DONT_UNPACK_SUBTREES |
+	ret = for_each_note(t, FOR_EACH_NOTE_DONT_UNPACK_SUBTREES |
 				FOR_EACH_NOTE_YIELD_SUBTREES,
 			write_each_note, &cb_data) ||
 		tree_write_stack_finish_subtree(&root) ||
@@ -747,15 +763,19 @@ int write_notes_tree(unsigned char *result)
 	return ret;
 }
 
-void free_notes(void)
+void free_notes(struct notes_tree *t)
 {
-	note_tree_free(&root_node);
-	memset(&root_node, 0, sizeof(struct int_node));
-	initialized = 0;
+	if (!t)
+		t = &default_notes_tree;
+	if (t->root)
+		note_tree_free(t->root);
+	free(t->root);
+	free(t->ref);
+	memset(t, 0, sizeof(struct notes_tree));
 }
 
-void format_note(const unsigned char *object_sha1, struct strbuf *sb,
-		const char *output_encoding, int flags)
+void format_note(struct notes_tree *t, const unsigned char *object_sha1,
+		struct strbuf *sb, const char *output_encoding, int flags)
 {
 	static const char utf8[] = "utf-8";
 	const unsigned char *sha1;
@@ -763,10 +783,12 @@ void format_note(const unsigned char *object_sha1, struct strbuf *sb,
 	unsigned long linelen, msglen;
 	enum object_type type;
 
-	if (!initialized)
-		init_notes(NULL, 0);
+	if (!t)
+		t = &default_notes_tree;
+	if (!t->initialized)
+		init_notes(t, NULL, 0);
 
-	sha1 = get_note(object_sha1);
+	sha1 = get_note(t, object_sha1);
 	if (!sha1)
 		return;
 
diff --git a/notes.h b/notes.h
index ebc301c..a599a0d 100644
--- a/notes.h
+++ b/notes.h
@@ -2,6 +2,21 @@
 #define NOTES_H
 
 /*
+ * Notes tree object
+ *
+ * Encapsulates the internal notes tree structure associated with a notes ref.
+ * Whenever a struct notes_tree pointer is required below, you may pass NULL in
+ * order to use the default/internal notes tree. E.g. you only need to pass a
+ * non-NULL value if you need to refer to several different notes trees
+ * simultaneously.
+ */
+extern struct notes_tree {
+	struct int_node *root;
+	char *ref;
+	int initialized;
+} default_notes_tree;
+
+/*
  * Flags controlling behaviour of notes tree initialization
  *
  * Default behaviour is to initialize the notes tree from the tree object
@@ -10,44 +25,50 @@
 #define NOTES_INIT_EMPTY 1
 
 /*
- * Initialize internal notes tree structure with the notes tree at the given
+ * Initialize the given notes_tree with the notes tree structure at the given
  * ref. If given ref is NULL, the value of the $GIT_NOTES_REF environment
  * variable is used, and if that is missing, the default notes ref is used
  * ("refs/notes/commits").
  *
- * If you need to re-intialize the internal notes tree structure (e.g. loading
- * from a different notes ref), please first de-initialize the current notes
- * tree by calling free_notes().
+ * If you need to re-intialize a notes_tree structure (e.g. when switching from
+ * one notes ref to another), you must first de-initialize the notes_tree
+ * structure by calling free_notes(struct notes_tree *).
+ *
+ * If you pass t == NULL, the default internal notes_tree will be initialized.
+ *
+ * Precondition: The notes_tree structure is zeroed (this can be achieved with
+ * memset(t, 0, sizeof(struct notes_tree)))
  */
-void init_notes(const char *notes_ref, int flags);
+void init_notes(struct notes_tree *t, const char *notes_ref, int flags);
 
 /*
- * Add the given note object to the internal notes tree structure
+ * Add the given note object to the given notes_tree structure
  *
- * IMPORTANT: The changes made by add_note() to the internal notes tree structure
+ * IMPORTANT: The changes made by add_note() to the given notes_tree structure
  * are not persistent until a subsequent call to write_notes_tree() returns
  * zero.
  */
-void add_note(const unsigned char *object_sha1,
+void add_note(struct notes_tree *t, const unsigned char *object_sha1,
 		const unsigned char *note_sha1);
 
 /*
- * Remove the given note object from the internal notes tree structure
+ * Remove the given note object from the given notes_tree structure
  *
- * IMPORTANT: The changes made by remove_note() to the internal notes tree
+ * IMPORTANT: The changes made by remove_note() to the given notes_tree
  * structure are not persistent until a subsequent call to write_notes_tree()
  * returns zero.
  */
-void remove_note(const unsigned char *object_sha1);
+void remove_note(struct notes_tree *t, const unsigned char *object_sha1);
 
 /* Get the note object SHA1 containing the note data for the given object */
-const unsigned char *get_note(const unsigned char *object_sha1);
+const unsigned char *get_note(struct notes_tree *t,
+		const unsigned char *object_sha1);
 
 /*
  * Flags controlling behaviour of for_each_note()
  *
  * Default behaviour of for_each_note() is to traverse every single note object
- * in the notes tree, unpacking subtree entries along the way.
+ * in the given notes tree, unpacking subtree entries along the way.
  * The following flags can be used to alter the default behaviour:
  *
  * - DONT_UNPACK_SUBTREES causes for_each_note() NOT to unpack and recurse into
@@ -71,7 +92,7 @@ const unsigned char *get_note(const unsigned char *object_sha1);
 #define FOR_EACH_NOTE_YIELD_SUBTREES 2
 
 /*
- * Invoke the specified callback function for each note
+ * Invoke the specified callback function for each note in the given notes_tree
  *
  * If the callback returns nonzero, the note walk is aborted, and the return
  * value from the callback is returned from for_each_note(). Hence, a zero
@@ -88,30 +109,30 @@ const unsigned char *get_note(const unsigned char *object_sha1);
 typedef int each_note_fn(const unsigned char *object_sha1,
 		const unsigned char *note_sha1, char *note_path,
 		void *cb_data);
-int for_each_note(int flags, each_note_fn fn, void *cb_data);
+int for_each_note(struct notes_tree *t, int flags, each_note_fn fn,
+		void *cb_data);
 
 /*
- * Write the internal notes tree structure to the object database
+ * Write the given notes_tree structure to the object database
  *
- * Creates a new tree object encapsulating the current state of the
- * internal notes tree, and stores its SHA1 into the 'result' argument.
+ * Creates a new tree object encapsulating the current state of the given
+ * notes_tree, and stores its SHA1 into the 'result' argument.
  *
  * Returns zero on success, non-zero on failure.
  *
- * IMPORTANT: Changes made to the internal notes tree structure are not
- * persistent until this function has returned zero. Please also remember
- * to create a corresponding commit object, and update the appropriate
- * notes ref.
+ * IMPORTANT: Changes made to the given notes_tree are not persistent until
+ * this function has returned zero. Please also remember to create a
+ * corresponding commit object, and update the appropriate notes ref.
  */
-int write_notes_tree(unsigned char *result);
+int write_notes_tree(struct notes_tree *t, unsigned char *result);
 
 /*
- * Free (and de-initialize) the internal notes tree structure
+ * Free (and de-initialize) the given notes_tree structure
  *
- * IMPORTANT: Changes made to the notes tree since the last, successful
+ * IMPORTANT: Changes made to the given notes_tree since the last, successful
  * call to write_notes_tree() will be lost.
  */
-void free_notes(void);
+void free_notes(struct notes_tree *t);
 
 /* Flags controlling how notes are formatted */
 #define NOTES_SHOW_HEADER 1
@@ -120,12 +141,14 @@ void free_notes(void);
 /*
  * Fill the given strbuf with the notes associated with the given object.
  *
- * If the internal notes structure is not initialized, it will be auto-
+ * If the given notes_tree structure is not initialized, it will be auto-
  * initialized to the default value (see documentation for init_notes() above).
+ * If the given notes_tree is NULL, the internal/default notes_tree will be
+ * used instead.
  *
  * 'flags' is a bitwise combination of the above formatting flags.
  */
-void format_note(const unsigned char *object_sha1, struct strbuf *sb,
-		const char *output_encoding, int flags);
+void format_note(struct notes_tree *t, const unsigned char *object_sha1,
+		struct strbuf *sb, const char *output_encoding, int flags);
 
 #endif
diff --git a/pretty.c b/pretty.c
index fe77090..b4882cc 100644
--- a/pretty.c
+++ b/pretty.c
@@ -775,8 +775,9 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 		}
 		return 0;	/* unknown %g placeholder */
 	case 'N':
-		format_note(commit->object.sha1, sb, git_log_output_encoding ?
-			    git_log_output_encoding : git_commit_encoding, 0);
+		format_note(NULL, commit->object.sha1, sb,
+			    git_log_output_encoding ? git_log_output_encoding
+						    : git_commit_encoding, 0);
 		return 1;
 	}
 
@@ -1095,7 +1096,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 		strbuf_addch(sb, '\n');
 
 	if (fmt != CMIT_FMT_ONELINE)
-		format_note(commit->object.sha1, sb, encoding,
+		format_note(NULL, commit->object.sha1, sb, encoding,
 			    NOTES_SHOW_HEADER | NOTES_INDENT);
 
 	free(reencoded);
-- 
1.6.6.rc1.321.g0496e

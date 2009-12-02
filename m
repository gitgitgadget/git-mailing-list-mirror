From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv9 10/11] Notes API: Allow multiple concurrent notes trees
 with new struct notes_tree
Date: Wed, 02 Dec 2009 03:09:42 +0100
Message-ID: <1259719783-4674-11-git-send-email-johan@herland.net>
References: <1259719783-4674-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 03:10:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFeg5-0005jA-AC
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 03:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755076AbZLBCKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 21:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755053AbZLBCKg
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 21:10:36 -0500
Received: from smtp.getmail.no ([84.208.15.66]:44317 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755032AbZLBCKb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 21:10:31 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KU000GWN61PEG10@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Dec 2009 03:10:37 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KU000JVB60NVI30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Dec 2009 03:10:37 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.2.15716
X-Mailer: git-send-email 1.6.5.3.433.g11067
In-reply-to: <1259719783-4674-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134290>

The new struct notes_tree encapsulates access to a specific notes tree.
It is provided to allow callers to interface with several different notes
trees simultaneously.

A struct notes_tree * parameter is added to every function in the notes API.
In all cases, NULL can be passed, in which case, a fallback "default" notes
tree (declared in notes.c) is used.

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c  |   67 ++++++++++++++++++++++++++++++++++++++-----------------------
 notes.h  |   53 +++++++++++++++++++++++++++++++++++-------------
 pretty.c |    7 +++--
 3 files changed, 84 insertions(+), 43 deletions(-)

diff --git a/notes.c b/notes.c
index 0d8ff2c..3f96ee6 100644
--- a/notes.c
+++ b/notes.c
@@ -50,9 +50,7 @@ struct leaf_node {
 #define SUBTREE_SHA1_PREFIXCMP(key_sha1, subtree_sha1) \
 	(memcmp(key_sha1, subtree_sha1, subtree_sha1[19]))
 
-static struct int_node root_node;
-
-static int initialized;
+static struct notes_tree default_tree;
 
 static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 		unsigned int n);
@@ -434,14 +432,15 @@ redo:
 	return 0;
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
+		t = &default_tree;
+	assert(!t->initialized);
 
 	if (!notes_ref) {
 		const char *env = getenv(GIT_NOTES_REF_ENVIRONMENT);
@@ -451,6 +450,10 @@ void init_notes(const char *notes_ref, int flags)
 			notes_ref = GIT_NOTES_DEFAULT_REF;
 	}
 
+	t->root = (struct int_node *) xcalloc(sizeof(struct int_node), 1);
+	t->ref = notes_ref ? xstrdup(notes_ref) : NULL;
+	t->initialized = 1;
+
 	if (flags & NOTES_INIT_EMPTY || !notes_ref ||
 	    read_ref(notes_ref, object_sha1) ||
 	    get_tree_entry(object_sha1, "", sha1, &mode))
@@ -458,44 +461,56 @@ void init_notes(const char *notes_ref, int flags)
 
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
+		t = &default_tree;
+	assert(t->initialized);
 	l = (struct leaf_node *) xmalloc(sizeof(struct leaf_node));
 	hashcpy(l->key_sha1, object_sha1);
 	hashcpy(l->val_sha1, note_sha1);
-	note_tree_insert(&root_node, 0, l, PTR_TYPE_NOTE);
+	note_tree_insert(t->root, 0, l, PTR_TYPE_NOTE);
 }
 
-const unsigned char *get_note(const unsigned char *object_sha1)
+const unsigned char *get_note(struct notes_tree *t,
+		const unsigned char *object_sha1)
 {
 	struct leaf_node *found;
 
-	assert(initialized);
-	found = note_tree_find(&root_node, 0, object_sha1);
+	if (!t)
+		t = &default_tree;
+	assert(t->initialized);
+	found = note_tree_find(t->root, 0, object_sha1);
 	return found ? found->val_sha1 : NULL;
 }
 
-int for_each_note(each_note_fn fn, void *cb_data)
+int for_each_note(struct notes_tree *t, each_note_fn fn, void *cb_data)
 {
-	assert(initialized);
-	return for_each_note_helper(&root_node, 0, 0, fn, cb_data);
+	if (!t)
+		t = &default_tree;
+	assert(t->initialized);
+	return for_each_note_helper(t->root, 0, 0, fn, cb_data);
 }
 
-void free_notes(void)
+void free_notes(struct notes_tree *t)
 {
-	note_tree_free(&root_node);
-	memset(&root_node, 0, sizeof(struct int_node));
-	initialized = 0;
+	if (!t)
+		t = &default_tree;
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
@@ -503,10 +518,12 @@ void format_note(const unsigned char *object_sha1, struct strbuf *sb,
 	unsigned long linelen, msglen;
 	enum object_type type;
 
-	if (!initialized)
-		init_notes(NULL, 0);
+	if (!t)
+		t = &default_tree;
+	if (!t->initialized)
+		init_notes(t, NULL, 0);
 
-	sha1 = get_note(object_sha1);
+	sha1 = get_note(t, object_sha1);
 	if (!sha1)
 		return;
 
diff --git a/notes.h b/notes.h
index f67bae8..ea1235f 100644
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
+struct notes_tree {
+	struct int_node *root;
+	char *ref;
+	int initialized;
+};
+
+/*
  * Flags controlling behaviour of notes tree initialization
  *
  * Default behaviour is to initialize the notes tree from the tree object
@@ -10,26 +25,32 @@
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
 
-/* Add the given note object to the internal notes tree structure */
-void add_note(const unsigned char *object_sha1,
+/* Add the given note object to the given notes_tree structure */
+void add_note(struct notes_tree *t, const unsigned char *object_sha1,
 		const unsigned char *note_sha1);
 
 /* Get the note object SHA1 containing the note data for the given object */
-const unsigned char *get_note(const unsigned char *object_sha1);
+const unsigned char *get_note(struct notes_tree *t,
+		const unsigned char *object_sha1);
 
 /*
- * Invoke the specified callback function for each note
+ * Invoke the specified callback function for each note in the given notes_tree
  *
  * If the callback returns nonzero, the note walk is aborted, and the return
  * value from the callback is returned from for_each_note().
@@ -43,10 +64,10 @@ const unsigned char *get_note(const unsigned char *object_sha1);
 typedef int each_note_fn(const unsigned char *object_sha1,
 		const unsigned char *note_sha1, const char *note_tree_path,
 		void *cb_data);
-int for_each_note(each_note_fn fn, void *cb_data);
+int for_each_note(struct notes_tree *t, each_note_fn fn, void *cb_data);
 
-/* Free (and de-initialize) the internal notes tree structure */
-void free_notes(void);
+/* Free (and de-initialize) the give notes_tree structure */
+void free_notes(struct notes_tree *t);
 
 /* Flags controlling how notes are formatted */
 #define NOTES_SHOW_HEADER 1
@@ -55,12 +76,14 @@ void free_notes(void);
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
index 81791f5..047dbb8 100644
--- a/pretty.c
+++ b/pretty.c
@@ -703,8 +703,9 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 		format_decoration(sb, commit);
 		return 1;
 	case 'N':
-		format_note(commit->object.sha1, sb, git_log_output_encoding ?
-			    git_log_output_encoding : git_commit_encoding, 0);
+		format_note(NULL, commit->object.sha1, sb,
+			    git_log_output_encoding ? git_log_output_encoding
+						    : git_commit_encoding, 0);
 		return 1;
 	}
 
@@ -982,7 +983,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 		strbuf_addch(sb, '\n');
 
 	if (fmt != CMIT_FMT_ONELINE)
-		format_note(commit->object.sha1, sb, encoding,
+		format_note(NULL, commit->object.sha1, sb, encoding,
 			    NOTES_SHOW_HEADER | NOTES_INDENT);
 
 	free(reencoded);
-- 
1.6.5.3.433.g11067

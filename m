From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 15/30] Teach notes code to properly preserve non-notes in
 the notes tree
Date: Sat, 13 Feb 2010 22:28:23 +0100
Message-ID: <1266096518-2104-16-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:30:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPZF-0001iD-RJ
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758106Ab0BMV3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:29:42 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62362 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757940Ab0BMV3d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:29:33 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00FJYUD65490@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:30 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:30 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211545
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139844>

The note tree structure allows for non-note entries to coexist with note
entries in a notes tree. Although we certainly expect there to be very
few non-notes in a notes tree, we should still support them to a certain
degree.

This patch teaches the notes code to preserve non-notes when updating the
notes tree with write_notes_tree(). Non-notes are not affected by fanout
restructuring.

For non-notes to be handled correctly, we can no longer allow subtree
entries that do not match the fanout structure produced by the notes code
itself. This means that fanouts like 4/36, 6/34, 8/32, 4/4/32, etc. are
no longer recognized as note subtrees; only 2-based fanouts are allowed
(2/38, 2/2/36, 2/2/2/34, etc.). Since the notes code has never at any point
_produced_ non-2-based fanouts, it is highly unlikely that this change will
cause problems for anyone.

The patch also adds some tests verifying the correct handling of non-notes
in a notes tree.

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c                   |  219 +++++++++++++++++++++++++++++++++++++--------
 notes.h                   |    1 +
 t/t3303-notes-subtrees.sh |   28 ++++---
 t/t3304-notes-mixed.sh    |   36 +++++++-
 4 files changed, 233 insertions(+), 51 deletions(-)

diff --git a/notes.c b/notes.c
index dc4e4f6..d432517 100644
--- a/notes.c
+++ b/notes.c
@@ -37,6 +37,21 @@ struct leaf_node {
 	unsigned char val_sha1[20];
 };
 
+/*
+ * A notes tree may contain entries that are not notes, and that do not follow
+ * the naming conventions of notes. There are typically none/few of these, but
+ * we still need to keep track of them. Keep a simple linked list sorted alpha-
+ * betically on the non-note path. The list is populated when parsing tree
+ * objects in load_subtree(), and the non-notes are correctly written back into
+ * the tree objects produced by write_notes_tree().
+ */
+struct non_note {
+	struct non_note *next; /* grounded (last->next == NULL) */
+	char *path;
+	unsigned int mode;
+	unsigned char sha1[20];
+};
+
 #define PTR_TYPE_NULL     0
 #define PTR_TYPE_INTERNAL 1
 #define PTR_TYPE_NOTE     2
@@ -53,8 +68,8 @@ struct leaf_node {
 
 struct notes_tree default_notes_tree;
 
-static void load_subtree(struct leaf_node *subtree, struct int_node *node,
-		unsigned int n);
+static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
+		struct int_node *node, unsigned int n);
 
 /*
  * Search the tree until the appropriate location for the given key is found:
@@ -71,7 +86,7 @@ static void load_subtree(struct leaf_node *subtree, struct int_node *node,
  *      - an unused leaf node (NULL)
  *      In any case, set *tree and *n, and return pointer to the tree location.
  */
-static void **note_tree_search(struct int_node **tree,
+static void **note_tree_search(struct notes_tree *t, struct int_node **tree,
 		unsigned char *n, const unsigned char *key_sha1)
 {
 	struct leaf_node *l;
@@ -83,9 +98,9 @@ static void **note_tree_search(struct int_node **tree,
 		if (!SUBTREE_SHA1_PREFIXCMP(key_sha1, l->key_sha1)) {
 			/* unpack tree and resume search */
 			(*tree)->a[0] = NULL;
-			load_subtree(l, *tree, *n);
+			load_subtree(t, l, *tree, *n);
 			free(l);
-			return note_tree_search(tree, n, key_sha1);
+			return note_tree_search(t, tree, n, key_sha1);
 		}
 	}
 
@@ -95,15 +110,15 @@ static void **note_tree_search(struct int_node **tree,
 	case PTR_TYPE_INTERNAL:
 		*tree = CLR_PTR_TYPE(p);
 		(*n)++;
-		return note_tree_search(tree, n, key_sha1);
+		return note_tree_search(t, tree, n, key_sha1);
 	case PTR_TYPE_SUBTREE:
 		l = (struct leaf_node *) CLR_PTR_TYPE(p);
 		if (!SUBTREE_SHA1_PREFIXCMP(key_sha1, l->key_sha1)) {
 			/* unpack tree and resume search */
 			(*tree)->a[i] = NULL;
-			load_subtree(l, *tree, *n);
+			load_subtree(t, l, *tree, *n);
 			free(l);
-			return note_tree_search(tree, n, key_sha1);
+			return note_tree_search(t, tree, n, key_sha1);
 		}
 		/* fall through */
 	default:
@@ -116,10 +131,11 @@ static void **note_tree_search(struct int_node **tree,
  * Search to the tree location appropriate for the given key:
  * If a note entry with matching key, return the note entry, else return NULL.
  */
-static struct leaf_node *note_tree_find(struct int_node *tree, unsigned char n,
+static struct leaf_node *note_tree_find(struct notes_tree *t,
+		struct int_node *tree, unsigned char n,
 		const unsigned char *key_sha1)
 {
-	void **p = note_tree_search(&tree, &n, key_sha1);
+	void **p = note_tree_search(t, &tree, &n, key_sha1);
 	if (GET_PTR_TYPE(*p) == PTR_TYPE_NOTE) {
 		struct leaf_node *l = (struct leaf_node *) CLR_PTR_TYPE(*p);
 		if (!hashcmp(key_sha1, l->key_sha1))
@@ -141,13 +157,13 @@ static struct leaf_node *note_tree_find(struct int_node *tree, unsigned char n,
  * - Else, create a new int_node, holding both the node-at-location and the
  *   node-to-be-inserted, and store the new int_node into the location.
  */
-static void note_tree_insert(struct int_node *tree, unsigned char n,
-		struct leaf_node *entry, unsigned char type,
+static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
+		unsigned char n, struct leaf_node *entry, unsigned char type,
 		combine_notes_fn combine_notes)
 {
 	struct int_node *new_node;
 	struct leaf_node *l;
-	void **p = note_tree_search(&tree, &n, entry->key_sha1);
+	void **p = note_tree_search(t, &tree, &n, entry->key_sha1);
 
 	assert(GET_PTR_TYPE(entry) == 0); /* no type bits set */
 	l = (struct leaf_node *) CLR_PTR_TYPE(*p);
@@ -178,7 +194,7 @@ static void note_tree_insert(struct int_node *tree, unsigned char n,
 			if (!SUBTREE_SHA1_PREFIXCMP(l->key_sha1,
 						    entry->key_sha1)) {
 				/* unpack 'entry' */
-				load_subtree(entry, tree, n);
+				load_subtree(t, entry, tree, n);
 				free(entry);
 				return;
 			}
@@ -189,9 +205,10 @@ static void note_tree_insert(struct int_node *tree, unsigned char n,
 		if (!SUBTREE_SHA1_PREFIXCMP(entry->key_sha1, l->key_sha1)) {
 			/* unpack 'l' and restart insert */
 			*p = NULL;
-			load_subtree(l, tree, n);
+			load_subtree(t, l, tree, n);
 			free(l);
-			note_tree_insert(tree, n, entry, type, combine_notes);
+			note_tree_insert(t, tree, n, entry, type,
+					 combine_notes);
 			return;
 		}
 		break;
@@ -201,9 +218,10 @@ static void note_tree_insert(struct int_node *tree, unsigned char n,
 	assert(GET_PTR_TYPE(*p) == PTR_TYPE_NOTE ||
 	       GET_PTR_TYPE(*p) == PTR_TYPE_SUBTREE);
 	new_node = (struct int_node *) xcalloc(sizeof(struct int_node), 1);
-	note_tree_insert(new_node, n + 1, l, GET_PTR_TYPE(*p), combine_notes);
+	note_tree_insert(t, new_node, n + 1, l, GET_PTR_TYPE(*p),
+			 combine_notes);
 	*p = SET_PTR_TYPE(new_node, PTR_TYPE_INTERNAL);
-	note_tree_insert(new_node, n + 1, entry, type, combine_notes);
+	note_tree_insert(t, new_node, n + 1, entry, type, combine_notes);
 }
 
 /*
@@ -249,7 +267,7 @@ static void note_tree_remove(struct notes_tree *t, struct int_node *tree,
 	struct leaf_node *l;
 	struct int_node *parent_stack[20];
 	unsigned char i, j;
-	void **p = note_tree_search(&tree, &n, entry->key_sha1);
+	void **p = note_tree_search(t, &tree, &n, entry->key_sha1);
 
 	assert(GET_PTR_TYPE(entry) == 0); /* no type bits set */
 	if (GET_PTR_TYPE(*p) != PTR_TYPE_NOTE)
@@ -324,14 +342,67 @@ static int get_sha1_hex_segment(const char *hex, unsigned int hex_len,
 	return len;
 }
 
-static void load_subtree(struct leaf_node *subtree, struct int_node *node,
-		unsigned int n)
+static int non_note_cmp(const struct non_note *a, const struct non_note *b)
+{
+	return strcmp(a->path, b->path);
+}
+
+static void add_non_note(struct notes_tree *t, const char *path,
+		unsigned int mode, const unsigned char *sha1)
+{
+	struct non_note *p = t->prev_non_note, *n;
+	n = (struct non_note *) xmalloc(sizeof(struct non_note));
+	n->next = NULL;
+	n->path = xstrdup(path);
+	n->mode = mode;
+	hashcpy(n->sha1, sha1);
+	t->prev_non_note = n;
+
+	if (!t->first_non_note) {
+		t->first_non_note = n;
+		return;
+	}
+
+	if (non_note_cmp(p, n) < 0)
+		; /* do nothing  */
+	else if (non_note_cmp(t->first_non_note, n) <= 0)
+		p = t->first_non_note;
+	else {
+		/* n sorts before t->first_non_note */
+		n->next = t->first_non_note;
+		t->first_non_note = n;
+		return;
+	}
+
+	/* n sorts equal or after p */
+	while (p->next && non_note_cmp(p->next, n) <= 0)
+		p = p->next;
+
+	if (non_note_cmp(p, n) == 0) { /* n ~= p; overwrite p with n */
+		assert(strcmp(p->path, n->path) == 0);
+		p->mode = n->mode;
+		hashcpy(p->sha1, n->sha1);
+		free(n);
+		t->prev_non_note = p;
+		return;
+	}
+
+	/* n sorts between p and p->next */
+	n->next = p->next;
+	p->next = n;
+}
+
+static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
+		struct int_node *node, unsigned int n)
 {
 	unsigned char object_sha1[20];
 	unsigned int prefix_len;
 	void *buf;
 	struct tree_desc desc;
 	struct name_entry entry;
+	int len, path_len;
+	unsigned char type;
+	struct leaf_node *l;
 
 	buf = fill_tree_descriptor(&desc, subtree->val_sha1);
 	if (!buf)
@@ -342,31 +413,68 @@ static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 	assert(prefix_len * 2 >= n);
 	memcpy(object_sha1, subtree->key_sha1, prefix_len);
 	while (tree_entry(&desc, &entry)) {
-		int len = get_sha1_hex_segment(entry.path, strlen(entry.path),
+		path_len = strlen(entry.path);
+		len = get_sha1_hex_segment(entry.path, path_len,
 				object_sha1 + prefix_len, 20 - prefix_len);
 		if (len < 0)
-			continue; /* entry.path is not a SHA1 sum. Skip */
+			goto handle_non_note; /* entry.path is not a SHA1 */
 		len += prefix_len;
 
 		/*
 		 * If object SHA1 is complete (len == 20), assume note object
-		 * If object SHA1 is incomplete (len < 20), assume note subtree
+		 * If object SHA1 is incomplete (len < 20), and current
+		 * component consists of 2 hex chars, assume note subtree
 		 */
 		if (len <= 20) {
-			unsigned char type = PTR_TYPE_NOTE;
-			struct leaf_node *l = (struct leaf_node *)
+			type = PTR_TYPE_NOTE;
+			l = (struct leaf_node *)
 				xcalloc(sizeof(struct leaf_node), 1);
 			hashcpy(l->key_sha1, object_sha1);
 			hashcpy(l->val_sha1, entry.sha1);
 			if (len < 20) {
-				if (!S_ISDIR(entry.mode))
-					continue; /* entry cannot be subtree */
+				if (!S_ISDIR(entry.mode) || path_len != 2)
+					goto handle_non_note; /* not subtree */
 				l->key_sha1[19] = (unsigned char) len;
 				type = PTR_TYPE_SUBTREE;
 			}
-			note_tree_insert(node, n, l, type,
+			note_tree_insert(t, node, n, l, type,
 					 combine_notes_concatenate);
 		}
+		continue;
+
+handle_non_note:
+		/*
+		 * Determine full path for this non-note entry:
+		 * The filename is already found in entry.path, but the
+		 * directory part of the path must be deduced from the subtree
+		 * containing this entry. We assume here that the overall notes
+		 * tree follows a strict byte-based progressive fanout
+		 * structure (i.e. using 2/38, 2/2/36, etc. fanouts, and not
+		 * e.g. 4/36 fanout). This means that if a non-note is found at
+		 * path "dead/beef", the following code will register it as
+		 * being found on "de/ad/beef".
+		 * On the other hand, if you use such non-obvious non-note
+		 * paths in the middle of a notes tree, you deserve what's
+		 * coming to you ;). Note that for non-notes that are not
+		 * SHA1-like at the top level, there will be no problems.
+		 *
+		 * To conclude, it is strongly advised to make sure non-notes
+		 * have at least one non-hex character in the top-level path
+		 * component.
+		 */
+		{
+			char non_note_path[PATH_MAX];
+			char *p = non_note_path;
+			const char *q = sha1_to_hex(subtree->key_sha1);
+			int i;
+			for (i = 0; i < prefix_len; i++) {
+				*p++ = *q++;
+				*p++ = *q++;
+				*p++ = '/';
+			}
+			strcpy(p, entry.path);
+			add_non_note(t, non_note_path, entry.mode, entry.sha1);
+		}
 	}
 	free(buf);
 }
@@ -426,9 +534,9 @@ static void construct_path_with_fanout(const unsigned char *sha1,
 	strcpy(path + i, hex_sha1 + j);
 }
 
-static int for_each_note_helper(struct int_node *tree, unsigned char n,
-		unsigned char fanout, int flags, each_note_fn fn,
-		void *cb_data)
+static int for_each_note_helper(struct notes_tree *t, struct int_node *tree,
+		unsigned char n, unsigned char fanout, int flags,
+		each_note_fn fn, void *cb_data)
 {
 	unsigned int i;
 	void *p;
@@ -443,7 +551,7 @@ redo:
 		switch (GET_PTR_TYPE(p)) {
 		case PTR_TYPE_INTERNAL:
 			/* recurse into int_node */
-			ret = for_each_note_helper(CLR_PTR_TYPE(p), n + 1,
+			ret = for_each_note_helper(t, CLR_PTR_TYPE(p), n + 1,
 				fanout, flags, fn, cb_data);
 			break;
 		case PTR_TYPE_SUBTREE:
@@ -481,7 +589,7 @@ redo:
 			    !(flags & FOR_EACH_NOTE_DONT_UNPACK_SUBTREES)) {
 				/* unpack subtree and resume traversal */
 				tree->a[i] = NULL;
-				load_subtree(l, tree, n);
+				load_subtree(t, l, tree, n);
 				free(l);
 				goto redo;
 			}
@@ -596,8 +704,29 @@ static int write_each_note_helper(struct tree_write_stack *tws,
 
 struct write_each_note_data {
 	struct tree_write_stack *root;
+	struct non_note *next_non_note;
 };
 
+static int write_each_non_note_until(const char *note_path,
+		struct write_each_note_data *d)
+{
+	struct non_note *n = d->next_non_note;
+	int cmp, ret;
+	while (n && (!note_path || (cmp = strcmp(n->path, note_path)) <= 0)) {
+		if (note_path && cmp == 0)
+			; /* do nothing, prefer note to non-note */
+		else {
+			ret = write_each_note_helper(d->root, n->path, n->mode,
+						     n->sha1);
+			if (ret)
+				return ret;
+		}
+		n = n->next;
+	}
+	d->next_non_note = n;
+	return 0;
+}
+
 static int write_each_note(const unsigned char *object_sha1,
 		const unsigned char *note_sha1, char *note_path,
 		void *cb_data)
@@ -615,7 +744,9 @@ static int write_each_note(const unsigned char *object_sha1,
 	}
 	assert(note_path_len <= 40 + 19);
 
-	return write_each_note_helper(d->root, note_path, mode, note_sha1);
+	/* Weave non-note entries into note entries */
+	return  write_each_non_note_until(note_path, d) ||
+		write_each_note_helper(d->root, note_path, mode, note_sha1);
 }
 
 int combine_notes_concatenate(unsigned char *cur_sha1,
@@ -696,6 +827,8 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 		combine_notes = combine_notes_concatenate;
 
 	t->root = (struct int_node *) xcalloc(sizeof(struct int_node), 1);
+	t->first_non_note = NULL;
+	t->prev_non_note = NULL;
 	t->ref = notes_ref ? xstrdup(notes_ref) : NULL;
 	t->combine_notes = combine_notes;
 	t->initialized = 1;
@@ -709,7 +842,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 
 	hashclr(root_tree.key_sha1);
 	hashcpy(root_tree.val_sha1, sha1);
-	load_subtree(&root_tree, t->root, 0);
+	load_subtree(t, &root_tree, t->root, 0);
 }
 
 void add_note(struct notes_tree *t, const unsigned char *object_sha1,
@@ -725,7 +858,7 @@ void add_note(struct notes_tree *t, const unsigned char *object_sha1,
 	l = (struct leaf_node *) xmalloc(sizeof(struct leaf_node));
 	hashcpy(l->key_sha1, object_sha1);
 	hashcpy(l->val_sha1, note_sha1);
-	note_tree_insert(t->root, 0, l, PTR_TYPE_NOTE, combine_notes);
+	note_tree_insert(t, t->root, 0, l, PTR_TYPE_NOTE, combine_notes);
 }
 
 void remove_note(struct notes_tree *t, const unsigned char *object_sha1)
@@ -748,7 +881,7 @@ const unsigned char *get_note(struct notes_tree *t,
 	if (!t)
 		t = &default_notes_tree;
 	assert(t->initialized);
-	found = note_tree_find(t->root, 0, object_sha1);
+	found = note_tree_find(t, t->root, 0, object_sha1);
 	return found ? found->val_sha1 : NULL;
 }
 
@@ -758,7 +891,7 @@ int for_each_note(struct notes_tree *t, int flags, each_note_fn fn,
 	if (!t)
 		t = &default_notes_tree;
 	assert(t->initialized);
-	return for_each_note_helper(t->root, 0, 0, flags, fn, cb_data);
+	return for_each_note_helper(t, t->root, 0, 0, flags, fn, cb_data);
 }
 
 int write_notes_tree(struct notes_tree *t, unsigned char *result)
@@ -776,11 +909,13 @@ int write_notes_tree(struct notes_tree *t, unsigned char *result)
 	strbuf_init(&root.buf, 256 * (32 + 40)); /* assume 256 entries */
 	root.path[0] = root.path[1] = '\0';
 	cb_data.root = &root;
+	cb_data.next_non_note = t->first_non_note;
 
 	/* Write tree objects representing current notes tree */
 	ret = for_each_note(t, FOR_EACH_NOTE_DONT_UNPACK_SUBTREES |
 				FOR_EACH_NOTE_YIELD_SUBTREES,
 			write_each_note, &cb_data) ||
+		write_each_non_note_until(NULL, &cb_data) ||
 		tree_write_stack_finish_subtree(&root) ||
 		write_sha1_file(root.buf.buf, root.buf.len, tree_type, result);
 	strbuf_release(&root.buf);
@@ -794,6 +929,12 @@ void free_notes(struct notes_tree *t)
 	if (t->root)
 		note_tree_free(t->root);
 	free(t->root);
+	while (t->first_non_note) {
+		t->prev_non_note = t->first_non_note->next;
+		free(t->first_non_note->path);
+		free(t->first_non_note);
+		t->first_non_note = t->prev_non_note;
+	}
 	free(t->ref);
 	memset(t, 0, sizeof(struct notes_tree));
 }
diff --git a/notes.h b/notes.h
index 20d6e17..f98578f 100644
--- a/notes.h
+++ b/notes.h
@@ -36,6 +36,7 @@ int combine_notes_ignore(unsigned char *cur_sha1, const unsigned char *new_sha1)
  */
 extern struct notes_tree {
 	struct int_node *root;
+	struct non_note *first_non_note, *prev_non_note;
 	char *ref;
 	combine_notes_fn *combine_notes;
 	int initialized;
diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
index edc4bc8..75ec187 100755
--- a/t/t3303-notes-subtrees.sh
+++ b/t/t3303-notes-subtrees.sh
@@ -95,12 +95,12 @@ INPUT_END
 test_expect_success 'test notes in 2/38-fanout' 'test_sha1_based "s|^..|&/|"'
 test_expect_success 'verify notes in 2/38-fanout' 'verify_notes'
 
-test_expect_success 'test notes in 4/36-fanout' 'test_sha1_based "s|^....|&/|"'
-test_expect_success 'verify notes in 4/36-fanout' 'verify_notes'
-
 test_expect_success 'test notes in 2/2/36-fanout' 'test_sha1_based "s|^\(..\)\(..\)|\1/\2/|"'
 test_expect_success 'verify notes in 2/2/36-fanout' 'verify_notes'
 
+test_expect_success 'test notes in 2/2/2/34-fanout' 'test_sha1_based "s|^\(..\)\(..\)\(..\)|\1/\2/\3/|"'
+test_expect_success 'verify notes in 2/2/2/34-fanout' 'verify_notes'
+
 test_same_notes () {
 	(
 		start_note_commit &&
@@ -128,14 +128,17 @@ INPUT_END
 	git fast-import --quiet
 }
 
-test_expect_success 'test same notes in 4/36-fanout and 2/38-fanout' 'test_same_notes "s|^..|&/|" "s|^....|&/|"'
-test_expect_success 'verify same notes in 4/36-fanout and 2/38-fanout' 'verify_notes'
+test_expect_success 'test same notes in no fanout and 2/38-fanout' 'test_same_notes "s|^..|&/|" ""'
+test_expect_success 'verify same notes in no fanout and 2/38-fanout' 'verify_notes'
+
+test_expect_success 'test same notes in no fanout and 2/2/36-fanout' 'test_same_notes "s|^\(..\)\(..\)|\1/\2/|" ""'
+test_expect_success 'verify same notes in no fanout and 2/2/36-fanout' 'verify_notes'
 
 test_expect_success 'test same notes in 2/38-fanout and 2/2/36-fanout' 'test_same_notes "s|^\(..\)\(..\)|\1/\2/|" "s|^..|&/|"'
 test_expect_success 'verify same notes in 2/38-fanout and 2/2/36-fanout' 'verify_notes'
 
-test_expect_success 'test same notes in 4/36-fanout and 2/2/36-fanout' 'test_same_notes "s|^\(..\)\(..\)|\1/\2/|" "s|^....|&/|"'
-test_expect_success 'verify same notes in 4/36-fanout and 2/2/36-fanout' 'verify_notes'
+test_expect_success 'test same notes in 2/2/2/34-fanout and 2/2/36-fanout' 'test_same_notes "s|^\(..\)\(..\)|\1/\2/|" "s|^\(..\)\(..\)\(..\)|\1/\2/\3/|"'
+test_expect_success 'verify same notes in 2/2/2/34-fanout and 2/2/36-fanout' 'verify_notes'
 
 test_concatenated_notes () {
 	(
@@ -176,13 +179,16 @@ verify_concatenated_notes () {
     test_cmp expect output
 }
 
-test_expect_success 'test notes in 4/36-fanout concatenated with 2/38-fanout' 'test_concatenated_notes "s|^..|&/|" "s|^....|&/|"'
-test_expect_success 'verify notes in 4/36-fanout concatenated with 2/38-fanout' 'verify_concatenated_notes'
+test_expect_success 'test notes in no fanout concatenated with 2/38-fanout' 'test_concatenated_notes "s|^..|&/|" ""'
+test_expect_success 'verify notes in no fanout concatenated with 2/38-fanout' 'verify_concatenated_notes'
+
+test_expect_success 'test notes in no fanout concatenated with 2/2/36-fanout' 'test_concatenated_notes "s|^\(..\)\(..\)|\1/\2/|" ""'
+test_expect_success 'verify notes in no fanout concatenated with 2/2/36-fanout' 'verify_concatenated_notes'
 
 test_expect_success 'test notes in 2/38-fanout concatenated with 2/2/36-fanout' 'test_concatenated_notes "s|^\(..\)\(..\)|\1/\2/|" "s|^..|&/|"'
 test_expect_success 'verify notes in 2/38-fanout concatenated with 2/2/36-fanout' 'verify_concatenated_notes'
 
-test_expect_success 'test notes in 4/36-fanout concatenated with 2/2/36-fanout' 'test_concatenated_notes "s|^\(..\)\(..\)|\1/\2/|" "s|^....|&/|"'
-test_expect_success 'verify notes in 4/36-fanout concatenated with 2/2/36-fanout' 'verify_concatenated_notes'
+test_expect_success 'test notes in 2/2/36-fanout concatenated with 2/2/2/34-fanout' 'test_concatenated_notes "s|^\(..\)\(..\)\(..\)|\1/\2/\3/|" "s|^\(..\)\(..\)|\1/\2/|"'
+test_expect_success 'verify notes in 2/2/36-fanout concatenated with 2/2/2/34-fanout' 'verify_concatenated_notes'
 
 test_done
diff --git a/t/t3304-notes-mixed.sh b/t/t3304-notes-mixed.sh
index 256687f..c975a6d 100755
--- a/t/t3304-notes-mixed.sh
+++ b/t/t3304-notes-mixed.sh
@@ -131,6 +131,17 @@ data <<EOF
 another non-note with SHA1-like name
 EOF
 
+M 644 inline de/adbeefdeadbeefdeadbeefdeadbeefdeadbeef
+data <<EOF
+This is actually a valid note, albeit to a non-existing object.
+It is needed in order to trigger the "mishandling" of the dead/beef non-note.
+EOF
+
+M 644 inline dead/beef
+data <<EOF
+yet another non-note with SHA1-like name
+EOF
+
 INPUT_END
 	git fast-import --quiet <input &&
 	git config core.notesRef refs/notes/commits
@@ -158,6 +169,9 @@ EXPECT_END
 cat >expect_nn3 <<EXPECT_END
 another non-note with SHA1-like name
 EXPECT_END
+cat >expect_nn4 <<EXPECT_END
+yet another non-note with SHA1-like name
+EXPECT_END
 
 test_expect_success "verify contents of non-notes" '
 
@@ -166,7 +180,27 @@ test_expect_success "verify contents of non-notes" '
 	git cat-file -p refs/notes/commits:deadbeef > actual_nn2 &&
 	test_cmp expect_nn2 actual_nn2 &&
 	git cat-file -p refs/notes/commits:de/adbeef > actual_nn3 &&
-	test_cmp expect_nn3 actual_nn3
+	test_cmp expect_nn3 actual_nn3 &&
+	git cat-file -p refs/notes/commits:dead/beef > actual_nn4 &&
+	test_cmp expect_nn4 actual_nn4
+'
+
+test_expect_success "git-notes preserves non-notes" '
+
+	test_tick &&
+	git notes edit -m "foo bar"
+'
+
+test_expect_success "verify contents of non-notes after git-notes" '
+
+	git cat-file -p refs/notes/commits:foobar/non-note.txt > actual_nn1 &&
+	test_cmp expect_nn1 actual_nn1 &&
+	git cat-file -p refs/notes/commits:deadbeef > actual_nn2 &&
+	test_cmp expect_nn2 actual_nn2 &&
+	git cat-file -p refs/notes/commits:de/adbeef > actual_nn3 &&
+	test_cmp expect_nn3 actual_nn3 &&
+	git cat-file -p refs/notes/commits:dead/beef > actual_nn4 &&
+	test_cmp expect_nn4 actual_nn4
 '
 
 test_done
-- 
1.7.0.rc1.141.gd3fd

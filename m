From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 09/30] Notes API: write_notes_tree(): Store the notes tree
 in the database
Date: Sat, 13 Feb 2010 22:28:17 +0100
Message-ID: <1266096518-2104-10-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:30:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPZC-0001iD-5H
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757879Ab0BMV3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:29:23 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62231 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758085Ab0BMV3L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:29:11 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00FJCUCM5490@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:10 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:10 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211545
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139840>

Uses for_each_note() to traverse the notes tree, and produces tree
objects on the fly representing the "on-disk" version of the notes
tree with appropriate fanout.

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |  145 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 notes.h |   38 +++++++++++++++-
 2 files changed, 180 insertions(+), 3 deletions(-)

diff --git a/notes.c b/notes.c
index eabd6f3..b576f7e 100644
--- a/notes.c
+++ b/notes.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "notes.h"
+#include "tree.h"
 #include "utf8.h"
 #include "strbuf.h"
 #include "tree-walk.h"
@@ -540,6 +541,126 @@ redo:
 	return 0;
 }
 
+struct tree_write_stack {
+	struct tree_write_stack *next;
+	struct strbuf buf;
+	char path[2]; /* path to subtree in next, if any */
+};
+
+static inline int matches_tree_write_stack(struct tree_write_stack *tws,
+		const char *full_path)
+{
+	return  full_path[0] == tws->path[0] &&
+		full_path[1] == tws->path[1] &&
+		full_path[2] == '/';
+}
+
+static void write_tree_entry(struct strbuf *buf, unsigned int mode,
+		const char *path, unsigned int path_len, const
+		unsigned char *sha1)
+{
+		strbuf_addf(buf, "%06o %.*s%c", mode, path_len, path, '\0');
+		strbuf_add(buf, sha1, 20);
+}
+
+static void tree_write_stack_init_subtree(struct tree_write_stack *tws,
+		const char *path)
+{
+	struct tree_write_stack *n;
+	assert(!tws->next);
+	assert(tws->path[0] == '\0' && tws->path[1] == '\0');
+	n = (struct tree_write_stack *)
+		xmalloc(sizeof(struct tree_write_stack));
+	n->next = NULL;
+	strbuf_init(&n->buf, 256 * (32 + 40)); /* assume 256 entries per tree */
+	n->path[0] = n->path[1] = '\0';
+	tws->next = n;
+	tws->path[0] = path[0];
+	tws->path[1] = path[1];
+}
+
+static int tree_write_stack_finish_subtree(struct tree_write_stack *tws)
+{
+	int ret;
+	struct tree_write_stack *n = tws->next;
+	unsigned char s[20];
+	if (n) {
+		ret = tree_write_stack_finish_subtree(n);
+		if (ret)
+			return ret;
+		ret = write_sha1_file(n->buf.buf, n->buf.len, tree_type, s);
+		if (ret)
+			return ret;
+		strbuf_release(&n->buf);
+		free(n);
+		tws->next = NULL;
+		write_tree_entry(&tws->buf, 040000, tws->path, 2, s);
+		tws->path[0] = tws->path[1] = '\0';
+	}
+	return 0;
+}
+
+static int write_each_note_helper(struct tree_write_stack *tws,
+		const char *path, unsigned int mode,
+		const unsigned char *sha1)
+{
+	size_t path_len = strlen(path);
+	unsigned int n = 0;
+	int ret;
+
+	/* Determine common part of tree write stack */
+	while (tws && 3 * n < path_len &&
+	       matches_tree_write_stack(tws, path + 3 * n)) {
+		n++;
+		tws = tws->next;
+	}
+
+	/* tws point to last matching tree_write_stack entry */
+	ret = tree_write_stack_finish_subtree(tws);
+	if (ret)
+		return ret;
+
+	/* Start subtrees needed to satisfy path */
+	while (3 * n + 2 < path_len && path[3 * n + 2] == '/') {
+		tree_write_stack_init_subtree(tws, path + 3 * n);
+		n++;
+		tws = tws->next;
+	}
+
+	/* There should be no more directory components in the given path */
+	assert(memchr(path + 3 * n, '/', path_len - (3 * n)) == NULL);
+
+	/* Finally add given entry to the current tree object */
+	write_tree_entry(&tws->buf, mode, path + 3 * n, path_len - (3 * n),
+			 sha1);
+
+	return 0;
+}
+
+struct write_each_note_data {
+	struct tree_write_stack *root;
+};
+
+static int write_each_note(const unsigned char *object_sha1,
+		const unsigned char *note_sha1, char *note_path,
+		void *cb_data)
+{
+	struct write_each_note_data *d =
+		(struct write_each_note_data *) cb_data;
+	size_t note_path_len = strlen(note_path);
+	unsigned int mode = 0100644;
+
+	if (note_path[note_path_len - 1] == '/') {
+		/* subtree entry */
+		note_path_len--;
+		note_path[note_path_len] = '\0';
+		mode = 040000;
+	}
+	assert(note_path_len <= 40 + 19);
+
+	return write_each_note_helper(d->root, note_path, mode, note_sha1);
+}
+
 void init_notes(const char *notes_ref, int flags)
 {
 	unsigned char sha1[20], object_sha1[20];
@@ -604,6 +725,30 @@ int for_each_note(int flags, each_note_fn fn, void *cb_data)
 	return for_each_note_helper(&root_node, 0, 0, flags, fn, cb_data);
 }
 
+int write_notes_tree(unsigned char *result)
+{
+	struct tree_write_stack root;
+	struct write_each_note_data cb_data;
+	int ret;
+
+	assert(initialized);
+
+	/* Prepare for traversal of current notes tree */
+	root.next = NULL; /* last forward entry in list is grounded */
+	strbuf_init(&root.buf, 256 * (32 + 40)); /* assume 256 entries */
+	root.path[0] = root.path[1] = '\0';
+	cb_data.root = &root;
+
+	/* Write tree objects representing current notes tree */
+	ret = for_each_note(FOR_EACH_NOTE_DONT_UNPACK_SUBTREES |
+				FOR_EACH_NOTE_YIELD_SUBTREES,
+			write_each_note, &cb_data) ||
+		tree_write_stack_finish_subtree(&root) ||
+		write_sha1_file(root.buf.buf, root.buf.len, tree_type, result);
+	strbuf_release(&root.buf);
+	return ret;
+}
+
 void free_notes(void)
 {
 	note_tree_free(&root_node);
diff --git a/notes.h b/notes.h
index 2131912..c49b7a5 100644
--- a/notes.h
+++ b/notes.h
@@ -21,11 +21,23 @@
  */
 void init_notes(const char *notes_ref, int flags);
 
-/* Add the given note object to the internal notes tree structure */
+/*
+ * Add the given note object to the internal notes tree structure
+ *
+ * IMPORTANT: The changes made by add_note() to the internal notes tree structure
+ * are not persistent until a subsequent call to write_notes_tree() returns
+ * zero.
+ */
 void add_note(const unsigned char *object_sha1,
 		const unsigned char *note_sha1);
 
-/* Remove the given note object from the internal notes tree structure */
+/*
+ * Remove the given note object from the internal notes tree structure
+ *
+ * IMPORTANT: The changes made by remove_note() to the internal notes tree
+ * structure are not persistent until a subsequent call to write_notes_tree()
+ * returns zero.
+ */
 void remove_note(const unsigned char *object_sha1);
 
 /*
@@ -82,7 +94,27 @@ typedef int each_note_fn(const unsigned char *object_sha1,
 		void *cb_data);
 int for_each_note(int flags, each_note_fn fn, void *cb_data);
 
-/* Free (and de-initialize) the internal notes tree structure */
+/*
+ * Write the internal notes tree structure to the object database
+ *
+ * Creates a new tree object encapsulating the current state of the
+ * internal notes tree, and stores its SHA1 into the 'result' argument.
+ *
+ * Returns zero on success, non-zero on failure.
+ *
+ * IMPORTANT: Changes made to the internal notes tree structure are not
+ * persistent until this function has returned zero. Please also remember
+ * to create a corresponding commit object, and update the appropriate
+ * notes ref.
+ */
+int write_notes_tree(unsigned char *result);
+
+/*
+ * Free (and de-initialize) the internal notes tree structure
+ *
+ * IMPORTANT: Changes made to the notes tree since the last, successful
+ * call to write_notes_tree() will be lost.
+ */
 void free_notes(void);
 
 /* Flags controlling how notes are formatted */
-- 
1.7.0.rc1.141.gd3fd

From: Johan Herland <johan@herland.net>
Subject: [PATCHv11 08/20] Notes API: for_each_note(): Traverse the entire notes
 tree with a callback
Date: Sun, 17 Jan 2010 22:04:25 +0100
Message-ID: <1263762277-31419-9-git-send-email-johan@herland.net>
References: <1263762277-31419-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 17 22:06:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWcKK-0007dl-MJ
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 22:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775Ab0AQVFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 16:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754640Ab0AQVFN
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 16:05:13 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62433 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750743Ab0AQVFI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jan 2010 16:05:08 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE002CCT8I0RE0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:05:06 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE00CILT85S310@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:05:06 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.17.205416
X-Mailer: git-send-email 1.6.6.rc1.321.g0496e
In-reply-to: <1263762277-31419-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137331>

This includes a first attempt at creating an optimal fanout scheme (which
is calculated on-the-fly, while traversing).

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 notes.h |   47 ++++++++++++++++++++++
 2 files changed, 180 insertions(+), 0 deletions(-)

diff --git a/notes.c b/notes.c
index a0a85b4..eabd6f3 100644
--- a/notes.c
+++ b/notes.c
@@ -413,6 +413,133 @@ static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 	free(buf);
 }
 
+/*
+ * Determine optimal on-disk fanout for this part of the notes tree
+ *
+ * Given a (sub)tree and the level in the internal tree structure, determine
+ * whether or not the given existing fanout should be expanded for this
+ * (sub)tree.
+ *
+ * Values of the 'fanout' variable:
+ * - 0: No fanout (all notes are stored directly in the root notes tree)
+ * - 1: 2/38 fanout
+ * - 2: 2/2/36 fanout
+ * - 3: 2/2/2/34 fanout
+ * etc.
+ */
+static unsigned char determine_fanout(struct int_node *tree, unsigned char n,
+		unsigned char fanout)
+{
+	/*
+	 * The following is a simple heuristic that works well in practice:
+	 * For each even-numbered 16-tree level (remember that each on-disk
+	 * fanout level corresponds to _two_ 16-tree levels), peek at all 16
+	 * entries at that tree level. If all of them are either int_nodes or
+	 * subtree entries, then there are likely plenty of notes below this
+	 * level, so we return an incremented fanout.
+	 */
+	unsigned int i;
+	if ((n % 2) || (n > 2 * fanout))
+		return fanout;
+	for (i = 0; i < 16; i++) {
+		switch (GET_PTR_TYPE(tree->a[i])) {
+		case PTR_TYPE_SUBTREE:
+		case PTR_TYPE_INTERNAL:
+			continue;
+		default:
+			return fanout;
+		}
+	}
+	return fanout + 1;
+}
+
+static void construct_path_with_fanout(const unsigned char *sha1,
+		unsigned char fanout, char *path)
+{
+	unsigned int i = 0, j = 0;
+	const char *hex_sha1 = sha1_to_hex(sha1);
+	assert(fanout < 20);
+	while (fanout) {
+		path[i++] = hex_sha1[j++];
+		path[i++] = hex_sha1[j++];
+		path[i++] = '/';
+		fanout--;
+	}
+	strcpy(path + i, hex_sha1 + j);
+}
+
+static int for_each_note_helper(struct int_node *tree, unsigned char n,
+		unsigned char fanout, int flags, each_note_fn fn,
+		void *cb_data)
+{
+	unsigned int i;
+	void *p;
+	int ret = 0;
+	struct leaf_node *l;
+	static char path[40 + 19 + 1];  /* hex SHA1 + 19 * '/' + NUL */
+
+	fanout = determine_fanout(tree, n, fanout);
+	for (i = 0; i < 16; i++) {
+redo:
+		p = tree->a[i];
+		switch (GET_PTR_TYPE(p)) {
+		case PTR_TYPE_INTERNAL:
+			/* recurse into int_node */
+			ret = for_each_note_helper(CLR_PTR_TYPE(p), n + 1,
+				fanout, flags, fn, cb_data);
+			break;
+		case PTR_TYPE_SUBTREE:
+			l = (struct leaf_node *) CLR_PTR_TYPE(p);
+			/*
+			 * Subtree entries in the note tree represent parts of
+			 * the note tree that have not yet been explored. There
+			 * is a direct relationship between subtree entries at
+			 * level 'n' in the tree, and the 'fanout' variable:
+			 * Subtree entries at level 'n <= 2 * fanout' should be
+			 * preserved, since they correspond exactly to a fanout
+			 * directory in the on-disk structure. However, subtree
+			 * entries at level 'n > 2 * fanout' should NOT be
+			 * preserved, but rather consolidated into the above
+			 * notes tree level. We achieve this by unconditionally
+			 * unpacking subtree entries that exist below the
+			 * threshold level at 'n = 2 * fanout'.
+			 */
+			if (n <= 2 * fanout &&
+			    flags & FOR_EACH_NOTE_YIELD_SUBTREES) {
+				/* invoke callback with subtree */
+				unsigned int path_len =
+					l->key_sha1[19] * 2 + fanout;
+				assert(path_len < 40 + 19);
+				construct_path_with_fanout(l->key_sha1, fanout,
+							   path);
+				/* Create trailing slash, if needed */
+				if (path[path_len - 1] != '/')
+					path[path_len++] = '/';
+				path[path_len] = '\0';
+				ret = fn(l->key_sha1, l->val_sha1, path,
+					 cb_data);
+			}
+			if (n > fanout * 2 ||
+			    !(flags & FOR_EACH_NOTE_DONT_UNPACK_SUBTREES)) {
+				/* unpack subtree and resume traversal */
+				tree->a[i] = NULL;
+				load_subtree(l, tree, n);
+				free(l);
+				goto redo;
+			}
+			break;
+		case PTR_TYPE_NOTE:
+			l = (struct leaf_node *) CLR_PTR_TYPE(p);
+			construct_path_with_fanout(l->key_sha1, fanout, path);
+			ret = fn(l->key_sha1, l->val_sha1, path, cb_data);
+			break;
+		}
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 void init_notes(const char *notes_ref, int flags)
 {
 	unsigned char sha1[20], object_sha1[20];
@@ -471,6 +598,12 @@ const unsigned char *get_note(const unsigned char *object_sha1)
 	return found ? found->val_sha1 : NULL;
 }
 
+int for_each_note(int flags, each_note_fn fn, void *cb_data)
+{
+	assert(initialized);
+	return for_each_note_helper(&root_node, 0, 0, flags, fn, cb_data);
+}
+
 void free_notes(void)
 {
 	note_tree_free(&root_node);
diff --git a/notes.h b/notes.h
index c0714f4..c319fd8 100644
--- a/notes.h
+++ b/notes.h
@@ -31,6 +31,53 @@ void remove_note(const unsigned char *object_sha1);
 /* Get the note object SHA1 containing the note data for the given object */
 const unsigned char *get_note(const unsigned char *object_sha1);
 
+/*
+ * Flags controlling behaviour of for_each_note()
+ *
+ * Default behaviour of for_each_note() is to traverse every single note object
+ * in the notes tree, unpacking subtree entries along the way.
+ * The following flags can be used to alter the default behaviour:
+ *
+ * - DONT_UNPACK_SUBTREES causes for_each_note() NOT to unpack and recurse into
+ *   subtree entries while traversing the notes tree. This causes notes within
+ *   those subtrees NOT to be passed to the callback. Use this flag if you
+ *   don't want to traverse _all_ notes, but only want to traverse the parts
+ *   of the notes tree that have already been unpacked (this includes at least
+ *   all notes that have been added/changed).
+ *
+ * - YIELD_SUBTREES causes any subtree entries that are encountered to be
+ *   passed to the callback, before recursing into them. Subtree entries are
+ *   not note objects, but represent intermediate directories in the notes
+ *   tree. When passed to the callback, subtree entries will have a trailing
+ *   slash in their path, which the callback may use to differentiate between
+ *   note entries and subtree entries. Note that already-unpacked subtree
+ *   entries are not part of the notes tree, and will therefore not be yielded.
+ *   If this flag is used together with DONT_UNPACK_SUBTREES, for_each_note()
+ *   will yield the subtree entry, but not recurse into it.
+ */
+#define FOR_EACH_NOTE_DONT_UNPACK_SUBTREES 1
+#define FOR_EACH_NOTE_YIELD_SUBTREES 2
+
+/*
+ * Invoke the specified callback function for each note
+ *
+ * If the callback returns nonzero, the note walk is aborted, and the return
+ * value from the callback is returned from for_each_note(). Hence, a zero
+ * return value from for_each_note() indicates that all notes were walked
+ * successfully.
+ *
+ * IMPORTANT: The callback function is NOT allowed to change the notes tree.
+ * In other words, the following functions can NOT be invoked (on the current
+ * notes tree) from within the callback:
+ * - add_note()
+ * - remove_note()
+ * - free_notes()
+ */
+typedef int each_note_fn(const unsigned char *object_sha1,
+		const unsigned char *note_sha1, char *note_path,
+		void *cb_data);
+int for_each_note(int flags, each_note_fn fn, void *cb_data);
+
 /* Free (and de-initialize) the internal notes tree structure */
 void free_notes(void);
 
-- 
1.6.6.rc1.321.g0496e

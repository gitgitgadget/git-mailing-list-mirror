From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv8 05/10] Notes API: for_each_note(): Traverse the entire
 notes tree with a callback
Date: Fri, 20 Nov 2009 02:39:09 +0100
Message-ID: <1258681154-2167-6-git-send-email-johan@herland.net>
References: <1258681154-2167-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 02:40:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBIU1-0004ED-TI
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 02:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757358AbZKTBjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 20:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757336AbZKTBjj
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 20:39:39 -0500
Received: from smtp.getmail.no ([84.208.15.66]:58297 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757247AbZKTBjf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Nov 2009 20:39:35 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTD00MNZWM5SE10@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 20 Nov 2009 02:39:41 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTD00D7NWLXUY10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 20 Nov 2009 02:39:41 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.11.20.12721
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1258681154-2167-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133283>

This includes a first attempt at creating an optimal fanout scheme (which
is calculated on-the-fly, while traversing).

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 notes.h |   17 ++++++++++
 2 files changed, 118 insertions(+), 0 deletions(-)

diff --git a/notes.c b/notes.c
index 2196a5f..9581b98 100644
--- a/notes.c
+++ b/notes.c
@@ -339,6 +339,101 @@ static void load_subtree(struct leaf_node *subtree, struct int_node *node,
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
+	 * fanout level corresponds to two 16-tree levels), peek at all 16
+	 * entries at that tree level. If any of them are subtree entries, then
+	 * there are likely plenty of notes below this level, so we return an
+	 * incremented fanout immediately. Otherwise, we return an incremented
+	 * fanout only if all of the entries at this level are int_nodes.
+	 */
+	unsigned int i;
+	if ((n % 2) || (n > 2 * fanout))
+		return fanout;
+	for (i = 0; i < 16; i++) {
+		switch(GET_PTR_TYPE(tree->a[i])) {
+		case PTR_TYPE_SUBTREE:
+			return fanout + 1;
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
+		unsigned char fanout, each_note_fn fn, void *cb_data)
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
+		switch(GET_PTR_TYPE(p)) {
+		case PTR_TYPE_INTERNAL:
+			/* recurse into int_node */
+			ret = for_each_note_helper(
+				CLR_PTR_TYPE(p), n + 1, fanout, fn, cb_data);
+			break;
+		case PTR_TYPE_SUBTREE:
+			/* unpack subtree and resume traversal */
+			l = (struct leaf_node *) CLR_PTR_TYPE(p);
+			tree->a[i] = NULL;
+			load_subtree(l, tree, n);
+			free(l);
+			goto redo;
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
@@ -386,6 +481,12 @@ const unsigned char *get_note(const unsigned char *object_sha1)
 	return found ? found->val_sha1 : NULL;
 }
 
+int for_each_note(each_note_fn fn, void *cb_data)
+{
+	assert(initialized);
+	return for_each_note_helper(&root_node, 0, 0, fn, cb_data);
+}
+
 void free_notes(void)
 {
 	note_tree_free(&root_node);
diff --git a/notes.h b/notes.h
index 21a8930..f67bae8 100644
--- a/notes.h
+++ b/notes.h
@@ -28,6 +28,23 @@ void add_note(const unsigned char *object_sha1,
 /* Get the note object SHA1 containing the note data for the given object */
 const unsigned char *get_note(const unsigned char *object_sha1);
 
+/*
+ * Invoke the specified callback function for each note
+ *
+ * If the callback returns nonzero, the note walk is aborted, and the return
+ * value from the callback is returned from for_each_note().
+ *
+ * IMPORTANT: The callback function is NOT allowed to change the notes tree.
+ * In other words, the following functions can NOT be invoked (on the current
+ * notes tree) from within the callback:
+ * - add_note()
+ * - free_notes()
+ */
+typedef int each_note_fn(const unsigned char *object_sha1,
+		const unsigned char *note_sha1, const char *note_tree_path,
+		void *cb_data);
+int for_each_note(each_note_fn fn, void *cb_data);
+
 /* Free (and de-initialize) the internal notes tree structure */
 void free_notes(void);
 
-- 
1.6.4.304.g1365c.dirty

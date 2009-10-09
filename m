From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv7 19/22] Notes API: for_each_note(): Traverse the entire
 notes tree with a callback
Date: Fri, 09 Oct 2009 12:22:15 +0200
Message-ID: <1255083738-23263-21-git-send-email-johan@herland.net>
References: <1255083738-23263-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:32:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwClX-0004PL-Pz
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760718AbZJIKZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 06:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753793AbZJIKZM
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:25:12 -0400
Received: from smtp.getmail.no ([84.208.15.66]:54694 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760716AbZJIKZL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 06:25:11 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800BT3SUH9320@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:23:05 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800IEJST91V00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:23:05 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.9.101220
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1255083738-23263-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129787>

This includes a first attempt at creating an optimal fanout scheme (which
is created on-the-fly, while traversing).

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 notes.h |    9 +++++
 2 files changed, 110 insertions(+), 0 deletions(-)

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
index 21a8930..28648fd 100644
--- a/notes.h
+++ b/notes.h
@@ -28,6 +28,15 @@ void add_note(const unsigned char *object_sha1,
 /* Get the note object SHA1 containing the note data for the given object */
 const unsigned char *get_note(const unsigned char *object_sha1);
 
+/*
+ * Calls the specified function for each note until it returns nonzero,
+ * and returns the value
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

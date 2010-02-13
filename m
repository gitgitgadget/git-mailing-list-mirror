From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 06/30] Notes API: remove_note(): Remove note objects from
 the notes tree structure
Date: Sat, 13 Feb 2010 22:28:14 +0100
Message-ID: <1266096518-2104-7-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:29:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPYL-00018f-L8
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757847Ab0BMV3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:29:21 -0500
Received: from smtp.getmail.no ([84.208.15.66]:51186 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758078Ab0BMV3F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:29:05 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00EEUUCFVE80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:04 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:03 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211545
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139837>

This includes adding internal functions for maintaining a healthy notes tree
structure after removing individual notes.

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 notes.h |    3 ++
 2 files changed, 87 insertions(+), 1 deletions(-)

diff --git a/notes.c b/notes.c
index 2c0d14e..2e82d71 100644
--- a/notes.c
+++ b/notes.c
@@ -44,7 +44,7 @@ struct leaf_node {
 #define CLR_PTR_TYPE(ptr)       ((void *) ((uintptr_t) (ptr) & ~3))
 #define SET_PTR_TYPE(ptr, type) ((void *) ((uintptr_t) (ptr) | (type)))
 
-#define GET_NIBBLE(n, sha1) (((sha1[n >> 1]) >> ((~n & 0x01) << 2)) & 0x0f)
+#define GET_NIBBLE(n, sha1) (((sha1[(n) >> 1]) >> ((~(n) & 0x01) << 2)) & 0x0f)
 
 #define SUBTREE_SHA1_PREFIXCMP(key_sha1, subtree_sha1) \
 	(memcmp(key_sha1, subtree_sha1, subtree_sha1[19]))
@@ -249,6 +249,79 @@ static void note_tree_insert(struct int_node *tree, unsigned char n,
 	note_tree_insert(new_node, n + 1, entry, type);
 }
 
+/*
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
+static void note_tree_remove(struct int_node *tree, unsigned char n,
+		struct leaf_node *entry)
+{
+	struct leaf_node *l;
+	struct int_node *parent_stack[20];
+	unsigned char i, j;
+	void **p = note_tree_search(&tree, &n, entry->key_sha1);
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
+	parent_stack[0] = &root_node;
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
 /* Free the entire notes data contained in the given tree */
 static void note_tree_free(struct int_node *tree)
 {
@@ -379,6 +452,16 @@ void add_note(const unsigned char *object_sha1, const unsigned char *note_sha1)
 	note_tree_insert(&root_node, 0, l, PTR_TYPE_NOTE);
 }
 
+void remove_note(const unsigned char *object_sha1)
+{
+	struct leaf_node l;
+
+	assert(initialized);
+	hashcpy(l.key_sha1, object_sha1);
+	hashclr(l.val_sha1);
+	return note_tree_remove(&root_node, 0, &l);
+}
+
 static unsigned char *lookup_notes(const unsigned char *object_sha1)
 {
 	struct leaf_node *found = note_tree_find(&root_node, 0, object_sha1);
diff --git a/notes.h b/notes.h
index 5f22852..9e66855 100644
--- a/notes.h
+++ b/notes.h
@@ -25,6 +25,9 @@ void init_notes(const char *notes_ref, int flags);
 void add_note(const unsigned char *object_sha1,
 		const unsigned char *note_sha1);
 
+/* Remove the given note object from the internal notes tree structure */
+void remove_note(const unsigned char *object_sha1);
+
 /* Free (and de-initialize) the internal notes tree structure */
 void free_notes(void);
 
-- 
1.7.0.rc1.141.gd3fd

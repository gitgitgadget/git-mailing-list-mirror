From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 19/30] Notes API: prune_notes(): Prune notes that belong to
 non-existing objects
Date: Sat, 13 Feb 2010 22:28:27 +0100
Message-ID: <1266096518-2104-20-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:30:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPZH-0001iD-LT
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758116Ab0BMV3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:29:51 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62475 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758103Ab0BMV3k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:29:40 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00FKAUDF5490@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:39 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:39 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211545
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139846>

When an object is made unreachable by Git, any notes that annotate that object
are not automagically made unreachable, since all notes are always trivially
reachable from a notes ref. In order to remove notes for non-existing objects,
we therefore need to add functionality for traversing the notes tree and
explicitly removing references to notes that annotate non-reachable objects.
Thus the notes objects themselves also become unreachable, and are removed
by a later garbage collect.

prune_notes() performs this traversal (by using for_each_note() internally),
and removes the notes in question from the notes tree.

Note that the effect of prune_notes() is not persistent unless a subsequent
call to write_notes_tree() is made.

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |   39 +++++++++++++++++++++++++++++++++++++++
 notes.h |   12 ++++++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/notes.c b/notes.c
index d432517..3ba3e6d 100644
--- a/notes.c
+++ b/notes.c
@@ -749,6 +749,29 @@ static int write_each_note(const unsigned char *object_sha1,
 		write_each_note_helper(d->root, note_path, mode, note_sha1);
 }
 
+struct note_delete_list {
+	struct note_delete_list *next;
+	const unsigned char *sha1;
+};
+
+static int prune_notes_helper(const unsigned char *object_sha1,
+		const unsigned char *note_sha1, char *note_path,
+		void *cb_data)
+{
+	struct note_delete_list **l = (struct note_delete_list **) cb_data;
+	struct note_delete_list *n;
+
+	if (has_sha1_file(object_sha1))
+		return 0; /* nothing to do for this note */
+
+	/* failed to find object => prune this note */
+	n = (struct note_delete_list *) xmalloc(sizeof(*n));
+	n->next = *l;
+	n->sha1 = object_sha1;
+	*l = n;
+	return 0;
+}
+
 int combine_notes_concatenate(unsigned char *cur_sha1,
 		const unsigned char *new_sha1)
 {
@@ -922,6 +945,22 @@ int write_notes_tree(struct notes_tree *t, unsigned char *result)
 	return ret;
 }
 
+void prune_notes(struct notes_tree *t)
+{
+	struct note_delete_list *l = NULL;
+
+	if (!t)
+		t = &default_notes_tree;
+	assert(t->initialized);
+
+	for_each_note(t, 0, prune_notes_helper, &l);
+
+	while (l) {
+		remove_note(t, l->sha1);
+		l = l->next;
+	}
+}
+
 void free_notes(struct notes_tree *t)
 {
 	if (!t)
diff --git a/notes.h b/notes.h
index f98578f..bad03cc 100644
--- a/notes.h
+++ b/notes.h
@@ -162,6 +162,18 @@ int for_each_note(struct notes_tree *t, int flags, each_note_fn fn,
 int write_notes_tree(struct notes_tree *t, unsigned char *result);
 
 /*
+ * Remove all notes annotating non-existing objects from the given notes tree
+ *
+ * All notes in the given notes_tree that are associated with objects that no
+ * longer exist in the database, are removed from the notes tree.
+ *
+ * IMPORTANT: The changes made by prune_notes() to the given notes_tree
+ * structure are not persistent until a subsequent call to write_notes_tree()
+ * returns zero.
+ */
+void prune_notes(struct notes_tree *t);
+
+/*
  * Free (and de-initialize) the given notes_tree structure
  *
  * IMPORTANT: Changes made to the given notes_tree since the last, successful
-- 
1.7.0.rc1.141.gd3fd

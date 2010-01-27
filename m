From: Johan Herland <johan@herland.net>
Subject: [PATCHv12 19/23] Notes API: prune_notes(): Prune notes that belong to
 non-existing objects
Date: Wed, 27 Jan 2010 12:51:56 +0100
Message-ID: <1264593120-4428-20-git-send-email-johan@herland.net>
References: <1264593120-4428-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 27 12:53:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na6Sg-0000gj-AT
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 12:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758Ab0A0LxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 06:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753550Ab0A0Lw6
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 06:52:58 -0500
Received: from smtp.getmail.no ([84.208.15.66]:52954 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750893Ab0A0Lws (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 06:52:48 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00JDRMBZ2M00@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:52:47 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00EZ7MAZN340@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:52:47 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.27.113919
X-Mailer: git-send-email 1.6.6.405.g80ed6
In-reply-to: <1264593120-4428-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138142>

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
index f25643e..c0c9c5a 100644
--- a/notes.h
+++ b/notes.h
@@ -158,6 +158,18 @@ int for_each_note(struct notes_tree *t, int flags, each_note_fn fn,
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
1.6.6.405.g80ed6

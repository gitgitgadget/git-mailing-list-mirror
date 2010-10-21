From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 05/21] notes.h/c: Clarify the handling of notes objects that
 are == null_sha1
Date: Thu, 21 Oct 2010 04:08:40 +0200
Message-ID: <1287626936-32232-6-git-send-email-johan@herland.net>
References: <1287626936-32232-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 04:10:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8kby-0007sY-7n
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 04:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756880Ab0JUCJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 22:09:09 -0400
Received: from smtp.getmail.no ([84.208.15.66]:33116 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756859Ab0JUCJG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 22:09:06 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAM00IQGBB3YX70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Oct 2010 04:09:03 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 9FE0B1EA57FC_CBFA0BFB	for <git@vger.kernel.org>; Thu,
 21 Oct 2010 02:09:03 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 6DDCB1EA2846_CBFA0BFF	for <git@vger.kernel.org>; Thu,
 21 Oct 2010 02:09:03 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAM0096KBB03500@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Oct 2010 04:09:01 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1287626936-32232-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159464>

Clearly specify how combine_notes functions are expected to handle null_sha1
in input. Also specify (and implement) that returning null_sha1 from a
combine_notes function will cause the note in question to be removed.

Furthermore, document that passing note_sha1 == null_sha1 to add_note() is
usually a no-op, except in cases where combining it with an existing note
yields a new/changed result.

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |   12 +++++++++++-
 notes.h |   16 +++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/notes.c b/notes.c
index bfb3ea5..0c13a36 100644
--- a/notes.c
+++ b/notes.c
@@ -248,7 +248,10 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
 	switch (GET_PTR_TYPE(*p)) {
 	case PTR_TYPE_NULL:
 		assert(!*p);
-		*p = SET_PTR_TYPE(entry, type);
+		if (is_null_sha1(entry->val_sha1))
+			free(entry);
+		else
+			*p = SET_PTR_TYPE(entry, type);
 		return;
 	case PTR_TYPE_NOTE:
 		switch (type) {
@@ -264,6 +267,9 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
 					    sha1_to_hex(l->val_sha1),
 					    sha1_to_hex(entry->val_sha1),
 					    sha1_to_hex(l->key_sha1));
+
+				if (is_null_sha1(l->val_sha1))
+					note_tree_remove(t, tree, n, entry);
 				free(entry);
 				return;
 			}
@@ -295,6 +301,10 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
 	/* non-matching leaf_node */
 	assert(GET_PTR_TYPE(*p) == PTR_TYPE_NOTE ||
 	       GET_PTR_TYPE(*p) == PTR_TYPE_SUBTREE);
+	if (is_null_sha1(entry->val_sha1)) { /* skip insertion of empty note */
+		free(entry);
+		return;
+	}
 	new_node = (struct int_node *) xcalloc(sizeof(struct int_node), 1);
 	note_tree_insert(t, new_node, n + 1, l, GET_PTR_TYPE(*p),
 			 combine_notes);
diff --git a/notes.h b/notes.h
index 20db42f..79ea797 100644
--- a/notes.h
+++ b/notes.h
@@ -12,7 +12,10 @@
  * resulting SHA1 into the first SHA1 argument (cur_sha1). A non-zero return
  * value indicates failure.
  *
- * The two given SHA1s must both be non-NULL and different from each other.
+ * The two given SHA1s shall both be non-NULL and different from each other.
+ * Either of them (but not both) may be == null_sha1, which indicates an
+ * empty/non-existent note. If the resulting SHA1 (cur_sha1) is == null_sha1,
+ * the note will be removed from the notes tree.
  *
  * The default combine_notes function (you get this when passing NULL) is
  * combine_notes_concatenate(), which appends the contents of the new note to
@@ -90,6 +93,17 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 /*
  * Add the given note object to the given notes_tree structure
  *
+ * If there already exists a note for the given object_sha1, the given
+ * combine_notes function is invoked to break the tie. If not given (i.e.
+ * combine_notes == NULL), the default combine_notes function for the given
+ * notes_tree is used.
+ *
+ * Passing note_sha1 == null_sha1 indicates the addition of an
+ * empty/non-existent note. This is a (potentially expensive) no-op unless
+ * there already exists a note for the given object_sha1, AND combining that
+ * note with the empty note (using the given combine_notes function) results
+ * in a new/changed note.
+ *
  * IMPORTANT: The changes made by add_note() to the given notes_tree structure
  * are not persistent until a subsequent call to write_notes_tree() returns
  * zero.
-- 
1.7.3.98.g5ad7d9

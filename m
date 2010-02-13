From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 04/30] Notes API: init_notes(): Initialize the notes tree
 from the given notes ref
Date: Sat, 13 Feb 2010 22:28:12 +0100
Message-ID: <1266096518-2104-5-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:29:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPYK-00018f-JP
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758084Ab0BMV3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:29:08 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62140 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758076Ab0BMV3B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:29:01 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00FIUUCC5490@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:00 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:29:00 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211545
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139835>

Created by a simple refactoring of initialize_notes().

Also add a new 'flags' parameter, which is a bitwise combination of notes
initialization flags. For now, there is only one flag - NOTES_INIT_EMPTY -
which indicates that the notes tree should not auto-load the contents of
the given (or default) notes ref, but rather should leave the notes tree
initialized to an empty state. This will become useful in the future when
manipulating the notes tree through the notes API.

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |   30 ++++++++++++++++++------------
 notes.h |   20 ++++++++++++++++++++
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/notes.c b/notes.c
index 4ee4fec..3f4ae35 100644
--- a/notes.c
+++ b/notes.c
@@ -340,15 +340,28 @@ static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 	free(buf);
 }
 
-static void initialize_notes(const char *notes_ref_name)
+void init_notes(const char *notes_ref, int flags)
 {
 	unsigned char sha1[20], object_sha1[20];
 	unsigned mode;
 	struct leaf_node root_tree;
 
-	if (!notes_ref_name || read_ref(notes_ref_name, object_sha1) ||
-	    get_tree_entry(object_sha1, "", sha1, &mode))
+	assert(!initialized);
+	initialized = 1;
+
+	if (!notes_ref)
+		notes_ref = getenv(GIT_NOTES_REF_ENVIRONMENT);
+	if (!notes_ref)
+		notes_ref = notes_ref_name; /* value of core.notesRef config */
+	if (!notes_ref)
+		notes_ref = GIT_NOTES_DEFAULT_REF;
+
+	if (flags & NOTES_INIT_EMPTY || !notes_ref ||
+	    read_ref(notes_ref, object_sha1))
 		return;
+	if (get_tree_entry(object_sha1, "", sha1, &mode))
+		die("Failed to read notes tree referenced by %s (%s)",
+		    notes_ref, object_sha1);
 
 	hashclr(root_tree.key_sha1);
 	hashcpy(root_tree.val_sha1, sha1);
@@ -379,15 +392,8 @@ void format_note(const unsigned char *object_sha1, struct strbuf *sb,
 	unsigned long linelen, msglen;
 	enum object_type type;
 
-	if (!initialized) {
-		const char *env = getenv(GIT_NOTES_REF_ENVIRONMENT);
-		if (env)
-			notes_ref_name = getenv(GIT_NOTES_REF_ENVIRONMENT);
-		else if (!notes_ref_name)
-			notes_ref_name = GIT_NOTES_DEFAULT_REF;
-		initialize_notes(notes_ref_name);
-		initialized = 1;
-	}
+	if (!initialized)
+		init_notes(NULL, 0);
 
 	sha1 = lookup_notes(object_sha1);
 	if (!sha1)
diff --git a/notes.h b/notes.h
index d745ed1..6b52799 100644
--- a/notes.h
+++ b/notes.h
@@ -1,6 +1,26 @@
 #ifndef NOTES_H
 #define NOTES_H
 
+/*
+ * Flags controlling behaviour of notes tree initialization
+ *
+ * Default behaviour is to initialize the notes tree from the tree object
+ * specified by the given (or default) notes ref.
+ */
+#define NOTES_INIT_EMPTY 1
+
+/*
+ * Initialize internal notes tree structure with the notes tree at the given
+ * ref. If given ref is NULL, the value of the $GIT_NOTES_REF environment
+ * variable is used, and if that is missing, the default notes ref is used
+ * ("refs/notes/commits").
+ *
+ * If you need to re-intialize the internal notes tree structure (e.g. loading
+ * from a different notes ref), please first de-initialize the current notes
+ * tree by calling free_notes().
+ */
+void init_notes(const char *notes_ref, int flags);
+
 /* Free (and de-initialize) the internal notes tree structure */
 void free_notes(void);
 
-- 
1.7.0.rc1.141.gd3fd

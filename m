From: Johan Herland <johan@herland.net>
Subject: [PATCHv11 02/20] Notes API: get_commit_notes() -> format_note() +
 remove the commit restriction
Date: Sun, 17 Jan 2010 22:04:19 +0100
Message-ID: <1263762277-31419-3-git-send-email-johan@herland.net>
References: <1263762277-31419-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 17 22:06:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWcKJ-0007dl-D5
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 22:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767Ab0AQVFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 16:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754725Ab0AQVFJ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 16:05:09 -0500
Received: from smtp.getmail.no ([84.208.15.66]:56151 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754200Ab0AQVFA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jan 2010 16:05:00 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE002J6T8AY850@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:04:58 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE00CILT85S310@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:04:58 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.17.205416
X-Mailer: git-send-email 1.6.6.rc1.321.g0496e
In-reply-to: <1263762277-31419-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137329>

There is really no reason why only commit objects can be annotated. By
changing the struct commit parameter to get_commit_notes() into a sha1 we
gain the ability to annotate any object type. To reflect this in the function
naming as well, we rename get_commit_notes() to format_note().

This patch also fixes comments and variable names throughout notes.c as a
consequence of the removal of the unnecessary 'commit' restriction.

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c  |   33 ++++++++++++++++-----------------
 notes.h  |   11 ++++++++++-
 pretty.c |    8 ++++----
 3 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/notes.c b/notes.c
index 47e38a1..4ee4fec 100644
--- a/notes.c
+++ b/notes.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "commit.h"
 #include "notes.h"
 #include "utf8.h"
 #include "strbuf.h"
@@ -24,10 +23,10 @@ struct int_node {
 /*
  * Leaf nodes come in two variants, note entries and subtree entries,
  * distinguished by the LSb of the leaf node pointer (see above).
- * As a note entry, the key is the SHA1 of the referenced commit, and the
+ * As a note entry, the key is the SHA1 of the referenced object, and the
  * value is the SHA1 of the note object.
  * As a subtree entry, the key is the prefix SHA1 (w/trailing NULs) of the
- * referenced commit, using the last byte of the key to store the length of
+ * referenced object, using the last byte of the key to store the length of
  * the prefix. The value is the SHA1 of the tree object containing the notes
  * subtree.
  */
@@ -210,7 +209,7 @@ static void note_tree_insert(struct int_node *tree, unsigned char n,
 				if (concatenate_notes(l->val_sha1,
 						entry->val_sha1))
 					die("failed to concatenate note %s "
-					    "into note %s for commit %s",
+					    "into note %s for object %s",
 					    sha1_to_hex(entry->val_sha1),
 					    sha1_to_hex(l->val_sha1),
 					    sha1_to_hex(l->key_sha1));
@@ -298,7 +297,7 @@ static int get_sha1_hex_segment(const char *hex, unsigned int hex_len,
 static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 		unsigned int n)
 {
-	unsigned char commit_sha1[20];
+	unsigned char object_sha1[20];
 	unsigned int prefix_len;
 	void *buf;
 	struct tree_desc desc;
@@ -311,23 +310,23 @@ static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 
 	prefix_len = subtree->key_sha1[19];
 	assert(prefix_len * 2 >= n);
-	memcpy(commit_sha1, subtree->key_sha1, prefix_len);
+	memcpy(object_sha1, subtree->key_sha1, prefix_len);
 	while (tree_entry(&desc, &entry)) {
 		int len = get_sha1_hex_segment(entry.path, strlen(entry.path),
-				commit_sha1 + prefix_len, 20 - prefix_len);
+				object_sha1 + prefix_len, 20 - prefix_len);
 		if (len < 0)
 			continue; /* entry.path is not a SHA1 sum. Skip */
 		len += prefix_len;
 
 		/*
-		 * If commit SHA1 is complete (len == 20), assume note object
-		 * If commit SHA1 is incomplete (len < 20), assume note subtree
+		 * If object SHA1 is complete (len == 20), assume note object
+		 * If object SHA1 is incomplete (len < 20), assume note subtree
 		 */
 		if (len <= 20) {
 			unsigned char type = PTR_TYPE_NOTE;
 			struct leaf_node *l = (struct leaf_node *)
 				xcalloc(sizeof(struct leaf_node), 1);
-			hashcpy(l->key_sha1, commit_sha1);
+			hashcpy(l->key_sha1, object_sha1);
 			hashcpy(l->val_sha1, entry.sha1);
 			if (len < 20) {
 				if (!S_ISDIR(entry.mode))
@@ -343,12 +342,12 @@ static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 
 static void initialize_notes(const char *notes_ref_name)
 {
-	unsigned char sha1[20], commit_sha1[20];
+	unsigned char sha1[20], object_sha1[20];
 	unsigned mode;
 	struct leaf_node root_tree;
 
-	if (!notes_ref_name || read_ref(notes_ref_name, commit_sha1) ||
-	    get_tree_entry(commit_sha1, "", sha1, &mode))
+	if (!notes_ref_name || read_ref(notes_ref_name, object_sha1) ||
+	    get_tree_entry(object_sha1, "", sha1, &mode))
 		return;
 
 	hashclr(root_tree.key_sha1);
@@ -356,9 +355,9 @@ static void initialize_notes(const char *notes_ref_name)
 	load_subtree(&root_tree, &root_node, 0);
 }
 
-static unsigned char *lookup_notes(const unsigned char *commit_sha1)
+static unsigned char *lookup_notes(const unsigned char *object_sha1)
 {
-	struct leaf_node *found = note_tree_find(&root_node, 0, commit_sha1);
+	struct leaf_node *found = note_tree_find(&root_node, 0, object_sha1);
 	if (found)
 		return found->val_sha1;
 	return NULL;
@@ -371,7 +370,7 @@ void free_notes(void)
 	initialized = 0;
 }
 
-void get_commit_notes(const struct commit *commit, struct strbuf *sb,
+void format_note(const unsigned char *object_sha1, struct strbuf *sb,
 		const char *output_encoding, int flags)
 {
 	static const char utf8[] = "utf-8";
@@ -390,7 +389,7 @@ void get_commit_notes(const struct commit *commit, struct strbuf *sb,
 		initialized = 1;
 	}
 
-	sha1 = lookup_notes(commit->object.sha1);
+	sha1 = lookup_notes(object_sha1);
 	if (!sha1)
 		return;
 
diff --git a/notes.h b/notes.h
index a1421e3..d745ed1 100644
--- a/notes.h
+++ b/notes.h
@@ -4,10 +4,19 @@
 /* Free (and de-initialize) the internal notes tree structure */
 void free_notes(void);
 
+/* Flags controlling how notes are formatted */
 #define NOTES_SHOW_HEADER 1
 #define NOTES_INDENT 2
 
-void get_commit_notes(const struct commit *commit, struct strbuf *sb,
+/*
+ * Fill the given strbuf with the notes associated with the given object.
+ *
+ * If the internal notes structure is not initialized, it will be auto-
+ * initialized to the default value (see documentation for init_notes() above).
+ *
+ * 'flags' is a bitwise combination of the above formatting flags.
+ */
+void format_note(const unsigned char *object_sha1, struct strbuf *sb,
 		const char *output_encoding, int flags);
 
 #endif
diff --git a/pretty.c b/pretty.c
index 8f5bd1a..fe77090 100644
--- a/pretty.c
+++ b/pretty.c
@@ -775,8 +775,8 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 		}
 		return 0;	/* unknown %g placeholder */
 	case 'N':
-		get_commit_notes(commit, sb, git_log_output_encoding ?
-			     git_log_output_encoding : git_commit_encoding, 0);
+		format_note(commit->object.sha1, sb, git_log_output_encoding ?
+			    git_log_output_encoding : git_commit_encoding, 0);
 		return 1;
 	}
 
@@ -1095,8 +1095,8 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 		strbuf_addch(sb, '\n');
 
 	if (fmt != CMIT_FMT_ONELINE)
-		get_commit_notes(commit, sb, encoding,
-				 NOTES_SHOW_HEADER | NOTES_INDENT);
+		format_note(commit->object.sha1, sb, encoding,
+			    NOTES_SHOW_HEADER | NOTES_INDENT);
 
 	free(reencoded);
 }
-- 
1.6.6.rc1.321.g0496e

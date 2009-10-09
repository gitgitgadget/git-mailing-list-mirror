From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv7 15/22] Notes API: get_commit_notes() -> format_note() +
 remove the commit restriction
Date: Fri, 09 Oct 2009 12:22:11 +0200
Message-ID: <1255083738-23263-17-git-send-email-johan@herland.net>
References: <1255083738-23263-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 12:32:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwClV-0004PL-KY
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 12:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760709AbZJIKYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 06:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760704AbZJIKYk
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 06:24:40 -0400
Received: from smtp.getmail.no ([84.208.15.66]:54694 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760703AbZJIKYi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 06:24:38 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800BRWSUA9320@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:22:58 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KR800IEJST91V00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 09 Oct 2009 12:22:58 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.9.101220
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1255083738-23263-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129789>

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
index 50a4672..0f7082f 100644
--- a/notes.c
+++ b/notes.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "commit.h"
 #include "notes.h"
 #include "refs.h"
 #include "utf8.h"
@@ -25,10 +24,10 @@ struct int_node {
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
@@ -211,7 +210,7 @@ static void note_tree_insert(struct int_node *tree, unsigned char n,
 				if (concatenate_notes(l->val_sha1,
 						entry->val_sha1))
 					die("failed to concatenate note %s "
-					    "into note %s for commit %s",
+					    "into note %s for object %s",
 					    sha1_to_hex(entry->val_sha1),
 					    sha1_to_hex(l->val_sha1),
 					    sha1_to_hex(l->key_sha1));
@@ -299,7 +298,7 @@ static int get_sha1_hex_segment(const char *hex, unsigned int hex_len,
 static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 		unsigned int n)
 {
-	unsigned char commit_sha1[20];
+	unsigned char object_sha1[20];
 	unsigned int prefix_len;
 	void *buf;
 	struct tree_desc desc;
@@ -312,23 +311,23 @@ static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 
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
 				l->key_sha1[19] = (unsigned char) len;
@@ -342,12 +341,12 @@ static void load_subtree(struct leaf_node *subtree, struct int_node *node,
 
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
@@ -355,9 +354,9 @@ static void initialize_notes(const char *notes_ref_name)
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
@@ -370,7 +369,7 @@ void free_notes(void)
 	initialized = 0;
 }
 
-void get_commit_notes(const struct commit *commit, struct strbuf *sb,
+void format_note(const unsigned char *object_sha1, struct strbuf *sb,
 		const char *output_encoding, int flags)
 {
 	static const char utf8[] = "utf-8";
@@ -389,7 +388,7 @@ void get_commit_notes(const struct commit *commit, struct strbuf *sb,
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
index 7f350bb..81791f5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -703,8 +703,8 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 		format_decoration(sb, commit);
 		return 1;
 	case 'N':
-		get_commit_notes(commit, sb, git_log_output_encoding ?
-			     git_log_output_encoding : git_commit_encoding, 0);
+		format_note(commit->object.sha1, sb, git_log_output_encoding ?
+			    git_log_output_encoding : git_commit_encoding, 0);
 		return 1;
 	}
 
@@ -982,8 +982,8 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 		strbuf_addch(sb, '\n');
 
 	if (fmt != CMIT_FMT_ONELINE)
-		get_commit_notes(commit, sb, encoding,
-				 NOTES_SHOW_HEADER | NOTES_INDENT);
+		format_note(commit->object.sha1, sb, encoding,
+			    NOTES_SHOW_HEADER | NOTES_INDENT);
 
 	free(reencoded);
 }
-- 
1.6.4.304.g1365c.dirty

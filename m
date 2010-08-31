From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/2] notes: Don't create (empty) commit when removing non-existing notes
Date: Tue, 31 Aug 2010 17:56:50 +0200
Message-ID: <201008311756.50509.johan@herland.net>
References: <4C7CB8AF.5080008@atlas-elektronik.com> <4C7CD5B8.20602@atlas-elektronik.com> <201008311753.37433.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 31 17:56:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqTCl-00005D-6p
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912Ab0HaP4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 11:56:53 -0400
Received: from smtp.opera.com ([213.236.208.81]:49053 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786Ab0HaP4x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 11:56:53 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o7VFuoSu021914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 31 Aug 2010 15:56:50 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <201008311753.37433.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154925>

Extend remove_note() in the notes API to return whether or not a note was
actually removed. Use this in 'git notes remove' to skip the creation of
a notes commit when no notes were actually removed.

Also add a test illustrating the change in behavior.

Signed-off-by: Johan Herland <johan@herland.net>
---

This patch is against master.

 builtin/notes.c  |   14 ++++++++++----
 notes.c          |   14 ++++++++++----
 notes.h          |    4 +++-
 t/t3301-notes.sh |    7 +++++++
 4 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index fbc347c..6d07aac 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -769,6 +769,7 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
 	const char *object_ref;
 	struct notes_tree *t;
 	unsigned char object[20];
+	int retval;
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_notes_remove_usage, 0);
@@ -785,12 +786,17 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
 
 	t = init_notes_check("remove");
 
-	fprintf(stderr, "Removing note for object %s\n", sha1_to_hex(object));
-	remove_note(t, object);
+	retval = remove_note(t, object);
+	if (retval)
+		fprintf(stderr, "Object %s has no note\n", sha1_to_hex(object));
+	else {
+		fprintf(stderr, "Removing note for object %s\n",
+			sha1_to_hex(object));
 
-	commit_notes(t, "Notes removed by 'git notes remove'");
+		commit_notes(t, "Notes removed by 'git notes remove'");
+	}
 	free_notes(t);
-	return 0;
+	return retval;
 }
 
 static int prune(int argc, const char **argv, const char *prefix)
diff --git a/notes.c b/notes.c
index 7fd2035..70d0013 100644
--- a/notes.c
+++ b/notes.c
@@ -263,11 +263,13 @@ static int note_tree_consolidate(struct int_node *tree,
  * To remove a leaf_node:
  * Search to the tree location appropriate for the given leaf_node's key:
  * - If location does not hold a matching entry, abort and do nothing.
+ * - Copy the matching entry's value into the given entry.
  * - Replace the matching leaf_node with a NULL entry (and free the leaf_node).
  * - Consolidate int_nodes repeatedly, while walking up the tree towards root.
  */
-static void note_tree_remove(struct notes_tree *t, struct int_node *tree,
-		unsigned char n, struct leaf_node *entry)
+static void note_tree_remove(struct notes_tree *t,
+		struct int_node *tree, unsigned char n,
+		struct leaf_node *entry)
 {
 	struct leaf_node *l;
 	struct int_node *parent_stack[20];
@@ -282,6 +284,7 @@ static void note_tree_remove(struct notes_tree *t, struct int_node *tree,
 		return; /* key mismatch, nothing to remove */
 
 	/* we have found a matching entry */
+	hashcpy(entry->val_sha1, l->val_sha1);
 	free(l);
 	*p = SET_PTR_TYPE(NULL, PTR_TYPE_NULL);
 
@@ -1003,17 +1006,20 @@ void add_note(struct notes_tree *t, const unsigned char *object_sha1,
 	note_tree_insert(t, t->root, 0, l, PTR_TYPE_NOTE, combine_notes);
 }
 
-void remove_note(struct notes_tree *t, const unsigned char *object_sha1)
+int remove_note(struct notes_tree *t, const unsigned char *object_sha1)
 {
 	struct leaf_node l;
 
 	if (!t)
 		t = &default_notes_tree;
 	assert(t->initialized);
-	t->dirty = 1;
 	hashcpy(l.key_sha1, object_sha1);
 	hashclr(l.val_sha1);
 	note_tree_remove(t, t->root, 0, &l);
+	if (is_null_sha1(l.val_sha1)) // no note was removed
+		return 1;
+	t->dirty = 1;
+	return 0;
 }
 
 const unsigned char *get_note(struct notes_tree *t,
diff --git a/notes.h b/notes.h
index 65fc3a6..5106761 100644
--- a/notes.h
+++ b/notes.h
@@ -89,8 +89,10 @@ void add_note(struct notes_tree *t, const unsigned char *object_sha1,
  * IMPORTANT: The changes made by remove_note() to the given notes_tree
  * structure are not persistent until a subsequent call to write_notes_tree()
  * returns zero.
+ *
+ * Return 0 if a note was removed; 1 if there was no note to remove.
  */
-void remove_note(struct notes_tree *t, const unsigned char *object_sha1);
+int remove_note(struct notes_tree *t, const unsigned char *object_sha1);
 
 /*
  * Get the note object SHA1 containing the note data for the given object
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 96b7581..a2b79a0 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -365,6 +365,13 @@ c18dc024e14f08d18d14eea0d747ff692d66d6a3 1584215f1d29c65e99c6c6848626553fdd07fd7
 c9c6af7f78bc47490dbf3e822cf2f3c24d4b9061 268048bfb8a1fb38e703baceb8ab235421bf80c5
 EOF
 
+test_expect_success 'removing non-existing note should not create new commit' '
+	git rev-parse --verify refs/notes/commits > before_commit &&
+	test_must_fail git notes remove HEAD^ &&
+	git rev-parse --verify refs/notes/commits > after_commit &&
+	test_cmp before_commit after_commit
+'
+
 test_expect_success 'list notes with "git notes list"' '
 	git notes list > output &&
 	test_cmp expect output
-- 
1.7.2.220.gea1d3

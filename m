From: Thomas Rast <trast@student.ethz.ch>
Subject: [WIP/RFC PATCH] Support showing notes from more than one notes tree
Date: Sat, 20 Feb 2010 15:58:47 +0100
Message-ID: <8c3f1d66d306747d777f04621f1d43d7e07ddc6a.1266677264.git.trast@student.ethz.ch>
References: <7v7hqcww7z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 20 15:59:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Niqnd-0000Id-UL
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 15:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480Ab0BTO7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 09:59:13 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:15036 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281Ab0BTO7L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 09:59:11 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 15:59:08 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 15:58:47 +0100
X-Mailer: git-send-email 1.7.0.143.gbf2a7.dirty
In-Reply-To: <7v7hqcww7z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140531>

With this patch, you can set notes.displayRef to a glob that points at
your favourite notes refs, e.g.,

[notes]
	displayRef = refs/notes/*

Then git-log and friends will show notes from all trees.
---

I'm running out of git time today, so I'm floating this weatherbaloon
to demonstrate how I would like to get around the limitations
discussed by Junio:

> I was envisioning that most of the time people would want to read from
> (and probably concatenate, or output with the origin information tagged in)
> multiple notes but want to create into a single one.  But updating for
> rewritten commits fundamentally need to happen in all of these multiple
> notes trees they would want to read from.

This patch is the display-several-trees bit.  I'm assuming that it's
ok to load all notes trees at once.  (Obviously it lacks docs, and it
also breaks test because of the new formatting that shows 'Notes from
notes/someref'.  Please ignore those for now.)

My actual intent was to allow more than one notes.displayref config
setting, and loading all of them.  But this doesn't seem to work; a
debugging print confirms that notes_display_config sees the entry, but
another debugging print shows that it only ever loads one of them.
What am I doing wrong?

I plan on having another set of configs called notes.rewriteRef that
gives the list of refs that should have their notes rewritten
automatically along with their commits.  [The rewriteMode setting
could become '<mode> for <ref>' if we want to let the user configure
it on a per-ref/glob basis.]

Finally, git-notes should probably grow a --ref option that serves as
a more convenient way of setting GIT_NOTES_REF.


 notes.c  |   82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 notes.h  |    1 +
 pretty.c |    6 ++--
 3 files changed, 80 insertions(+), 9 deletions(-)

diff --git a/notes.c b/notes.c
index a5ff723..47eaa21 100644
--- a/notes.c
+++ b/notes.c
@@ -5,6 +5,8 @@
 #include "utf8.h"
 #include "strbuf.h"
 #include "tree-walk.h"
+#include "string-list.h"
+#include "refs.h"
 
 /*
  * Use a non-balancing simple 16-tree structure with struct int_node as
@@ -68,6 +70,9 @@ struct non_note {
 
 struct notes_tree default_notes_tree;
 
+struct string_list display_notes_refs;
+struct notes_tree **display_notes_trees;
+
 static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		struct int_node *node, unsigned int n);
 
@@ -828,6 +833,36 @@ int combine_notes_ignore(unsigned char *cur_sha1,
 	return 0;
 }
 
+static int read_one_display_ref(const char *path, const unsigned char *sha1,
+				int flag, void *cb)
+{
+	string_list_insert(path, &display_notes_refs);
+	return 0;
+}
+
+
+static int notes_display_config(const char *k, const char *v, void *cb)
+{
+	if (!strcmp(k, "notes.displayref")) {
+		for_each_glob_ref(read_one_display_ref, v, NULL);
+		return 0;
+	}
+
+	return 0;
+}
+
+static const char *default_notes_ref()
+{
+	const char *notes_ref = NULL;
+	if (!notes_ref)
+		notes_ref = getenv(GIT_NOTES_REF_ENVIRONMENT);
+	if (!notes_ref)
+		notes_ref = notes_ref_name; /* value of core.notesRef config */
+	if (!notes_ref)
+		notes_ref = GIT_NOTES_DEFAULT_REF;
+	return notes_ref;
+}
+
 void init_notes(struct notes_tree *t, const char *notes_ref,
 		combine_notes_fn combine_notes, int flags)
 {
@@ -840,11 +875,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	assert(!t->initialized);
 
 	if (!notes_ref)
-		notes_ref = getenv(GIT_NOTES_REF_ENVIRONMENT);
-	if (!notes_ref)
-		notes_ref = notes_ref_name; /* value of core.notesRef config */
-	if (!notes_ref)
-		notes_ref = GIT_NOTES_DEFAULT_REF;
+		notes_ref = default_notes_ref();
 
 	if (!combine_notes)
 		combine_notes = combine_notes_concatenate;
@@ -868,6 +899,29 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	load_subtree(t, &root_tree, t->root, 0);
 }
 
+static int load_one_display_note_ref(struct string_list_item *item,
+				     void *cb_data)
+{
+	int *counter = cb_data;
+	struct notes_tree *t = xcalloc(1, sizeof(struct notes_tree));
+	init_notes(t, item->string, combine_notes_ignore, 0);
+	display_notes_trees[(*counter)++] = t;
+	return 0;
+}
+
+void init_display_notes()
+{
+	int cb_counter = 0;
+	string_list_insert(default_notes_ref(), &display_notes_refs);
+	display_notes_refs.strdup_strings = 1;
+	git_config(notes_display_config, NULL);
+	display_notes_trees = xmalloc((display_notes_refs.nr+1)
+				      * sizeof(struct notes_tree *));
+	for_each_string_list(load_one_display_note_ref,
+			     &display_notes_refs, &cb_counter);
+	display_notes_trees[cb_counter] = NULL;
+}
+
 void add_note(struct notes_tree *t, const unsigned char *object_sha1,
 		const unsigned char *note_sha1, combine_notes_fn combine_notes)
 {
@@ -1016,7 +1070,12 @@ void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 	if (msglen && msg[msglen - 1] == '\n')
 		msglen--;
 
-	if (flags & NOTES_SHOW_HEADER)
+	if (flags & NOTES_SHOW_HEADER_WITH_REF && t->ref) {
+		const char *ref = t->ref;
+		if (!prefixcmp(ref, "refs/"))
+			ref += 5;
+		strbuf_addf(sb, "\nNotes from %s:\n", ref);
+	} else if (flags & (NOTES_SHOW_HEADER|NOTES_SHOW_HEADER_WITH_REF))
 		strbuf_addstr(sb, "\nNotes:\n");
 
 	for (msg_p = msg; msg_p < msg + msglen; msg_p += linelen + 1) {
@@ -1031,6 +1090,17 @@ void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 	free(msg);
 }
 
+void format_display_notes(const unsigned char *object_sha1,
+			  struct strbuf *sb, const char *output_encoding, int flags)
+{
+	int i;
+	if (!display_notes_trees)
+		init_display_notes();
+	for (i = 0; display_notes_trees[i]; i++)
+		format_note(display_notes_trees[i], object_sha1, sb,
+			    output_encoding, flags);
+}
+
 int copy_note(struct notes_tree *t,
 	      const unsigned char *from_obj, const unsigned char *to_obj,
 	      int force, combine_notes_fn combine_fn)
diff --git a/notes.h b/notes.h
index b7547bf..f6a5229 100644
--- a/notes.h
+++ b/notes.h
@@ -193,6 +193,7 @@ int for_each_note(struct notes_tree *t, int flags, each_note_fn fn,
 /* Flags controlling how notes are formatted */
 #define NOTES_SHOW_HEADER 1
 #define NOTES_INDENT 2
+#define NOTES_SHOW_HEADER_WITH_REF 4
 
 /*
  * Fill the given strbuf with the notes associated with the given object.
diff --git a/pretty.c b/pretty.c
index f999485..c185fd2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -775,7 +775,7 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 		}
 		return 0;	/* unknown %g placeholder */
 	case 'N':
-		format_note(NULL, commit->object.sha1, sb,
+		format_display_notes(commit->object.sha1, sb,
 			    git_log_output_encoding ? git_log_output_encoding
 						    : git_commit_encoding, 0);
 		return 1;
@@ -1096,8 +1096,8 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 		strbuf_addch(sb, '\n');
 
 	if (context->show_notes)
-		format_note(NULL, commit->object.sha1, sb, encoding,
-			    NOTES_SHOW_HEADER | NOTES_INDENT);
+		format_display_notes(commit->object.sha1, sb, encoding,
+				     NOTES_SHOW_HEADER_WITH_REF | NOTES_INDENT);
 
 	free(reencoded);
 }
-- 
1.7.0.143.gbf2a7.dirty

From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v3 07/12] notes: implement helpers needed for note copying during rewrite
Date: Sat, 20 Feb 2010 23:16:28 +0100
Message-ID: <9f4cb8a577e853378c1d3136b54a5e73ac29dc22.1266703765.git.trast@student.ethz.ch>
References: <cover.1266703765.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 20 23:42:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nixda-0006LF-Vb
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 23:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756893Ab0BTWRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 17:17:14 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:6942 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756689Ab0BTWRH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 17:17:07 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 23:16:57 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 20 Feb
 2010 23:16:38 +0100
X-Mailer: git-send-email 1.7.0.137.gfe3f1
In-Reply-To: <cover.1266703765.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140563>

Implement helper functions to load the rewriting config, and to
actually copy the notes.  Also document the config.

Secondly, also implement an undocumented --for-rewrite=<cmd> option to
'git notes copy' which is used like --stdin, but also puts the
configuration for <cmd> into effect.  It will be needed to support the
copying in git-rebase.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/config.txt    |   23 ++++++++
 Documentation/git-notes.txt |    4 ++
 Documentation/githooks.txt  |    4 ++
 builtin-notes.c             |  121 ++++++++++++++++++++++++++++++++++++++++---
 builtin.h                   |   16 ++++++
 t/t3301-notes.sh            |  118 +++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 277 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3c5cfec..9c3b337 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1311,6 +1311,29 @@ The effective value of "core.notesRef" (possibly overridden by
 GIT_NOTES_REF) is also implicitly added to the list of refs to be
 displayed.
 
+notes.rewrite.<command>::
+	When rewriting commits with <command> (currently `amend` or
+	`rebase`) and this variable is set to `true`, git
+	automatically copies your notes from the original to the
+	rewritten commit.  Defaults to `true`, but see
+	"notes.rewriteRef" below.
+
+notes.rewriteMode::
+	When copying notes during a rewrite (see the
+	"notes.rewrite.<command>" option), determines what to do if
+	the target commit already has a note.  Must be one of
+	`overwrite`, `concatenate`, or `ignore`.  Defaults to
+	`concatenate`.
+
+notes.rewriteRef::
+	When copying notes during a rewrite, specifies the ref whose
+	notes should be copied.  The ref may be a glob, in which case
+	notes in all matching refs will be copied.  You may also
+	specify this configuration several times.
++
+Does not have a default value; you must configure this variable to
+enable note rewriting.
+
 pack.window::
 	The size of the window used by linkgit:git-pack-objects[1] when no
 	window size is given on the command line. Defaults to 10.
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index f67cb6a..92f1249 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -34,6 +34,10 @@ the empty string.  Alternatively, you can set it to a different ref,
 something like "refs/notes/bugzilla".  This setting can be overridden
 by the environment variable "GIT_NOTES_REF".
 
+See the description of "notes.rewrite.<command>" in
+linkgit:git-config[1] for a way of carrying your notes across commands
+that rewrite commits.
+
 
 SUBCOMMANDS
 -----------
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 41895e9..c33a38e 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -335,6 +335,10 @@ The 'extra-info' is again command-dependent.  If it is empty, the
 preceding SP is also omitted.  Currently, no commands pass any
 'extra-info'.
 
+The hook always runs after the automatic note copying (see
+"notes.rewrite.<command>" in linkgit:git-config.txt) has happened, and
+thus has access to these notes.
+
 The following command-specific comments apply:
 
 rebase::
diff --git a/builtin-notes.c b/builtin-notes.c
index 62f6ceb..19dd3ab 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -16,6 +16,7 @@
 #include "exec_cmd.h"
 #include "run-command.h"
 #include "parse-options.h"
+#include "string-list.h"
 
 static const char * const git_notes_usage[] = {
 	"git notes [list [<object>]]",
@@ -278,15 +279,104 @@ int commit_notes(struct notes_tree *t, const char *msg)
 	return 0;
 }
 
-int notes_copy_from_stdin(int force)
+
+combine_notes_fn *parse_combine_notes_fn(const char *v)
+{
+	if (!strcasecmp(v, "overwrite"))
+		return combine_notes_overwrite;
+	else if (!strcasecmp(v, "ignore"))
+		return combine_notes_ignore;
+	else if (!strcasecmp(v, "concatenate"))
+		return combine_notes_concatenate;
+	else
+		return NULL;
+}
+
+static int notes_rewrite_config(const char *k, const char *v, void *cb)
+{
+	struct notes_rewrite_cfg *c = cb;
+	if (!prefixcmp(k, "notes.rewrite.") && !strcmp(k+14, c->cmd)) {
+		c->enabled = git_config_bool(k, v);
+		return 0;
+	} else if (!strcmp(k, "notes.rewritemode")) {
+		c->combine = parse_combine_notes_fn(v);
+		if (!c->combine) {
+			error("Bad notes.rewriteMode value: '%s'", v);
+			return 1;
+		}
+		return 0;
+	} else if (!strcmp(k, "notes.rewriteref")) {
+		/* note that a refs/ prefix is implied in the
+		 * underlying for_each_glob_ref */
+		if (!prefixcmp(v, "refs/notes/") || !prefixcmp(v, "notes/"))
+			string_list_add_refs_by_glob(c->refs, v);
+		else
+			warning("Refusing to rewrite notes in %s"
+				" (outside of refs/notes/)", v);
+		return 0;
+	}
+
+	return 0;
+}
+
+
+struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
+{
+	struct notes_rewrite_cfg *c = xmalloc(sizeof(struct notes_rewrite_cfg));
+	c->cmd = cmd;
+	c->enabled = 1;
+	c->combine = combine_notes_concatenate;
+	c->refs = xcalloc(1, sizeof(struct string_list));
+	c->refs->strdup_strings = 1;
+	git_config(notes_rewrite_config, c);
+	if (!c->enabled || !c->refs->nr) {
+		string_list_clear(c->refs, 0);
+		free(c->refs);
+		free(c);
+		return NULL;
+	}
+	c->trees = load_notes_trees(c->refs);
+	string_list_clear(c->refs, 0);
+	free(c->refs);
+	return c;
+}
+
+int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
+			  const unsigned char *from_obj, const unsigned char *to_obj)
+{
+	int ret = 0;
+	int i;
+	for (i = 0; c->trees[i]; i++)
+		ret = copy_note(c->trees[i], from_obj, to_obj, 1, c->combine) || ret;
+	return ret;
+}
+
+void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c)
+{
+	int i;
+	for (i = 0; c->trees[i]; i++) {
+		commit_notes(c->trees[i], "Notes added by 'git notes copy'");
+		free_notes(c->trees[i]);
+	}
+	free(c->trees);
+	free(c);
+}
+
+int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct notes_tree *t;
 	struct notes_rewrite_cfg *c = NULL;
 	int ret = 0;
 
-	init_notes(NULL, NULL, NULL, 0);
-	t = &default_notes_tree;
+	if (rewrite_cmd) {
+		c = init_copy_notes_for_rewrite(rewrite_cmd);
+		if (!c)
+			return 0;
+	} else {
+		init_notes(NULL, NULL, NULL, 0);
+		t = &default_notes_tree;
+	}
 
 	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
 		unsigned char from_obj[20], to_obj[20];
@@ -303,7 +393,11 @@ int notes_copy_from_stdin(int force)
 		if (get_sha1(split[1]->buf, to_obj))
 			die("Failed to resolve '%s' as a valid ref.", split[1]->buf);
 
-		err = copy_note(t, from_obj, to_obj, force, combine_notes_overwrite);
+		if (rewrite_cmd)
+			err = copy_note_for_rewrite(c, from_obj, to_obj);
+		else
+			err = copy_note(t, from_obj, to_obj, force,
+					combine_notes_overwrite);
 
 		if (err) {
 			error("Failed to copy notes from '%s' to '%s'",
@@ -314,8 +408,12 @@ int notes_copy_from_stdin(int force)
 		strbuf_list_free(split);
 	}
 
-	commit_notes(t, "Notes added by 'git notes copy'");
-	free_notes(t);
+	if (!rewrite_cmd) {
+		commit_notes(t, "Notes added by 'git notes copy'");
+		free_notes(t);
+	} else {
+		finish_copy_notes_for_rewrite(c);
+	}
 	return ret;
 }
 
@@ -331,6 +429,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	    remove = 0, prune = 0, force = 0, from_stdin = 0;
 	int given_object = 0, i = 1, retval = 0;
 	struct msg_arg msg = { 0, 0, STRBUF_INIT };
+	const char *rewrite_cmd = NULL;
 	struct option options[] = {
 		OPT_GROUP("Notes options"),
 		OPT_CALLBACK('m', "message", &msg, "MSG",
@@ -343,6 +442,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 			   "reuse specified note object", parse_reuse_arg),
 		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
 		OPT_BOOLEAN(0, "stdin", &from_stdin, "read objects from stdin"),
+		OPT_STRING(0, "for-rewrite", &rewrite_cmd, "command",
+			   "load rewriting config for <command> (implies --stdin)"),
 		OPT_END()
 	};
 
@@ -391,6 +492,10 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_usage, options);
 	}
 
+	if (!copy && rewrite_cmd) {
+		error("cannot use --for-rewrite with %s subcommand.", argv[0]);
+		usage_with_options(git_notes_usage, options);
+	}
 	if (!copy && from_stdin) {
 		error("cannot use --stdin with %s subcommand.", argv[0]);
 		usage_with_options(git_notes_usage, options);
@@ -398,12 +503,12 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
 	if (copy) {
 		const char *from_ref;
-		if (from_stdin) {
+		if (from_stdin || rewrite_cmd) {
 			if (argc > 1) {
 				error("too many parameters");
 				usage_with_options(git_notes_usage, options);
 			} else {
-				return notes_copy_from_stdin(force);
+				return notes_copy_from_stdin(force, rewrite_cmd);
 			}
 		}
 		if (argc < 3) {
diff --git a/builtin.h b/builtin.h
index cdf9847..1508db6 100644
--- a/builtin.h
+++ b/builtin.h
@@ -20,6 +20,22 @@ extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author);
 extern int commit_notes(struct notes_tree *t, const char *msg);
+
+struct notes_rewrite_cfg
+{
+	struct notes_tree **trees;
+	const char *cmd;
+	int enabled;
+	combine_notes_fn *combine;
+	struct string_list *refs;
+};
+
+combine_notes_fn *parse_combine_notes_fn(const char *v);
+struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd);
+int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
+			  const unsigned char *from_obj, const unsigned char *to_obj);
+void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c);
+
 extern int check_pager_config(const char *cmd);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 634d213..5a0dccd 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -684,6 +684,7 @@ test_expect_success 'cannot copy note from object without notes' '
 '
 
 cat > expect << EOF
+commit e5d4fb5698d564ab8c73551538ecaf2b0c666185
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:25:13 2005 -0700
 
@@ -694,6 +695,7 @@ Notes from notes/other:
 $whitespace
     yet another note
 
+commit 7038787dfe22a14c3867ce816dbba39845359719
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 15:24:13 2005 -0700
 
@@ -710,9 +712,123 @@ test_expect_success 'git notes copy --stdin' '
 	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
 	git notes copy --stdin &&
 	git log -2 > output &&
-	strip_then_cmp expect output &&
+	test_cmp expect output &&
 	test "$(git notes list HEAD)" = "$(git notes list HEAD~2)" &&
 	test "$(git notes list HEAD^)" = "$(git notes list HEAD~3)"
 '
 
+cat > expect << EOF
+commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:27:13 2005 -0700
+
+    15th
+
+commit be28d8b4d9951ad940d229ee3b0b9ee3b1ec273d
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:26:13 2005 -0700
+
+    14th
+EOF
+
+test_expect_success 'git notes copy --for-rewrite (unconfigured)' '
+	test_commit 14th &&
+	test_commit 15th &&
+	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^); \
+	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
+	git notes copy --for-rewrite=foo &&
+	git log -2 > output &&
+	test_cmp expect output
+'
+
+cat > expect << EOF
+commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:27:13 2005 -0700
+
+    15th
+
+Notes from notes/other:
+    yet another note
+$whitespace
+    yet another note
+
+commit be28d8b4d9951ad940d229ee3b0b9ee3b1ec273d
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:26:13 2005 -0700
+
+    14th
+
+Notes from notes/other:
+    other note
+$whitespace
+    yet another note
+EOF
+
+test_expect_success 'git notes copy --for-rewrite (enabled)' '
+	git config notes.rewriteMode overwrite &&
+	git config notes.rewriteRef "refs/notes/*" &&
+	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^); \
+	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
+	git notes copy --for-rewrite=foo &&
+	git log -2 > output &&
+	test_cmp expect output
+'
+
+test_expect_success 'git notes copy --for-rewrite (disabled)' '
+	git config notes.rewrite.bar false &&
+	echo $(git rev-parse HEAD~3) $(git rev-parse HEAD) |
+	git notes copy --for-rewrite=bar &&
+	git log -2 > output &&
+	test_cmp expect output
+'
+
+cat > expect << EOF
+commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:27:13 2005 -0700
+
+    15th
+
+Notes from notes/other:
+    a fresh note
+EOF
+
+test_expect_success 'git notes copy --for-rewrite (overwrite)' '
+	git notes add -f -m"a fresh note" HEAD^ &&
+	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
+	git notes copy --for-rewrite=foo &&
+	git log -1 > output &&
+	test_cmp expect output
+'
+
+test_expect_success 'git notes copy --for-rewrite (ignore)' '
+	git config notes.rewriteMode ignore &&
+	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
+	git notes copy --for-rewrite=foo &&
+	git log -1 > output &&
+	test_cmp expect output
+'
+
+cat > expect << EOF
+commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:27:13 2005 -0700
+
+    15th
+
+Notes from notes/other:
+    a fresh note
+    another fresh note
+EOF
+
+test_expect_success 'git notes copy --for-rewrite (append)' '
+	git notes add -f -m"another fresh note" HEAD^ &&
+	git config notes.rewriteMode concatenate &&
+	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
+	git notes copy --for-rewrite=foo &&
+	git log -1 > output &&
+	test_cmp expect output
+'
+
 test_done
-- 
1.7.0.59.g783f8

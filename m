From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 08/11] notes: implement helpers needed for note copying during rewrite
Date: Mon, 22 Feb 2010 01:10:21 +0100
Message-ID: <4006267bef22c62d9cf79377d2f24a75ed69799c.1266797028.git.trast@student.ethz.ch>
References: <cover.1266797028.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 02:08:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjLtO-0000EH-Mz
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 01:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910Ab0BVALG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 19:11:06 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:28109 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753796Ab0BVAK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 19:10:58 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 01:10:51 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 01:10:33 +0100
X-Mailer: git-send-email 1.7.0.147.g5aeb9
In-Reply-To: <cover.1266797028.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140630>

Implement helper functions to load the rewriting config, and to
actually copy the notes.  Also document the config.

Secondly, also implement an undocumented --for-rewrite=<cmd> option to
'git notes copy' which is used like --stdin, but also puts the
configuration for <cmd> into effect.  It will be needed to support the
copying in git-rebase.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Changes since v3: introduced GIT_NOTES_REWRITE_REF and _MODE.
* more tests

 Documentation/config.txt    |   30 +++++++
 Documentation/git-notes.txt |    4 +
 Documentation/githooks.txt  |    4 +
 builtin-notes.c             |  139 +++++++++++++++++++++++++++++--
 builtin.h                   |   18 ++++
 cache.h                     |    2 +
 notes.h                     |    1 +
 t/t3301-notes.sh            |  195 +++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh               |    2 +
 9 files changed, 387 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a0f2b0f..46adaf1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1317,6 +1317,36 @@ The effective value of "core.notesRef" (possibly overridden by
 GIT_NOTES_REF) is also implicitly added to the list of refs to be
 displayed.
 
+notes.rewrite.<command>::
+	When rewriting commits with <command> (currently `amend` or
+	`rebase`) and this variable is set to `true`, git
+	automatically copies your notes from the original to the
+	rewritten commit.  Defaults to `true`, but see
+	"notes.rewriteRef" below.
++
+This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
+environment variable, which must be a colon (or semicolon) separated
+list of refs or globs.
+
+notes.rewriteMode::
+	When copying notes during a rewrite (see the
+	"notes.rewrite.<command>" option), determines what to do if
+	the target commit already has a note.  Must be one of
+	`overwrite`, `concatenate`, or `ignore`.  Defaults to
+	`concatenate`.
++
+This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
+environment variable.
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
index daeb14e..8c65709 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -16,6 +16,7 @@
 #include "exec_cmd.h"
 #include "run-command.h"
 #include "parse-options.h"
+#include "string-list.h"
 
 static const char * const git_notes_usage[] = {
 	"git notes [list [<object>]]",
@@ -278,14 +279,121 @@ int commit_notes(struct notes_tree *t, const char *msg)
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
+	} else if (!c->mode_from_env && !strcmp(k, "notes.rewritemode")) {
+		if (!v)
+			config_error_nonbool(k);
+		c->combine = parse_combine_notes_fn(v);
+		if (!c->combine) {
+			error("Bad notes.rewriteMode value: '%s'", v);
+			return 1;
+		}
+		return 0;
+	} else if (!c->refs_from_env && !strcmp(k, "notes.rewriteref")) {
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
+	const char *rewrite_mode_env = getenv(GIT_NOTES_REWRITE_MODE_ENVIRONMENT);
+	const char *rewrite_refs_env = getenv(GIT_NOTES_REWRITE_REF_ENVIRONMENT);
+	c->cmd = cmd;
+	c->enabled = 1;
+	c->combine = combine_notes_concatenate;
+	c->refs = xcalloc(1, sizeof(struct string_list));
+	c->refs->strdup_strings = 1;
+	c->refs_from_env = 0;
+	c->mode_from_env = 0;
+	if (rewrite_mode_env) {
+		c->mode_from_env = 1;
+		c->combine = parse_combine_notes_fn(rewrite_mode_env);
+		if (!c->combine)
+			error("Bad " GIT_NOTES_REWRITE_MODE_ENVIRONMENT
+			      " value: '%s'", rewrite_mode_env);
+	}
+	if (rewrite_refs_env) {
+		c->refs_from_env = 1;
+		string_list_add_refs_from_glob_list(c->refs, rewrite_refs_env);
+	}
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
+	struct notes_rewrite_cfg *c = NULL;
 	struct notes_tree *t;
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
@@ -302,7 +410,11 @@ int notes_copy_from_stdin(int force)
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
@@ -313,8 +425,12 @@ int notes_copy_from_stdin(int force)
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
 
@@ -330,6 +446,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	    remove = 0, prune = 0, force = 0, from_stdin = 0;
 	int given_object = 0, i = 1, retval = 0;
 	struct msg_arg msg = { 0, 0, STRBUF_INIT };
+	const char *rewrite_cmd = NULL;
 	struct option options[] = {
 		OPT_GROUP("Notes options"),
 		OPT_CALLBACK('m', "message", &msg, "MSG",
@@ -342,6 +459,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 			   "reuse specified note object", parse_reuse_arg),
 		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
 		OPT_BOOLEAN(0, "stdin", &from_stdin, "read objects from stdin"),
+		OPT_STRING(0, "for-rewrite", &rewrite_cmd, "command",
+			   "load rewriting config for <command> (implies --stdin)"),
 		OPT_END()
 	};
 
@@ -390,6 +509,10 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_usage, options);
 	}
 
+	if (!copy && rewrite_cmd) {
+		error("cannot use --for-rewrite with %s subcommand.", argv[0]);
+		usage_with_options(git_notes_usage, options);
+	}
 	if (!copy && from_stdin) {
 		error("cannot use --stdin with %s subcommand.", argv[0]);
 		usage_with_options(git_notes_usage, options);
@@ -397,12 +520,12 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
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
index cdf9847..8aebe61 100644
--- a/builtin.h
+++ b/builtin.h
@@ -20,6 +20,24 @@ extern int commit_tree(const char *msg, unsigned char *tree,
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
+	int refs_from_env;
+	int mode_from_env;
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
diff --git a/cache.h b/cache.h
index 445ce16..ab740e3 100644
--- a/cache.h
+++ b/cache.h
@@ -388,6 +388,8 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_NOTES_REF_ENVIRONMENT "GIT_NOTES_REF"
 #define GIT_NOTES_DEFAULT_REF "refs/notes/commits"
 #define GIT_NOTES_DISPLAY_REF_ENVIRONMENT "GIT_NOTES_DISPLAY_REF"
+#define GIT_NOTES_REWRITE_REF_ENVIRONMENT "GIT_NOTES_REWRITE_REF"
+#define GIT_NOTES_REWRITE_MODE_ENVIRONMENT "GIT_NOTES_REWRITE_MODE"
 
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
diff --git a/notes.h b/notes.h
index fb09537..1f48af3 100644
--- a/notes.h
+++ b/notes.h
@@ -213,5 +213,6 @@ void format_display_notes(const unsigned char *object_sha1,
 
 struct notes_tree **load_notes_trees(struct string_list *refs);
 void string_list_add_refs_by_glob(struct string_list *list, const char *glob);
+void string_list_add_refs_from_glob_list(struct string_list *list, const char *globs);
 
 #endif
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 40c17f1..34a993c 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -777,4 +777,199 @@ test_expect_success 'git notes copy --stdin' '
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
+Notes (other):
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
+Notes (other):
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
+Notes (other):
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
+Notes (other):
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
+cat > expect << EOF
+commit 37a0d4cba38afef96ba54a3ea567e6dac575700b
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:27:13 2005 -0700
+
+    15th
+
+Notes (other):
+    a fresh note
+    another fresh note
+    append 1
+    append 2
+EOF
+
+test_expect_success 'git notes copy --for-rewrite (append two to one)' '
+	git notes add -f -m"append 1" HEAD^ &&
+	git notes add -f -m"append 2" HEAD^^ &&
+	(echo $(git rev-parse HEAD^) $(git rev-parse HEAD);
+	echo $(git rev-parse HEAD^^) $(git rev-parse HEAD)) |
+	git notes copy --for-rewrite=foo &&
+	git log -1 > output &&
+	test_cmp expect output
+'
+
+test_expect_success 'git notes copy --for-rewrite (append empty)' '
+	git notes remove HEAD^ &&
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
+Notes (other):
+    replacement note 1
+EOF
+
+test_expect_success 'GIT_NOTES_REWRITE_MODE works' '
+	git notes add -f -m"replacement note 1" HEAD^ &&
+	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
+	GIT_NOTES_REWRITE_MODE=overwrite git notes copy --for-rewrite=foo &&
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
+Notes (other):
+    replacement note 2
+EOF
+
+test_expect_success 'GIT_NOTES_REWRITE_REF works' '
+	git config notes.rewriteMode overwrite &&
+	git notes add -f -m"replacement note 2" HEAD^ &&
+	git config --unset-all notes.rewriteRef &&
+	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
+	GIT_NOTES_REWRITE_REF=refs/notes/commits:refs/notes/other \
+		git notes copy --for-rewrite=foo &&
+	git log -1 > output &&
+	test_cmp expect output
+'
+
+test_expect_success 'GIT_NOTES_REWRITE_REF overrides config' '
+	git config notes.rewriteRef refs/notes/other &&
+	git notes add -f -m"replacement note 3" HEAD^ &&
+	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
+	GIT_NOTES_REWRITE_REF= git notes copy --for-rewrite=foo &&
+	git log -1 > output &&
+	test_cmp expect output
+'
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index c814e9c..4caad9f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -56,6 +56,8 @@ unset SHA1_FILE_DIRECTORIES
 unset SHA1_FILE_DIRECTORY
 unset GIT_NOTES_REF
 unset GIT_NOTES_DISPLAY_REF
+unset GIT_NOTES_REWRITE_REF
+unset GIT_NOTES_REWRITE_MODE
 GIT_MERGE_VERBOSITY=5
 export GIT_MERGE_VERBOSITY
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
-- 
1.7.0.147.g5aeb9

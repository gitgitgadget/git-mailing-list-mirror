From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v2 07/11] notes: implement helpers needed for note copying during rewrite
Date: Wed, 17 Feb 2010 00:26:03 +0100
Message-ID: <b8d8e699a7067f0bb095f4df73966fc61ffeb6c6.1266361759.git.trast@student.ethz.ch>
References: <cover.1266361759.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 17 00:27:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhWp2-0006BI-7O
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 00:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933595Ab0BPX0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 18:26:41 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:45469 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933572Ab0BPX0g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 18:26:36 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 17 Feb
 2010 00:26:26 +0100
Received: from localhost.localdomain (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 17 Feb
 2010 00:26:10 +0100
X-Mailer: git-send-email 1.7.0.67.g67ac3
In-Reply-To: <cover.1266361759.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140164>

Implement helper functions to load the rewriting config, and to
actually copy the notes.  Also document the config.

Secondly, also implement an undocumented --for-rewrite=<cmd> option to
'git notes copy' which is used like --stdin, but also puts the
configuration for <cmd> into effect.  It will be needed to support the
copying in git-rebase.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/config.txt    |   13 ++++++
 Documentation/git-notes.txt |    4 ++
 Documentation/githooks.txt  |    4 ++
 builtin-notes.c             |   89 +++++++++++++++++++++++++++++++++++---
 builtin.h                   |   15 ++++++
 t/t3301-notes.sh            |  100 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 219 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4c36aa9..403f5cf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1300,6 +1300,19 @@ mergetool.keepTemporaries::
 mergetool.prompt::
 	Prompt before each invocation of the merge resolution program.
 
+notes.rewrite.<command>::
+	When rewriting commits with <command> (currently `amend` or
+	`rebase`) and this variable is set to `true`, git
+	automatically copies your notes from the original to the
+	rewritten commit.  Defaults to `false`.
+
+notes.rewriteMode::
+	When copying notes during a rewrite (see the
+	"notes.rewrite.<command>" option), determines what to do if
+	the target commit already has a note.  Must be one of
+	`overwrite`, `concatenate`, or `ignore`.  Defaults to
+	`concatenate`.
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
index 30420d1..116dbf6 100644
--- a/builtin-notes.c
+++ b/builtin-notes.c
@@ -278,15 +278,81 @@ int commit_notes(struct notes_tree *t, const char *msg)
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
+	c->enabled = 0;
+	c->combine = combine_notes_concatenate;
+	git_config(notes_rewrite_config, c);
+	if (!c->enabled) {
+		free(c);
+		return NULL;
+	}
+	init_notes(NULL, NULL, NULL, 0);
+	c->tree = &default_notes_tree;
+	return c;
+}
+
+int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
+			  const unsigned char *from_obj, const unsigned char *to_obj)
+{
+	return copy_note(c->tree, from_obj, to_obj, 1, c->combine);
+}
+
+void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c)
+{
+	commit_notes(c->tree, "Notes added by 'git notes copy'");
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
@@ -303,7 +369,11 @@ int notes_copy_from_stdin(int force)
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
@@ -330,6 +400,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	    remove = 0, prune = 0, force = 0, from_stdin = 0;
 	int given_object = 0, i = 1, retval = 0;
 	struct msg_arg msg = { 0, 0, STRBUF_INIT };
+	const char *rewrite_cmd = NULL;
 	struct option options[] = {
 		OPT_GROUP("Notes options"),
 		OPT_CALLBACK('m', "message", &msg, "MSG",
@@ -342,6 +413,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 			   "reuse specified note object", parse_reuse_arg),
 		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
 		OPT_BOOLEAN(0, "stdin", &from_stdin, "read objects from stdin"),
+		OPT_STRING(0, "for-rewrite", &rewrite_cmd, "command",
+			   "load rewriting config for <command> (implies --stdin)"),
 		OPT_END()
 	};
 
@@ -390,6 +463,10 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_notes_usage, options);
 	}
 
+	if (!copy && rewrite_cmd) {
+		error("cannot use --for-rewrite with %s subcommand.", argv[0]);
+		usage_with_options(git_notes_usage, options);
+	}
 	if (!copy && from_stdin) {
 		error("cannot use --stdin with %s subcommand.", argv[0]);
 		usage_with_options(git_notes_usage, options);
@@ -397,12 +474,12 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
 	if (copy) {
 		const char *from_ref;
-		if (from_stdin) {
+		if (from_stdin || rewrite_cmd) {
 			if (argc > 1) {
 				error("too many parameters");
 				usage_with_options(git_notes_usage, options);
 			} else {
-				retval = notes_copy_from_stdin(force);
+				retval = notes_copy_from_stdin(force, rewrite_cmd);
 				goto end;
 			}
 		}
diff --git a/builtin.h b/builtin.h
index cdf9847..f71f44f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -20,6 +20,21 @@ extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author);
 extern int commit_notes(struct notes_tree *t, const char *msg);
+
+struct notes_rewrite_cfg
+{
+	struct notes_tree *tree;
+	const char *cmd;
+	int enabled;
+	combine_notes_fn *combine;
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
index 9396080..c91a714 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -627,4 +627,104 @@ test_expect_success 'git notes copy --stdin' '
 	test "$(git notes list HEAD^)" = "$(git notes list HEAD~3)"
 '
 
+cat > expect << EOF
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:27:13 2005 -0700
+
+    15th
+
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
+	strip_then_cmp expect output
+'
+
+cat > expect << EOF
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:27:13 2005 -0700
+
+    15th
+
+Notes:
+    yet another note
+$whitespace
+    yet another note
+
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:26:13 2005 -0700
+
+    14th
+
+Notes:
+    other note
+$whitespace
+    yet another note
+EOF
+
+test_expect_success 'git notes copy --for-rewrite (enabled)' '
+	git config notes.rewrite.foo true &&
+	git config notes.rewriteMode overwrite &&
+	(echo $(git rev-parse HEAD~3) $(git rev-parse HEAD^); \
+	echo $(git rev-parse HEAD~2) $(git rev-parse HEAD)) |
+	git notes copy --for-rewrite=foo &&
+	git log -2 > output &&
+	strip_then_cmp expect output
+'
+
+cat > expect << EOF
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:27:13 2005 -0700
+
+    15th
+
+Notes:
+    a fresh note
+EOF
+
+test_expect_success 'git notes copy --for-rewrite (overwrite)' '
+	git notes add -f -m"a fresh note" HEAD^ &&
+	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
+	git notes copy --for-rewrite=foo &&
+	git log -1 > output &&
+	strip_then_cmp expect output
+'
+
+test_expect_success 'git notes copy --for-rewrite (ignore)' '
+	git config notes.rewriteMode ignore &&
+	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
+	git notes copy --for-rewrite=foo &&
+	git log -1 > output &&
+	strip_then_cmp expect output
+'
+
+cat > expect << EOF
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:27:13 2005 -0700
+
+    15th
+
+Notes:
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
+	strip_then_cmp expect output
+'
+
 test_done
-- 
1.7.0.53.g5c2e6.dirty

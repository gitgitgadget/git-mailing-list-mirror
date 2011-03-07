From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] commit: allow editing notes in commit message editor
Date: Mon, 7 Mar 2011 18:41:38 -0500
Message-ID: <20110307234138.GB20912@sigill.intra.peff.net>
References: <20110307233902.GA20447@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 00:41:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwk3j-0006IR-1q
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 00:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731Ab1CGXlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 18:41:45 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54053 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741Ab1CGXlo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 18:41:44 -0500
Received: (qmail 9712 invoked by uid 111); 7 Mar 2011 23:41:44 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Mar 2011 23:41:44 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Mar 2011 18:41:38 -0500
Content-Disposition: inline
In-Reply-To: <20110307233902.GA20447@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168622>

One workflow for git-notes is to informally keep a list of
changes from one version of a patch to another as the patch
is modified via "commit --amend" and "git rebase". Often the
most convenient time for this is while editing the commit
message, since you see it during amend, during "rebase -i"
edit stops, and when "rebase" finds a conflict.

This patch adds a "--notes" option which displays existing
notes in the commit editor (in the case of --amend), and
extracts new notes from the editor message to add to the
newly created commit.

The feature is activated only for interactive edits, so "-F"
and "-m" messages are safe from munging.

Signed-off-by: Jeff King <peff@peff.net>
---
Changes from v1:

  - fix bug with adding notes to new commit (we failed to
    initialize the notes tree properly in this case)

  - you can now do "commit --notes=foo" to view/edit
    refs/notes/foo

  - added tests for basic operations, plus interaction with
    --cleanup and -v

  - turn off commit rewriting when we edit

Todo:

  - commit.notes config variable to have this on all the time

  - I punted on the separator decision here.

  - probably still some magic needed for rebase conflict
    case; we will be making a new commit, so we don't know
    to pull the notes in from the old commit as we do with
    --amend.

  - still needs the format-patch component to make the
    workflow complete :)

 builtin/commit.c        |   87 ++++++++++++++++++++++-
 t/t7510-commit-notes.sh |  183 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 268 insertions(+), 2 deletions(-)
 create mode 100755 t/t7510-commit-notes.sh

diff --git a/builtin/commit.c b/builtin/commit.c
index d71e1e0..f84ca23 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -26,6 +26,7 @@
 #include "unpack-trees.h"
 #include "quote.h"
 #include "submodule.h"
+#include "blob.h"
 
 static const char * const builtin_commit_usage[] = {
 	"git commit [options] [--] <filepattern>...",
@@ -90,6 +91,8 @@ static char *cleanup_arg;
 
 static int use_editor = 1, initial_commit, in_merge, include_status = 1;
 static int show_ignored_in_status;
+static const char *edit_notes;
+static struct notes_tree edit_notes_tree;
 static const char *only_include_assumed;
 static struct strbuf message;
 
@@ -132,6 +135,8 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
 	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
 	OPT_BOOLEAN(0, "status", &include_status, "include status in commit message template"),
+	{ OPTION_STRING, 0, "notes", &edit_notes, "ref", "edit notes interactively",
+		PARSE_OPT_OPTARG, NULL, 1 },
 	/* end commit message options */
 
 	OPT_GROUP("Commit contents options"),
@@ -559,6 +564,68 @@ static char *cut_ident_timestamp_part(char *string)
 	return ket;
 }
 
+static void init_edit_notes() {
+	struct strbuf ref = STRBUF_INIT;
+	if (edit_notes_tree.initialized)
+		return;
+	strbuf_addstr(&ref, edit_notes);
+	expand_notes_ref(&ref);
+	init_notes(&edit_notes_tree, ref.buf,
+		   combine_notes_overwrite, 0);
+}
+
+static void add_notes_from_commit(struct strbuf *out, const char *name)
+{
+	struct commit *commit;
+	struct strbuf note = STRBUF_INIT;
+
+	init_edit_notes();
+
+	commit = lookup_commit_reference_by_name(name);
+	if (!commit)
+		die("could not lookup commit %s", name);
+	format_note(&edit_notes_tree, commit->object.sha1, &note,
+		    get_commit_output_encoding(), 0);
+
+	if (note.len) {
+		strbuf_addstr(out, "\n---\n");
+		strbuf_addbuf(out, &note);
+	}
+	strbuf_release(&note);
+}
+
+static void extract_notes_from_message(struct strbuf *msg, struct strbuf *notes)
+{
+	const char *separator = strstr(msg->buf, "\n---\n");
+
+	if (!separator)
+		return;
+
+	strbuf_addstr(notes, separator + 5);
+	strbuf_setlen(msg, separator - msg->buf + 1);
+}
+
+static void update_notes_for_commit(struct strbuf *notes,
+				    unsigned char *commit_sha1)
+{
+	init_edit_notes();
+
+	if (cleanup_mode != CLEANUP_NONE)
+		stripspace(notes, cleanup_mode == CLEANUP_ALL);
+
+	if (!notes->len)
+		remove_note(&edit_notes_tree, commit_sha1);
+	else {
+		unsigned char blob_sha1[20];
+		if (write_sha1_file(notes->buf, notes->len,
+				    blob_type, blob_sha1) < 0)
+			die("unable to write note blob");
+		add_note(&edit_notes_tree, commit_sha1, blob_sha1,
+			 combine_notes_overwrite);
+	}
+	commit_notes(&edit_notes_tree, "updated by commit --notes");
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct wt_status *s,
 			     struct strbuf *author_ident)
@@ -682,6 +749,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		strbuf_release(&sob);
 	}
 
+	if (edit_notes && amend)
+		add_notes_from_commit(&sb, "HEAD");
+
 	if (fwrite(sb.buf, 1, sb.len, fp) < sb.len)
 		die_errno("could not write commit template");
 
@@ -918,8 +988,13 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		use_editor = 0;
 	if (edit_flag)
 		use_editor = 1;
-	if (!use_editor)
+	if (!use_editor) {
 		setenv("GIT_EDITOR", ":", 1);
+		edit_notes = NULL;
+	}
+	/* Magic value for "no ref passed" */
+	if (edit_notes == (void *)1)
+		edit_notes = default_notes_ref();
 
 	if (get_sha1("HEAD", head_sha1))
 		initial_commit = 1;
@@ -1288,6 +1363,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf author_ident = STRBUF_INIT;
+	struct strbuf notes = STRBUF_INIT;
 	const char *index_file, *reflog_msg;
 	char *nl, *p;
 	unsigned char commit_sha1[20];
@@ -1388,6 +1464,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			strbuf_setlen(&sb, p - sb.buf + 1);
 	}
 
+	if (edit_notes)
+		extract_notes_from_message(&sb, &notes);
+
 	if (cleanup_mode != CLEANUP_NONE)
 		stripspace(&sb, cleanup_mode == CLEANUP_ALL);
 	if (message_is_empty(&sb) && !allow_empty_message) {
@@ -1403,6 +1482,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 	strbuf_release(&author_ident);
 
+	if (edit_notes)
+		update_notes_for_commit(&notes, commit_sha1);
+	strbuf_release(&notes);
+
 	ref_lock = lock_any_ref_for_update("HEAD",
 					   initial_commit ? NULL : head_sha1,
 					   0);
@@ -1436,7 +1519,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	rerere(0);
 	run_hook(get_index_file(), "post-commit", NULL);
-	if (amend && !no_post_rewrite) {
+	if (!edit_notes && amend && !no_post_rewrite) {
 		struct notes_rewrite_cfg *cfg;
 		cfg = init_copy_notes_for_rewrite("amend");
 		if (cfg) {
diff --git a/t/t7510-commit-notes.sh b/t/t7510-commit-notes.sh
new file mode 100755
index 0000000..ffc0781
--- /dev/null
+++ b/t/t7510-commit-notes.sh
@@ -0,0 +1,183 @@
+#!/bin/sh
+
+test_description='commit w/ --notes'
+. ./test-lib.sh
+
+# Fake editor to simulate user adding a note.
+cat >add.sh <<'EOF'
+perl -i -pe '
+  BEGIN { $n = shift }
+  # insert at $n-th blank line
+  if (/^$/ && ++$count == $n) {
+	  print "---\n";
+	  print "added note\n";
+	  print "with multiple lines\n";
+  }
+' "$@"
+EOF
+cat >expect-add <<'EOF'
+added note
+with multiple lines
+EOF
+
+# Fake editor to simulate user deleting a note.
+cat >del.sh <<'EOF'
+perl -i -ne '
+  if (/^---$/) {
+	  while (<>) {
+		  last if /^$/;
+	  }
+	  next;
+  }
+  print;
+' "$1"
+EOF
+
+# Fake editor to simulate user modifying a note.
+cat >mod.sh <<'EOF'
+perl -i -pe '
+  s/added note/modified note/
+' "$1"
+EOF
+cat >expect-mod <<'EOF'
+modified note
+with multiple lines
+EOF
+
+# Fake editor for leaving notes untouched.
+cat >nil.sh <<'EOF'
+EOF
+
+# Convenience function for setting up editor.
+set_editor() {
+	git config core.editor "\"$SHELL_PATH\" $1.sh $2"
+}
+
+cat >expect-msg <<'EOF'
+commit one
+
+this is the body of commit one
+EOF
+
+test_expect_success 'setup' '
+	test_commit one &&
+	git commit --amend -F expect-msg
+'
+
+test_expect_success 'add a note' '
+	set_editor add 2 &&
+	git commit --notes --amend &&
+	git notes show >actual &&
+	test_cmp expect-add actual &&
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect-msg actual
+'
+
+test_expect_success 'notes are preserved' '
+	set_editor nil &&
+	git commit --notes --amend &&
+	git notes show >actual &&
+	test_cmp expect-add actual &&
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect-msg actual
+'
+
+test_expect_success 'modify a note' '
+	set_editor mod &&
+	git commit --notes --amend &&
+	git notes show >actual &&
+	test_cmp expect-mod actual &&
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect-msg actual
+'
+
+test_expect_success 'delete a note' '
+	set_editor del &&
+	git commit --notes --amend &&
+	test_must_fail git notes show &&
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect-msg actual
+'
+
+test_expect_success 'add to commit without body' '
+	test_commit two &&
+	git log -1 --pretty=format:%B >expect-msg &&
+	set_editor add 1 &&
+	git commit --notes --amend &&
+	git notes show >actual &&
+	test_cmp expect-add actual &&
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect-msg actual
+'
+
+cat >expect-verbatim-msg <<'EOF'
+verbatim subject
+
+verbatim body
+# embedded comment
+
+EOF
+cat >expect-verbatim-note <<'EOF'
+
+verbatim note
+with leading and trailing whitespace
+# and embedded comments
+
+EOF
+cat >verbatim.sh <<'EOF'
+{
+	cat expect-verbatim-msg &&
+	echo --- &&
+	cat expect-verbatim-note
+} >"$1"
+EOF
+
+test_expect_success 'commit --cleanup=verbatim preserves message and notes' '
+	test_tick &&
+	echo content >>file && git add file &&
+	set_editor verbatim &&
+	git commit --notes --cleanup=verbatim &&
+	git cat-file commit HEAD >msg.raw &&
+	sed "1,/^\$/d" <msg.raw >actual &&
+	test_cmp expect-verbatim-msg actual &&
+	git notes show >actual &&
+	test_cmp expect-verbatim-note actual
+'
+
+test_expect_success 'commit -v does not interfere with notes' '
+	test_commit three &&
+	git log -1 --pretty=format:%B >expect-msg
+	set_editor add 1 &&
+	git commit -v --notes --amend &&
+	git notes show >actual &&
+	test_cmp actual expect-add &&
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect-msg actual
+'
+
+test_expect_success 'edit notes on alternate ref' '
+	test_commit four &&
+	set_editor add 1 &&
+	git commit --notes=foo --amend &&
+	test_must_fail git notes show &&
+	git notes --ref refs/notes/foo show >actual &&
+	test_cmp expect-add actual
+'
+
+test_expect_success 'ref rewriting does not overwrite our edits' '
+	git config notes.rewriteRef refs/notes/commits &&
+	test_commit five &&
+	set_editor add 1 &&
+	git commit --notes --amend &&
+	git notes show >actual &&
+	test_cmp expect-add actual &&
+	set_editor mod &&
+	git commit --notes --amend &&
+	git notes show >actual &&
+	test_cmp expect-mod actual &&
+	set_editor del &&
+	git commit --notes --amend &&
+	test_must_fail git notes show
+'
+
+test_done
-- 
1.7.4.31.g76e18

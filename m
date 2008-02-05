From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH-v2 3/4] git-commit: Refactor creation of log message.
Date: Tue,  5 Feb 2008 11:01:46 +0100
Message-ID: <1202205704-10024-3-git-send-email-bonzini@gnu.org>
References: <1202205704-10024-1-git-send-email-bonzini@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 11:52:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMLPa-0003uq-L7
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 11:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857AbYBEKvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 05:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756362AbYBEKvg
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 05:51:36 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:36291 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857AbYBEKvb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 05:51:31 -0500
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1JMLOk-00027Q-SL
	for git@vger.kernel.org; Tue, 05 Feb 2008 05:51:30 -0500
X-Mailer: git-send-email 1.5.4.1138.g882bc-dirty
In-Reply-To: <1202205704-10024-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72646>

This patch moves the code of run_commit, up to writing the trees, editing
the message and running the commit-msg hook to prepare_log_message.  It also
renames the latter to prepare_to_commit.

This simplifies a little the code for the next patch.
---
 builtin-commit.c  |  171 +++++++++++++++++++++++++++--------------------------
 t/t7502-commit.sh |   28 +++++++++
 2 files changed, 116 insertions(+), 83 deletions(-)

	While not strictly necessary, I moved code that invokes pre-commit
	too, because it seemed more logical.  Both for pre-commit and
	for the old prepare_log_message you have to call rollback_index_files
	upon failure.

	I added a testcase that the editor is invoked *after* checking
	for incomplete merges.

diff --git a/builtin-commit.c b/builtin-commit.c
index 7d1059c..d8945ac 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -377,9 +377,17 @@ static int run_hook(const char *index_file, const char *name, ...)
 	return run_command(&hook);
 }
 
+static int is_a_merge(const unsigned char *sha1)
+{
+	struct commit *commit = lookup_commit(sha1);
+	if (!commit || parse_commit(commit))
+		die("could not parse HEAD commit");
+	return !!(commit->parents && commit->parents->next);
+}
+
 static const char sign_off_header[] = "Signed-off-by: ";
 
-static int prepare_log_message(const char *index_file, const char *prefix)
+static int prepare_to_commit(const char *index_file, const char *prefix)
 {
 	struct stat statbuf;
 	int commitable, saved_color_setting;
@@ -387,6 +395,9 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 	char *buffer;
 	FILE *fp;
 
+	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
+		return 0;
+
 	strbuf_init(&sb, 0);
 	if (message.len) {
 		strbuf_addbuf(&sb, &message);
@@ -447,13 +458,38 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 
 	strbuf_release(&sb);
 
-	if (!use_editor) {
+	if (use_editor) {
+		if (in_merge)
+			fprintf(fp,
+				"#\n"
+				"# It looks like you may be committing a MERGE.\n"
+				"# If this is not correct, please remove the file\n"
+				"#	%s\n"
+				"# and try again.\n"
+				"#\n",
+				git_path("MERGE_HEAD"));
+
+		fprintf(fp,
+			"\n"
+			"# Please enter the commit message for your changes.\n"
+			"# (Comment lines starting with '#' will ");
+		if (cleanup_mode == CLEANUP_ALL)
+			fprintf(fp, "not be included)\n");
+		else /* CLEANUP_SPACE, that is. */
+			fprintf(fp, "be kept.\n"
+				"# You can remove them yourself if you want to)\n");
+		if (only_include_assumed)
+			fprintf(fp, "# %s\n", only_include_assumed);
+
+		saved_color_setting = wt_status_use_color;
+		wt_status_use_color = 0;
+		commitable = run_status(fp, index_file, prefix, 1);
+		wt_status_use_color = saved_color_setting;
+	} else {
 		struct rev_info rev;
 		unsigned char sha1[20];
 		const char *parent = "HEAD";
 
-		fclose(fp);
-
 		if (!active_nr && read_cache() < 0)
 			die("Cannot read index");
 
@@ -461,48 +497,56 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 			parent = "HEAD^1";
 
 		if (get_sha1(parent, sha1))
-			return !!active_nr;
+			commitable = !!active_nr;
+		else {
+			init_revisions(&rev, "");
+			rev.abbrev = 0;
+			setup_revisions(0, NULL, &rev, parent);
+			DIFF_OPT_SET(&rev.diffopt, QUIET);
+			DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
+			run_diff_index(&rev, 1 /* cached */);
+
+			commitable = !!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES);
+		}
+	}
 
-		init_revisions(&rev, "");
-		rev.abbrev = 0;
-		setup_revisions(0, NULL, &rev, parent);
-		DIFF_OPT_SET(&rev.diffopt, QUIET);
-		DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
-		run_diff_index(&rev, 1 /* cached */);
+	fclose(fp);
+
+	if (!commitable && !in_merge && !allow_empty &&
+	    !(amend && is_a_merge(head_sha1))) {
+		run_status(stdout, index_file, prefix, 0);
+		unlink(commit_editmsg);
+		return 0;
+	}
 
-		return !!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES);
+	/*
+	 * Re-read the index as pre-commit hook could have updated it,
+	 * and write it out as a tree.  We must do this before we invoke
+	 * the editor and after we invoke run_status above.
+	 */
+	discard_cache();
+	read_cache_from(index_file);
+	if (!active_cache_tree)
+		active_cache_tree = cache_tree();
+	if (cache_tree_update(active_cache_tree,
+			      active_cache, active_nr, 0, 0) < 0) {
+		error("Error building trees");
+		return 0;
 	}
 
-	if (in_merge)
-		fprintf(fp,
-			"#\n"
-			"# It looks like you may be committing a MERGE.\n"
-			"# If this is not correct, please remove the file\n"
-			"#	%s\n"
-			"# and try again.\n"
-			"#\n",
-			git_path("MERGE_HEAD"));
-
-	fprintf(fp,
-		"\n"
-		"# Please enter the commit message for your changes.\n"
-		"# (Comment lines starting with '#' will ");
-	if (cleanup_mode == CLEANUP_ALL)
-		fprintf(fp, "not be included)\n");
-	else /* CLEANUP_SPACE, that is. */
-		fprintf(fp, "be kept.\n"
-			"# You can remove them yourself if you want to)\n");
-	if (only_include_assumed)
-		fprintf(fp, "# %s\n", only_include_assumed);
-
-	saved_color_setting = wt_status_use_color;
-	wt_status_use_color = 0;
-	commitable = run_status(fp, index_file, prefix, 1);
-	wt_status_use_color = saved_color_setting;
+	if (use_editor) {
+		char index[PATH_MAX];
+		const char *env[2] = { index, NULL };
+		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
+		launch_editor(git_path(commit_editmsg), NULL, env);
+	}
 
-	fclose(fp);
+	if (!no_verify &&
+	    run_hook(index_file, "commit-msg", git_path(commit_editmsg), NULL)) {
+		return 0;
+	}
 
-	return commitable;
+	return 1;
 }
 
 /*
@@ -761,14 +805,6 @@ int git_commit_config(const char *k, const char *v)
 	return git_status_config(k, v);
 }
 
-static int is_a_merge(const unsigned char *sha1)
-{
-	struct commit *commit = lookup_commit(sha1);
-	if (!commit || parse_commit(commit))
-		die("could not parse HEAD commit");
-	return !!(commit->parents && commit->parents->next);
-}
-
 static const char commit_utf8_warn[] =
 "Warning: commit message does not conform to UTF-8.\n"
 "You may want to amend it after fixing the message, or set the config\n"
@@ -800,34 +836,14 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	index_file = prepare_index(argc, argv, prefix);
 
-	if (!no_verify && run_hook(index_file, "pre-commit", NULL)) {
-		rollback_index_files();
-		return 1;
-	}
-
-	if (!prepare_log_message(index_file, prefix) && !in_merge &&
-	    !allow_empty && !(amend && is_a_merge(head_sha1))) {
-		run_status(stdout, index_file, prefix, 0);
+	/* Set up everything for writing the commit object.  This includes
+	   running hooks, writing the trees, and interacting with the user.  */
+	if (!prepare_to_commit(index_file, prefix)) {
 		rollback_index_files();
-		unlink(commit_editmsg);
 		return 1;
 	}
 
 	/*
-	 * Re-read the index as pre-commit hook could have updated it,
-	 * and write it out as a tree.
-	 */
-	discard_cache();
-	read_cache_from(index_file);
-	if (!active_cache_tree)
-		active_cache_tree = cache_tree();
-	if (cache_tree_update(active_cache_tree,
-			      active_cache, active_nr, 0, 0) < 0) {
-		rollback_index_files();
-		die("Error building trees");
-	}
-
-	/*
 	 * The commit object
 	 */
 	strbuf_init(&sb, 0);
@@ -878,19 +894,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&sb, "encoding %s\n", git_commit_encoding);
 	strbuf_addch(&sb, '\n');
 
-	/* Get the commit message and validate it */
+	/* Finally, get the commit message */
 	header_len = sb.len;
-	if (use_editor) {
-		char index[PATH_MAX];
-		const char *env[2] = { index, NULL };
-		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-		launch_editor(git_path(commit_editmsg), NULL, env);
-	}
-	if (!no_verify &&
-	    run_hook(index_file, "commit-msg", git_path(commit_editmsg), NULL)) {
-		rollback_index_files();
-		exit(1);
-	}
 	if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
 		rollback_index_files();
 		die("could not read commit message");
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index aaf497e..5ab8e23 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -154,4 +154,33 @@ test_expect_success 'cleanup commit messages (strip,-F,-e)' '
 
 '
 
+pwd=`pwd`
+cat >> .git/FAKE_EDITOR << EOF
+#! /bin/sh
+echo editor started > "$pwd/.git/result"
+exit 0
+EOF
+chmod +x .git/FAKE_EDITOR
+
+test_expect_success 'do not fire editor in the presence of conflicts' '
+
+	git clean
+	echo f>g
+	git add g
+	git commit -myes
+	git branch second
+	echo master>g
+	echo g>h
+	git add g h
+	git commit -mmaster
+	git checkout second
+	echo second>g
+	git add g
+	git commit -msecond
+	git cherry-pick -n master
+	echo "editor not started" > .git/result
+	GIT_EDITOR=`pwd`/.git/FAKE_EDITOR git commit && exit 1  # should fail
+	test "`cat .git/result`" = "editor not started"
+'
+
 test_done
-- 
1.5.3.4.910.gc5122-dirty

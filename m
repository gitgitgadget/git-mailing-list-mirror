From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 3/4] git-commit: Refactor creation of log message.
Date: Mon, 21 Jan 2008 15:33:51 +0100
Message-ID: <14fc1ba3f94a773ab2e5b8cdf0c230962f32180d.1200933409.git.bonzini@gnu.org>
References: <2885c7896ba72adee6bc5c9e2210a8881904f601.head.git.bonzini@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 13:21:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM0KU-0006Pl-QB
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 13:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbYBDMUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 07:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753176AbYBDMUv
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 07:20:51 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:42353 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbYBDMUq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 07:20:46 -0500
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1JM0JZ-0007oJ-I6
	for git@vger.kernel.org; Mon, 04 Feb 2008 07:20:45 -0500
In-Reply-To: <2885c7896ba72adee6bc5c9e2210a8881904f601.head.git.bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72498>

This patch moves around some code from run_commit to prepare_log_message.
This simplifies a little the code for the next patch.  The biggest change
is that the editor and the commit-msg hook are invoked before building
the prolog of the commit object.

This means that: 1) the commit may be aborted after editing the message
if there is a problem writing out the tree object (slight disadvantage);
2) no tree will be written out if the commit-msg hook fails (slight
advantage).

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>

---
 builtin-commit.c |  114 ++++++++++++++++++++++++++++---------------------------
 1 files changed, 60 insertions(+), 54 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 955cc84..fed549e 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -371,6 +371,14 @@ static int run_hook(const char *index_file, const char *name, ...)
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
 
 static int prepare_log_message(const char *index_file, const char *prefix)
@@ -441,13 +449,38 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 
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
 
@@ -464,39 +499,31 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 		DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
 		run_diff_index(&rev, 1 /* cached */);
 
-		return !!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES);
+		commitable = !!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES);
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
-
 	fclose(fp);
 
-	return commitable;
+	if (!commitable && !in_merge && !allow_empty &&
+	    !(amend && is_a_merge(head_sha1))) {
+		run_status(stdout, index_file, prefix, 0);
+		unlink(commit_editmsg);
+		return 0;
+	}
+
+	if (use_editor) {
+		char index[PATH_MAX];
+		const char *env[2] = { index, NULL };
+		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
+		launch_editor(git_path(commit_editmsg), NULL, env);
+	}
+
+	if (!no_verify &&
+	    run_hook(index_file, "commit-msg", git_path(commit_editmsg), NULL)) {
+		return 0;
+	}
+
+	return 1;
 }
 
 /*
@@ -755,14 +782,6 @@ int git_commit_config(const char *k, const char *v)
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
@@ -799,11 +818,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		return 1;
 	}
 
-	if (!prepare_log_message(index_file, prefix) && !in_merge &&
-	    !allow_empty && !(amend && is_a_merge(head_sha1))) {
-		run_status(stdout, index_file, prefix, 0);
+	/* Prepare, let the user edit, and validate the log message.  */
+	if (!prepare_log_message(index_file, prefix)) {
 		rollback_index_files();
-		unlink(commit_editmsg);
 		return 1;
 	}
 
@@ -872,19 +889,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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

From: "James P. Howard, II" <jh@jameshoward.us>
Subject: [PATCH] Add commit.infodisplay option to give message editor empty file
Date: Fri,  4 Dec 2009 18:04:39 -0500
Message-ID: <1259967879-65517-1-git-send-email-jh@jameshoward.us>
Cc: "James P. Howard, II" <jh@jameshoward.us>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 05 00:36:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGhh8-0003gL-Tz
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 00:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbZLDXgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 18:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbZLDXgC
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 18:36:02 -0500
Received: from byzantine.jameshoward.us ([204.109.63.101]:30409 "EHLO
	byzantine.jameshoward.us" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472AbZLDXgB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 18:36:01 -0500
Received: from byzantine.jameshoward.us (localhost [127.0.0.1])
	by byzantine.jameshoward.us (8.14.3/8.14.3) with ESMTP id nB4N4tAk065548;
	Fri, 4 Dec 2009 23:04:55 GMT
	(envelope-from howardjp@byzantine.jameshoward.us)
Received: (from howardjp@localhost)
	by byzantine.jameshoward.us (8.14.3/8.14.3/Submit) id nB4N4tBk065547;
	Fri, 4 Dec 2009 18:04:55 -0500 (EST)
	(envelope-from howardjp)
X-Mailer: git-send-email 1.6.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134589>

This patch creates commit.infodisplay which causes git commit to
display the status information on the standard output rather
than in the temporary file for the commit message.  By doing
this, it becomes feasible to set core.editor for commit messages
to be a line editor, e.g. ex or ed.

Signed-off-by: James P. Howard, II <jh@jameshoward.us>
---
 Documentation/config.txt |    5 +++++
 builtin-commit.c         |   31 ++++++++++++++++++-------------
 cache.h                  |    1 +
 environment.c            |    3 +++
 4 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a1e36d7..56b3238 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -705,6 +705,11 @@ color.ui::
 	terminal. When more specific variables of color.* are set, they always
 	take precedence over this setting. Defaults to false.
 
+commit.infodisplay::
+	When true and a commit message is not specified on the command line,
+	the status information is not placed in the message template but is
+	printed to the standard output.
+
 commit.template::
 	Specify a file to use as the template for new commit messages.
 	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to the
diff --git a/builtin-commit.c b/builtin-commit.c
index e93a647..e4db374 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -463,7 +463,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	int commitable, saved_color_setting;
 	struct strbuf sb = STRBUF_INIT;
 	char *buffer;
-	FILE *fp;
+	FILE *fp, *infofp;
 	const char *hook_arg1 = NULL;
 	const char *hook_arg2 = NULL;
 	int ident_shown = 0;
@@ -540,7 +540,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 	if (fwrite(sb.buf, 1, sb.len, fp) < sb.len)
 		die_errno("could not write commit template");
-
+	if (info_display)
+		infofp = stdout;
+	else {
+		infofp = fp;
+		fprintf(infofp, "\n");
+	}
 	strbuf_release(&sb);
 
 	determine_author_info();
@@ -552,7 +557,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		const char *committer_ident;
 
 		if (in_merge)
-			fprintf(fp,
+			fprintf(infofp,
 				"#\n"
 				"# It looks like you may be committing a MERGE.\n"
 				"# If this is not correct, please remove the file\n"
@@ -561,28 +566,27 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				"#\n",
 				git_path("MERGE_HEAD"));
 
-		fprintf(fp,
-			"\n"
+		fprintf(infofp,
 			"# Please enter the commit message for your changes.");
 		if (cleanup_mode == CLEANUP_ALL)
-			fprintf(fp,
+			fprintf(infofp,
 				" Lines starting\n"
 				"# with '#' will be ignored, and an empty"
 				" message aborts the commit.\n");
 		else /* CLEANUP_SPACE, that is. */
-			fprintf(fp,
+			fprintf(infofp,
 				" Lines starting\n"
 				"# with '#' will be kept; you may remove them"
 				" yourself if you want to.\n"
 				"# An empty message aborts the commit.\n");
 		if (only_include_assumed)
-			fprintf(fp, "# %s\n", only_include_assumed);
+			fprintf(infofp, "# %s\n", only_include_assumed);
 
 		author_ident = xstrdup(fmt_name(author_name, author_email));
 		committer_ident = fmt_name(getenv("GIT_COMMITTER_NAME"),
 					   getenv("GIT_COMMITTER_EMAIL"));
 		if (strcmp(author_ident, committer_ident))
-			fprintf(fp,
+			fprintf(infofp,
 				"%s"
 				"# Author:    %s\n",
 				ident_shown++ ? "" : "#\n",
@@ -590,18 +594,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		free(author_ident);
 
 		if (!user_ident_explicitly_given)
-			fprintf(fp,
+			fprintf(infofp,
 				"%s"
 				"# Committer: %s\n",
 				ident_shown++ ? "" : "#\n",
 				committer_ident);
 
 		if (ident_shown)
-			fprintf(fp, "#\n");
+			fprintf(infofp, "#\n");
 
 		saved_color_setting = s->use_color;
 		s->use_color = 0;
-		commitable = run_status(fp, index_file, prefix, 1, s);
+		commitable = run_status(infofp, index_file, prefix, 1, s);
 		s->use_color = saved_color_setting;
 	} else {
 		unsigned char sha1[20];
@@ -1006,7 +1010,8 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 
 	if (!strcmp(k, "commit.template"))
 		return git_config_pathname(&template_file, k, v);
-
+	if (!strcmp(k, "commit.infodisplay"))
+		info_display = git_config_bool(k, v);
 	return git_status_config(k, v, s);
 }
 
diff --git a/cache.h b/cache.h
index bf468e5..2b36fb3 100644
--- a/cache.h
+++ b/cache.h
@@ -529,6 +529,7 @@ extern int auto_crlf;
 extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
+extern int info_display;
 
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
diff --git a/environment.c b/environment.c
index 5171d9f..ac7cfed 100644
--- a/environment.c
+++ b/environment.c
@@ -55,6 +55,9 @@ int grafts_replace_parents = 1;
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
 
+/* Controls whether commit information is appended to message text or displayed */
+int info_display = 0;
+
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
 static char *work_tree;
-- 
1.6.5.3

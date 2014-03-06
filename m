From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 2/6] commit: fix patch hunk editing with "commit -p -m"
Date: Thu,  6 Mar 2014 15:50:20 +0100
Message-ID: <1394117424-29780-3-git-send-email-benoit.pierre@gmail.com>
References: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 15:50:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLZdN-0005Cd-5p
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 15:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbaCFOuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 09:50:46 -0500
Received: from mail-wg0-f49.google.com ([74.125.82.49]:41982 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbaCFOuo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 09:50:44 -0500
Received: by mail-wg0-f49.google.com with SMTP id b13so3293188wgh.32
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 06:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=COT+HLjU+juXp309NkAWmNpvYWWkpphQ85HNybgapas=;
        b=Z5kIMNuxAXGoF9ojRK4A9dgRqlCtad/1CBkO6/0TKOul1sQ5y65xQAYbgSXQ6UV4kU
         95LfLM9sKaSWjzvPnBoClT4muLWRIGD6zodPW1zdgg8/ZICgbAghfh4MF3oH8c4le7Pf
         mvBqEwRPs6PS0crKNCjVmIh+STrC1ZP/pU7RZEWhJjy6M9oSXDPaXRZD+mEWApUEpPLl
         mUV6DFFzxqgLU0+EPti/ZFc4LtDvST+anEXV05HW1BYWn9zDHJnruK4jeNVt1Or4an2H
         mX5xzwIpdJkSUrTfeMA1KmjMD3rtRNeNh/ysWSVd8MgjhbAv2MuuTtxiovYatidmyeXM
         pBcw==
X-Received: by 10.195.13.103 with SMTP id ex7mr10684396wjd.3.1394117436110;
        Thu, 06 Mar 2014 06:50:36 -0800 (PST)
Received: from localhost (109.12.70.86.rev.sfr.net. [86.70.12.109])
        by mx.google.com with ESMTPSA id az1sm18014006wjb.11.2014.03.06.06.50.34
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Mar 2014 06:50:35 -0800 (PST)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243516>

Don't change git environment: move the GIT_EDITOR=":" override to the
hook command subprocess, like it's already done for GIT_INDEX_FILE.

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 builtin/commit.c                  | 35 ++++++++++++++++++++++++++++-------
 builtin/merge.c                   |  4 ++--
 commit.h                          |  3 +++
 run-command.c                     | 27 +++++++++++++++------------
 run-command.h                     |  3 ++-
 t/t7513-commit_-p_-m_hunk_edit.sh |  2 +-
 6 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 3767478..2f5a44f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -612,7 +612,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
 
-	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
+	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
 		return 0;
 
 	if (squash_message) {
@@ -866,8 +866,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (run_hook(index_file, "prepare-commit-msg",
-		     git_path(commit_editmsg), hook_arg1, hook_arg2, NULL))
+	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
+			    git_path(commit_editmsg), hook_arg1, hook_arg2, NULL))
 		return 0;
 
 	if (use_editor) {
@@ -883,7 +883,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	if (!no_verify &&
-	    run_hook(index_file, "commit-msg", git_path(commit_editmsg), NULL)) {
+	    run_commit_hook(use_editor, index_file, "commit-msg", git_path(commit_editmsg), NULL)) {
 		return 0;
 	}
 
@@ -1067,8 +1067,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		use_editor = 0;
 	if (0 <= edit_flag)
 		use_editor = edit_flag;
-	if (!use_editor)
-		setenv("GIT_EDITOR", ":", 1);
 
 	/* Sanity check options */
 	if (amend && !current_head)
@@ -1445,6 +1443,29 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 	return finish_command(&proc);
 }
 
+int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...)
+{
+	const char *hook_env[3] =  { NULL };
+	char index[PATH_MAX];
+	va_list args;
+	int ret;
+
+	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
+	hook_env[0] = index;
+
+	/*
+	 * Let the hook know that no editor will be launched.
+	 */
+	if (!editor_is_used)
+		hook_env[1] = "GIT_EDITOR=:";
+
+	va_start(args, name);
+	ret = run_hook_v(hook_env, name, args);
+	va_end(args);
+
+	return ret;
+}
+
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
 	static struct wt_status s;
@@ -1669,7 +1690,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		     "not exceeded, and then \"git reset HEAD\" to recover."));
 
 	rerere(0);
-	run_hook(get_index_file(), "post-commit", NULL);
+	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		struct notes_rewrite_cfg *cfg;
 		cfg = init_copy_notes_for_rewrite("amend");
diff --git a/builtin/merge.c b/builtin/merge.c
index e576a7f..d2a1bfe 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -821,8 +821,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	if (0 < option_edit)
 		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
 	write_merge_msg(&msg);
-	if (run_hook(get_index_file(), "prepare-commit-msg",
-		     git_path("MERGE_MSG"), "merge", NULL, NULL))
+	if (run_commit_hook(1, get_index_file(), "prepare-commit-msg",
+			    git_path("MERGE_MSG"), "merge", NULL))
 		abort_commit(remoteheads, NULL);
 	if (0 < option_edit) {
 		if (launch_editor(git_path("MERGE_MSG"), NULL, NULL))
diff --git a/commit.h b/commit.h
index 16d9c43..8d97a5c 100644
--- a/commit.h
+++ b/commit.h
@@ -304,4 +304,7 @@ extern void check_commit_signature(const struct commit* commit, struct signature
 
 int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
 
+LAST_ARG_MUST_BE_NULL
+extern int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
+
 #endif /* COMMIT_H */
diff --git a/run-command.c b/run-command.c
index 3914d9c..4e9be12 100644
--- a/run-command.c
+++ b/run-command.c
@@ -760,13 +760,11 @@ char *find_hook(const char *name)
 	return path;
 }
 
-int run_hook(const char *index_file, const char *name, ...)
+int run_hook_v(const char *const *env, const char *name, va_list args)
 {
 	struct child_process hook;
 	struct argv_array argv = ARGV_ARRAY_INIT;
-	const char *p, *env[2];
-	char index[PATH_MAX];
-	va_list args;
+	const char *p;
 	int ret;
 
 	p = find_hook(name);
@@ -775,23 +773,28 @@ int run_hook(const char *index_file, const char *name, ...)
 
 	argv_array_push(&argv, p);
 
-	va_start(args, name);
 	while ((p = va_arg(args, const char *)))
 		argv_array_push(&argv, p);
-	va_end(args);
 
 	memset(&hook, 0, sizeof(hook));
 	hook.argv = argv.argv;
+	hook.env = env;
 	hook.no_stdin = 1;
 	hook.stdout_to_stderr = 1;
-	if (index_file) {
-		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-		env[0] = index;
-		env[1] = NULL;
-		hook.env = env;
-	}
 
 	ret = run_command(&hook);
 	argv_array_clear(&argv);
 	return ret;
 }
+
+int run_hook(const char *const *env, const char *name, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, name);
+	ret = run_hook_v(env, name, args);
+	va_end(args);
+
+	return ret;
+}
diff --git a/run-command.h b/run-command.h
index 6b985af..9f89e9f 100644
--- a/run-command.h
+++ b/run-command.h
@@ -47,7 +47,8 @@ int run_command(struct child_process *);
 
 extern char *find_hook(const char *name);
 LAST_ARG_MUST_BE_NULL
-extern int run_hook(const char *index_file, const char *name, ...);
+extern int run_hook(const char *const *env, const char *name, ...);
+extern int run_hook_v(const char *const *env, const char *name, va_list args);
 
 #define RUN_COMMAND_NO_STDIN 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
diff --git a/t/t7513-commit_-p_-m_hunk_edit.sh b/t/t7513-commit_-p_-m_hunk_edit.sh
index e0ad905..ffc4120 100755
--- a/t/t7513-commit_-p_-m_hunk_edit.sh
+++ b/t/t7513-commit_-p_-m_hunk_edit.sh
@@ -28,7 +28,7 @@ index a29bdeb..c0d0fb4 100644
 EOF
 '
 
-test_expect_failure 'edit hunk "commit -p -m message"' '
+test_expect_success 'edit hunk "commit -p -m message"' '
 	echo e | env GIT_EDITOR="sed s/+line3\$/+line2/ -i" git commit -p -m commit2 file &&
 	git diff HEAD^ HEAD >diff &&
 	test_cmp expected diff
-- 
1.9.0

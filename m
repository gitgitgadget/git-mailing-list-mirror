From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 4/7] commit: fix patch hunk editing with "commit -p -m"
Date: Mon, 10 Mar 2014 19:49:34 +0100
Message-ID: <1394477377-10994-5-git-send-email-benoit.pierre@gmail.com>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 19:50:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN5HD-0005To-EA
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 19:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132AbaCJSt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 14:49:57 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:51654 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbaCJStz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 14:49:55 -0400
Received: by mail-wg0-f43.google.com with SMTP id x13so9144158wgg.2
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 11:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=x2YRRwVmfc9nP99u5ZQJOuR8m3FNZq6rue3DBwgZs8w=;
        b=SLy0QSh7FMwyJ4OiVYZ2zi4qegCrJVuyOsI9j6lv1+4Wad4FJgbcepNXuZ1Sw22hsS
         RlyTYI6SeMEllHWwgRIL+Xi15CTQFf6XypQmhv+/AlLPRa206h8XnSsoAC0byk9feRSk
         S4sfxCV/QOtzxfWK3gOw9n97egfas7fEpBguq/DSdoxVwgaotTM757HhcAqeRIodh7tY
         QHaGPP8WvaJCbQMauvIg/lJ2A+H8rk8n6eyx/nsUKz/DrjgDCPqGgVaX5pw3fCLU++m2
         sh5l0TB7TbVZ/sIrnXALNf/2vRR0KYlygeqcZagSOd4fqy8gpyef9hkMiQYyyt97z8R0
         rUcg==
X-Received: by 10.195.13.103 with SMTP id ex7mr32805044wjd.3.1394477394012;
        Mon, 10 Mar 2014 11:49:54 -0700 (PDT)
Received: from localhost (109.12.70.86.rev.sfr.net. [86.70.12.109])
        by mx.google.com with ESMTPSA id g5sm54372812wjs.8.2014.03.10.11.49.52
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Mar 2014 11:49:53 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.7.gca5104e.dirty
In-Reply-To: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243791>

Don't change git environment: move the GIT_EDITOR=":" override to the
hook command subprocess, like it's already done for GIT_INDEX_FILE.

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 builtin/checkout.c                |  8 +++----
 builtin/clone.c                   |  4 ++--
 builtin/commit.c                  | 35 ++++++++++++++++++++++++-------
 builtin/gc.c                      |  2 +-
 builtin/merge.c                   |  6 +++---
 commit.h                          |  3 +++
 run-command.c                     | 44 ++++++++++++++++++++++++++++-----------
 run-command.h                     |  6 +++++-
 t/t7513-commit_-p_-m_hunk_edit.sh |  2 +-
 9 files changed, 79 insertions(+), 31 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5df3837..da423b2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -53,10 +53,10 @@ struct checkout_opts {
 static int post_checkout_hook(struct commit *old, struct commit *new,
 			      int changed)
 {
-	return run_hook(NULL, "post-checkout",
-			sha1_to_hex(old ? old->object.sha1 : null_sha1),
-			sha1_to_hex(new ? new->object.sha1 : null_sha1),
-			changed ? "1" : "0", NULL);
+    return run_hook_le(NULL, "post-checkout",
+		       sha1_to_hex(old ? old->object.sha1 : null_sha1),
+		       sha1_to_hex(new ? new->object.sha1 : null_sha1),
+		       changed ? "1" : "0", NULL);
 	/* "new" can be NULL when checking out from the index before
 	   a commit exists. */
 
diff --git a/builtin/clone.c b/builtin/clone.c
index 43e772c..9b3c04d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -660,8 +660,8 @@ static int checkout(void)
 	    commit_locked_index(lock_file))
 		die(_("unable to write new index file"));
 
-	err |= run_hook(NULL, "post-checkout", sha1_to_hex(null_sha1),
-			sha1_to_hex(sha1), "1", NULL);
+	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
+			   sha1_to_hex(sha1), "1", NULL);
 
 	if (!err && option_recursive)
 		err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
diff --git a/builtin/commit.c b/builtin/commit.c
index 3767478..baf1fc0 100644
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
+	ret = run_hook_ve(hook_env, name, args);
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
diff --git a/builtin/gc.c b/builtin/gc.c
index c19545d..7fa717a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -179,7 +179,7 @@ static int need_to_gc(void)
 	else if (!too_many_loose_objects())
 		return 0;
 
-	if (run_hook(NULL, "pre-auto-gc", NULL))
+	if (run_hook_le(NULL, "pre-auto-gc", NULL))
 		return 0;
 	return 1;
 }
diff --git a/builtin/merge.c b/builtin/merge.c
index e576a7f..67f312d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -421,7 +421,7 @@ static void finish(struct commit *head_commit,
 	}
 
 	/* Run a post-merge hook */
-	run_hook(NULL, "post-merge", squash ? "1" : "0", NULL);
+	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
 
 	strbuf_release(&reflog_message);
 }
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
index 3914d9c..75abc47 100644
--- a/run-command.c
+++ b/run-command.c
@@ -760,13 +760,11 @@ char *find_hook(const char *name)
 	return path;
 }
 
-int run_hook(const char *index_file, const char *name, ...)
+int run_hook_ve(const char *const *env, const char *name, va_list args)
 {
 	struct child_process hook;
 	struct argv_array argv = ARGV_ARRAY_INIT;
-	const char *p, *env[2];
-	char index[PATH_MAX];
-	va_list args;
+	const char *p;
 	int ret;
 
 	p = find_hook(name);
@@ -775,23 +773,45 @@ int run_hook(const char *index_file, const char *name, ...)
 
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
+int run_hook_le(const char *const *env, const char *name, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, name);
+	ret = run_hook_ve(env, name, args);
+	va_end(args);
+
+	return ret;
+}
+
+int run_hook_with_custom_index(const char *index_file, const char *name, ...)
+{
+	const char *hook_env[3] =  { NULL };
+	char index[PATH_MAX];
+	va_list args;
+	int ret;
+
+	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
+	hook_env[0] = index;
+
+	va_start(args, name);
+	ret = run_hook_ve(hook_env, name, args);
+	va_end(args);
+
+	return ret;
+}
diff --git a/run-command.h b/run-command.h
index 6b985af..88460f9 100644
--- a/run-command.h
+++ b/run-command.h
@@ -47,7 +47,11 @@ int run_command(struct child_process *);
 
 extern char *find_hook(const char *name);
 LAST_ARG_MUST_BE_NULL
-extern int run_hook(const char *index_file, const char *name, ...);
+extern int run_hook_le(const char *const *env, const char *name, ...);
+extern int run_hook_ve(const char *const *env, const char *name, va_list args);
+
+LAST_ARG_MUST_BE_NULL
+extern int run_hook_with_custom_index(const char *index_file, const char *name, ...);
 
 #define RUN_COMMAND_NO_STDIN 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
diff --git a/t/t7513-commit_-p_-m_hunk_edit.sh b/t/t7513-commit_-p_-m_hunk_edit.sh
index 994939a..1f05d32 100755
--- a/t/t7513-commit_-p_-m_hunk_edit.sh
+++ b/t/t7513-commit_-p_-m_hunk_edit.sh
@@ -25,7 +25,7 @@ test_expect_success 'setup (initial)' '
 	EOF
 '
 
-test_expect_failure 'edit hunk "commit -p -m message"' '
+test_expect_success 'edit hunk "commit -p -m message"' '
 	echo e | env GIT_EDITOR="sed s/+line3\$/+line2/ -i" git commit -p -m commit2 file &&
 	git diff HEAD^ HEAD >actual &&
 	test_cmp expect actual
-- 
1.9.0

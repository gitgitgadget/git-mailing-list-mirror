From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 4/7] commit: fix patch hunk editing with "commit -p -m"
Date: Sat, 15 Mar 2014 22:42:27 +0100
Message-ID: <1394919750-28432-4-git-send-email-benoit.pierre@gmail.com>
References: <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
 <1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 22:43:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOwMG-000254-JA
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 22:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756646AbaCOVnC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 17:43:02 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:44944 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190AbaCOVnA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 17:43:00 -0400
Received: by mail-we0-f177.google.com with SMTP id u57so3187169wes.8
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 14:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=P6g4xBWU4uoi1aO2zVvEySMIfEqhJjwajmj9lZaJfAo=;
        b=YtyVTgMMdMJujLVzdaCgN5w03qCWzKGK1Cm31vuJKTrc3rv4BjmmISnSmrYZz+0yCC
         AYlrdkeNOyABb3jYluIORe+GZKy6FCADO8Dc1RnJVzU6H1YsV0t2Vz4qfBbWiBGO9/XT
         yqGcY5o5/OJTXBdVwrJopVFbRoMtjCYbf4qSMYsGuDFgMp8Y3wo91RzPavOMsPs+L9vu
         ArhwRg87MAq7XiZMxJO/hvq8QjHmDmbrfS/JVECvuA7XSXURdmZkCAJgJGOsjQw65z2Z
         XEoN27Ww5PVGmPKkxgFR5sYWKa2d5CoHbcMRsGvoSDmZtZlj2NPwjUPP+L5v+m6eyHfk
         2jbw==
X-Received: by 10.194.236.232 with SMTP id ux8mr2707198wjc.46.1394919779509;
        Sat, 15 Mar 2014 14:42:59 -0700 (PDT)
Received: from localhost (121.12.70.86.rev.sfr.net. [86.70.12.121])
        by mx.google.com with ESMTPSA id h13sm24322223wjr.22.2014.03.15.14.42.56
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Mar 2014 14:42:58 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244172>

Don't change git environment: move the GIT_EDITOR=":" override to the
hook command subprocess, like it's already done for GIT_INDEX_FILE.

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 builtin/checkout.c      |  8 ++++----
 builtin/clone.c         |  4 ++--
 builtin/commit.c        | 35 ++++++++++++++++++++++++++++-------
 builtin/gc.c            |  2 +-
 builtin/merge.c         |  6 +++---
 commit.h                |  3 +++
 run-command.c           | 44 ++++++++++++++++++++++++++++++++------------
 run-command.h           |  6 +++++-
 t/t7513-commit-patch.sh |  4 ++--
 9 files changed, 80 insertions(+), 32 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index ada51fa..1b86d9c 100644
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
+	return run_hook_le(NULL, "post-checkout",
+			   sha1_to_hex(old ? old->object.sha1 : null_sha1),
+			   sha1_to_hex(new ? new->object.sha1 : null_sha1),
+			   changed ? "1" : "0", NULL);
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
index 3783bca..68a90b3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -610,7 +610,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
 
-	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
+	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
 		return 0;
 
 	if (squash_message) {
@@ -867,8 +867,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (run_hook(index_file, "prepare-commit-msg",
-		     git_path(commit_editmsg), hook_arg1, hook_arg2, NULL))
+	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
+			    git_path(commit_editmsg), hook_arg1, hook_arg2, NULL))
 		return 0;
 
 	if (use_editor) {
@@ -884,7 +884,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	if (!no_verify &&
-	    run_hook(index_file, "commit-msg", git_path(commit_editmsg), NULL)) {
+	    run_commit_hook(use_editor, index_file, "commit-msg", git_path(commit_editmsg), NULL)) {
 		return 0;
 	}
 
@@ -1068,8 +1068,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		use_editor = 0;
 	if (0 <= edit_flag)
 		use_editor = edit_flag;
-	if (!use_editor)
-		setenv("GIT_EDITOR", ":", 1);
 
 	/* Sanity check options */
 	if (amend && !current_head)
@@ -1450,6 +1448,29 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
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
@@ -1674,7 +1695,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		     "not exceeded, and then \"git reset HEAD\" to recover."));
 
 	rerere(0);
-	run_hook(get_index_file(), "post-commit", NULL);
+	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		struct notes_rewrite_cfg *cfg;
 		cfg = init_copy_notes_for_rewrite("amend");
diff --git a/builtin/gc.c b/builtin/gc.c
index 63d400b..11cf295 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -184,7 +184,7 @@ static int need_to_gc(void)
 	else if (!too_many_loose_objects())
 		return 0;
 
-	if (run_hook(NULL, "pre-auto-gc", NULL))
+	if (run_hook_le(NULL, "pre-auto-gc", NULL))
 		return 0;
 	return 1;
 }
diff --git a/builtin/merge.c b/builtin/merge.c
index f0cf120..bdf6655 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -421,7 +421,7 @@ static void finish(struct commit *head_commit,
 	}
 
 	/* Run a post-merge hook */
-	run_hook(NULL, "post-merge", squash ? "1" : "0", NULL);
+	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
 
 	strbuf_release(&reflog_message);
 }
@@ -824,8 +824,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
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
diff --git a/t/t7513-commit-patch.sh b/t/t7513-commit-patch.sh
index 9311b0c..67e4cde 100755
--- a/t/t7513-commit-patch.sh
+++ b/t/t7513-commit-patch.sh
@@ -15,14 +15,14 @@ test_expect_success 'setup (initial)' '
 	git commit -m commit1
 '
 
-test_expect_failure 'edit hunk "commit -p -m message"' '
+test_expect_success 'edit hunk "commit -p -m message"' '
 	test_when_finished "rm -f editor_was_started" &&
 	echo more >>file &&
 	echo e | env GIT_EDITOR="touch editor_was_started" git commit -p -m commit2 file &&
 	test -r editor_was_started
 '
 
-test_expect_failure 'edit hunk "commit --dry-run -p -m message"' '
+test_expect_success 'edit hunk "commit --dry-run -p -m message"' '
 	test_when_finished "rm -f editor_was_started" &&
 	echo more >>file &&
 	echo e | env GIT_EDITOR="touch editor_was_started" git commit -p -m commit3 file &&
-- 
1.9.0

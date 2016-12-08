Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D0751FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 21:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932309AbcLHVEK (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 16:04:10 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35987 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752683AbcLHVEF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 16:04:05 -0500
Received: by mail-pg0-f49.google.com with SMTP id f188so177078837pgc.3
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 13:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ADNW/VuDadJCyfJkM/MQ2QeIZhNH0gpRVMsQNEomZfg=;
        b=l625MlAwuHqiQ08Si5EjZHcqD6xi1kyw+zKPhmKd6hH8Kte2C5rXFfbUR1j7dBnGyD
         12x+yPCNAm5xHtONXL9GyIcxFOc0IeW7WULsEBUBkW6a8GpQDmjQ0AiX3goIoZcDCuyX
         TWwT3ANQD0RAktHVg194XbAdBGtFjNC4y7tmQVdoDO3ArquTgRuHd0yF30J9ZzL6XKkk
         LnWkY1jVUZ0Rwt51h9MR9U5rL8HeVWxRVHC5pqHGlNyZRQaGpI77M76eFG8RNDKbZWNj
         jiDZYLQ1qD4vxzH4dsyQZ3IsZFKzfu5SWHPBacEELUdC0hcZqmoIBGmXP2PHYKIKKZ/k
         s1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ADNW/VuDadJCyfJkM/MQ2QeIZhNH0gpRVMsQNEomZfg=;
        b=HPdYcu0z6HFdQn0k2z/pWuJZes0vLJ2AsQaI/FmCQvidFLR8PfnBeTDKAfMOXK035U
         jnxdI0SSivIW9bUg/oz/jmOLqHyqjh7FCqWQhFhA8asYS759bXIg+g27xidhDDSrhrU1
         UPnZZ0fTb+8f95UPyKiqawLH0f+F0r5ThLL4SZbM7o4/q7QMeZsMQVF0o2aq2+0CyNI/
         QOwrtxXdPo2dwwPt05yC9c2PLXwwr4BWtQa12EJN8kfBdq0DyU7U2mydc3XCUHD/2Hwx
         gippSoccgiQVJvYpX3Ad76cr8QU3zjuo11o9qTFkT45ak8GP8wv8+Xc/AMsP0/cEj74V
         9YXQ==
X-Gm-Message-State: AKaTC00zDvuJXd+w2vZAvsspjeN3YK0/ctCbd7QnnWCpsXc9K0KCQJijXXJZpZr+bAYDe6xP
X-Received: by 10.99.24.84 with SMTP id 20mr136335613pgy.12.1481231019911;
        Thu, 08 Dec 2016 13:03:39 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6884:a3d1:aaf8:234b])
        by smtp.gmail.com with ESMTPSA id q9sm52222103pfg.47.2016.12.08.13.03.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 13:03:39 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 6/6] submodule: add absorb-git-dir function
Date:   Thu,  8 Dec 2016 13:03:29 -0800
Message-Id: <20161208210329.12919-7-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.29.g7c00390.dirty
In-Reply-To: <20161208210329.12919-1-sbeller@google.com>
References: <20161208210329.12919-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodule has its git dir inside the working dir, the submodule
support for checkout that we plan to add in a later patch will fail.

Add functionality to migrate the git directory to be absorbed
into the superprojects git directory.

The newly added code in this patch is structured such that other areas of
Git can also make use of it. The code in the submodule--helper is a mere
wrapper and option parser for the function
`absorb_git_dir_into_superproject`, that takes care of embedding the
submodules git directory into the superprojects git dir. That function
makes use of the more abstract function for this use case
`relocate_gitdir`, which can be used by e.g. the worktree code eventually
to move around a git directory.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt    |  15 ++++++
 builtin/submodule--helper.c        |  38 ++++++++++++++
 dir.c                              |  12 +++++
 dir.h                              |   3 ++
 git-submodule.sh                   |   7 ++-
 submodule.c                        | 103 +++++++++++++++++++++++++++++++++++++
 submodule.h                        |   4 ++
 t/t7412-submodule-absorbgitdirs.sh | 101 ++++++++++++++++++++++++++++++++++++
 8 files changed, 282 insertions(+), 1 deletion(-)
 create mode 100755 t/t7412-submodule-absorbgitdirs.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index d841573475..918bd1d1bd 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -22,6 +22,7 @@ SYNOPSIS
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
 'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
+'git submodule' [--quiet] absorbgitdirs [--] [<path>...]
 
 
 DESCRIPTION
@@ -245,6 +246,20 @@ sync::
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and sync any nested submodules within.
 
+absorbgitdirs::
+	If a git directory of a submodule is inside the submodule,
+	move the git directory of the submodule into its superprojects
+	`$GIT_DIR/modules` path and then connect the git directory and
+	its working directory by setting the `core.worktree` and adding
+	a .git file pointing to the git directory embedded in the
+	superprojects git directory.
++
+A repository that was cloned independently and later added as a submodule or
+old setups have the submodules git directory inside the submodule instead of
+embedded into the superprojects git directory.
++
+This command is recursive by default.
+
 OPTIONS
 -------
 -q::
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5643848667..242d9911a6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1076,6 +1076,43 @@ static int resolve_remote_submodule_branch(int argc, const char **argv,
 	return 0;
 }
 
+static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+	unsigned flags = ABSORB_GITDIR_RECURSE_SUBMODULES;
+
+	struct option embed_gitdir_options[] = {
+		OPT_STRING(0, "prefix", &prefix,
+			   N_("path"),
+			   N_("path into the working tree")),
+		OPT_BIT(0, "--recursive", &flags, N_("recurse into submodules"),
+			ABSORB_GITDIR_RECURSE_SUBMODULES),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper embed-git-dir [<path>...]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, embed_gitdir_options,
+			     git_submodule_helper_usage, 0);
+
+	gitmodules_config();
+	git_config(submodule_config, NULL);
+
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+		return 1;
+
+	for (i = 0; i < list.nr; i++)
+		absorb_git_dir_into_superproject(prefix,
+				list.entries[i]->name, flags);
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -1094,6 +1131,7 @@ static struct cmd_struct commands[] = {
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"init", module_init, 0},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
+	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/dir.c b/dir.c
index e0efd3c2c3..d872cc1570 100644
--- a/dir.c
+++ b/dir.c
@@ -2773,3 +2773,15 @@ void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
 	free(work_tree);
 	free(git_dir);
 }
+
+/*
+ * Migrate the git directory of the given path from old_git_dir to new_git_dir.
+ */
+void relocate_gitdir(const char *path, const char *old_git_dir, const char *new_git_dir)
+{
+	if (rename(old_git_dir, new_git_dir) < 0)
+		die_errno(_("could not migrate git directory from '%s' to '%s'"),
+			old_git_dir, new_git_dir);
+
+	connect_work_tree_and_git_dir(path, new_git_dir);
+}
diff --git a/dir.h b/dir.h
index 051674a431..bf23a470af 100644
--- a/dir.h
+++ b/dir.h
@@ -336,4 +336,7 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
 extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
+extern void relocate_gitdir(const char *path,
+			    const char *old_git_dir,
+			    const char *new_git_dir);
 #endif
diff --git a/git-submodule.sh b/git-submodule.sh
index a024a135d6..9285b5c43d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1131,6 +1131,11 @@ cmd_sync()
 	done
 }
 
+cmd_absorbgitdirs()
+{
+	git submodule--helper absorb-git-dirs --prefix "$wt_prefix" "$@"
+}
+
 # This loop parses the command line arguments to find the
 # subcommand name to dispatch.  Parsing of the subcommand specific
 # options are primarily done by the subcommand implementations.
@@ -1140,7 +1145,7 @@ cmd_sync()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | deinit | update | status | summary | sync)
+	add | foreach | init | deinit | update | status | summary | sync | absorbgitdirs)
 		command=$1
 		;;
 	-q|--quiet)
diff --git a/submodule.c b/submodule.c
index 0bb50b4b62..45ccfb7ab4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -14,6 +14,7 @@
 #include "blob.h"
 #include "thread-utils.h"
 #include "quote.h"
+#include "worktree.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static int parallel_jobs = 1;
@@ -1237,3 +1238,105 @@ void prepare_submodule_repo_env(struct argv_array *out)
 	}
 	argv_array_push(out, "GIT_DIR=.git");
 }
+
+/*
+ * Embeds a single submodules git directory into the superprojects git dir,
+ * non recursively.
+ */
+static void relocate_single_git_dir_into_superproject(const char *prefix,
+						      const char *path)
+{
+	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
+	const char *new_git_dir;
+	const struct submodule *sub;
+
+	if (submodule_uses_worktrees(path))
+		die(_("relocate_gitdir for submodule '%s' with "
+		      "more than one worktree not supported"), path);
+
+	old_git_dir = xstrfmt("%s/.git", path);
+	if (read_gitfile(old_git_dir))
+		/* If it is an actual gitfile, it doesn't need migration. */
+		return;
+
+	real_old_git_dir = xstrdup(real_path(old_git_dir));
+
+	sub = submodule_from_path(null_sha1, path);
+	if (!sub)
+		die(_("could not lookup name for submodule '%s'"), path);
+
+	new_git_dir = git_path("modules/%s", sub->name);
+	if (safe_create_leading_directories_const(new_git_dir) < 0)
+		die(_("could not create directory '%s'"), new_git_dir);
+	real_new_git_dir = xstrdup(real_path(new_git_dir));
+
+	if (!prefix)
+		prefix = get_super_prefix();
+
+	fprintf(stderr, _("Migrating git directory of '%s%s' from\n'%s' to\n'%s'\n"),
+		prefix ? prefix : "", path,
+		real_old_git_dir, real_new_git_dir);
+
+	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
+
+	free(old_git_dir);
+	free(real_old_git_dir);
+	free(real_new_git_dir);
+}
+
+/*
+ * Migrate the git directory of the submodule given by path from
+ * having its git directory within the working tree to the git dir nested
+ * in its superprojects git dir under modules/.
+ */
+void absorb_git_dir_into_superproject(const char *prefix,
+				      const char *path,
+				      unsigned flags)
+{
+	const char *sub_git_dir, *v;
+	char *real_sub_git_dir = NULL, *real_common_git_dir = NULL;
+	struct strbuf gitdir = STRBUF_INIT;
+
+	strbuf_addf(&gitdir, "%s/.git", path);
+	sub_git_dir = resolve_gitdir(gitdir.buf);
+
+	/* Not populated? */
+	if (!sub_git_dir)
+		goto out;
+
+	/* Is it already absorbed into the superprojects git dir? */
+	real_sub_git_dir = xstrdup(real_path(sub_git_dir));
+	real_common_git_dir = xstrdup(real_path(get_git_common_dir()));
+	if (!skip_prefix(real_sub_git_dir, real_common_git_dir, &v))
+		relocate_single_git_dir_into_superproject(prefix, path);
+
+	if (flags & ABSORB_GITDIR_RECURSE_SUBMODULES) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct strbuf sb = STRBUF_INIT;
+
+		if (flags & ~ABSORB_GITDIR_RECURSE_SUBMODULES)
+			die("BUG: we don't know how to pass the flags down?");
+
+		if (get_super_prefix())
+			strbuf_addstr(&sb, get_super_prefix());
+		strbuf_addstr(&sb, path);
+		strbuf_addch(&sb, '/');
+
+		cp.dir = path;
+		cp.git_cmd = 1;
+		cp.no_stdin = 1;
+		argv_array_pushl(&cp.args, "--super-prefix", sb.buf,
+					   "submodule--helper",
+					   "absorb-git-dirs", NULL);
+		prepare_submodule_repo_env(&cp.env_array);
+		if (run_command(&cp))
+			die(_("could not recurse into submodule '%s'"), path);
+
+		strbuf_release(&sb);
+	}
+
+out:
+	strbuf_release(&gitdir);
+	free(real_sub_git_dir);
+	free(real_common_git_dir);
+}
diff --git a/submodule.h b/submodule.h
index 4e3bf469b4..6229054b99 100644
--- a/submodule.h
+++ b/submodule.h
@@ -74,4 +74,8 @@ int parallel_submodules(void);
  */
 void prepare_submodule_repo_env(struct argv_array *out);
 
+#define ABSORB_GITDIR_RECURSE_SUBMODULES (1<<0)
+extern void absorb_git_dir_into_superproject(const char *prefix,
+					     const char *path,
+					     unsigned flags);
 #endif
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
new file mode 100755
index 0000000000..7c4e8b8d79
--- /dev/null
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+
+test_description='Test submodule absorbgitdirs
+
+This test verifies that `git submodue absorbgitdirs` moves a submodules git
+directory into the superproject.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup a real submodule' '
+	git init sub1 &&
+	test_commit -C sub1 first &&
+	git submodule add ./sub1 &&
+	test_tick &&
+	git commit -m superproject
+'
+
+test_expect_success 'absorb the git dir' '
+	>expect.1 &&
+	>expect.2 &&
+	>actual.1 &&
+	>actual.2 &&
+	git status >expect.1 &&
+	git -C sub1 rev-parse HEAD >expect.2 &&
+	git submodule absorbgitdirs &&
+	git fsck &&
+	test -f sub1/.git &&
+	test -d .git/modules/sub1 &&
+	git status >actual.1 &&
+	git -C sub1 rev-parse HEAD >actual.2 &&
+	test_cmp expect.1 actual.1 &&
+	test_cmp expect.2 actual.2
+'
+
+test_expect_success 'absorbing does not fail for deinitalized submodules' '
+	test_when_finished "git submodule update --init" &&
+	git submodule deinit --all &&
+	git submodule absorbgitdirs &&
+	test -d .git/modules/sub1 &&
+	test -d sub1 &&
+	! test -e sub1/.git
+'
+
+test_expect_success 'setup nested submodule' '
+	git init sub1/nested &&
+	test_commit -C sub1/nested first_nested &&
+	git -C sub1 submodule add ./nested &&
+	test_tick &&
+	git -C sub1 commit -m "add nested" &&
+	git add sub1 &&
+	git commit -m "sub1 to include nested submodule"
+'
+
+test_expect_success 'absorb the git dir in a nested submodule' '
+	git status >expect.1 &&
+	git -C sub1/nested rev-parse HEAD >expect.2 &&
+	git submodule absorbgitdirs &&
+	test -f sub1/nested/.git &&
+	test -d .git/modules/sub1/modules/nested &&
+	git status >actual.1 &&
+	git -C sub1/nested rev-parse HEAD >actual.2 &&
+	test_cmp expect.1 actual.1 &&
+	test_cmp expect.2 actual.2
+'
+
+test_expect_success 'setup a gitlink with missing .gitmodules entry' '
+	git init sub2 &&
+	test_commit -C sub2 first &&
+	git add sub2 &&
+	git commit -m superproject
+'
+
+test_expect_success 'absorbing the git dir fails for incomplete submodules' '
+	git status >expect.1 &&
+	git -C sub2 rev-parse HEAD >expect.2 &&
+	test_must_fail git submodule absorbgitdirs &&
+	git -C sub2 fsck &&
+	test -d sub2/.git &&
+	git status >actual &&
+	git -C sub2 rev-parse HEAD >actual.2 &&
+	test_cmp expect.1 actual.1 &&
+	test_cmp expect.2 actual.2
+'
+
+test_expect_success 'setup a submodule with multiple worktrees' '
+	# first create another unembedded git dir in a new submodule
+	git init sub3 &&
+	test_commit -C sub3 first &&
+	git submodule add ./sub3 &&
+	test_tick &&
+	git commit -m "add another submodule" &&
+	git -C sub3 worktree add ../sub3_second_work_tree
+'
+
+test_expect_success 'absorb a submodule with multiple worktrees' '
+	test_must_fail git submodule absorbgitdirs sub3 2>error &&
+	test_i18ngrep "not supported" error
+'
+
+test_done
-- 
2.11.0.rc2.29.g7c00390.dirty


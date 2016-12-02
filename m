Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A29B1FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 23:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755092AbcLBXnY (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 18:43:24 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34892 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbcLBXnR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 18:43:17 -0500
Received: by mail-pg0-f44.google.com with SMTP id p66so112521620pga.2
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 15:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fwtwxNk2xRXjIJj+E1F3euXwYRyj8knEAr9r4WXI+O4=;
        b=cNIkYeKVfxvdVaYf1DayftoUG7y4I+kXA661nN2XAXBKq3HN/WacdQ6g3ZGD+qgQQe
         ENz9B412NRvjIBKLHPXUZAcRPPdBnofhitEwXwtUgPtclcxJC/Y9BsXafH2XN5Vgbrmh
         MqT3IEm/iKjFMevH0wmGGf3AnpZBEJGjti7lLkMICdKk5kxybe+NYWtqd0Bj7af9Jgit
         vrf2eRrDENzFMAvSVqxaXIxeGPDds5aUWbh9X9atw01R8QDJgU6/+m2V6AqzRgn4qqpB
         ADB55wMCKnaN+YtSgEeEahECNQHyxL3GSBprQhV3HGaXxFEaFDTVX2YYlWCvtIKTaK9y
         0pLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fwtwxNk2xRXjIJj+E1F3euXwYRyj8knEAr9r4WXI+O4=;
        b=I+2+jODmQlA3q3wJjKiWRavyTk7AOzcsUAgnn12Ml6MN8xpOm1hCOAHurtEi3sKnxp
         z/cMnIs77HERMWsILNP5Ozem2MX1uBgEsSppdbH2mjQgQS1FoM4kJHvRYipvZ6acxcen
         vLFt/hDdzb7p/RxNMaVVjYYnQqapjR1fUw1kx5IiUXTSntwZenbRly2deAZ0dh19YI3/
         tHcMAjVhxW8t7VpDADDe4T6wz53Zd0s3wjeapF+2M6Xvh3kvcBG2CVpSxlbl4DdVqprB
         Gxqe8/4hqZtA1gbM26ppBVaKdUiCclHJldDdQ13ID4wnBxRIaj/D0O5VJk3EZuBrCAMt
         V6PQ==
X-Gm-Message-State: AKaTC03eYq3o7A8FKuanEWlp+cChUxWipaghy9XEcj5nH1omjr10+tfQprRY83u9FkQPcPuL
X-Received: by 10.99.245.21 with SMTP id w21mr84608342pgh.5.1480722149454;
        Fri, 02 Dec 2016 15:42:29 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id 24sm10151680pfh.41.2016.12.02.15.42.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 15:42:29 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com, bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 5/5] submodule: add embed-git-dir function
Date:   Fri,  2 Dec 2016 15:42:20 -0800
Message-Id: <20161202234220.24664-6-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161202234220.24664-1-sbeller@google.com>
References: <20161202234220.24664-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodule has its git dir inside the working dir, the submodule
support for checkout that we plan to add in a later patch will fail.

Add functionality to migrate the git directory to be embedded
into the superprojects git directory.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-submodule.txt   |  14 ++++++
 builtin/submodule--helper.c       |  62 ++++++++++++++++++++++-
 dir.c                             |  81 ++++++++++++++++++++++++++++++
 dir.h                             |   4 ++
 git-submodule.sh                  |   7 ++-
 t/t7412-submodule-embedgitdirs.sh | 101 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 267 insertions(+), 2 deletions(-)
 create mode 100755 t/t7412-submodule-embedgitdirs.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index d841573475..34791cfc65 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -22,6 +22,7 @@ SYNOPSIS
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
 'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
+'git submodule' [--quiet] embedgitdirs [--] [<path>...]
 
 
 DESCRIPTION
@@ -245,6 +246,19 @@ sync::
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and sync any nested submodules within.
 
+embedgitdirs::
+	Move the git directory of submodules into its superprojects
+	`$GIT_DIR/modules` path and then connect the git directory and
+	its working directory by setting the `core.worktree` and adding
+	a .git file pointing to the git directory interned into the
+	superproject.
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
index 806e29ce4e..10df69c86a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1076,6 +1076,65 @@ static int resolve_remote_submodule_branch(int argc, const char **argv,
 	return 0;
 }
 
+static int embed_git_dir(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+	unsigned flags = RELOCATE_GITDIR_RECURSE_SUBMODULES;
+
+	struct option embed_gitdir_options[] = {
+		OPT_STRING(0, "prefix", &prefix,
+			   N_("path"),
+			   N_("path into the working tree")),
+		OPT_BIT(0, "--recursive", &flags, N_("recurse into submodules"),
+			RELOCATE_GITDIR_RECURSE_SUBMODULES),
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
+	for (i = 0; i < list.nr; i++) {
+		const char *path = list.entries[i]->name, *sub_git_dir, *v;
+		char *real_sub_git_dir = NULL, *real_common_git_dir = NULL;
+		struct strbuf gitdir = STRBUF_INIT;
+
+		strbuf_addf(&gitdir, "%s/.git", path);
+		sub_git_dir = resolve_gitdir(gitdir.buf);
+
+		/* not populated? */
+		if (!sub_git_dir)
+			goto free_and_continue;
+
+		/* Is it already embedded? */
+		real_sub_git_dir = xstrdup(real_path(sub_git_dir));
+		real_common_git_dir = xstrdup(real_path(get_git_common_dir()));
+		if (skip_prefix(real_sub_git_dir, real_common_git_dir, &v), NULL)
+			goto free_and_continue;
+
+		relocate_gitdir(prefix, path, flags);
+
+free_and_continue:
+		strbuf_release(&gitdir);
+		free(real_sub_git_dir);
+		free(real_common_git_dir);
+	}
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -1093,7 +1152,8 @@ static struct cmd_struct commands[] = {
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"init", module_init, 0},
-	{"remote-branch", resolve_remote_submodule_branch, 0}
+	{"remote-branch", resolve_remote_submodule_branch, 0},
+	{"embed-git-dirs", embed_git_dir, SUPPORT_SUPER_PREFIX}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/dir.c b/dir.c
index bfa8c8a9a5..d2f60b5abf 100644
--- a/dir.c
+++ b/dir.c
@@ -15,6 +15,9 @@
 #include "utf8.h"
 #include "varint.h"
 #include "ewah/ewok.h"
+#include "submodule-config.h"
+#include "run-command.h"
+#include "worktree.h"
 
 struct path_simplify {
 	int len;
@@ -2748,3 +2751,81 @@ void untracked_cache_add_to_index(struct index_state *istate,
 {
 	untracked_cache_invalidate_path(istate, path);
 }
+
+/*
+ * Migrate the given submodule (and all its submodules recursively) from
+ * having its git directory within the working tree to the git dir nested
+ * in its superprojects git dir under modules/.
+ */
+void relocate_gitdir(const char *prefix, const char *path, unsigned flags)
+{
+	char *old_git_dir;
+	const char *new_git_dir;
+	const struct submodule *sub;
+	struct worktree **worktrees;
+	int i;
+
+	worktrees = get_submodule_worktrees(path, 0);
+	if (worktrees) {
+		for (i = 0; worktrees[i]; i++)
+			;
+		free_worktrees(worktrees);
+		if (i > 1)
+			die(_("relocate_gitdir for submodule with more than one worktree not supported"));
+	}
+
+	old_git_dir = xstrfmt("%s/.git", path);
+	if (read_gitfile(old_git_dir))
+		/* If it is an actual gitfile, it doesn't need migration. */
+		goto out;
+
+	sub = submodule_from_path(null_sha1, path);
+	if (!sub)
+		die(_("Could not lookup name for submodule '%s'"),
+		      path);
+
+	new_git_dir = git_path("modules/%s", sub->name);
+	if (safe_create_leading_directories_const(new_git_dir) < 0)
+		die(_("could not create directory '%s'"), new_git_dir);
+
+	if (!prefix)
+		prefix = get_super_prefix();
+	printf("Migrating git directory of %s%s from\n'%s' to\n'%s'\n",
+		prefix ? prefix : "", path,
+		real_path(old_git_dir), new_git_dir);
+
+	if (rename(old_git_dir, new_git_dir) < 0)
+		die_errno(_("Could not migrate git directory from '%s' to '%s'"),
+			old_git_dir, new_git_dir);
+
+	connect_work_tree_and_git_dir(path, new_git_dir);
+
+out:
+	if (flags & RELOCATE_GITDIR_RECURSE_SUBMODULES) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct strbuf sb = STRBUF_INIT;
+
+		if (flags & ~RELOCATE_GITDIR_RECURSE_SUBMODULES)
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
+					    "submodule--helper",
+					   "embed-git-dirs", NULL);
+		prepare_submodule_repo_env(&cp.env_array);
+		if (run_command(&cp))
+			die(_("Could not migrate git directory in submodule '%s'"),
+			    path);
+
+		strbuf_release(&sb);
+	}
+
+	free(old_git_dir);
+}
diff --git a/dir.h b/dir.h
index 97c83bb383..0b5e99b21d 100644
--- a/dir.h
+++ b/dir.h
@@ -335,4 +335,8 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
+
+#define RELOCATE_GITDIR_RECURSE_SUBMODULES (1<<0)
+extern void relocate_gitdir(const char *prefix, const char *path, unsigned flags);
+
 #endif
diff --git a/git-submodule.sh b/git-submodule.sh
index a024a135d6..b7e124f340 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1131,6 +1131,11 @@ cmd_sync()
 	done
 }
 
+cmd_embedgitdirs()
+{
+	git submodule--helper embed-git-dirs --prefix "$wt_prefix" "$@"
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
+	add | foreach | init | deinit | update | status | summary | sync | embedgitdirs)
 		command=$1
 		;;
 	-q|--quiet)
diff --git a/t/t7412-submodule-embedgitdirs.sh b/t/t7412-submodule-embedgitdirs.sh
new file mode 100755
index 0000000000..a02e7c447a
--- /dev/null
+++ b/t/t7412-submodule-embedgitdirs.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+
+test_description='Test submodule embedgitdirs
+
+This test verifies that `git submodue embedgitdirs` moves a submodules git
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
+test_expect_success 'embed the git dir' '
+	>expect.1 &&
+	>expect.2 &&
+	>actual.1 &&
+	>actual.2 &&
+	git status >expect.1 &&
+	git -C sub1 rev-parse HEAD >expect.2 &&
+	git submodule embedgitdirs &&
+	git fsck &&
+	test -f sub1/.git &&
+	test -d .git/modules/sub1 &&
+	git status >actual.1 &&
+	git -C sub1 rev-parse HEAD >actual.2 &&
+	test_cmp expect.1 actual.1 &&
+	test_cmp expect.2 actual.2
+'
+
+test_expect_success 'embedding does not fail for deinitalized submodules' '
+	test_when_finished "git submodule update --init" &&
+	git submodule deinit --all &&
+	git submodule embedgitdirs &&
+	test -d .git/modules/sub1 &&
+	! test -f sub1/.git &&
+	test -d sub1
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
+test_expect_success 'embed the git dir in a nested submodule' '
+	git status >expect.1 &&
+	git -C sub1/nested rev-parse HEAD >expect.2 &&
+	git submodule embedgitdirs &&
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
+test_expect_success 'embedding the git dir fails for incomplete submodules' '
+	git status >expect.1 &&
+	git -C sub2 rev-parse HEAD >expect.2 &&
+	test_must_fail git submodule embedgitdirs &&
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
+test_expect_success 'embed a submodule with multiple worktrees' '
+	test_must_fail git submodule embedgitdirs sub3 2>error &&
+	test_i18ngrep "not supported" error
+'
+
+test_done
-- 
2.11.0.rc2.28.g2673dad


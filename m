Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 149511FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 21:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933017AbcLGVCM (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 16:02:12 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33682 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932339AbcLGVCI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 16:02:08 -0500
Received: by mail-pg0-f46.google.com with SMTP id 3so165817488pgd.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 13:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NSB02ZsQmEmNwflpcgJZrIhxdNqoTKBGvP0nlh/AA48=;
        b=KaTL80ZIGUsP82twy4g6jw54cSYupIpDYp8/+b39v4wqtUCB6z69Z8uwosOlVnizl4
         sR+kQOF7yMDT2XXv3dE4nth4MwRLcvn0bRFYIKItsV7AWniErHMAifoobkeDapbYkunL
         l5xDlsTgJ2Ocdj5J5LFi5S1+6xiOPeiCREyi0x1+5GJMXeOeqDiAgH130mPAgGYG+Lmf
         v2xNnNqaZEg5N1UecFH0RqlZykGaZ4/Nxt0vDyVzLStJFff7SqwYoSzgyrEfxpkCofs3
         yUj3Dbiz3hq0PUe8f0oMCXVRX8dt5b/8wTqkDDzVx2iYNJtkNQ7yqQ8ZiSHHbGh+onhF
         bo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NSB02ZsQmEmNwflpcgJZrIhxdNqoTKBGvP0nlh/AA48=;
        b=FYnF2OXmJtjipLdsS3QAqXBvqUsAmIMpbJnBqgkFLrUzA3NzPoh944VW1nr/eRB3P0
         KF++vNnB9sZUszQRzcfuW72Fd8WsYUFg+TCw5ZTy/AMo8okbbZAooxrPU22IJEYX4u6Y
         eihU/bHvLl9QHIlP50NXQMUQ+96LOHjpWu+e3zG1s/Mg0fHg3HzzMB6Bz6mIentWogG7
         MTfMStv0ZIRhu/34q2CGCUWJqeQfsEFgA9jAT2LBBU1qF3X9Q9yK6fs2CcYwdQ0KBzNC
         apZAqBJFxL1tLw/QtHqH5nqkIjFHHlstE1amu/mMPZxS4ywZ7+Rsq4FHHdwbUhTOxDD9
         9C+A==
X-Gm-Message-State: AKaTC00w8jM0D6+0D1rLhYMyMGrIzjj+4QO0eiA6/3ttnd1nhXNQGF+w96ttivPoMcsrRl+K
X-Received: by 10.84.164.162 with SMTP id w31mr151735036pla.9.1481144527029;
        Wed, 07 Dec 2016 13:02:07 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2441:4f9a:ad0f:a8d7])
        by smtp.gmail.com with ESMTPSA id x2sm44622206pfx.65.2016.12.07.13.02.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 13:02:06 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 5/5] submodule: add embed-git-dir function
Date:   Wed,  7 Dec 2016 13:01:57 -0800
Message-Id: <20161207210157.18932-6-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2af45f1.dirty
In-Reply-To: <20161207210157.18932-1-sbeller@google.com>
References: <20161207210157.18932-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodule has its git dir inside the working dir, the submodule
support for checkout that we plan to add in a later patch will fail.

Add functionality to migrate the git directory to be embedded
into the superprojects git directory.

The newly added code in this patch is structured such that
other areas of Git can also make use of it. The code in the
submodule--helper is a mere wrapper and option parser
for the function `submodule_embed_git_dir_for_path`, that
takes care of embedding the submodules git directory into
the superprojects git dir. That function makes use of the
more abstract function for this use case `relocate_gitdir`,
which can be used by e.g. the worktree code eventually to
move around a git directory.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-submodule.txt   |  14 +++++
 builtin/submodule--helper.c       |  39 ++++++++++++-
 dir.c                             |  27 +++++++++
 dir.h                             |   3 +
 git-submodule.sh                  |   7 ++-
 submodule.c                       | 115 ++++++++++++++++++++++++++++++++++++++
 submodule.h                       |   7 +++
 t/t7412-submodule-embedgitdirs.sh | 101 +++++++++++++++++++++++++++++++++
 8 files changed, 311 insertions(+), 2 deletions(-)
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
index 806e29ce4e..321c9e250a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1076,6 +1076,42 @@ static int resolve_remote_submodule_branch(int argc, const char **argv,
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
+	for (i = 0; i < list.nr; i++)
+		submodule_embed_git_dir(prefix, list.entries[i]->name, flags);
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -1093,7 +1129,8 @@ static struct cmd_struct commands[] = {
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"init", module_init, 0},
-	{"remote-branch", resolve_remote_submodule_branch, 0}
+	{"remote-branch", resolve_remote_submodule_branch, 0},
+	{"embed-git-dirs", embed_git_dir, SUPPORT_SUPER_PREFIX}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/dir.c b/dir.c
index bfa8c8a9a5..e023b04407 100644
--- a/dir.c
+++ b/dir.c
@@ -2748,3 +2748,30 @@ void untracked_cache_add_to_index(struct index_state *istate,
 {
 	untracked_cache_invalidate_path(istate, path);
 }
+
+/*
+ * Migrate the git directory of the given `path` from `old_git_dir` to
+ * `new_git_dir`. If an error occurs, append it to `err` and return the
+ * error code.
+ */
+int relocate_gitdir(const char *path, const char *old_git_dir,
+		    const char *new_git_dir, const char *displaypath,
+		    struct strbuf *err)
+{
+	int ret = 0;
+
+	printf("Migrating git directory of '%s' from\n'%s' to\n'%s'\n",
+		displaypath, old_git_dir, new_git_dir);
+
+	if (rename(old_git_dir, new_git_dir) < 0) {
+		ret = errno;
+		strbuf_addf(err,
+			_("could not migrate git directory from '%s' to '%s'"),
+			old_git_dir, new_git_dir);
+		return ret;
+	}
+
+	connect_work_tree_and_git_dir(path, new_git_dir);
+
+	return ret;
+}
diff --git a/dir.h b/dir.h
index 97c83bb383..bf06729a86 100644
--- a/dir.h
+++ b/dir.h
@@ -335,4 +335,7 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
+extern int relocate_gitdir(const char *path, const char *old_git_dir,
+			   const char *new_git_dir, const char *displaypath,
+			   struct strbuf *err);
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
diff --git a/submodule.c b/submodule.c
index 66c5ce5a24..67a91275b8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -14,6 +14,7 @@
 #include "blob.h"
 #include "thread-utils.h"
 #include "quote.h"
+#include "worktree.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static int parallel_jobs = 1;
@@ -1263,3 +1264,117 @@ void prepare_submodule_repo_env(struct argv_array *out)
 	}
 	argv_array_push(out, "GIT_DIR=.git");
 }
+
+/* Embeds a single submodule, non recursively. */
+static void submodule_embed_git_dir_for_path(const char *prefix, const char *path)
+{
+	struct worktree **worktrees;
+	struct strbuf pathbuf = STRBUF_INIT;
+	struct strbuf errbuf = STRBUF_INIT;
+	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
+	const char *new_git_dir;
+	const struct submodule *sub;
+	int code;
+
+	worktrees = get_submodule_worktrees(path, 0);
+	if (worktrees) {
+		int i;
+		for (i = 0; worktrees[i]; i++)
+			;
+		free_worktrees(worktrees);
+		if (i > 1)
+			die(_("relocate_gitdir for submodule '%s' with "
+			    "more than one worktree not supported"), path);
+	}
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
+	strbuf_addf(&pathbuf, "%s%s", prefix ? prefix : "", path);
+
+	code = relocate_gitdir(path, real_old_git_dir, real_new_git_dir,
+			       pathbuf.buf, &errbuf);
+	if (code) {
+		errno = code;
+		die_errno("%s\n", errbuf.buf);
+	}
+
+	free(old_git_dir);
+	free(real_old_git_dir);
+	free(real_new_git_dir);
+	strbuf_release(&pathbuf);
+}
+
+/*
+ * Migrate the git directory of the submodule given by path from
+ * having its git directory within the working tree to the git dir nested
+ * in its superprojects git dir under modules/.
+ */
+int submodule_embed_git_dir(const char *prefix,
+			    const char *path,
+			    unsigned flags)
+{
+	const char *sub_git_dir, *v;
+	char *real_sub_git_dir = NULL, *real_common_git_dir = NULL;
+	struct strbuf gitdir = STRBUF_INIT;
+
+
+	strbuf_addf(&gitdir, "%s/.git", path);
+	sub_git_dir = resolve_gitdir(gitdir.buf);
+
+	/* Not populated? */
+	if (!sub_git_dir)
+		goto out;
+
+	/* Is it already embedded? */
+	real_sub_git_dir = xstrdup(real_path(sub_git_dir));
+	real_common_git_dir = xstrdup(real_path(get_git_common_dir()));
+	if (!skip_prefix(real_sub_git_dir, real_common_git_dir, &v))
+		submodule_embed_git_dir_for_path(prefix, path);
+
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
+			die(_("could not recurse into submodule '%s'"), path);
+
+		strbuf_release(&sb);
+	}
+
+out:
+	strbuf_release(&gitdir);
+	free(real_sub_git_dir);
+	free(real_common_git_dir);
+	return 0;
+}
diff --git a/submodule.h b/submodule.h
index d9e197a948..922cfd258f 100644
--- a/submodule.h
+++ b/submodule.h
@@ -75,4 +75,11 @@ int parallel_submodules(void);
  */
 void prepare_submodule_repo_env(struct argv_array *out);
 
+/*
+ * Embed a git dir of the submodule given by path.
+ */
+#define RELOCATE_GITDIR_RECURSE_SUBMODULES (1<<0)
+extern int submodule_embed_git_dir(const char *prefix,
+				   const char *path,
+				   unsigned flags);
 #endif
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
2.11.0.rc2.28.g2af45f1.dirty


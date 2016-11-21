Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B56A1FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 20:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754870AbcKUUnF (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 15:43:05 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35414 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754174AbcKUUm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 15:42:57 -0500
Received: by mail-pf0-f172.google.com with SMTP id i88so65676605pfk.2
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 12:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tSAzxhpt5c7qoQ/hZqFxFsWUoBm1D7TMQ7PBKtZrg18=;
        b=FL+WZWr0qjCzw2q2Cwrn/E1ScGi19VPp53KOb207QHf6/g+zlzosR03t/SqI9yP8m3
         tQrqSqqve4SqAOul0Ghe/SH3vrEun7+SJwfQjWaubMzUyrdew+jl3HtkSzFxdhVd0lyo
         /9zsdgdZDCH55G7VDpFb+UFl2IHUBaN1SlpYbg0yBNXJCQsHM5BoSFZTvZAskAqKk/Ln
         UDZxE1kUJ07FNPHlM1btlWP5IdWJ9MRFFx5WzpY/nU0mLADnhoKWtr3vHjkwdZwRnSYt
         N8cc0lwfihK+3HvbC1WkHEIu4hzgzE5nWzf3AEgVqggCvpcLHhhJCW2Ei5N/j5XicEZe
         1/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tSAzxhpt5c7qoQ/hZqFxFsWUoBm1D7TMQ7PBKtZrg18=;
        b=CIC+XAc9Xf+uo8g0VWBeC11hyNAn8Tpw/q9h0jTAZOAYsHaxp+Of4IcW9fAmjYMVbi
         XCtknbrE83F94HbMFdTVLKfbTVbU3dIG+nUQdLuecEifixLHR6CA+F5BWy++OGTsM+Ax
         TBEv1RG9hSrv58XQu/R6v2NkPKDSluJp7HJJiFTs2PijGHDy6GfhPUx6PZowkKT0wLm1
         192CBDTP2bhzyeHSgMMrmTr/PSX0F/xe7O2Z0gdoL4wiEfEXlB8Dh9pllHBqiokbE+Qm
         mfSFeqKNb6L342Scyvn2wHkfLfFHXJdztPDLZnGn0suwxXAVLY42/oA360RKIwNPoCjl
         lgnw==
X-Gm-Message-State: AKaTC01tidGmShMYndoTCKJfngWAjXIudbTvj90AirgN8t82dDICPo/acrOTWEoAOiPKUJWK
X-Received: by 10.99.218.21 with SMTP id c21mr35739704pgh.67.1479760921043;
        Mon, 21 Nov 2016 12:42:01 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1d4e:2913:1c16:dc05])
        by smtp.gmail.com with ESMTPSA id x4sm21550910pgc.14.2016.11.21.12.42.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 12:42:00 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de,
        hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] submodule--helper: add intern-git-dir function
Date:   Mon, 21 Nov 2016 12:41:46 -0800
Message-Id: <20161121204146.13665-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.18.g0126045.dirty
In-Reply-To: <20161121204146.13665-1-sbeller@google.com>
References: <20161121204146.13665-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodule has its git dir inside the working dir, the submodule
support for checkout that we plan to add in a later patch will fail.

Add functionality to migrate the git directory to be embedded
into the superprojects git directory.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt    | 15 ++++++++++++-
 builtin/submodule--helper.c        | 33 ++++++++++++++++++++++++++++-
 git-submodule.sh                   |  7 ++++++-
 submodule.c                        | 43 ++++++++++++++++++++++++++++++++++++++
 submodule.h                        |  1 +
 t/t7412-submodule-interngitdirs.sh | 41 ++++++++++++++++++++++++++++++++++++
 6 files changed, 137 insertions(+), 3 deletions(-)
 create mode 100755 t/t7412-submodule-interngitdirs.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index d841573475..80d55350eb 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -22,7 +22,7 @@ SYNOPSIS
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
 'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
-
+'git submodule' [--quiet] interngitdirs [--] [<path>...]
 
 DESCRIPTION
 -----------
@@ -245,6 +245,19 @@ sync::
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and sync any nested submodules within.
 
+interngitdirs::
+	Move the git directory of submodules into its superprojects
+	`$GIT_DIR/modules` path and then connect the git directory and
+	its working directory by setting the `core.worktree` and adding
+	a .git file pointing to the git directory interned into the
+	superproject.
++
+	A repository that was cloned independently and later added
+	as a submodule or old setups have the submodules git directory
+	inside the submodule instead of the
++
+	This command is recursive by default.
+
 OPTIONS
 -------
 -q::
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4beeda5f9f..256f8e9439 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1076,6 +1076,36 @@ static int resolve_remote_submodule_branch(int argc, const char **argv,
 	return 0;
 }
 
+static int intern_git_dir(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+
+	struct option intern_gitdir_options[] = {
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper intern-git-dir [<path>...]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, intern_gitdir_options,
+			     git_submodule_helper_usage, 0);
+
+	gitmodules_config();
+	git_config(submodule_config, NULL);
+
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+		return 1;
+
+	for (i = 0; i < list.nr; i++)
+		migrate_submodule_gitdir(list.entries[i]->name);
+
+	return 0;
+}
+
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
@@ -1090,7 +1120,8 @@ static struct cmd_struct commands[] = {
 	{"resolve-relative-url", resolve_relative_url},
 	{"resolve-relative-url-test", resolve_relative_url_test},
 	{"init", module_init},
-	{"remote-branch", resolve_remote_submodule_branch}
+	{"remote-branch", resolve_remote_submodule_branch},
+	{"intern-git-dir", intern_git_dir}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index a024a135d6..747e934df2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1131,6 +1131,11 @@ cmd_sync()
 	done
 }
 
+cmd_interngitdirs()
+{
+	git submodule--helper intern-git-dir "$@"
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
+	add | foreach | init | deinit | update | status | summary | sync | interngitdirs)
 		command=$1
 		;;
 	-q|--quiet)
diff --git a/submodule.c b/submodule.c
index 66c5ce5a24..99befdba85 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1263,3 +1263,46 @@ void prepare_submodule_repo_env(struct argv_array *out)
 	}
 	argv_array_push(out, "GIT_DIR=.git");
 }
+
+/*
+ * Migrate the given submodule (and all its submodules recursively) from
+ * having its git directory within the working tree to the git dir nested
+ * in its superprojects git dir under modules/.
+ */
+void migrate_submodule_gitdir(const char *path)
+{
+	char *old_git_dir;
+	const char *new_git_dir;
+	const struct submodule *sub;
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.dir = path;
+	argv_array_pushl(&cp.args, "submodule", "foreach", "--recursive",
+			"git", "submodule--helper" "intern-git-dir", NULL);
+
+	if (run_command(&cp))
+		die(_("Could not migrate git directory in submodule '%s'"),
+		    path);
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
+	new_git_dir = git_common_path("modules/%s", sub->name);
+	mkdir_in_gitdir(".git/modules");
+
+	if (rename(old_git_dir, new_git_dir) < 0)
+		die_errno(_("Could not migrate git directory from '%s' to '%s'"),
+			old_git_dir, new_git_dir);
+
+	connect_work_tree_and_git_dir(path, new_git_dir);
+out:
+	free(old_git_dir);
+}
diff --git a/submodule.h b/submodule.h
index d9e197a948..859026ecfa 100644
--- a/submodule.h
+++ b/submodule.h
@@ -75,4 +75,5 @@ int parallel_submodules(void);
  */
 void prepare_submodule_repo_env(struct argv_array *out);
 
+extern void migrate_submodule_gitdir(const char *path);
 #endif
diff --git a/t/t7412-submodule-interngitdirs.sh b/t/t7412-submodule-interngitdirs.sh
new file mode 100755
index 0000000000..8938a4c8b7
--- /dev/null
+++ b/t/t7412-submodule-interngitdirs.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='Test submodule interngitdirs
+
+This test verifies that `git submodue interngitdirs` moves a submodules git
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
+test_expect_success 'intern the git dir' '
+	git submodule interngitdirs &&
+	test -f sub1/.git &&
+	test -d .git/modules/sub1 &&
+	# check that we did not break the repository:
+	git status
+'
+
+test_expect_success 'setup a gitlink with missing .gitmodules entry' '
+	git init sub2 &&
+	test_commit -C sub2 first &&
+	git add sub2 &&
+	git commit -m superproject
+'
+
+test_expect_success 'intern the git dir fails for incomplete submodules' '
+	test_must_fail git submodule interngitdirs &&
+	# check that we did not break the repository:
+	git status
+'
+
+test_done
+
-- 
2.11.0.rc2.18.g0126045.dirty


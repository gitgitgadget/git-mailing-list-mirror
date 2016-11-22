Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C55F1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 19:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933430AbcKVTXR (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 14:23:17 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34133 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933321AbcKVTXB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 14:23:01 -0500
Received: by mail-pg0-f48.google.com with SMTP id x23so10521110pgx.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 11:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QXOaezu5u/hkjNIhvCGS89iNmW9r1YmRnod2j0gOR/4=;
        b=Gdqu6cTRo8bZiPXAIenWxVd2YphBMZyig3Y9qcWuRuy84D+u3KDTcaFWM4sNbokeEm
         4eZwjEYfD225SuFPkP539t5OxuUBEoxmivA0AdC8Z4GBzfeRSfQ3Uu7ktHrKhMeT2Z9g
         Knp+4XDJzT2SKAQ26IrEXjxTv4v1xlxiJZgzWruPQr+EyDgq3Eo4pV8O9CE6Vl+9IQa2
         9radThC2o+u6vfff2yT0uox346oSesOsPAVJVe6Z4aYW7nS/wXGNYx8h2hQJ9rixeF5v
         SmI5VNeeDYKzVLtzEivdfkED1ZE2x8vk204RK36UHqo6H1zhIdKw9GGgQyeg1DD/0cy4
         HORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QXOaezu5u/hkjNIhvCGS89iNmW9r1YmRnod2j0gOR/4=;
        b=jUrY6YM+c9RGqsG7a7X8sR41p6AcLltENkyY/bviKUXx6lbL+cd/2SWjKk5FCvZDih
         PEBYBtZtlZeX7Vie/cq49en8oJX3hMj1Pll2+q/d1g7zeYxx/QsSiy1kSd70J4jAQ2hu
         hfO2sEGuz/Ku8R15hK2TkBypjatoqthh7iEYncvMMU5upmZQnMXcYIQzengD1XeN7nSx
         cCM6Xb3mksfxa0snHDQb/I2SFCNs6qMD541tD/rp/ypDE4XQlvaJAY2jyvwM9kTigCpk
         nnWvrH88XhUhYOflS9aeZyRbufJ0gwbtNjPbGN/eppHKn1s2vNjp07ceUil/7E2VAf1G
         gDyA==
X-Gm-Message-State: AKaTC00GllxSskOoCiMR5sphmghfZBvwyj10WGU8yQdMf2ed9yYGmMQzdwus8N29YfrB5IjO
X-Received: by 10.98.61.152 with SMTP id x24mr26833068pfj.88.1479842568585;
        Tue, 22 Nov 2016 11:22:48 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:3d4e:3f15:a371:dcb8])
        by smtp.gmail.com with ESMTPSA id k67sm46975740pfk.69.2016.11.22.11.22.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 11:22:48 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
        hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 4/4] submodule: add embed-git-dir function
Date:   Tue, 22 Nov 2016 11:22:35 -0800
Message-Id: <20161122192235.6055-5-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.4.g3396b6f.dirty
In-Reply-To: <20161122192235.6055-1-sbeller@google.com>
References: <20161122192235.6055-1-sbeller@google.com>
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
 Documentation/git-submodule.txt   | 14 +++++++
 builtin/submodule--helper.c       | 33 ++++++++++++++++-
 git-submodule.sh                  |  7 +++-
 submodule.c                       | 65 ++++++++++++++++++++++++++++++++
 submodule.h                       |  2 +
 t/t7412-submodule-embedgitdirs.sh | 78 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 197 insertions(+), 2 deletions(-)
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
index 806e29ce4e..e94dd68a0e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1076,6 +1076,36 @@ static int resolve_remote_submodule_branch(int argc, const char **argv,
 	return 0;
 }
 
+static int embed_git_dir(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+
+	struct option embed_gitdir_options[] = {
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
+		migrate_submodule_gitdir(prefix, list.entries[i]->name, 1);
+
+	return 0;
+}
+
 #define SUPPORT_SUPER_PREFIX (1<<0)
 
 struct cmd_struct {
@@ -1093,7 +1123,8 @@ static struct cmd_struct commands[] = {
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"init", module_init, 0},
-	{"remote-branch", resolve_remote_submodule_branch, 0}
+	{"remote-branch", resolve_remote_submodule_branch, 0},
+	{"embed-git-dirs", embed_git_dir, SUPPORT_SUPER_PREFIX}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index a024a135d6..2178248287 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1131,6 +1131,11 @@ cmd_sync()
 	done
 }
 
+cmd_embedgitdirs()
+{
+	git submodule--helper --prefix "$wt_prefix" embed-git-dirs "$@"
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
index 66c5ce5a24..d330b567a3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1263,3 +1263,68 @@ void prepare_submodule_repo_env(struct argv_array *out)
 	}
 	argv_array_push(out, "GIT_DIR=.git");
 }
+
+/*
+ * Migrate the given submodule (and all its submodules recursively) from
+ * having its git directory within the working tree to the git dir nested
+ * in its superprojects git dir under modules/.
+ */
+void migrate_submodule_gitdir(const char *prefix, const char *path,
+			      int recursive)
+{
+	char *old_git_dir;
+	const char *new_git_dir;
+	const struct submodule *sub;
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
+	new_git_dir = git_common_path("modules/%s", sub->name);
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
+	if (recursive) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		struct strbuf sb = STRBUF_INIT;
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
diff --git a/submodule.h b/submodule.h
index d9e197a948..e5975d1f3d 100644
--- a/submodule.h
+++ b/submodule.h
@@ -75,4 +75,6 @@ int parallel_submodules(void);
  */
 void prepare_submodule_repo_env(struct argv_array *out);
 
+extern void migrate_submodule_gitdir(const char *prefix,
+				     const char *path, int recursive);
 #endif
diff --git a/t/t7412-submodule-embedgitdirs.sh b/t/t7412-submodule-embedgitdirs.sh
new file mode 100755
index 0000000000..3153dbc069
--- /dev/null
+++ b/t/t7412-submodule-embedgitdirs.sh
@@ -0,0 +1,78 @@
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
+test_done
+
-- 
2.11.0.rc2.4.g3396b6f.dirty


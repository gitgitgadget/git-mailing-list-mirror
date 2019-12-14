Return-Path: <SRS0=+pXB=2E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CF8C43603
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 16:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D5D24656
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 16:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfLNQPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Dec 2019 11:15:19 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50047 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfLNQPS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Dec 2019 11:15:18 -0500
X-Originating-IP: 157.36.95.247
Received: from localhost.localdomain (unknown [157.36.95.247])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id BE2E4E0003
        for <git@vger.kernel.org>; Sat, 14 Dec 2019 16:15:12 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Subject: [PATCH 1/1] worktree: delete branches auto-created by 'worktree add'
Date:   Sat, 14 Dec 2019 21:44:38 +0530
Message-Id: <20191214161438.16157-2-me@yadavpratyush.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191214161438.16157-1-me@yadavpratyush.com>
References: <20191214161438.16157-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When no branch name is supplied to 'worktree add', it creates a new
branch based on the name of the directory the new worktree is located
in. But when the worktree is later removed, that created branch is left
over.

Remove that branch when removing the worktree. To make sure no commits
are lost, the branch won't be deleted if it has moved.

An example use case of when something like this is useful is when the
user wants to check out a separate worktree to run and test on an older
version, but don't want to touch the current worktree. So, they create a
worktree, run some tests, and then remove it. But this leaves behind a
branch the user never created in the first place.

So, remove the branch if nothing was done on it.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 Documentation/git-worktree.txt |  9 ++++--
 builtin/worktree.c             | 52 ++++++++++++++++++++++++++++++++--
 t/t2403-worktree-move.sh       | 45 +++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 85d92c9761..87b84be608 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -73,8 +73,9 @@ If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
 then, as a convenience, the new worktree is associated with a branch
 (call it `<branch>`) named after `$(basename <path>)`.  If `<branch>`
 doesn't exist, a new branch based on HEAD is automatically created as
-if `-b <branch>` was given.  If `<branch>` does exist, it will be
-checked out in the new worktree, if it's not checked out anywhere
+if `-b <branch>` was given.  In this case, if `<branch>` is not moved, it is
+automatically deleted when the worktree is removed.  If `<branch>` does exist,
+it will be checked out in the new worktree, if it's not checked out anywhere
 else, otherwise the command will refuse to create the worktree (unless
 `--force` is used).
 
@@ -108,6 +109,10 @@ Remove a working tree. Only clean working trees (no untracked files
 and no modification in tracked files) can be removed. Unclean working
 trees or ones with submodules can be removed with `--force`. The main
 working tree cannot be removed.
++
+Removing a working tree might lead to its associated branch being deleted if
+it was auto-created and has not moved since. See `add` for more information on
+when exactly this can happen.
 
 unlock::
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index d6bc5263f1..c62811259a 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -35,6 +35,7 @@ struct add_opts {
 static int show_only;
 static int verbose;
 static int guess_remote;
+static int auto_create;
 static timestamp_t expire;
 
 static int git_worktree_config(const char *var, const char *value, void *cb)
@@ -270,11 +271,13 @@ static int add_worktree(const char *path, const char *refname,
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct argv_array child_env = ARGV_ARRAY_INIT;
 	unsigned int counter = 0;
-	int len, ret;
+	int len, ret, fd;
 	struct strbuf symref = STRBUF_INIT;
 	struct commit *commit = NULL;
 	int is_branch = 0;
 	struct strbuf sb_name = STRBUF_INIT;
+	struct object_id oid;
+	char *hex;
 
 	validate_worktree_add(path, opts);
 
@@ -353,6 +356,18 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/auto_created", sb_repo.buf);
+	/* Mark this branch as an "auto-created" one. */
+	if (auto_create) {
+		fd = xopen(sb.buf, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+		get_oid("HEAD", &oid);
+		hex = oid_to_hex(&oid);
+		write_file_buf(sb.buf, hex, strlen(hex));
+
+		if (close(fd))
+			die(_("could not close '%s'"), sb.buf);
+	}
 
 	argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
@@ -576,6 +591,8 @@ static int add(int ac, const char **av, const char *prefix)
 		if (run_command(&cp))
 			return -1;
 		branch = new_branch;
+
+		auto_create = 1;
 	} else if (opt_track) {
 		die(_("--[no-]track can only be used if a new branch is created"));
 	}
@@ -912,9 +929,10 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 		OPT_END()
 	};
 	struct worktree **worktrees, *wt;
-	struct strbuf errmsg = STRBUF_INIT;
+	struct strbuf errmsg = STRBUF_INIT, sb = STRBUF_INIT, hex = STRBUF_INIT;
 	const char *reason = NULL;
-	int ret = 0;
+	int ret = 0, delete_auto_created = 0;
+	struct object_id oid;
 
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
 	if (ac != 1)
@@ -939,6 +957,23 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 		    errmsg.buf);
 	strbuf_release(&errmsg);
 
+	/*
+	 * Check if we auto-created a branch for this worktree and it hasn't
+	 * moved since. Do it before the contents of the worktree get wiped.
+	 * Delete the branch later because it is checked out right now.
+	 */
+	git_path_buf(&sb, "worktrees/%s/auto_created", wt->id);
+	if (file_exists(sb.buf)) {
+		strbuf_read_file(&hex, sb.buf, 0);
+		get_oid(wt->id, &oid);
+
+		if (strcmp(hex.buf, oid_to_hex(&oid)) == 0)
+			delete_auto_created = 1;
+	}
+
+	strbuf_release(&sb);
+	strbuf_release(&hex);
+
 	if (file_exists(wt->path)) {
 		if (!force)
 			check_clean_worktree(wt, av[0]);
@@ -952,6 +987,17 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 	ret |= delete_git_dir(wt->id);
 	delete_worktrees_dir_if_empty();
 
+	if (delete_auto_created) {
+		struct child_process cp = CHILD_PROCESS_INIT;
+		cp.git_cmd = 1;
+
+		argv_array_push(&cp.args, "branch");
+		argv_array_push(&cp.args, "-d");
+		argv_array_push(&cp.args, wt->id);
+
+		ret |= run_command(&cp);
+	}
+
 	free_worktrees(worktrees);
 	return ret;
 }
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index 939d18d728..c71c0bc1c7 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -222,4 +222,49 @@ test_expect_success 'not remove a repo with initialized submodule' '
 	)
 '
 
+test_expect_success 'remove auto-created branch' '
+	(
+		git worktree add to-remove &&
+		git worktree remove to-remove &&
+		git branch -l to-remove >branch_list &&
+		test_line_count = 0 branch_list
+	)
+'
+
+test_expect_success 'do not remove a branch that was not auto-created' '
+	(
+		git worktree add -b new_branch to-remove &&
+		git worktree remove to-remove &&
+		git branch -l new_branch >branch_list &&
+		test_line_count = 1 branch_list &&
+		git branch -d new_branch &&
+		git branch foo &&
+		git worktree add to-remove foo &&
+		git worktree remove to-remove &&
+		git branch -l foo >branch_list &&
+		test_line_count = 1 branch_list &&
+		git branch -d foo &&
+		git branch to-remove &&
+		git worktree add to-remove &&
+		git worktree remove to-remove &&
+		git branch -l to-remove >branch_list &&
+		test_line_count = 1 branch_list &&
+		git branch -d to-remove
+	)
+'
+
+test_expect_success 'do not remove auto-created branch that was moved' '
+	(
+		git worktree add to-remove &&
+		cd to-remove &&
+		test_commit foo &&
+		cd ../ &&
+		git worktree remove to-remove &&
+		git branch -l to-remove >branch_list &&
+		test_line_count = 1 branch_list &&
+		git branch -D to-remove
+	)
+'
+
+
 test_done
-- 
2.24.1


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C906F1FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 14:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415AbcGSOxX (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 10:53:23 -0400
Received: from vpn.foo.tf ([195.154.43.236]:41032 "EHLO mail.foo.tf"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752868AbcGSOxV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 10:53:21 -0400
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jul 2016 10:53:20 EDT
Received: from localhost (unknown [192.168.97.19])
	by mail.foo.tf (Postfix) with ESMTPSA id CE8D73817A0;
	Tue, 19 Jul 2016 14:48:01 +0000 (UTC)
From:	Antoine Tenart <antoine.tenart@ack.tf>
To:	git@vger.kernel.org
Cc:	Antoine Tenart <antoine.tenart@ack.tf>, gitster@pobox.com,
	pclouds@gmail.com, sunshine@sunshineco.com
Subject: [PATCH] worktree: add: introduce the --name option
Date:	Tue, 19 Jul 2016 16:47:01 +0200
Message-Id: <20160719144701.571-1-antoine.tenart@ack.tf>
X-Mailer: git-send-email 2.9.2
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Adds a --name option allowing to specify the name of a worktree when
creating it. This allows to have multiple worktrees in directories
having the same name (e.g. project0/foo, project1/foo etc...). This
commit keeps the previous behaviour by making it the default value, i.e.
by using $(basename <path>) as the worktree name when the --name option
isn't used.

Two new test cases are added to ensure the --name option does not break
other functionalities and is working properly.

Finally, the documentation is updated to reflect this --name option
addition.

Signed-off-by: Antoine Tenart <antoine.tenart@ack.tf>
---
 Documentation/git-worktree.txt |  6 +++++-
 builtin/worktree.c             | 14 +++++++++++---
 t/t2025-worktree-add.sh        | 14 ++++++++++++++
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 7c4cfb0885f4..d05a7a77a89f 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,7 +9,7 @@ git-worktree - Manage multiple working trees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' [-f] [--detach] [--checkout] [-b <new-branch>] <path> [<branch>]
+'git worktree add' [-f] [--detach] [--checkout] [-b <new-branch>] [--name <name>] <path> [<branch>]
 'git worktree list' [--porcelain]
 'git worktree prune' [-n] [-v] [--expire <expire>]
 
@@ -84,6 +84,10 @@ OPTIONS
 	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
 	`<branch>`.
 
+--name <name>::
+	With `add`, create a new worktree named `<name>`. Defaults to
+	`$(basename <path>)`.
+
 --detach::
 	With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
diff --git a/builtin/worktree.c b/builtin/worktree.c
index e866844685d5..d435ea7e6d06 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -24,6 +24,7 @@ struct add_opts {
 	int checkout;
 	const char *new_branch;
 	int force_new_branch;
+	const char *name;
 };
 
 static int show_only;
@@ -212,9 +213,14 @@ static int add_worktree(const char *path, const char *refname,
 			die(_("invalid reference: %s"), refname);
 	}
 
-	name = worktree_basename(path, &len);
-	strbuf_addstr(&sb_repo,
-		      git_path("worktrees/%.*s", (int)(path + len - name), name));
+	if (!opts->name) {
+		name = worktree_basename(path, &len);
+		strbuf_addstr(&sb_repo,
+			      git_path("worktrees/%.*s", (int)(path + len - name), name));
+	} else {
+		strbuf_addstr(&sb_repo, git_path("worktrees/%s", opts->name));
+	}
+
 	len = sb_repo.len;
 	if (safe_create_leading_directories_const(sb_repo.buf))
 		die_errno(_("could not create leading directories of '%s'"),
@@ -324,6 +330,8 @@ static int add(int ac, const char **av, const char *prefix)
 			   N_("create a new branch")),
 		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
 			   N_("create or reset a branch")),
+		OPT_STRING(0, "name", &opts.name, N_("name"),
+			   N_("use a custom worktree name")),
 		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
 		OPT_END()
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 4bcc335a19f9..5a40f5921e4d 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -243,6 +243,20 @@ test_expect_success '"add" worktree with --checkout' '
 	test_cmp init.t swamp2/init.t
 '
 
+test_expect_success '"add" worktree with --name' '
+	git worktree add --name kikoo -b foo foo &&
+	test_cmp init.t foo/init.t &&
+	test -d .git/worktrees/kikoo &&
+	test -d foo
+'
+
+test_expect_success '"add" worktree without --name' '
+	git worktree add -b foobar foobar &&
+	test_cmp init.t foobar/init.t &&
+	test -d .git/worktrees/foobar &&
+	test -d foobar
+'
+
 test_expect_success 'put a worktree under rebase' '
 	git worktree add under-rebase &&
 	(
-- 
2.9.2


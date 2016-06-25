Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67FCD1FE4E
	for <e@80x24.org>; Sat, 25 Jun 2016 05:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbcFYFX2 (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 01:23:28 -0400
Received: from [104.236.5.163] ([104.236.5.163]:44141 "EHLO brennie.ca"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbcFYFX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 01:23:27 -0400
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Jun 2016 01:23:27 EDT
Received: from localhost.localdomain (142-165-34-81.sktn.hsdb.sasknet.sk.ca [142.165.34.81])
	by brennie.ca (Postfix) with ESMTPSA id AC767400A9;
	Fri, 24 Jun 2016 23:16:10 -0600 (CST)
From:	Barret Rennie <barret@brennie.ca>
To:	git@vger.kernel.org
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Rappazzo <rappazzo@gmail.com>,
	Barret Rennie <barret@brennie.ca>
Subject: [PATCH] builtin/worktree.c: add option for setting worktree name
Date:	Fri, 24 Jun 2016 23:15:48 -0600
Message-Id: <20160625051548.95564-1-barret@brennie.ca>
X-Mailer: git-send-email 2.9.0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Add the --name parameter to git worktree add that allows the user to set
the name of the created worktree directory. A worktree must not already
exist with the current name or creation will fail.

Signed-off-by: Barret Rennie <barret@brennie.ca>
---
 Documentation/git-worktree.txt |  6 +++++-
 builtin/worktree.c             | 24 ++++++++++++++++++------
 t/t2025-worktree-add.sh        | 16 ++++++++++++++++
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 23d8d2a..2af0ee4 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,7 +9,7 @@ git-worktree - Manage multiple working trees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' [-f] [--detach] [--checkout] [-b <new-branch>] <path> [<branch>]
+'git worktree add' [-f] [--detach] [--checkout] [-b <new-branch>] [--name <name>] <path> [<branch>]
 'git worktree prune' [-n] [-v] [--expire <expire>]
 'git worktree list' [--porcelain]
 
@@ -88,6 +88,10 @@ OPTIONS
 	With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
 
+--name::
+	Set the name for the worktree. If there is already a worktree with this
+	name, the command will fail.
+
 --[no-]checkout::
 	By default, `add` checks out `<branch>`, however, `--no-checkout` can
 	be used to suppress checkout in order to make customizations,
diff --git a/builtin/worktree.c b/builtin/worktree.c
index e3199a2..ed071b2 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -24,6 +24,7 @@ struct add_opts {
 	int checkout;
 	const char *new_branch;
 	int force_new_branch;
+	const char *name;
 };
 
 static int show_only;
@@ -212,19 +213,29 @@ static int add_worktree(const char *path, const char *refname,
 			die(_("invalid reference: %s"), refname);
 	}
 
-	name = worktree_basename(path, &len);
+	if (opts->name) {
+		name = opts->name;
+		len = strlen(name);
+	} else {
+		name = worktree_basename(path, &len);
+	}
+
 	strbuf_addstr(&sb_repo,
 		      git_path("worktrees/%.*s", (int)(path + len - name), name));
+
 	len = sb_repo.len;
 	if (safe_create_leading_directories_const(sb_repo.buf))
 		die_errno(_("could not create leading directories of '%s'"),
 			  sb_repo.buf);
-	while (!stat(sb_repo.buf, &st)) {
-		counter++;
-		strbuf_setlen(&sb_repo, len);
-		strbuf_addf(&sb_repo, "%d", counter);
+
+	if (!opts->name) {
+		while (!stat(sb_repo.buf, &st)) {
+			counter++;
+			strbuf_setlen(&sb_repo, len);
+			strbuf_addf(&sb_repo, "%d", counter);
+		}
+		name = strrchr(sb_repo.buf, '/') + 1;
 	}
-	name = strrchr(sb_repo.buf, '/') + 1;
 
 	junk_pid = getpid();
 	atexit(remove_junk);
@@ -326,6 +337,7 @@ static int add(int ac, const char **av, const char *prefix)
 			   N_("create or reset a branch")),
 		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
+		OPT_STRING(0, "name", &opts.name, N_("name"), N_("set name for working tree")),
 		OPT_END()
 	};
 
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 4bcc335..9abcf8e 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -63,6 +63,22 @@ test_expect_success '"add" worktree' '
 	)
 '
 
+test_expect_success '"add" worktree with name' '
+	git worktree add --detach --name custom-name another-worktree master &&
+	(
+		cd here &&
+		test_cmp ../init.t init.t
+	) &&
+	(
+		cd .git/worktrees &&
+		test -d custom-name
+	)
+'
+
+test_expect_success '"add" worktree with name that already exists' '
+	test_must_fail git worktree add --name custom-name --detach yet-another-worktree master
+'
+
 test_expect_success '"add" worktree from a subdir' '
 	(
 		mkdir sub &&
-- 
2.9.0


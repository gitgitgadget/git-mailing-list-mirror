Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15FC720954
	for <e@80x24.org>; Thu,  7 Dec 2017 21:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751137AbdLGVVY (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 16:21:24 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:37518 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbdLGVVV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 16:21:21 -0500
Received: by mail-it0-f65.google.com with SMTP id d137so363473itc.2
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 13:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=LHm9YmvpJ6/qvlWwqNU7as6L6JkAjgMYS5kwtfx1gX4=;
        b=qfNXsWaqtdgZQmkhfF+Ercjm+Fvd/d9jRz/gN//u69Lt4yYBdO02dE4IWID84Q7ZcP
         m5kdEdw5uOYioUanxYOoP4Sj68rqMaNqrvsQrcCB9tmk9ECtsUlkNc52O+VUqsyoEE+J
         Kak1oOfrOuaUgMvRhI6Ljm6ENy5h9X6NQK2UaiM2zfowVhShbwCU0NrnX1tR6H/hfxy1
         eqIdKGzupX1yje2clGFQ3Q7+MVNvr48ZK06ZtUteY67F5z+Xut7v4jkMFt6N/Jnl0Mn7
         41v8EHbO7bxatjmpTHRqbdmXhQI0+B49QCm9R3XKUCSjm14yOcEF2xe12S+jDDSaiROw
         e4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=LHm9YmvpJ6/qvlWwqNU7as6L6JkAjgMYS5kwtfx1gX4=;
        b=D+6MUMPoIzUnXzW/CijXHjukqFV9t90UsOokh8sDWdelOEkjsQUFZ6CcSAuaq7ajYB
         t0V2RNCvWWGo/NWEioqTDxFPDDcO9ViLEDMqNsBKzR7SWCikUleoiYAk+vGVvxQWughg
         Oo1eKDmRQAm1C6PJChFHyDXS60XRNfSfZ7PoXLn+LkWF9MYiS6x7km73+lbEjdNvt+IY
         dzU5YSouMbwwsGPG/Wtf3beNfG6CZy4GeDvNoG21AaK3fSRCnbhVk9nX33mQtRmCKFqO
         W6ibJHxQLdYm/z1vjr64M6YT8wRLikZcaRnRvNVwYgye35LSCvjbFFqp3O4nuZHpO9dj
         wqBw==
X-Gm-Message-State: AJaThX5R4H0OL1Fo8Gce4CTwFDJvSXrmU5xmLoaptId0JVAt7fko9IoR
        lZ8tTitCYblAJrSFt7RH1hNQ5g==
X-Google-Smtp-Source: AGs4zMbGZ0w5deB888AsF9ZZ1hCuBZZa2lzfMldW4OHheSUy2KBai5xJK8d2HIP96yC4iRJQkha0+w==
X-Received: by 10.107.4.206 with SMTP id 197mr39334691ioe.163.1512681680404;
        Thu, 07 Dec 2017 13:21:20 -0800 (PST)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id v79sm34812ita.37.2017.12.07.13.21.19
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 07 Dec 2017 13:21:19 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] worktree: invoke post-checkout hook (unless --no-checkout)
Date:   Thu,  7 Dec 2017 16:20:17 -0500
Message-Id: <20171207212017.53774-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.15.1.502.gccaef8de57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-clone and git-checkout both invoke the post-checkout hook following
a successful checkout, yet git-worktree neglects to do so even though it
too "checks out" the worktree. Fix this oversight.

Implementation note: The newly-created worktree may reference a branch
or be detached. In the latter case, a commit lookup is performed, though
the result is used only in a boolean sense to (a) determine if the
commit actually exists, and (b) assign either the branch name or commit
ID to HEAD. Since the post-commit hook needs to know the ID of the
checked-out commit, the lookup now needs to be done in all cases, rather
than only when detached. Consequently, a new boolean is needed to handle
(b) since the lookup result itself can no longer perform that role.

Reported-by: Matthew K Gumbel <matthew.k.gumbel@intel.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/githooks.txt |  3 ++-
 builtin/worktree.c         | 22 ++++++++++++++++------
 t/t2025-worktree-add.sh    | 29 +++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 0bb0042d8c..91eb297f7b 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -170,7 +170,8 @@ This hook cannot affect the outcome of 'git checkout'.
 
 It is also run after 'git clone', unless the --no-checkout (-n) option is
 used. The first parameter given to the hook is the null-ref, the second the
-ref of the new HEAD and the flag is always 1.
+ref of the new HEAD and the flag is always 1. Likewise for 'git worktree add'
+unless --no-checkout is used.
 
 This hook can be used to perform repository validity checks, auto-display
 differences from the previous HEAD if different, or set working dir metadata
diff --git a/builtin/worktree.c b/builtin/worktree.c
index ed043d5f1c..9591f10442 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -218,20 +218,21 @@ static int add_worktree(const char *path, const char *refname,
 	int counter = 0, len, ret;
 	struct strbuf symref = STRBUF_INIT;
 	struct commit *commit = NULL;
+	int is_branch = 0;
 
 	if (file_exists(path) && !is_empty_dir(path))
 		die(_("'%s' already exists"), path);
 
 	/* is 'refname' a branch or commit? */
 	if (!opts->detach && !strbuf_check_branch_ref(&symref, refname) &&
-		 ref_exists(symref.buf)) { /* it's a branch */
+	    ref_exists(symref.buf)) {
+		is_branch = 1;
 		if (!opts->force)
 			die_if_checked_out(symref.buf, 0);
-	} else { /* must be a commit */
-		commit = lookup_commit_reference_by_name(refname);
-		if (!commit)
-			die(_("invalid reference: %s"), refname);
 	}
+	commit = lookup_commit_reference_by_name(refname);
+	if (!commit)
+		die(_("invalid reference: %s"), refname);
 
 	name = worktree_basename(path, &len);
 	git_path_buf(&sb_repo, "worktrees/%.*s", (int)(path + len - name), name);
@@ -296,7 +297,7 @@ static int add_worktree(const char *path, const char *refname,
 	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
 	cp.git_cmd = 1;
 
-	if (commit)
+	if (!is_branch)
 		argv_array_pushl(&cp.args, "update-ref", "HEAD",
 				 oid_to_hex(&commit->object.oid), NULL);
 	else
@@ -327,6 +328,15 @@ static int add_worktree(const char *path, const char *refname,
 		strbuf_addf(&sb, "%s/locked", sb_repo.buf);
 		unlink_or_warn(sb.buf);
 	}
+
+	/*
+	 * Hook failure does not warrant worktree deletion, so run hook after
+	 * is_junk is cleared, but do return appropriate code when hook fails.
+	 */
+	if (!ret && opts->checkout)
+		ret = run_hook_le(NULL, "post-checkout", oid_to_hex(&null_oid),
+				  oid_to_hex(&commit->object.oid), "1", NULL);
+
 	argv_array_clear(&child_env);
 	strbuf_release(&sb);
 	strbuf_release(&symref);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index b5c47ac602..d6fb062f83 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -314,4 +314,33 @@ test_expect_success 'rename a branch under bisect not allowed' '
 	test_must_fail git branch -M under-bisect bisect-with-new-name
 '
 
+post_checkout_hook () {
+	test_when_finished "rm -f .git/hooks/post-checkout" &&
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/post-checkout <<-\EOF
+	echo $* >hook.actual
+	EOF
+}
+
+test_expect_success '"add" invokes post-checkout hook (branch)' '
+	post_checkout_hook &&
+	printf "%s %s 1\n" $_z40 $(git rev-parse HEAD) >hook.expect &&
+	git worktree add gumby &&
+	test_cmp hook.expect hook.actual
+'
+
+test_expect_success '"add" invokes post-checkout hook (detached)' '
+	post_checkout_hook &&
+	printf "%s %s 1\n" $_z40 $(git rev-parse HEAD) >hook.expect &&
+	git worktree add --detach grumpy &&
+	test_cmp hook.expect hook.actual
+'
+
+test_expect_success '"add --no-checkout" suppresses post-checkout hook' '
+	post_checkout_hook &&
+	rm -f hook.actual &&
+	git worktree add --no-checkout gloopy &&
+	test_path_is_missing hook.actual
+'
+
 test_done
-- 
2.15.1.502.gccaef8de57


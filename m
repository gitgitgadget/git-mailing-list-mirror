From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 13/14] pull --rebase: exit early when the working directory is dirty
Date: Mon, 18 May 2015 23:06:10 +0800
Message-ID: <1431961571-20370-14-git-send-email-pyokagan@gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 17:09:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMf7-00051Z-AN
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbbERPIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:08:53 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34776 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702AbbERPII (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:08:08 -0400
Received: by pdbnk13 with SMTP id nk13so57698676pdb.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 08:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vjVmZ23qR+IrABgoBTjrZJfx9kRVYMGy0zavK3YrT4w=;
        b=u0B22a4PVYPGcGTma6X62d1Sf1Vmx8pPXWUFJtfxSNKJuqi7ji00BXAUsBc/hVtFkP
         FqV2HiPnIQq7R48BXZ9d4FtBam4rRoTNxWL6BfIrCwj1oHOK2rbL2wrDbVFkESemrn9U
         vVe4f0bIH0121WPavodujLpuEhz/URlXG0UtOoS5Fo9SYTZgC9MEsvrjhqf0v1EC96YD
         10E9ngpFqprQP7GSe2xGIWu/BV2IDVN2u+XaTRAsjuT/R1XqZ1sqnKCQ/JSFGmNMmt33
         RQKK6fOxruISDm3wOQs0QeEQO8vb6/Ua7SJ63CDzUttSxSKvg/Zgf4xUmZj/4y8lF4fe
         r04A==
X-Received: by 10.70.93.36 with SMTP id cr4mr44226954pdb.68.1431961687732;
        Mon, 18 May 2015 08:08:07 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id i9sm10370062pdj.27.2015.05.18.08.08.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 08:08:06 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269272>

Re-implement the behavior introduced by f9189cf (pull --rebase: exit
early when the working directory is dirty, 2008-05-21).

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c  | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t5520-pull.sh |  6 ++---
 2 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index a0958a7..c8d673d 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -14,6 +14,8 @@
 #include "remote.h"
 #include "dir.h"
 #include "refs.h"
+#include "revision.h"
+#include "lockfile.h"
 
 /**
  * Given an option opt, where opt->value points to a char* and opt->defval is a
@@ -327,6 +329,73 @@ static int config_get_rebase(void)
 	return value;
 }
 
+/**
+ * Returns 1 if there are unstaged changes, 0 otherwise.
+ */
+static int has_unstaged_changes(const char *prefix)
+{
+	struct rev_info rev_info;
+	int result;
+
+	init_revisions(&rev_info, prefix);
+	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
+	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
+	diff_setup_done(&rev_info.diffopt);
+	result = run_diff_files(&rev_info, 0);
+	return diff_result_code(&rev_info.diffopt, result);
+}
+
+/**
+ * Returns 1 if there are uncommitted changes, 0 otherwise.
+ */
+static int has_uncommitted_changes(const char *prefix)
+{
+	struct rev_info rev_info;
+	int result;
+
+	if (is_cache_unborn())
+		return 0;
+
+	init_revisions(&rev_info, prefix);
+	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
+	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
+	add_head_to_pending(&rev_info);
+	diff_setup_done(&rev_info.diffopt);
+	result = run_diff_index(&rev_info, 1);
+	return diff_result_code(&rev_info.diffopt, result);
+}
+
+/**
+ * If the work tree has unstaged or uncommitted changes, dies with the
+ * appropriate message.
+ */
+static void die_on_unclean_work_tree(const char *prefix)
+{
+	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
+	int do_die = 0;
+
+	hold_locked_index(lock_file, 0);
+	refresh_cache(REFRESH_QUIET);
+	update_index_if_able(&the_index, lock_file);
+	rollback_lock_file(lock_file);
+
+	if (has_unstaged_changes(prefix)) {
+		error(_("Cannot pull with rebase: You have unstaged changes."));
+		do_die = 1;
+	}
+
+	if (has_uncommitted_changes(prefix)) {
+		if (do_die)
+			error(_("Additionally, your index contains uncommitted changes."));
+		else
+			error(_("Cannot pull with rebase: Your index contains uncommitted changes."));
+		do_die = 1;
+	}
+
+	if (do_die)
+		exit(1);
+}
+
 struct known_remote {
 	struct known_remote *next;
 	struct remote *remote;
@@ -782,9 +851,15 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (get_sha1("HEAD", orig_head))
 		hashclr(orig_head);
 
-	if (opt_rebase)
+	if (opt_rebase) {
+		if (is_null_sha1(orig_head) && !is_cache_unborn())
+			die(_("Updating an unborn branch with changes added to the index."));
+
+		die_on_unclean_work_tree(prefix);
+
 		if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
 			hashclr(rebase_fork_point);
+	}
 
 	if (run_fetch(repo, refspecs))
 		return 1;
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 17254ee..62dbfb5 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -390,7 +390,7 @@ test_expect_success 'rebased upstream + fetch + pull --rebase' '
 
 '
 
-test_expect_failure 'pull --rebase dies early with dirty working directory' '
+test_expect_success 'pull --rebase dies early with dirty working directory' '
 
 	git checkout to-rebase &&
 	git update-ref refs/remotes/me/copy copy^ &&
@@ -420,7 +420,7 @@ test_expect_success 'pull --rebase works on branch yet to be born' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'pull --rebase fails on unborn branch with staged changes' '
+test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
 	test_when_finished "rm -rf empty_repo2" &&
 	git init empty_repo2 &&
 	(
@@ -492,7 +492,7 @@ test_expect_success 'git pull --rebase does not reapply old patches' '
 	)
 '
 
-test_expect_failure 'git pull --rebase against local branch' '
+test_expect_success 'git pull --rebase against local branch' '
 	git checkout -b copy2 to-rebase-orig &&
 	git pull --rebase . to-rebase &&
 	test "conflicting modification" = "$(cat file)" &&
-- 
2.1.4

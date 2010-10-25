From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 22/23] cmd_merge(): Parse options before checking MERGE_HEAD
Date: Mon, 25 Oct 2010 02:08:52 +0200
Message-ID: <1287965333-5099-23-git-send-email-johan@herland.net>
References: <1287965333-5099-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 25 02:10:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAAdo-0000ju-2m
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 02:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab0JYAJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 20:09:33 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59867 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015Ab0JYAJb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 20:09:31 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT0052AKFOGG50@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:24 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 9613317990AE_CC4CAB4B	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:24 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 5DB56179696B_CC4CAB4F	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:23 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT004SRKFAVB20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:18 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1287965333-5099-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159911>

Reorder the initial part of builtin/merge.c:cmd_merge() so that command-line
options are parsed _before_ we load the index and check for MERGE_HEAD
(and exits if it exists). This does not change the behaviour of 'git merge',
but is needed in preparation for the implementation of 'git merge --abort'
(which requires MERGE_HEAD to be present).

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/merge.c        |   33 ++++++++--------
 t/t7609-merge-abort.sh |   97 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 16 deletions(-)
 create mode 100755 t/t7609-merge-abort.sh

diff --git a/builtin/merge.c b/builtin/merge.c
index 37ce4f5..702f399 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -895,22 +895,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	const char *best_strategy = NULL, *wt_strategy = NULL;
 	struct commit_list **remotes = &remoteheads;
 
-	if (read_cache_unmerged()) {
-		die_resolve_conflict("merge");
-	}
-	if (file_exists(git_path("MERGE_HEAD"))) {
-		/*
-		 * There is no unmerged entry, don't advise 'git
-		 * add/rm <file>', just 'git commit'.
-		 */
-		if (advice_resolve_conflict)
-			die("You have not concluded your merge (MERGE_HEAD exists).\n"
-			    "Please, commit your changes before you can merge.");
-		else
-			die("You have not concluded your merge (MERGE_HEAD exists).");
-	}
-
-	resolve_undo_clear();
 	/*
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
@@ -929,6 +913,23 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, builtin_merge_options,
 			builtin_merge_usage, 0);
+
+	if (read_cache_unmerged()) {
+		die_resolve_conflict("merge");
+	}
+	if (file_exists(git_path("MERGE_HEAD"))) {
+		/*
+		 * There is no unmerged entry, don't advise 'git
+		 * add/rm <file>', just 'git commit'.
+		 */
+		if (advice_resolve_conflict)
+			die("You have not concluded your merge (MERGE_HEAD exists).\n"
+			    "Please, commit your changes before you can merge.");
+		else
+			die("You have not concluded your merge (MERGE_HEAD exists).");
+	}
+	resolve_undo_clear();
+
 	if (verbosity < 0)
 		show_diffstat = 0;
 
diff --git a/t/t7609-merge-abort.sh b/t/t7609-merge-abort.sh
new file mode 100755
index 0000000..88d76e1
--- /dev/null
+++ b/t/t7609-merge-abort.sh
@@ -0,0 +1,97 @@
+#!/bin/sh
+
+test_description='test aborting in-progress merges'
+. ./test-lib.sh
+
+# Test git merge --abort with the following variables:
+# - before/after successful merge (i.e. should fail if not in merge context)
+# - with/without conflicts
+# - clean/dirty worktree before merge (may fail to reconstruct dirty worktree)
+# - clean/dirty index before merge (merge should fail on dirty index)
+# - changed/unchanged worktree after merge
+# - changed/unchanged index after merge
+
+test_done
+
+test_expect_success 'fails without MERGE_HEAD (unstarted merge)' '
+	test_must_fail git merge --abort 2>output &&
+	grep -q MERGE_HEAD output
+'
+
+test_expect_success 'fails without MERGE_HEAD (completed merge)' '
+	test_commit master-1 &&
+	test_commit master-2 &&
+	git checkout -b side HEAD^ &&
+	test_commit side-1 &&
+	git checkout master &&
+	git merge side &&
+	# Merge successfully completed
+	test_must_fail git merge --abort 2>output &&
+	grep -q MERGE_HEAD output
+'
+
+test_expect_success 'Abort successfully after --no-commit' '
+	# Forget previous merge
+	git reset --hard master^ &&
+	head=$(git rev-parse HEAD) &&
+	git merge --no-commit side &&
+	test -f .git/MERGE_HEAD &&
+	git merge --abort &&
+	test "$head" = "$(git rev-parse HEAD)" &&
+	test -z "$(git diff HEAD)" &&
+	test ! -f .git/MERGE_HEAD
+'
+
+
+
+test_done
+
+test_expect_success 'merge local branch' '
+	test_commit master-1 &&
+	git checkout -b local-branch &&
+	test_commit branch-1 &&
+	git checkout master &&
+	test_commit master-2 &&
+	git merge local-branch &&
+	check_oneline "Merge branch Qlocal-branchQ"
+'
+
+test_expect_success 'merge octopus branches' '
+	git checkout -b octopus-a master &&
+	test_commit octopus-1 &&
+	git checkout -b octopus-b master &&
+	test_commit octopus-2 &&
+	git checkout master &&
+	git merge octopus-a octopus-b &&
+	check_oneline "Merge branches Qoctopus-aQ and Qoctopus-bQ"
+'
+
+test_expect_success 'merge tag' '
+	git checkout -b tag-branch master &&
+	test_commit tag-1 &&
+	git checkout master &&
+	test_commit master-3 &&
+	git merge tag-1 &&
+	check_oneline "Merge commit Qtag-1Q"
+'
+
+test_expect_success 'ambiguous tag' '
+	git checkout -b ambiguous master &&
+	test_commit ambiguous &&
+	git checkout master &&
+	test_commit master-4 &&
+	git merge ambiguous &&
+	check_oneline "Merge commit QambiguousQ"
+'
+
+test_expect_success 'remote branch' '
+	git checkout -b remote master &&
+	test_commit remote-1 &&
+	git update-ref refs/remotes/origin/master remote &&
+	git checkout master &&
+	test_commit master-5 &&
+	git merge origin/master &&
+	check_oneline "Merge remote branch Qorigin/masterQ"
+'
+
+test_done
-- 
1.7.3.98.g5ad7d9

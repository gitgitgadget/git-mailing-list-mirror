From: Yuval Kogman <nothingmuch@woobling.org>
Subject: [PATCH] Add --ff-only flag to git-merge
Date: Fri, 30 Jan 2009 06:32:45 +0200
Message-ID: <1233289965-19538-2-git-send-email-nothingmuch@woobling.org>
References: <7vbptpeoge.fsf@gitster.siamese.dyndns.org>
 <1233289965-19538-1-git-send-email-nothingmuch@woobling.org>
Cc: Yuval Kogman <nothingmuch@woobling.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 05:34:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSl5O-0002mp-Af
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 05:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbZA3Ec4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 23:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbZA3Ecy
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 23:32:54 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:49244 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbZA3Ecw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 23:32:52 -0500
Received: by fk-out-0910.google.com with SMTP id f33so260203fkf.5
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 20:32:49 -0800 (PST)
Received: by 10.103.90.17 with SMTP id s17mr398608mul.73.1233289969394;
        Thu, 29 Jan 2009 20:32:49 -0800 (PST)
Received: from syeeda.local (bzq-84-109-225-67.red.bezeqint.net [84.109.225.67])
        by mx.google.com with ESMTPS id t10sm869549muh.31.2009.01.29.20.32.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Jan 2009 20:32:48 -0800 (PST)
Received: by syeeda.local (Postfix, from userid 501)
	id 12A21315094A; Fri, 30 Jan 2009 06:32:45 +0200 (IST)
X-Mailer: git-send-email 1.6.1
In-Reply-To: <1233289965-19538-1-git-send-email-nothingmuch@woobling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107768>

When specified git-merge will exit with an error unless the merge is
resolved as a fast-forward.

This is similar to the default behavior of git push.
---
 Documentation/merge-options.txt |    4 +++
 builtin-merge.c                 |   18 +++++++++++++++
 git-pull.sh                     |    4 ++-
 t/t7600-merge.sh                |   45 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 1 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 637b53f..ac742f8 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -59,6 +59,10 @@
 	a fast-forward, only update the branch pointer. This is
 	the default behavior of git-merge.
 
+--ff-only::
+	Refuse to merge unless the merge is resolved as a
+	fast-forward.
+
 -s <strategy>::
 --strategy=<strategy>::
 	Use the given merge strategy; can be supplied more than
diff --git a/builtin-merge.c b/builtin-merge.c
index e4555b0..dae53fe 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -44,6 +44,7 @@ static const char * const builtin_merge_usage[] = {
 static int show_diffstat = 1, option_log, squash;
 static int option_commit = 1, allow_fast_forward = 1;
 static int allow_trivial = 1, have_message;
+static int only_fast_forward;
 static struct strbuf merge_msg;
 static struct commit_list *remoteheads;
 static unsigned char head[20], stash[20];
@@ -167,6 +168,8 @@ static struct option builtin_merge_options[] = {
 		"perform a commit if the merge succeeds (default)"),
 	OPT_BOOLEAN(0, "ff", &allow_fast_forward,
 		"allow fast forward (default)"),
+	OPT_BOOLEAN(0, "ff-only", &only_fast_forward,
+		"allow only fast forward"),
 	OPT_CALLBACK('s', "strategy", &use_strategies, "strategy",
 		"merge strategy to use", option_parse_strategy),
 	OPT_CALLBACK('m', "message", &merge_msg, "message",
@@ -858,6 +861,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		option_commit = 0;
 	}
 
+	if (only_fast_forward && !allow_fast_forward)
+		die("You cannot combine --ff-only with --no-ff.");
+
 	if (!argc)
 		usage_with_options(builtin_merge_usage,
 			builtin_merge_options);
@@ -959,6 +965,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			allow_trivial = 0;
 	}
 
+	if (only_fast_forward && !allow_fast_forward)
+		die("You cannot combine --ff-only with the selected"
+		    " merge strategies.");
+
+
 	if (!remoteheads->next)
 		common = get_merge_bases(lookup_commit(head),
 				remoteheads->item, 1);
@@ -1023,6 +1034,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * We are not doing octopus, not fast forward, and have
 		 * only one common.
 		 */
+
+		if (only_fast_forward)
+			die("Merge is non fast forward, aborting.");
+
 		refresh_cache(REFRESH_QUIET);
 		if (allow_trivial) {
 			/* See if it is really trivial. */
@@ -1063,6 +1078,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (only_fast_forward)
+		die("Merge is non fast forward, aborting.");
+
 	/* We are going to make a new commit. */
 	git_committer_info(IDENT_ERROR_ON_NO_NAME);
 
diff --git a/git-pull.sh b/git-pull.sh
index 2c7f432..242d36f 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -45,6 +45,8 @@ do
 		no_ff=--ff ;;
 	--no-ff)
 		no_ff=--no-ff ;;
+	--ff-only)
+		ff-only=--ff-only ;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
@@ -185,5 +187,5 @@ merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 test true = "$rebase" &&
 	exec git-rebase $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
-exec git-merge $no_stat $no_commit $squash $no_ff $log_arg $strategy_args \
+exec git-merge $no_stat $no_commit $squash $no_ff $ff_only $log_arg $strategy_args \
 	"$merge_name" HEAD $merge_head $verbosity
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index e5b210b..6c2febc 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -234,6 +234,8 @@ test_expect_success 'reject non-strategy with a git-merge-foo name' '
 	test_must_fail git merge -s index c1
 '
 
+test_debug 'gitk --all'
+
 test_expect_success 'merge c0 with c1' '
 	git reset --hard c0 &&
 	git merge c1 &&
@@ -243,6 +245,15 @@ test_expect_success 'merge c0 with c1' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge c0 with c1 (fast forward only)' '
+	git reset --hard c0 &&
+	git merge --ff-only c1 &&
+	verify_merge file result.1 &&
+	verify_head "$c1"
+'
+
+test_debug 'gitk --all'
+
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
 	test_tick &&
@@ -253,6 +264,14 @@ test_expect_success 'merge c1 with c2' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge c1 with c2' '
+	git reset --hard c1 &&
+	test_tick &&
+	test_must_fail git merge --ff-only c2
+'
+
+test_debug 'gitk --all'
+
 test_expect_success 'merge c1 with c2 and c3' '
 	git reset --hard c1 &&
 	test_tick &&
@@ -263,6 +282,14 @@ test_expect_success 'merge c1 with c2 and c3' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge c1 with c2 and c3 (fast forward only' '
+	git reset --hard c1 &&
+	test_tick &&
+	test_must_fail git merge --ff-only c2 c3
+'
+
+test_debug 'gitk --all'
+
 test_expect_success 'merge c0 with c1 (no-commit)' '
 	git reset --hard c0 &&
 	git merge --no-commit c1 &&
@@ -470,6 +497,15 @@ test_expect_success 'merge c1 with c0, c2, c0, and c1' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge fast forward only' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       test_must_fail git merge --ff-only c0 c2 c0 c1
+'
+
+test_debug 'gitk --all'
+
 test_expect_success 'merge c1 with c0, c2, c0, and c1' '
        git reset --hard c1 &&
        git config branch.master.mergeoptions "" &&
@@ -481,6 +517,15 @@ test_expect_success 'merge c1 with c0, c2, c0, and c1' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge fast forward only' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       test_must_fail git merge --ff-only c1 c2
+'
+
+test_debug 'gitk --all'
+
 test_expect_success 'merge c1 with c1 and c2' '
        git reset --hard c1 &&
        git config branch.master.mergeoptions "" &&
-- 
1.6.1

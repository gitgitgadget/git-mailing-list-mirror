From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/6] Introduce fast forward option only
Date: Wed, 21 May 2008 18:16:49 -0700
Message-ID: <1211419009-9741-7-git-send-email-gitster@pobox.com>
References: <1211419009-9741-1-git-send-email-gitster@pobox.com>
 <1211419009-9741-2-git-send-email-gitster@pobox.com>
 <1211419009-9741-3-git-send-email-gitster@pobox.com>
 <1211419009-9741-4-git-send-email-gitster@pobox.com>
 <1211419009-9741-5-git-send-email-gitster@pobox.com>
 <1211419009-9741-6-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 03:18:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyzRt-0002NR-MJ
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 03:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762870AbYEVBRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 21:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762995AbYEVBRb
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 21:17:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762716AbYEVBR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 21:17:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C94D46866
	for <git@vger.kernel.org>; Wed, 21 May 2008 21:17:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4FBA46864 for <git@vger.kernel.org>; Wed, 21 May 2008 21:17:27 -0400
 (EDT)
X-Mailer: git-send-email 1.5.5.1.499.g878b8
In-Reply-To: <1211419009-9741-6-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D84A2790-279C-11DD-B7AA-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82595>

From: Sverre Hvammen Johansen <hvammen@gmail.com>

This commit introduces fast forward option 'only'.  With --ff=only
merge succeeds only if it resolves to fast-forward merge.

This feature is useful for cases where a rebase is desired
instead of a real merge.  This option can then be used to
avoid an accidental merge.

See the documentation for further details.

Signed-off-by: Sverre Hvammen Johansen <hvammen@gmail.com>
---
 Documentation/fast-forward-options.txt |    9 ++
 git-merge.sh                           |   12 +-
 git-pull.sh                            |    2 +-
 t/t7601-merge-ff-options.sh            |  214 ++++++++++++++++++++++++++++++++
 4 files changed, 231 insertions(+), 6 deletions(-)

diff --git a/Documentation/fast-forward-options.txt b/Documentation/fast-forward-options.txt
index 9374aa9..41580ea 100644
--- a/Documentation/fast-forward-options.txt
+++ b/Documentation/fast-forward-options.txt
@@ -12,6 +12,10 @@ never::
 	Generate a merge commit even if the merge resolves as a
 	fast-forward.  This option is equivalent of '--no-ff'.
 
+only::
+	Only allow a fast-forward.  The merge will fail unless HEAD is
+	up to date or the merge resolves as a fast-forward.
+
 If your workflow is always to branch from the special branch
 ("master") when working on a topic and merge that back to "master", if
 you happen to have worked only on a single topic and the "master" was
@@ -42,3 +46,8 @@ The first merge of topicA or the only merge of topicB would have
 resulted in a fast forward without '--ff=never'.  Topic A consist of
 those commits that can be reached from master^2 without passing
 through any of the first-parent ancestries of master.
+
+However, if the workflow require that the branch you are merging with
+is based on the current HEAD you can use "only fast forward" policy to
+enforce fast forward or a failure.  The last merge of topicA in
+the example above would have failed with '--ff=only'.
diff --git a/git-merge.sh b/git-merge.sh
index 775dae7..b87e125 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -168,21 +168,21 @@ parse_config () {
 			no_commit=t ;;
 		--ff)
 			case "$2" in
-			allow|never)
+			allow|never|only)
 				fast_forward=$2; shift ;;
 			-*)
 				fast_forward=allow ;;
 			*)
-				die "Available fast-forward options are: allow and newer" ;;
+				die "Available fast-forward options are: allow, newer, and only" ;;
 			esac
 			;;
 		--ff=*)
 			fast_forward=${1#--ff=}
 			case "$fast_forward" in
-			allow|never)
+			allow|never|only)
 				;;
 			*)
-				die "Available fast-forward options are: allow and newer" ;;
+				die "Available fast-forward options are: allow, newer, and only" ;;
 			esac
 			;;
 		--no-ff)
@@ -209,7 +209,7 @@ parse_config () {
 		shift
 	done
 	test "$fast_forward" = allow -o "$squash" = "" ||
-		die "You cannot combine --squash with --ff=never"
+		die "You cannot combine --squash with --ff=never or --ff=only."
 	args_left=$#
 }
 
@@ -347,6 +347,8 @@ find_reduced_parents "$@"
 # ff_head may be included here or later in actual parents
 if test -n "$reduced_parents"
 then
+	test $fast_forward = only &&
+		die "--ff=only can not handle more than one real parent"
 	test $head = $ff_head ||
 		reduced_parents="$ff_head$LF$reduced_parents"
 fi
diff --git a/git-pull.sh b/git-pull.sh
index 9e91e75..c5fa1ee 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -41,7 +41,7 @@ do
 		no_ff=--ff ;;
 	--no-ff)
 		no_ff=--no-ff ;;
-	--ff=allow|--ff=never)
+	--ff=allow|--ff=only|--ff=never)
 		no_ff=$1 ;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
diff --git a/t/t7601-merge-ff-options.sh b/t/t7601-merge-ff-options.sh
index c7c6d14..56e8370 100755
--- a/t/t7601-merge-ff-options.sh
+++ b/t/t7601-merge-ff-options.sh
@@ -662,4 +662,218 @@ test_expect_success 'merge c1 with new repository (pull --ff=never)' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge c0 with c1 (--ff=only overrides --no-ff)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "--no-ff" &&
+	git merge --ff=only c1 &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 (--ff=only in config)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "--ff=only" &&
+	git merge c1 &&
+	test_tick &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c0 (--ff=only in config)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "--ff=only" &&
+	git merge c0 &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (--ff=only in config)' '
+	git reset --hard c1 &&
+	test_tick &&
+	git config branch.master.mergeoptions "--ff=only" &&
+	test_must_fail git merge c2 &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 (--ff=only)' '
+	git reset --hard c0 &&
+	test_tick &&
+	git merge --ff=only c1 &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c0 (--ff=only)' '
+	git reset --hard c1 &&
+	test_tick &&
+	git merge --ff=only c0 &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 and c2 (--ff=only)' '
+	git reset --hard c0 &&
+	test_must_fail git merge --ff=only c1 c2 &&
+	verify_merge file result.0 &&
+	verify_head $c0
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c0 (--ff=only)' '
+	git reset --hard c1 &&
+	test_tick &&
+	git merge --ff=only c0 &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (--ff=only overrides --no-ff)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "--no-ff" &&
+	test_tick &&
+	test_must_fail git merge c2 --ff=only &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 (--no-ff overrides --ff=only)' '
+	git reset --hard c0 &&
+	git config branch.master.mergeoptions "--ff=only" &&
+	test_tick &&
+	git merge --no-ff c1 &&
+	verify_merge file result.1 &&
+	verify_parents $c0 $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (--ff owerrides --ff=only)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "--ff=only" &&
+	test_tick &&
+	git merge --ff c2 &&
+	verify_merge file result.1-5 &&
+	verify_parents $c1 $c2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with x0 (--squash combined with --ff=only)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	test_must_fail git merge x0 --squash --ff=only &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge x0 with c1 (--squash combined with --ff=only)' '
+	git reset --hard x0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	test_must_fail git merge c1 --squash --ff=only &&
+	verify_merge file result.1-5 &&
+	verify_head $x0
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge c1 with c2 (--squash combined with --ff=only)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	test_must_fail git merge c2 --squash --ff=only &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge c1 with x0 (--no-commit combined with --ff=only)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge x0 --no-commit --ff=only &&
+	verify_merge file result.1-5 &&
+	verify_head $x0
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge x0 with c1 (--no-commit combined with --ff=only)' '
+	git reset --hard x0 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	git merge c1 --no-commit --ff=only &&
+	verify_merge file result.1-5 &&
+	verify_head $x0
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (--no-commit combined with --ff=only)' '
+	git reset --hard c1 &&
+	git config branch.master.mergeoptions "" &&
+	test_tick &&
+	test_must_fail git merge c2 --no-commit --ff=only &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with x1 (pull --ff=only)' '
+	git reset --hard c1 &&
+	test_tick &&
+	git pull --ff=only clone refs/heads/master &&
+	verify_merge file result.1-13 &&
+	verify_head $x1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge x2 with x1 (pull --ff=only)' '
+	git reset --hard x2 &&
+	test_tick &&
+	test_must_fail git pull --ff=only clone refs/heads/master &&
+	verify_merge file result.5-13 &&
+	verify_head $x2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with new repository (pull --ff=only)' '
+	git reset --hard c1 &&
+	test_tick &&
+	test_must_fail git pull --ff=only new refs/heads/master &&
+	verify_merge file result.1 &&
+	verify_head $c1
+'
+
+test_debug 'gitk --all'
+
 test_done
-- 
1.5.5.1.499.g878b8

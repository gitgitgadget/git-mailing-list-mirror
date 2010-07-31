From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH 2/2 v2] checkout: add a test for creating a new branch with regexp as a starting point
Date: Sat, 31 Jul 2010 05:44:49 +0400
Message-ID: <20100731014449.GA19956@wo.int.altlinux.org>
References: <AANLkTimeQA2_fQ_f2pQchbo1coj3=mV9TRPnbET8SQ4F@mail.gmail.com> <20100731001919.GB24129@wo.int.altlinux.org> <AANLkTin11hHryAbJiOkiBH5TfpPbKREJK-ekWkd4fDhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 03:45:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of18E-0001Hf-H6
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 03:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441Ab0GaBox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 21:44:53 -0400
Received: from vint.altlinux.org ([194.107.17.35]:49969 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419Ab0GaBow (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 21:44:52 -0400
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id C9AB73F80005
	for <git@vger.kernel.org>; Sat, 31 Jul 2010 01:44:50 +0000 (UTC)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id C03AA519000D; Sat, 31 Jul 2010 05:44:49 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <AANLkTin11hHryAbJiOkiBH5TfpPbKREJK-ekWkd4fDhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152285>

Reported-by: Ivan Zakharyaschev <imz@altlinux.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 t/t2018-checkout-branch.sh |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 1caffea..6ada870 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -4,12 +4,13 @@ test_description='checkout '
 
 . ./test-lib.sh
 
-# Arguments: <branch> <sha> [<checkout options>]
+# Arguments: <branch> <start_point> [<checkout options>]
 #
 # Runs "git checkout" to switch to <branch>, testing that
 #
 #   1) we are on the specified branch, <branch>;
-#   2) HEAD is <sha>; if <sha> is not specified, the old HEAD is used.
+#   2) HEAD points to the same commit as <start_point> does;
+#      if <start_point> is not specified, the old HEAD is used.
 #
 # If <checkout options> is not specified, "git checkout" is run with -b.
 do_checkout() {
@@ -17,7 +18,8 @@ do_checkout() {
 	exp_ref="refs/heads/$exp_branch" &&
 
 	# if <sha> is not specified, use HEAD.
-	exp_sha=${2:-$(git rev-parse --verify HEAD)} &&
+	start_point=${2:-HEAD}
+	exp_sha=$(git rev-parse --verify $start_point) &&
 
 	# default options for git checkout: -b
 	if [ -z "$3" ]; then
@@ -26,7 +28,7 @@ do_checkout() {
 		opts="$3"
 	fi
 
-	git checkout $opts $exp_branch $exp_sha &&
+	git checkout $opts $exp_branch $start_point &&
 
 	test $exp_ref = $(git rev-parse --symbolic-full-name HEAD) &&
 	test $exp_sha = $(git rev-parse --verify HEAD)
@@ -118,7 +120,22 @@ test_expect_success 'checkout -b to an existing branch fails' '
 	test_must_fail do_checkout branch2 $HEAD2
 '
 
+test_expect_failure 'checkout -b new_branch :/regexp' '
+	# clean up from previous test
+	git reset --hard &&
+
+	do_checkout old_regexp_branch branch1 &&
+	# The first commit in this test should not be referenced by
+	# other branches or tags.
+	test_commit first a a "" &&
+	test_commit second &&
+
+	do_checkout new_regexp_branch :/first
+'
+
 test_expect_success 'checkout -B to an existing branch resets branch to HEAD' '
+	# clean up from previous test
+	git reset --hard &&
 	git checkout branch1 &&
 
 	do_checkout branch2 "" -B
-- 
1.7.2.1

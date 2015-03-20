From: Jeff King <peff@peff.net>
Subject: [PATCH 08/25] t: fix &&-chaining issues around setup which might fail
Date: Fri, 20 Mar 2015 06:10:21 -0400
Message-ID: <20150320101021.GH12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:10:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtsv-0003Ol-Np
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbbCTKKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:10:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:35688 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751458AbbCTKKY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:10:24 -0400
Received: (qmail 5752 invoked by uid 102); 20 Mar 2015 10:10:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:10:24 -0500
Received: (qmail 21524 invoked by uid 107); 20 Mar 2015 10:10:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:10:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:10:21 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265882>

Many tests have an initial setup step that might fail based
on whether earlier tests in the script have succeeded or
not. Using a trick like "|| true" breaks the &&-chain,
missing earlier failures (and fooling --chain-lint).

We can use test_might_fail in some cases, which is correct
and makes the intent more obvious. We can also use
test_unconfig for unsetting config (and which is more
robust, as well).

The case in t9500 is an oddball. It wants to run cmd1 _or_
cmd2, and does it like:

  cmd1 || cmd2 &&
  other_stuff

It's not wrong in this case, but it's a bad habit to get
into, because it breaks the &&-chain if used anywhere except
at the beginning of the test (and we use the correct
solution here, putting it inside a block for precedence).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5503-tagfollow.sh                   | 4 ++--
 t/t6032-merge-large-rename.sh          | 6 +++---
 t/t7201-co.sh                          | 2 +-
 t/t7508-status.sh                      | 2 +-
 t/t9500-gitweb-standalone-no-errors.sh | 5 ++++-
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index f30c038..4ca48f0 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -139,8 +139,8 @@ EOF
 '
 
 test_expect_success 'new clone fetch master and tags' '
-	git branch -D cat
-	rm -f $U
+	test_might_fail git branch -D cat &&
+	rm -f $U &&
 	(
 		mkdir clone2 &&
 		cd clone2 &&
diff --git a/t/t6032-merge-large-rename.sh b/t/t6032-merge-large-rename.sh
index 15beecc..0f79268 100755
--- a/t/t6032-merge-large-rename.sh
+++ b/t/t6032-merge-large-rename.sh
@@ -28,10 +28,10 @@ make_text() {
 
 test_rename() {
 	test_expect_success "rename ($1, $2)" '
-	n='$1'
-	expect='$2'
+	n='$1' &&
+	expect='$2' &&
 	git checkout -f master &&
-	git branch -D test$n || true &&
+	test_might_fail git branch -D test$n &&
 	git reset --hard initial &&
 	for i in $(count $n); do
 		make_text $i initial initial >$i
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index eae9e5a..a7fe4e6 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -591,7 +591,7 @@ test_expect_success 'checkout --conflict=merge, overriding config' '
 '
 
 test_expect_success 'checkout --conflict=diff3' '
-	git config --unset merge.conflictstyle
+	test_unconfig merge.conflictstyle &&
 	setup_conflicting_index &&
 	echo "none of the above" >sample &&
 	echo ourside >expect &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 0f9ad4c..c3ed7cb 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -538,7 +538,7 @@ A  dir2/added
 ?? untracked
 EOF
 test_expect_success 'status -s -uall' '
-	git config --unset status.showuntrackedfiles
+	test_unconfig status.showuntrackedfiles &&
 	git status -s -uall >output &&
 	test_cmp expect output
 '
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index f9f078e..e94b2f1 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -779,7 +779,10 @@ test_expect_success \
 
 test_expect_success \
 	'unborn HEAD: "summary" page (with "heads" subview)' \
-	'git checkout orphan_branch || git checkout --orphan orphan_branch &&
+	'{
+		git checkout orphan_branch ||
+		git checkout --orphan orphan_branch
+	 } &&
 	 test_when_finished "git checkout master" &&
 	 gitweb_run "p=.git;a=summary"'
 
-- 
2.3.3.520.g3cfbb5d

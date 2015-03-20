From: Jeff King <peff@peff.net>
Subject: [PATCH 11/25] t: wrap complicated expect_code users in a block
Date: Fri, 20 Mar 2015 06:12:29 -0400
Message-ID: <20150320101229.GK12543@peff.net>
References: <20150320100429.GA17354@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:12:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYtux-0005Eq-Lr
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 11:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbbCTKMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 06:12:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:35697 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751385AbbCTKMc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 06:12:32 -0400
Received: (qmail 5851 invoked by uid 102); 20 Mar 2015 10:12:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 05:12:32 -0500
Received: (qmail 21572 invoked by uid 107); 20 Mar 2015 10:12:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 06:12:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 06:12:29 -0400
Content-Disposition: inline
In-Reply-To: <20150320100429.GA17354@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265885>

If we are expecting a command to produce a particular exit
code, we can use test_expect_code. However, some cases are
more complicated, and want to accept one of a range of exit
codes. For these, we end up with something like:

  cmd;
  case "$?" in
  ...

That unfortunately breaks the &&-chain and fools
--chain-lint. Since these special cases are so few, we can
wrap them in a block, like this:

  { cmd; ret=$?; } &&
  case "$ret" in
  ...

This accomplishes the same thing, and retains the &&-chain
(the exit status fed to the && is that of the assignment,
which should always be true). It's technically longer, but
it is probably a good thing for unusual code like this to
stand out.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0005-signals.sh              | 4 ++--
 t/t4026-color.sh                | 6 +++---
 t/t5004-archive-corner-cases.sh | 6 ++++--
 t/t5512-ls-remote.sh            | 6 ++++--
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index aeea50c..5c5707d 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -10,8 +10,8 @@ one
 EOF
 
 test_expect_success 'sigchain works' '
-	test-sigchain >actual
-	case "$?" in
+	{ test-sigchain >actual; ret=$?; } &&
+	case "$ret" in
 	143) true ;; # POSIX w/ SIGTERM=15
 	271) true ;; # ksh w/ SIGTERM=15
 	  3) true ;; # Windows
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 4d20fea..2b32c4f 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -111,9 +111,9 @@ test_expect_success 'unknown color slots are ignored (branch)' '
 '
 
 test_expect_success 'unknown color slots are ignored (status)' '
-	git config color.status.nosuchslotwilleverbedefined white || exit
-	git status
-	case $? in 0|1) : ok ;; *) false ;; esac
+	git config color.status.nosuchslotwilleverbedefined white &&
+	{ git status; ret=$?; } &&
+	case $ret in 0|1) : ok ;; *) false ;; esac
 '
 
 test_done
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 305bcac..654adda 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -66,8 +66,10 @@ test_expect_success UNZIP 'zip archive of empty tree is empty' '
 	# handle the empty repo at all, making our later check of its exit code
 	# a no-op). But we cannot do anything reasonable except skip the test
 	# on such platforms anyway, and this is the moral equivalent.
-	"$GIT_UNZIP" "$TEST_DIRECTORY"/t5004/empty.zip
-	expect_code=$?
+	{
+		"$GIT_UNZIP" "$TEST_DIRECTORY"/t5004/empty.zip
+		expect_code=$?
+	} &&
 
 	git archive --format=zip HEAD >empty.zip &&
 	make_dir extract &&
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 321c3e5..3bd9759 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -103,8 +103,10 @@ test_expect_success 'confuses pattern as remote when no remote specified' '
 '
 
 test_expect_success 'die with non-2 for wrong repository even with --exit-code' '
-	git ls-remote --exit-code ./no-such-repository ;# not &&
-	status=$? &&
+	{
+		git ls-remote --exit-code ./no-such-repository
+		status=$?
+	} &&
 	test $status != 2 && test $status != 0
 '
 
-- 
2.3.3.520.g3cfbb5d

From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 0/9] remote-hg, remote-bzr fixes
Date: Tue, 12 Nov 2013 00:54:39 -0500
Message-ID: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 06:55:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg6wd-0008KE-Eh
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 06:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697Ab3KLFzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 00:55:15 -0500
Received: from smtp.bbn.com ([128.33.1.81]:53323 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979Ab3KLFzM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 00:55:12 -0500
Received: from socket.bbn.com ([192.1.120.102]:44819)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vg6wQ-0002P8-Jy; Tue, 12 Nov 2013 00:55:10 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id E42B94004D
X-Mailer: git-send-email 1.8.5.rc1.208.g8ff7964
In-Reply-To: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237685>

A handful of fixes for the git-remote-hg and git-remote-bzr remote
helpers and their unit tests.

Changes from v1:

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index ea597b0..1e53ff9 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -5,8 +5,8 @@
 
 test_description='Test remote-bzr'
 
-cd "${0%/*}"/../../t || exit 1
-. ./test-lib.sh
+test -n "$TEST_DIRECTORY" || TEST_DIRECTORY=${0%/*}/../../t
+. "$TEST_DIRECTORY"/test-lib.sh
 
 if ! test_have_prereq PYTHON
 then
@@ -28,9 +28,6 @@ check () {
 
 bzr whoami "A U Thor <author@example.com>"
 
-# silence warnings
-git config --global push.default simple
-
 test_expect_success 'cloning' '
 	(
 	bzr init bzrrepo &&
@@ -382,7 +379,7 @@ test_expect_success 'export utf-8 authors' '
 	git add content &&
 	git commit -m one &&
 	git remote add bzr "bzr::../bzrrepo" &&
-	git push -u bzr master
+	git push bzr master
 	) &&
 
 	(
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 9f5066b..347e812 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -8,8 +8,8 @@
 
 test_description='Test remote-hg'
 
-cd "${0%/*}"/../../t || exit 1
-. ./test-lib.sh
+test -n "$TEST_DIRECTORY" || TEST_DIRECTORY=${0%/*}/../../t
+. "$TEST_DIRECTORY"/test-lib.sh
 
 if ! test_have_prereq PYTHON
 then
@@ -102,9 +102,6 @@ setup () {
 	GIT_AUTHOR_DATE="2007-01-01 00:00:00 +0230" &&
 	GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE" &&
 	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
-
-	# silence warnings
-	git config --global push.default simple
 }
 
 setup
@@ -210,16 +207,16 @@ test_expect_success 'authors' '
 	>../expected &&
 	author_test alpha "" "H G Wells <wells@example.com>" &&
 	author_test beta "beta" "beta <unknown>" &&
-	author_test beta "beta <test@example.com> (comment)" "beta <test@example.com>" &&
-	author_test gamma "<gamma@example.com>" "Unknown <gamma@example.com>" &&
-	author_test delta "delta<test@example.com>" "delta <test@example.com>" &&
-	author_test epsilon "epsilon <test@example.com" "epsilon <test@example.com>" &&
-	author_test zeta " zeta " "zeta <unknown>" &&
-	author_test eta "eta < test@example.com >" "eta <test@example.com>" &&
-	author_test theta "theta >test@example.com>" "theta <test@example.com>" &&
-	author_test iota "iota < test <at> example <dot> com>" "iota <unknown>" &&
-	author_test kappa "kappa@example.com" "Unknown <kappa@example.com>" &&
-	author_test lambda "lambda.lambda@example.com" "Unknown <lambda.lambda@example.com>"
+	author_test gamma "gamma <test@example.com> (comment)" "gamma <test@example.com>" &&
+	author_test delta "<delta@example.com>" "Unknown <delta@example.com>" &&
+	author_test epsilon "epsilon<test@example.com>" "epsilon <test@example.com>" &&
+	author_test zeta "zeta <test@example.com" "zeta <test@example.com>" &&
+	author_test eta " eta " "eta <unknown>" &&
+	author_test theta "theta < test@example.com >" "theta <test@example.com>" &&
+	author_test iota "iota >test@example.com>" "iota <test@example.com>" &&
+	author_test kappa "kappa < test <at> example <dot> com>" "kappa <unknown>" &&
+	author_test lambda "lambda@example.com" "Unknown <lambda@example.com>" &&
+	author_test mu "mu.mu@example.com" "Unknown <mu.mu@example.com>"
 	) &&
 
 	git clone "hg::hgrepo" gitrepo &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index b25249e..af172d9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -26,6 +26,10 @@ then
 	# outside of t/, e.g. for running tests on the test library
 	# itself.
 	TEST_DIRECTORY=$(pwd)
+else
+	# ensure that TEST_DIRECTORY is an absolute path so that it
+	# works even if the current working directory is changed
+	TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
 fi
 if test -z "$TEST_OUTPUT_DIRECTORY"
 then

Richard Hansen (9):
  remote-hg:  don't decode UTF-8 paths into Unicode objects
  test-lib.sh: convert $TEST_DIRECTORY to an absolute path
  test-bzr.sh, test-hg.sh: allow running from any dir
  test-bzr.sh, test-hg.sh: prepare for change to push.default=simple
  test-hg.sh: eliminate 'local' bashism
  test-hg.sh: avoid obsolete 'test' syntax
  test-hg.sh: fix duplicate content strings in author tests
  test-hg.sh: help user correlate verbose output with email test
  remote-bzr, remote-hg: fix email address regular expression

 contrib/remote-helpers/git-remote-bzr |  7 +++----
 contrib/remote-helpers/git-remote-hg  |  9 ++++-----
 contrib/remote-helpers/test-bzr.sh    |  5 +++--
 contrib/remote-helpers/test-hg.sh     | 30 ++++++++++++++++--------------
 t/test-lib.sh                         |  4 ++++
 5 files changed, 30 insertions(+), 25 deletions(-)

-- 
1.8.5.rc1.208.g8ff7964

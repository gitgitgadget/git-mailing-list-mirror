From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH as/check-ignore] t0007: fix tests on Windows
Date: Sun, 04 Nov 2012 22:07:54 +0100
Message-ID: <5096D92A.7090600@kdbg.org>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com> <1350282486-4646-1-git-send-email-pclouds@gmail.com> <1350282486-4646-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 22:08:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TV7QP-0005L5-DU
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 22:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab2KDVH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 16:07:57 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:61258 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075Ab2KDVH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 16:07:56 -0500
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Nov 2012 16:07:56 EST
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 367E2CDF87;
	Sun,  4 Nov 2012 22:07:55 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BAB0B19F40E;
	Sun,  4 Nov 2012 22:07:54 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121025 Thunderbird/16.0.2
In-Reply-To: <1350282486-4646-12-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209041>

The value of $global_excludes is sometimes part of the output
that is tested for. Since git on Windows only sees DOS style paths,
we have to ensure that the "expected" values are constructed in
the same manner. To account for this, use $(pwd) to set the value
of global_excludes.

Additionally, add a SYMLINKS prerequisite to the tests involving
symbolic links.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t0007-ignores.sh | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/t/t0007-ignores.sh b/t/t0007-ignores.sh
index 7fd7e53..5d2b8f2 100755
--- a/t/t0007-ignores.sh
+++ b/t/t0007-ignores.sh
@@ -5,7 +5,7 @@ test_description=check-ignore
 . ./test-lib.sh
 
 init_vars () {
-	global_excludes="$HOME/global-excludes"
+	global_excludes="$(pwd)/global-excludes"
 }
 
 enable_global_excludes () {
@@ -77,18 +77,24 @@ test_check_ignore () {
 }
 
 test_expect_success_multi () {
+	prereq=
+	if test $# -eq 4
+	then
+		prereq=$1
+		shift
+	fi
 	testname="$1" expect_verbose="$2" code="$3"
 
 	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
 
-	test_expect_success "$testname" "
+	test_expect_success $prereq "$testname" "
 		expect '$expect' &&
 		$code
 	"
 
 	for quiet_opt in '-q' '--quiet'
 	do
-		test_expect_success "$testname${quiet_opt:+ with $quiet_opt}" "
+		test_expect_success $prereq "$testname${quiet_opt:+ with $quiet_opt}" "
 			expect '' &&
 			$code
 		"
@@ -97,7 +103,7 @@ test_expect_success_multi () {
 
 	for verbose_opt in '-v' '--verbose'
 	do
-		test_expect_success "$testname${verbose_opt:+ with $verbose_opt}" "
+		test_expect_success $prereq "$testname${verbose_opt:+ with $verbose_opt}" "
 			expect '$expect_verbose' &&
 			$code
 		"
@@ -108,7 +114,10 @@ test_expect_success_multi () {
 test_expect_success 'setup' '
 	init_vars
 	mkdir -p a/b/ignored-dir a/submodule b &&
-	ln -s b a/symlink &&
+	if test_have_prereq SYMLINKS
+	then
+		ln -s b a/symlink
+	fi &&
 	(
 		cd a/submodule &&
 		git init &&
@@ -326,16 +335,16 @@ test_expect_success 'cd to ignored sub-directory with -v' '
 #
 # test handling of symlinks
 
-test_expect_success_multi 'symlink' '' '
+test_expect_success_multi SYMLINKS 'symlink' '' '
 	test_check_ignore "a/symlink" 1
 '
 
-test_expect_success_multi 'beyond a symlink' '' '
+test_expect_success_multi SYMLINKS 'beyond a symlink' '' '
 	test_check_ignore "a/symlink/foo" 128 &&
 	test_stderr "fatal: '\''a/symlink/foo'\'' is beyond a symbolic link"
 '
 
-test_expect_success_multi 'beyond a symlink from subdirectory' '' '
+test_expect_success_multi SYMLINKS 'beyond a symlink from subdirectory' '' '
 	(
 		cd a &&
 		test_check_ignore "symlink/foo" 128
-- 
1.8.0.rc0.45.g6c9d890

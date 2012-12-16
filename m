From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v6 5/7] tests: refactor mechanics of testing in a sub test-lib
Date: Sun, 16 Dec 2012 18:28:13 +0000
Message-ID: <1355682495-22382-6-git-send-email-git@adamspiers.org>
References: <1355682495-22382-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 19:39:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkJ7S-0007Pf-Jj
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 19:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614Ab2LPSi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 13:38:58 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:41199 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab2LPSi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 13:38:56 -0500
Received: from localhost (4.8.9.4.4.5.7.d.4.0.6.a.a.2.0.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:b02a:a604:d754:4984])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 9BCEE2E665
	for <git@vger.kernel.org>; Sun, 16 Dec 2012 18:28:20 +0000 (GMT)
X-Mailer: git-send-email 1.7.12.1.396.g53b3ea9
In-Reply-To: <1355682495-22382-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211594>

This will allow us to test the test framework more thoroughly
without disrupting the top-level test metrics.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 t/t0000-basic.sh | 85 ++++++++++++++++++++++++++------------------------------
 1 file changed, 40 insertions(+), 45 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 46ccda3..fc5200f 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -45,39 +45,53 @@ test_expect_failure 'pretend we have a known breakage' '
 	false
 '
 
-test_expect_success 'pretend we have fixed a known breakage (run in sub test-lib)' "
-	mkdir passing-todo &&
-	(cd passing-todo &&
-	cat >passing-todo.sh <<-EOF &&
-	#!$SHELL_PATH
-
-	test_description='A passing TODO test
-
-	This is run in a sub test-lib so that we do not get incorrect
-	passing metrics
-	'
-
-	# Point to the t/test-lib.sh, which isn't in ../ as usual
-	TEST_DIRECTORY=\"$TEST_DIRECTORY\"
-	. \"\$TEST_DIRECTORY\"/test-lib.sh
+run_sub_test_lib_test () {
+	name="$1" descr="$2" # stdin is the body of the test code
+	mkdir $name &&
+	(
+		cd $name &&
+		cat >$name.sh <<-EOF &&
+		#!$SHELL_PATH
+
+		test_description='$descr (run in sub test-lib)
+
+		This is run in a sub test-lib so that we do not get incorrect
+		passing metrics
+		'
+
+		# Point to the t/test-lib.sh, which isn't in ../ as usual
+		. "\$TEST_DIRECTORY"/test-lib.sh
+		EOF
+		cat >>$name.sh &&
+		chmod +x $name.sh &&
+		export TEST_DIRECTORY &&
+		./$name.sh >out 2>err
+	)
+}
 
-	test_expect_failure 'pretend we have fixed a known breakage' '
-		:
-	'
+check_sub_test_lib_test () {
+	name="$1" # stdin is the expected output from the test
+	(
+		cd $name &&
+		! test -s err &&
+		sed -e 's/^> //' -e 's/Z$//' >expect &&
+		test_cmp expect out
+	)
+}
 
+test_expect_success 'pretend we have fixed a known breakage' "
+	run_sub_test_lib_test passing-todo 'A passing TODO test' <<-\\EOF &&
+	test_expect_failure 'pretend we have fixed a known breakage' 'true'
 	test_done
 	EOF
-	chmod +x passing-todo.sh &&
-	./passing-todo.sh >out 2>err &&
-	! test -s err &&
-	sed -e 's/^> //' >expect <<-\\EOF &&
+	check_sub_test_lib_test passing-todo <<-\\EOF
 	> ok 1 - pretend we have fixed a known breakage # TODO known breakage
 	> # fixed 1 known breakage(s)
 	> # passed all 1 test(s)
 	> 1..1
 	EOF
-	test_cmp expect out)
 "
+
 test_set_prereq HAVEIT
 haveit=no
 test_expect_success HAVEIT 'test runs if prerequisite is satisfied' '
@@ -159,19 +173,8 @@ then
 fi
 
 test_expect_success 'tests clean up even on failures' "
-	mkdir failing-cleanup &&
-	(
-	cd failing-cleanup &&
-
-	cat >failing-cleanup.sh <<-EOF &&
-	#!$SHELL_PATH
-
-	test_description='Failing tests with cleanup commands'
-
-	# Point to the t/test-lib.sh, which isn't in ../ as usual
-	TEST_DIRECTORY=\"$TEST_DIRECTORY\"
-	. \"\$TEST_DIRECTORY\"/test-lib.sh
-
+	test_must_fail run_sub_test_lib_test \
+		failing-cleanup 'Failing tests with cleanup commands' <<-\\EOF &&
 	test_expect_success 'tests clean up even after a failure' '
 		touch clean-after-failure &&
 		test_when_finished rm clean-after-failure &&
@@ -181,14 +184,8 @@ test_expect_success 'tests clean up even on failures' "
 		test_when_finished \"(exit 2)\"
 	'
 	test_done
-
 	EOF
-
-	chmod +x failing-cleanup.sh &&
-	test_must_fail ./failing-cleanup.sh >out 2>err &&
-	! test -s err &&
-	! test -f \"trash directory.failing-cleanup/clean-after-failure\" &&
-	sed -e 's/Z$//' -e 's/^> //' >expect <<-\\EOF &&
+	check_sub_test_lib_test failing-cleanup <<-\\EOF
 	> not ok 1 - tests clean up even after a failure
 	> #	Z
 	> #	touch clean-after-failure &&
@@ -202,8 +199,6 @@ test_expect_success 'tests clean up even on failures' "
 	> # failed 2 among 2 test(s)
 	> 1..2
 	EOF
-	test_cmp expect out
-	)
 "
 
 ################################################################
-- 
1.7.12.1.396.g53b3ea9

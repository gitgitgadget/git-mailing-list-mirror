From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 4/6] Refactor mechanics of testing in a sub test-lib
Date: Wed, 19 Sep 2012 19:49:49 +0100
Message-ID: <1348080591-16430-1-git-send-email-git@adamspiers.org>
References: <20120919184406.GC19246@atlantic.linksys.moosehall>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 20:50:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEPLX-0000ht-0U
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 20:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756875Ab2ISSty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 14:49:54 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:45036 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756865Ab2ISStx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 14:49:53 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 85DD62E39E;
	Wed, 19 Sep 2012 19:49:52 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <20120919184406.GC19246@atlantic.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205975>

This will allow us to test the test framework more thoroughly
without disrupting the top-level test metrics.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 t/t0000-basic.sh | 67 ++++++++++++++++++++++++--------------------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index c6b42de..029e3bd 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -55,39 +55,49 @@ test_expect_failure 'pretend we have a known breakage' '
 	false
 '
 
-test_expect_success 'pretend we have fixed a known breakage (run in sub test-lib)' "
-	mkdir passing-todo &&
-	(cd passing-todo &&
-	cat >passing-todo.sh <<-EOF &&
+run_sub_test_lib_test () {
+	name="$1" descr="$2" # stdin is body of test code
+	mkdir $name &&
+	(cd $name &&
+	cat >$name.sh <<-EOF &&
 	#!$SHELL_PATH
 
-	test_description='A passing TODO test
+	test_description='$descr (run in sub test-lib)
 
 	This is run in a sub test-lib so that we do not get incorrect
 	passing metrics
 	'
 
 	# Point to the t/test-lib.sh, which isn't in ../ as usual
-	TEST_DIRECTORY=\"$TEST_DIRECTORY\"
-	. \"\$TEST_DIRECTORY\"/test-lib.sh
-
-	test_expect_failure 'pretend we have fixed a known breakage' '
-		:
-	'
+	TEST_DIRECTORY="$TEST_DIRECTORY"
+	. "\$TEST_DIRECTORY"/test-lib.sh
+	EOF
+	cat >>$name.sh &&
+	chmod +x $name.sh &&
+	./$name.sh >out 2>err)
+}
+
+check_sub_test_lib_test () {
+	name="$1" # stdin is test's expected stdout
+	(cd $name &&
+	! test -s err &&
+	sed -e 's/^> //' -e 's/Z$//' >expect &&
+	test_cmp expect out)
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
@@ -137,19 +147,8 @@ then
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
@@ -159,14 +158,8 @@ test_expect_success 'tests clean up even on failures' "
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
@@ -180,8 +173,6 @@ test_expect_success 'tests clean up even on failures' "
 	> # failed 2 among 2 test(s)
 	> 1..2
 	EOF
-	test_cmp expect out
-	)
 "
 
 ################################################################
-- 
1.7.12.147.g6d168f4

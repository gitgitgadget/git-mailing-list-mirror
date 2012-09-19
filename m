From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 4/6] Refactor mechanics of testing in a sub test-lib
Date: Wed, 19 Sep 2012 18:15:13 +0100
Message-ID: <1348074915-19985-5-git-send-email-git@adamspiers.org>
References: <1348074915-19985-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 19:15:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TENsC-0001rP-5L
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 19:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708Ab2ISRP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 13:15:27 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:44894 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932639Ab2ISRPW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 13:15:22 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id B7B4B2E39E;
	Wed, 19 Sep 2012 18:15:20 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <1348074915-19985-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205953>

This will allow us to test the test framework more thoroughly
without disrupting the top-level test metrics.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 t/t0000-basic.sh | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index c6b42de..662cd2f 100755
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
+	sed -e 's/^> //' >expect &&
+	test_cmp expect out)
+}
 
+test_expect_success 'pretend we have fixed a known breakage' "
+	run_sub_test_lib_test passing-todo 'A passing TODO test' <<-EOF &&
+	test_expect_failure 'pretend we have fixed a known breakage' 'true'
 	test_done
 	EOF
-	chmod +x passing-todo.sh &&
-	./passing-todo.sh >out 2>err &&
-	! test -s err &&
-	sed -e 's/^> //' >expect <<-\\EOF &&
+	check_sub_test_lib_test passing-todo <<-EOF
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
@@ -166,7 +176,7 @@ test_expect_success 'tests clean up even on failures' "
 	test_must_fail ./failing-cleanup.sh >out 2>err &&
 	! test -s err &&
 	! test -f \"trash directory.failing-cleanup/clean-after-failure\" &&
-	sed -e 's/Z$//' -e 's/^> //' >expect <<-\\EOF &&
+	sed -e 's/Z$//' -e 's/^> //' >expect <<-EOF &&
 	> not ok 1 - tests clean up even after a failure
 	> #	Z
 	> #	touch clean-after-failure &&
-- 
1.7.12.147.g6d168f4

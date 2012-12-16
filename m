From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v6 7/7] tests: paint unexpectedly fixed known breakages in bold red
Date: Sun, 16 Dec 2012 18:28:15 +0000
Message-ID: <1355682495-22382-8-git-send-email-git@adamspiers.org>
References: <1355682495-22382-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 19:39:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkJ7k-0007bF-8s
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 19:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab2LPSjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 13:39:21 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:41195 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080Ab2LPSi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 13:38:56 -0500
Received: from localhost (4.8.9.4.4.5.7.d.4.0.6.a.a.2.0.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:b02a:a604:d754:4984])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 5B8602E667
	for <git@vger.kernel.org>; Sun, 16 Dec 2012 18:28:22 +0000 (GMT)
X-Mailer: git-send-email 1.7.12.1.396.g53b3ea9
In-Reply-To: <1355682495-22382-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211598>

Change color of unexpectedly fixed known breakages to bold red.  An
unexpectedly passing test indicates that the test code is somehow
broken or out of sync with the code it is testing.  Either way this is
an error which is potentially as bad as a failing test, and as such is
no longer portrayed as a pass in the output.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 t/t0000-basic.sh | 30 ++++++++++++++++++++++++------
 t/test-lib.sh    | 13 +++++++++----
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 5c1dde0..bd6127f 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -134,13 +134,31 @@ test_expect_success 'pretend we have fixed a known breakage' "
 	test_done
 	EOF
 	check_sub_test_lib_test passing-todo <<-\\EOF
-	> ok 1 - pretend we have fixed a known breakage # TODO known breakage
-	> # fixed 1 known breakage(s)
-	> # passed all 1 test(s)
+	> ok 1 - pretend we have fixed a known breakage # TODO known breakage vanished
+	> # 1 known breakage(s) vanished; please update test(s)
 	> 1..1
 	EOF
 "
 
+test_expect_success 'pretend we have fixed one of two known breakages (run in sub test-lib)' "
+	run_sub_test_lib_test partially-passing-todos \
+		'2 TODO tests, one passing' <<-\\EOF &&
+	test_expect_failure 'pretend we have a known breakage' 'false'
+	test_expect_success 'pretend we have a passing test' 'true'
+	test_expect_failure 'pretend we have fixed another known breakage' 'true'
+	test_done
+	EOF
+	check_sub_test_lib_test partially-passing-todos <<-\\EOF
+	> not ok 1 - pretend we have a known breakage # TODO known breakage
+	> ok 2 - pretend we have a passing test
+	> ok 3 - pretend we have fixed another known breakage # TODO known breakage vanished
+	> # 1 known breakage(s) vanished; please update test(s)
+	> # still have 1 known breakage(s)
+	> # passed all remaining 1 test(s)
+	> 1..3
+	EOF
+"
+
 test_expect_success 'pretend we have a pass, fail, and known breakage' "
 	test_must_fail run_sub_test_lib_test \
 		mixed-results1 'mixed results #1' <<-\\EOF &&
@@ -188,10 +206,10 @@ test_expect_success 'pretend we have a mix of all possible results' "
 	> #	false
 	> not ok 8 - pretend we have a known breakage # TODO known breakage
 	> not ok 9 - pretend we have a known breakage # TODO known breakage
-	> ok 10 - pretend we have fixed a known breakage # TODO known breakage
-	> # fixed 1 known breakage(s)
+	> ok 10 - pretend we have fixed a known breakage # TODO known breakage vanished
+	> # 1 known breakage(s) vanished; please update test(s)
 	> # still have 2 known breakage(s)
-	> # failed 3 among remaining 8 test(s)
+	> # failed 3 among remaining 7 test(s)
 	> 1..10
 	EOF
 "
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5d9d0fc..b1acdfc 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -308,7 +308,7 @@ test_failure_ () {
 
 test_known_broken_ok_ () {
 	test_fixed=$(($test_fixed+1))
-	say_color "" "ok $test_count - $@ # TODO known breakage"
+	say_color error "ok $test_count - $@ # TODO known breakage vanished"
 }
 
 test_known_broken_failure_ () {
@@ -406,13 +406,18 @@ test_done () {
 
 	if test "$test_fixed" != 0
 	then
-		say_color pass "# fixed $test_fixed known breakage(s)"
+		say_color error "# $test_fixed known breakage(s) vanished; please update test(s)"
 	fi
 	if test "$test_broken" != 0
 	then
 		say_color warn "# still have $test_broken known breakage(s)"
-		msg="remaining $(($test_count-$test_broken)) test(s)"
+	fi
+	if test "$test_broken" != 0 || test "$test_fixed" != 0
+	then
+		test_remaining=$(( $test_count - $test_broken - $test_fixed ))
+		msg="remaining $test_remaining test(s)"
 	else
+		test_remaining=$test_count
 		msg="$test_count test(s)"
 	fi
 	case "$test_failure" in
@@ -426,7 +431,7 @@ test_done () {
 
 		if test $test_external_has_tap -eq 0
 		then
-			if test $test_count -gt 0
+			if test $test_remaining -gt 0
 			then
 				say_color pass "# passed all $msg"
 			fi
-- 
1.7.12.1.396.g53b3ea9

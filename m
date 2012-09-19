From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 6/6] Treat unexpectedly fixed known breakages more seriously
Date: Wed, 19 Sep 2012 19:49:51 +0100
Message-ID: <1348080591-16430-3-git-send-email-git@adamspiers.org>
References: <20120919184406.GC19246@atlantic.linksys.moosehall>
 <1348080591-16430-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 20:50:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEPLg-0000mh-1G
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 20:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882Ab2ISSt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 14:49:59 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:45042 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756865Ab2ISStz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 14:49:55 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 6DBE92E5DF;
	Wed, 19 Sep 2012 19:49:54 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <1348080591-16430-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205976>

Change color of unexpectedly fixed known breakages to bold red.  An
unexpectedly passing test indicates that the test code is somehow
broken or out of sync with the code it is testing.  Either way this
is an error which is potentially as bad as a failing test, and as
such is no longer portrayed as a pass in the output.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 t/t0000-basic.sh | 30 ++++++++++++++++++++++++------
 t/test-lib.sh    | 13 +++++++++----
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 65f578f..ed44f7d 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -140,13 +140,31 @@ test_expect_success 'pretend we have fixed a known breakage' "
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
@@ -194,10 +212,10 @@ test_expect_success 'pretend we have a mix of all possible results' "
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
index 7028ba8..b403e85 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -278,7 +278,7 @@ test_failure_ () {
 
 test_known_broken_ok_ () {
 	test_fixed=$(($test_fixed+1))
-	say_color "" "ok $test_count - $@ # TODO known breakage"
+	say_color error "ok $test_count - $@ # TODO known breakage vanished"
 }
 
 test_known_broken_failure_ () {
@@ -373,13 +373,18 @@ test_done () {
 
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
@@ -393,7 +398,7 @@ test_done () {
 
 		if test $test_external_has_tap -eq 0
 		then
-			if test $test_count -gt 0
+			if test $test_remaining -gt 0
 			then
 				say_color pass "# passed all $msg"
 			fi
-- 
1.7.12.147.g6d168f4

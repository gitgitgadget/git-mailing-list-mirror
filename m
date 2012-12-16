From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v6 6/7] tests: test the test framework more thoroughly
Date: Sun, 16 Dec 2012 18:28:14 +0000
Message-ID: <1355682495-22382-7-git-send-email-git@adamspiers.org>
References: <1355682495-22382-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 19:39:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkJ7j-0007bF-Pa
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 19:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859Ab2LPSjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 13:39:21 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:41198 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab2LPSi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 13:38:56 -0500
Received: from localhost (4.8.9.4.4.5.7.d.4.0.6.a.a.2.0.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:b02a:a604:d754:4984])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 91AB52E666
	for <git@vger.kernel.org>; Sun, 16 Dec 2012 18:28:21 +0000 (GMT)
X-Mailer: git-send-email 1.7.12.1.396.g53b3ea9
In-Reply-To: <1355682495-22382-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211599>

Add 5 new full test suite runs each with a different number of
passing/failing/broken/fixed tests, in order to ensure that the
correct exit code and output are generated in each case.  As before,
these are run in a subdirectory to avoid disrupting the metrics for
the parent tests.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 t/t0000-basic.sh | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index fc5200f..5c1dde0 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -79,6 +79,55 @@ check_sub_test_lib_test () {
 	)
 }
 
+test_expect_success 'pretend we have a fully passing test suite' "
+	run_sub_test_lib_test full-pass '3 passing tests' <<-\\EOF &&
+	for i in 1 2 3; do
+		test_expect_success \"passing test #\$i\" 'true'
+	done
+	test_done
+	EOF
+	check_sub_test_lib_test full-pass <<-\\EOF
+	> ok 1 - passing test #1
+	> ok 2 - passing test #2
+	> ok 3 - passing test #3
+	> # passed all 3 test(s)
+	> 1..3
+	EOF
+"
+
+test_expect_success 'pretend we have a partially passing test suite' "
+	test_must_fail run_sub_test_lib_test \
+		partial-pass '2/3 tests passing' <<-\\EOF &&
+	test_expect_success 'passing test #1' 'true'
+	test_expect_success 'failing test #2' 'false'
+	test_expect_success 'passing test #3' 'true'
+	test_done
+	EOF
+	check_sub_test_lib_test partial-pass <<-\\EOF
+	> ok 1 - passing test #1
+	> not ok 2 - failing test #2
+	#	false
+	> ok 3 - passing test #3
+	> # failed 1 among 3 test(s)
+	> 1..3
+	EOF
+"
+
+test_expect_success 'pretend we have a known breakage' "
+	run_sub_test_lib_test failing-todo 'A failing TODO test' <<-\\EOF &&
+	test_expect_success 'passing test' 'true'
+	test_expect_failure 'pretend we have a known breakage' 'false'
+	test_done
+	EOF
+	check_sub_test_lib_test failing-todo <<-\\EOF
+	> ok 1 - passing test
+	> not ok 2 - pretend we have a known breakage # TODO known breakage
+	> # still have 1 known breakage(s)
+	> # passed all remaining 1 test(s)
+	> 1..2
+	EOF
+"
+
 test_expect_success 'pretend we have fixed a known breakage' "
 	run_sub_test_lib_test passing-todo 'A passing TODO test' <<-\\EOF &&
 	test_expect_failure 'pretend we have fixed a known breakage' 'true'
@@ -92,6 +141,61 @@ test_expect_success 'pretend we have fixed a known breakage' "
 	EOF
 "
 
+test_expect_success 'pretend we have a pass, fail, and known breakage' "
+	test_must_fail run_sub_test_lib_test \
+		mixed-results1 'mixed results #1' <<-\\EOF &&
+	test_expect_success 'passing test' 'true'
+	test_expect_success 'failing test' 'false'
+	test_expect_failure 'pretend we have a known breakage' 'false'
+	test_done
+	EOF
+	check_sub_test_lib_test mixed-results1 <<-\\EOF
+	> ok 1 - passing test
+	> not ok 2 - failing test
+	> #	false
+	> not ok 3 - pretend we have a known breakage # TODO known breakage
+	> # still have 1 known breakage(s)
+	> # failed 1 among remaining 2 test(s)
+	> 1..3
+	EOF
+"
+
+test_expect_success 'pretend we have a mix of all possible results' "
+	test_must_fail run_sub_test_lib_test \
+		mixed-results2 'mixed results #2' <<-\\EOF &&
+	test_expect_success 'passing test' 'true'
+	test_expect_success 'passing test' 'true'
+	test_expect_success 'passing test' 'true'
+	test_expect_success 'passing test' 'true'
+	test_expect_success 'failing test' 'false'
+	test_expect_success 'failing test' 'false'
+	test_expect_success 'failing test' 'false'
+	test_expect_failure 'pretend we have a known breakage' 'false'
+	test_expect_failure 'pretend we have a known breakage' 'false'
+	test_expect_failure 'pretend we have fixed a known breakage' 'true'
+	test_done
+	EOF
+	check_sub_test_lib_test mixed-results2 <<-\\EOF
+	> ok 1 - passing test
+	> ok 2 - passing test
+	> ok 3 - passing test
+	> ok 4 - passing test
+	> not ok 5 - failing test
+	> #	false
+	> not ok 6 - failing test
+	> #	false
+	> not ok 7 - failing test
+	> #	false
+	> not ok 8 - pretend we have a known breakage # TODO known breakage
+	> not ok 9 - pretend we have a known breakage # TODO known breakage
+	> ok 10 - pretend we have fixed a known breakage # TODO known breakage
+	> # fixed 1 known breakage(s)
+	> # still have 2 known breakage(s)
+	> # failed 3 among remaining 8 test(s)
+	> 1..10
+	EOF
+"
+
 test_set_prereq HAVEIT
 haveit=no
 test_expect_success HAVEIT 'test runs if prerequisite is satisfied' '
-- 
1.7.12.1.396.g53b3ea9

From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v3 3/8] test-lib: rearrange start/end of test_expect_* and test_skip
Date: Tue, 18 Jun 2013 14:25:59 +0200
Message-ID: <0c11f94a00644b0fe8d2fcc3620ece530868f5af.1371557431.git.trast@inf.ethz.ch>
References: <cover.1371557431.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:26:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UouzR-0007cU-TS
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755811Ab3FRM0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:26:18 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:19096 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932192Ab3FRM0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:26:16 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 14:26:13 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.157) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 14:26:15 +0200
X-Mailer: git-send-email 1.8.3.1.530.g6f90e57
In-Reply-To: <cover.1371557431.git.trast@inf.ethz.ch>
X-Originating-IP: [213.55.184.157]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228214>

This moves

* the early setup part from test_skip to a new function test_start_

* the final common parts of test_expect_* to a new function
  test_finish_

to make the next commit more obvious.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/test-lib-functions.sh | 6 ++++--
 t/test-lib.sh           | 9 ++++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 5251009..ad6d60a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -343,6 +343,7 @@ test_declared_prereq () {
 }
 
 test_expect_failure () {
+	test_start_
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
 	error "bug in the test script: not 2 or 3 parameters to test-expect-failure"
@@ -357,10 +358,11 @@ test_expect_failure () {
 			test_known_broken_failure_ "$1"
 		fi
 	fi
-	echo >&3 ""
+	test_finish_
 }
 
 test_expect_success () {
+	test_start_
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
 	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
@@ -375,7 +377,7 @@ test_expect_success () {
 			test_failure_ "$@"
 		fi
 	fi
-	echo >&3 ""
+	test_finish_
 }
 
 # test_external runs external test scripts that provide continuous
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4fa141a..e99b0ea 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -369,8 +369,15 @@ test_run_ () {
 	return "$eval_ret"
 }
 
-test_skip () {
+test_start_ () {
 	test_count=$(($test_count+1))
+}
+
+test_finish_ () {
+	echo >&3 ""
+}
+
+test_skip () {
 	to_skip=
 	if match_pattern_list $this_test.$test_count $GIT_SKIP_TESTS
 	then
-- 
1.8.3.1.530.g6f90e57

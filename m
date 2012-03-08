From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/2] perf: export some important test-lib variables
Date: Thu, 8 Mar 2012 09:54:55 +0100
Message-ID: <1c5b174027fc70f084a6547352596d8c0305f6c9.1331196679.git.trast@student.ethz.ch>
References: <14709b4345420da36a9152904bef4cc4503f78e4.1331196679.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 09:55:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Z7p-0007rZ-9g
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 09:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238Ab2CHIzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 03:55:01 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:12506 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755162Ab2CHIy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 03:54:59 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 8 Mar
 2012 09:54:56 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 8 Mar
 2012 09:54:56 +0100
X-Mailer: git-send-email 1.7.9.3.556.g7eb2d
In-Reply-To: <14709b4345420da36a9152904bef4cc4503f78e4.1331196679.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192538>

The only bug right now is that $GIT_TEST_CMP is needed for test_cmp to
work.

However, we also export the three most important paths for tests:

  TEST_DIRECTORY
  TRASH_DIRECTORY
  GIT_BUILD_DIR

Since they are available within test_expect_success, a future test
writer may expect them to also be defined in test_perf.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/perf/p0000-perf-lib-sanity.sh |   11 ++++++++++-
 t/perf/perf-lib.sh              |    4 ++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/t/perf/p0000-perf-lib-sanity.sh b/t/perf/p0000-perf-lib-sanity.sh
index f8dd536..cf8e1ef 100755
--- a/t/perf/p0000-perf-lib-sanity.sh
+++ b/t/perf/p0000-perf-lib-sanity.sh
@@ -38,9 +38,18 @@ test_expect_success 'test_export works with weird vars' '
 	test "$bar" = "weird # variable"
 '
 
+test_perf 'important variables available in subshells' '
+	test -n "$HOME" &&
+	test -n "$TEST_DIRECTORY" &&
+	test -n "$TRASH_DIRECTORY" &&
+	test -n "$GIT_BUILD_DIR"
+'
+
 test_perf 'test-lib-functions correctly loaded in subshells' '
 	: >a &&
-	test_path_is_file a
+	test_path_is_file a &&
+	: >b &&
+	test_cmp a b
 '
 
 test_done
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index bcc0131..5580c22 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -45,6 +45,10 @@ TEST_NO_CREATE_REPO=t
 
 . ../test-lib.sh
 
+# Variables from test-lib that are normally internal to the tests; we
+# need to export them for test_perf subshells
+export TEST_DIRECTORY TRASH_DIRECTORY GIT_BUILD_DIR GIT_TEST_CMP
+
 perf_results_dir=$TEST_OUTPUT_DIRECTORY/test-results
 mkdir -p "$perf_results_dir"
 rm -f "$perf_results_dir"/$(basename "$0" .sh).subtests
-- 
1.7.9.3.556.g7eb2d

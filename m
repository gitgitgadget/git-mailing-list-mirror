From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 10/11] perf: implement a test-selection feature
Date: Mon, 12 Mar 2012 17:27:28 +0100
Message-ID: <b21f1ec0d40a38be53040d182933ed2935bbcfc9.1331561353.git.trast@student.ethz.ch>
References: <cover.1331561353.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 17:27:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S785z-0006I3-Al
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 17:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155Ab2CLQ1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 12:27:34 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:29865 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177Ab2CLQ1d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 12:27:33 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 17:27:29 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 17:27:30 +0100
X-Mailer: git-send-email 1.7.10.rc0.230.g16d90
In-Reply-To: <cover.1331561353.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192893>

When bisecting for a performance regression, there is usually no point
in running all tests in the pNNNN-foo.sh file, since you are
interested only in the result of a single test.

Make GIT_PERF_TEST_ONLY=pNNNN.I select only the test NNNN.I for
running.  All other test_perf blocks are skipped.  test_expect_success
blocks are deliberately not affected; presumably they consist of setup
code.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/perf/perf-lib.sh |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index bfc2926..ddb3272 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -153,7 +153,11 @@ test_perf () {
 	test "$#" = 2 ||
 	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
 	export test_prereq
-	if ! test_skip "$@"
+	skipping=
+	test_skip "$@" && skipping=t
+	test -z "$GIT_PERF_TEST_ONLY" ||
+	test "$GIT_PERF_TEST_ONLY" = $this_test.$test_count || skipping=t
+	if test -z "$skipping"
 	then
 		base=$(basename "$0" .sh)
 		echo "$test_count" >>"$perf_results_dir"/$base.subtests
-- 
1.7.10.rc0.230.g16d90

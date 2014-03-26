From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] t/perf-lib: factor boilerplate out of test_perf
Date: Wed, 26 Mar 2014 03:22:33 -0400
Message-ID: <20140326072232.GA32193@sigill.intra.peff.net>
References: <20140326072215.GA31739@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Maurer <bmaurer@fb.com>, Siddharth Agarwal <sid0@fb.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 08:22:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSiAZ-00056n-T5
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 08:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbaCZHWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 03:22:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:47382 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751394AbaCZHWe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 03:22:34 -0400
Received: (qmail 14477 invoked by uid 102); 26 Mar 2014 07:22:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Mar 2014 02:22:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2014 03:22:33 -0400
Content-Disposition: inline
In-Reply-To: <20140326072215.GA31739@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245162>

About half of test_perf() is boilerplate, and half is
actually related to running the perf test. Let's split it
into two functions, so that we can reuse the boilerplate in
future commits.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/perf-lib.sh | 61 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index a8c9574..20f306a 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -150,8 +150,8 @@ exit $ret' >&3 2>&4
 	return "$eval_ret"
 }
 
-
-test_perf () {
+test_wrapper_ () {
+	test_wrapper_func_=$1; shift
 	test_start_
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
@@ -162,35 +162,44 @@ test_perf () {
 		base=$(basename "$0" .sh)
 		echo "$test_count" >>"$perf_results_dir"/$base.subtests
 		echo "$1" >"$perf_results_dir"/$base.$test_count.descr
-		if test -z "$verbose"; then
-			printf "%s" "perf $test_count - $1:"
-		else
-			echo "perf $test_count - $1:"
-		fi
-		for i in $(test_seq 1 $GIT_PERF_REPEAT_COUNT); do
-			say >&3 "running: $2"
-			if test_run_perf_ "$2"
-			then
-				if test -z "$verbose"; then
-					printf " %s" "$i"
-				else
-					echo "* timing run $i/$GIT_PERF_REPEAT_COUNT:"
-				fi
+		base="$perf_results_dir"/"$perf_results_prefix$(basename "$0" .sh)"."$test_count"
+		"$test_wrapper_func_" "$@"
+	fi
+
+	test_finish_
+}
+
+test_perf_ () {
+	if test -z "$verbose"; then
+		printf "%s" "perf $test_count - $1:"
+	else
+		echo "perf $test_count - $1:"
+	fi
+	for i in $(test_seq 1 $GIT_PERF_REPEAT_COUNT); do
+		say >&3 "running: $2"
+		if test_run_perf_ "$2"
+		then
+			if test -z "$verbose"; then
+				printf " %s" "$i"
 			else
-				test -z "$verbose" && echo
-				test_failure_ "$@"
-				break
+				echo "* timing run $i/$GIT_PERF_REPEAT_COUNT:"
 			fi
-		done
-		if test -z "$verbose"; then
-			echo " ok"
 		else
-			test_ok_ "$1"
+			test -z "$verbose" && echo
+			test_failure_ "$@"
+			break
 		fi
-		base="$perf_results_dir"/"$perf_results_prefix$(basename "$0" .sh)"."$test_count"
-		"$TEST_DIRECTORY"/perf/min_time.perl test_time.* >"$base".times
+	done
+	if test -z "$verbose"; then
+		echo " ok"
+	else
+		test_ok_ "$1"
 	fi
-	test_finish_
+	"$TEST_DIRECTORY"/perf/min_time.perl test_time.* >"$base".times
+}
+
+test_perf () {
+	test_wrapper_ test_perf_ "$@"
 }
 
 # We extend test_done to print timings at the end (./run disables this
-- 
1.9.1.601.g7ec968e

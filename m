Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AED31F954
	for <e@80x24.org>; Fri, 17 Aug 2018 20:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeHRAAB (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 20:00:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:59264 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728332AbeHRAAB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 20:00:01 -0400
Received: (qmail 8786 invoked by uid 109); 17 Aug 2018 20:55:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Aug 2018 20:55:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28442 invoked by uid 111); 17 Aug 2018 20:55:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 17 Aug 2018 16:55:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Aug 2018 16:55:06 -0400
Date:   Fri, 17 Aug 2018 16:55:06 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/6] t/perf: factor boilerplate out of test_perf
Message-ID: <20180817205506.GA20088@sigill.intra.peff.net>
References: <20180817205427.GA19580@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180817205427.GA19580@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

About half of test_perf() is boilerplate preparing to run
_any_ test, and the other half is specifically running a
timing test. Let's split it into two functions, so that we
can reuse the boilerplate in future commits.

Signed-off-by: Jeff King <peff@peff.net>
---
Best viewed with "-w".

 t/perf/perf-lib.sh | 61 ++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index e4c343a6b7..a54be09516 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -179,8 +179,8 @@ exit $ret' >&3 2>&4
 	return "$eval_ret"
 }
 
-
-test_perf () {
+test_wrapper_ () {
+	test_wrapper_func_=$1; shift
 	test_start_
 	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
 	test "$#" = 2 ||
@@ -191,35 +191,44 @@ test_perf () {
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
2.18.0.1205.g3878b1e64a


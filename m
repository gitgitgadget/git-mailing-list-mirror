Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55C820248
	for <e@80x24.org>; Fri, 15 Mar 2019 06:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfCOGPe (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 02:15:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:52004 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728050AbfCOGPe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 02:15:34 -0400
Received: (qmail 16064 invoked by uid 109); 15 Mar 2019 06:15:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Mar 2019 06:15:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29597 invoked by uid 111); 15 Mar 2019 06:14:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Mar 2019 02:14:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Mar 2019 02:14:17 -0400
Date:   Fri, 15 Mar 2019 02:14:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] perf-lib.sh: rely on test-lib.sh for --tee handling
Message-ID: <20190315061416.GA13068@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since its inception, the perf-lib.sh script has manually handled the
"--tee" option (and other options which imply it, like "--valgrind")
with a cut-and-pasted block from test-lib.sh. That block has grown stale
over the years, and has at least three problems:

  1. It uses $SHELL to re-exec the script, whereas the version in
     test-lib.sh learned to use $TEST_SHELL_PATH.

  2. It does an ad-hoc search of the "$*" string, whereas test-lib.sh
     learned to carefully parse the arguments left to right.

  3. It never learned about --verbose-log (which also implies --tee),
     so it would not trigger for that option.

This last one was especially annoying, because t/perf/run uses the
GIT_TEST_OPTS from your config.mak to run the perf scripts. So if you've
set, say, "-x --verbose-log" there, it will be passed as part of most
perf runs. And while this script doesn't recognize the option, the
test-lib.sh that we source _does_, and the behavior ends up being much
more annoying:

  - as the comment at the top of the block says, we have to run this
    tee code early, before we start munging variables (it says
    GIT_BUILD_DIR, but the problematic variable is actually
    GIT_TEST_INSTALLED).

  - since we don't recognize --verbose-log, we don't trigger the block.
    We go on to munge GIT_TEST_INSTALLED, converting it from a relative
    to an absolute path.

  - then we source test-lib.sh, which _does_ recognize --verbose-log. It
    re-execs the script, which runs again. But this time with an
    absolute version of GIT_TEST_INSTALLED.

  - As a result, we copy the absolute version of GIT_TEST_INSTALLED into
    perf_results_prefix. Instead of writing our results to the expected
    "test-results/build_1234abcd.p1234-whatever.times", we instead write
    them to "test-results/_full_path_to_repo_t_perf_build_1234...".

    The aggregate.perl script doesn't expect this, and so it prints
    "<missing>" for each result (even though it spent considerable time
    running the tests!).

We can solve all of these in one blow by just deleting our custom
handling, and relying on the inclusion of test-lib.sh to handle --tee,
--verbose-log, etc.

There's one catch, though. We want to handle GIT_TEST_INSTALLED after
we've included test-lib.sh, since we want it un-munged in the re-exec'd
version of the script. But if we want to convert it from a relative
to an absolute path, we must do so before we load test-lib.sh, since it
will change our working directory. So we compute the absolute directory
first, store it away, then include test-lib.sh, and finally assign to
GIT_TEST_INSTALLED as appropriate.

Signed-off-by: Jeff King <peff@peff.net>
---
This has been bugging me for months, so I finally tracked it down
earlier today.

I recommend viewing the diff with "--color-moved".

 t/perf/perf-lib.sh | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 2e33ab3ec3..169f92eae3 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -17,37 +17,25 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see http://www.gnu.org/licenses/ .
 
-# do the --tee work early; it otherwise confuses our careful
-# GIT_BUILD_DIR mangling
-case "$GIT_TEST_TEE_STARTED, $* " in
-done,*)
-	# do not redirect again
-	;;
-*' --tee '*|*' --va'*)
-	mkdir -p test-results
-	BASE=test-results/$(basename "$0" .sh)
-	(GIT_TEST_TEE_STARTED=done ${SHELL-sh} "$0" "$@" 2>&1;
-	 echo $? > $BASE.exit) | tee $BASE.out
-	test "$(cat $BASE.exit)" = 0
-	exit
-	;;
-esac
-
+# These variables must be set before the inclusion of test-lib.sh below,
+# because it will change our working directory.
 TEST_DIRECTORY=$(pwd)/..
 TEST_OUTPUT_DIRECTORY=$(pwd)
-if test -z "$GIT_TEST_INSTALLED"; then
-	perf_results_prefix=
-else
-	perf_results_prefix=$(printf "%s" "${GIT_TEST_INSTALLED%/bin-wrappers}" | tr -c "[a-zA-Z0-9]" "[_*]")"."
-	# make the tested dir absolute
-	GIT_TEST_INSTALLED=$(cd "$GIT_TEST_INSTALLED" && pwd)
-fi
+ABSOLUTE_GIT_TEST_INSTALLED=$(
+	test -n "$GIT_TEST_INSTALLED" && cd "$GIT_TEST_INSTALLED" && pwd)
 
 TEST_NO_CREATE_REPO=t
 TEST_NO_MALLOC_CHECK=t
 
 . ../test-lib.sh
 
+if test -z "$GIT_TEST_INSTALLED"; then
+	perf_results_prefix=
+else
+	perf_results_prefix=$(printf "%s" "${GIT_TEST_INSTALLED%/bin-wrappers}" | tr -c "[a-zA-Z0-9]" "[_*]")"."
+	GIT_TEST_INSTALLED=$ABSOLUTE_GIT_TEST_INSTALLED
+fi
+
 # Variables from test-lib that are normally internal to the tests; we
 # need to export them for test_perf subshells
 export TEST_DIRECTORY TRASH_DIRECTORY GIT_BUILD_DIR GIT_TEST_CMP
-- 
2.21.0.543.g90eed137f3

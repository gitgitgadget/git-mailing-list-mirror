Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E94001F453
	for <e@80x24.org>; Thu,  2 May 2019 22:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfEBWYL (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 18:24:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:47430 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726022AbfEBWYL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 18:24:11 -0400
Received: (qmail 22670 invoked by uid 109); 2 May 2019 22:24:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 May 2019 22:24:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6281 invoked by uid 111); 2 May 2019 22:24:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 May 2019 18:24:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 May 2019 18:24:09 -0400
Date:   Thu, 2 May 2019 18:24:09 -0400
From:   Jeff King <peff@peff.net>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: js/partial-clone-connectivity-check (was: What's cooking in
 git.git (Apr 2019, #05; Thu, 25))
Message-ID: <20190502222409.GA15631@sigill.intra.peff.net>
References: <xmqqsgu6wfv9.fsf@gitster-ct.c.googlers.com>
 <20190425221657.GV60888@google.com>
 <20190502025206.GA25395@sigill.intra.peff.net>
 <20190502214509.GA19188@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190502214509.GA19188@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 02, 2019 at 05:45:09PM -0400, Jeff King wrote:

> Here's what I came up with. Note that there's a bug in 'master' right
> now which causes perf to produce nonsense results. It's due to my
> 0baf78e7bc (perf-lib.sh: rely on test-lib.sh for --tee handling,
> 2019-03-15). I'll fix that separately (the timing below is done with
> that commit reverted).

And here's the fix for that. It's rather subtle, so I hope I explained
it sufficiently. I didn't notice it while working on the original
because everything _appears_ to run fine, but you just get timings from
the wrong version of Git. Which is only noticeable if you're literally
testing two versions that you expect to differ.

-- >8 --
Subject: [PATCH] t/perf: set GIT_TEST_INSTALLED before including test-lib.sh

Commit 0baf78e7bc (perf-lib.sh: rely on test-lib.sh for --tee handling,
2019-03-15) introduced a bug which causes perf test runs to always find
git in the $PATH, rather than actually testing $GIT_TEST_INSTALLED
(which is used by the "run" script).

That commit bumped the conversion of $GIT_TEST_INSTALLED to an absolute
path until after test-lib.sh was been included. That solved the original
problem of generating a bogus $perf_results_prefix value from the
absolute path. But it introduced a new one: test-lib.sh needs to see
that absolute value because it will put it at the front of the $PATH.

The root of the issue is that we need both the relative and the absolute
paths available. That earlier commit chose to stuff the absolute path
into $ABSOLUTE_GIT_TEST_INSTALLED, keep the relative one in
$GIT_TEST_INSTALLED, and then resolve the two after test-lib.sh has been
loaded. We can fix it by reversing our strategy: we'll keep the absolute
path in $GIT_TEST_INSTALLED, drop our now-useless ABSOLUTE variable, and
introduce a new $TEST_INSTALLED_ORIG variable to hold the original value
(from which we will later derive the prefix).

Note that we need to export our ORIG variable because the whole point of
0baf78e7bc is that test-lib.sh may actually re-exec a new copy of the
script to handle tee-ing the output.

I'd hoped to add a test to p0000-perf-lib-sanity to cover this, but the
bug is actually outside that scope. It triggers if you do something
like:

  cat >t/perf/p1234-foo.sh <<-\EOF
  #!/bin/sh
  test_description=debugging
  . ./perf-lib.sh
  test_expect_success 'version' 'which git && git version'
  test_perf 'fake timing' 'true'
  test_done
  EOF

  chmod +x t/perf/p1234-foo.sh
  make GIT_TEST_OPTS=--verbose-log
  cd t/perf
  ./run origin p1234-foo.sh
  cat test-results/p1234-foo.out

Without this patch, you'll see that we're running whatever git is in
your $PATH, not the one from "origin". With this patch, we should see:

  - the correct git is run

  - we get timing results out of ./run, showing that the prefix bug from
    0baf78e7bc was not regressed

  - our values make it across the script re-exec due to --verbose-log

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/perf-lib.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 169f92eae3..8317dbef44 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -21,7 +21,11 @@
 # because it will change our working directory.
 TEST_DIRECTORY=$(pwd)/..
 TEST_OUTPUT_DIRECTORY=$(pwd)
-ABSOLUTE_GIT_TEST_INSTALLED=$(
+
+# Likewise we must turn GIT_TEST_INSTALLED into an absolute path; but remember
+# and export the original value, since we'll later generate our prefix from it.
+: ${TEST_INSTALLED_ORIG=$GIT_TEST_INSTALLED}; export TEST_INSTALLED_ORIG
+GIT_TEST_INSTALLED=$(
 	test -n "$GIT_TEST_INSTALLED" && cd "$GIT_TEST_INSTALLED" && pwd)
 
 TEST_NO_CREATE_REPO=t
@@ -32,8 +36,7 @@ TEST_NO_MALLOC_CHECK=t
 if test -z "$GIT_TEST_INSTALLED"; then
 	perf_results_prefix=
 else
-	perf_results_prefix=$(printf "%s" "${GIT_TEST_INSTALLED%/bin-wrappers}" | tr -c "[a-zA-Z0-9]" "[_*]")"."
-	GIT_TEST_INSTALLED=$ABSOLUTE_GIT_TEST_INSTALLED
+	perf_results_prefix=$(printf "%s" "${TEST_INSTALLED_ORIG%/bin-wrappers}" | tr -c "[a-zA-Z0-9]" "[_*]")"."
 fi
 
 # Variables from test-lib that are normally internal to the tests; we
-- 
2.21.0.1314.g224b191707


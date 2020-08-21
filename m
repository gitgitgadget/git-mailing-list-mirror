Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A15C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0E220724
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHURxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:53:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:37290 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgHURxl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 13:53:41 -0400
Received: (qmail 18987 invoked by uid 109); 21 Aug 2020 17:53:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 17:53:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30107 invoked by uid 111); 21 Aug 2020 17:53:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 13:53:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 13:53:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] p5302: disable thread-count parameter tests by default
Message-ID: <20200821175339.GA3263141@coredump.intra.peff.net>
References: <20200821175153.GA3263018@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200821175153.GA3263018@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The primary function of the perf suite is to detect regressions (or
improvements) between versions of Git. The only numbers we show a direct
comparison for are timings between the same test run on two different
versions.

However, it can sometimes be used to collect other information.  For
instance, p5302 runs the same index-pack operation with different thread
counts. The output doesn't directly compare these, but anybody
interested in working on index-pack can manually compare the results.

For a normal regression run of the full perf-suite, though, this incurs
a significant cost to generate numbers nobody will actually look at;
about 25% of the total time of the test suite is spent in p5302. And the
low-thread-count runs are the most expensive part of it, since they're
(unsurprisingly) not using as many threads.

Let's skip these tests by default, but make it possible for people
working on index-pack to still run them by setting an environment
variable. Rather than make this specific to p5302, let's introduce a
generic mechanism. This makes it possible to run the full suite with
every possible test if somebody really wants to burn some CPU.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/README              |  9 +++++++++
 t/perf/p5302-pack-index.sh | 10 +++++-----
 t/perf/perf-lib.sh         |  2 ++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/t/perf/README b/t/perf/README
index c7b70e2d28..bd649afa97 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -84,6 +84,15 @@ You can set the following variables (also in your config.mak):
 	probably be about linux.git size for optimal results.
 	Both default to the git.git you are running from.
 
+    GIT_PERF_EXTRA
+	Boolean to enable additional tests. Most test scripts are
+	written to detect regressions between two versions of Git, and
+	the output will compare timings for individual tests between
+	those versions. Some scripts have additional tests which are not
+	run by default, that show patterns within a single version of
+	Git (e.g., performance of index-pack as the number of threads
+	changes). These can be enabled with GIT_PERF_EXTRA.
+
 You can also pass the options taken by ordinary git tests; the most
 useful one is:
 
diff --git a/t/perf/p5302-pack-index.sh b/t/perf/p5302-pack-index.sh
index a9b3e112d9..23011ab739 100755
--- a/t/perf/p5302-pack-index.sh
+++ b/t/perf/p5302-pack-index.sh
@@ -13,31 +13,31 @@ test_expect_success 'repack' '
 	export PACK
 '
 
-test_perf 'index-pack 0 threads' '
+test_perf PERF_EXTRA 'index-pack 0 threads' '
 	rm -rf repo.git &&
 	git init --bare repo.git &&
 	GIT_DIR=repo.git git index-pack --threads=1 --stdin < $PACK
 '
 
-test_perf 'index-pack 1 thread ' '
+test_perf PERF_EXTRA 'index-pack 1 thread ' '
 	rm -rf repo.git &&
 	git init --bare repo.git &&
 	GIT_DIR=repo.git GIT_FORCE_THREADS=1 git index-pack --threads=1 --stdin < $PACK
 '
 
-test_perf 'index-pack 2 threads' '
+test_perf PERF_EXTRA 'index-pack 2 threads' '
 	rm -rf repo.git &&
 	git init --bare repo.git &&
 	GIT_DIR=repo.git git index-pack --threads=2 --stdin < $PACK
 '
 
-test_perf 'index-pack 4 threads' '
+test_perf PERF_EXTRA 'index-pack 4 threads' '
 	rm -rf repo.git &&
 	git init --bare repo.git &&
 	GIT_DIR=repo.git git index-pack --threads=4 --stdin < $PACK
 '
 
-test_perf 'index-pack 8 threads' '
+test_perf PERF_EXTRA 'index-pack 8 threads' '
 	rm -rf repo.git &&
 	git init --bare repo.git &&
 	GIT_DIR=repo.git git index-pack --threads=8 --stdin < $PACK
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 13e389367a..821581a885 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -245,3 +245,5 @@ test_at_end_hook_ () {
 test_export () {
 	export "$@"
 }
+
+test_lazy_prereq PERF_EXTRA 'test_bool_env GIT_PERF_EXTRA false'
-- 
2.28.0.694.g07780f7063


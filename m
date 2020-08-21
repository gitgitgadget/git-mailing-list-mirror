Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3B4C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3859820702
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHURyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:54:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:37296 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgHURyw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 13:54:52 -0400
Received: (qmail 19001 invoked by uid 109); 21 Aug 2020 17:54:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 17:54:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30147 invoked by uid 111); 21 Aug 2020 17:54:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 13:54:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 13:54:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] p5302: count up to online-cpus for thread tests
Message-ID: <20200821175451.GB3263141@coredump.intra.peff.net>
References: <20200821175153.GA3263018@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200821175153.GA3263018@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When PERF_EXTRA is enabled, p5302 checks the performance of index-pack
with various numbers of threads. This can be useful for deciding what
the default should be (which is currently capped at 3 threads based on
the results of this script).

However, we only go up to 8 threads, and modern machines may have more.
Let's get the number of CPUs from test-tool, and test various numbers of
threads between one and that maximum.

Note that the current tests aren't all identical, as we have to set
GIT_FORCE_THREADS for the --threads=1 test (which measures the overhead
of starting a single worker thread versus the "0" case of using the main
thread). To keep the loop simple, we'll keep the "0" case out of it, and
set GIT_FORCE_THREADS=1 for all of the other cases (it's a noop for all
but the "1" case, since numbers higher than 1 would always need
threads).

Note also that we could skip running "test-tool" if PERF_EXTRA isn't
set. However, there's some small value in knowing the number of threads,
so that we can mark each test as skipped in the output.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/p5302-pack-index.sh | 47 +++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/t/perf/p5302-pack-index.sh b/t/perf/p5302-pack-index.sh
index 23011ab739..228593d9ad 100755
--- a/t/perf/p5302-pack-index.sh
+++ b/t/perf/p5302-pack-index.sh
@@ -13,35 +13,36 @@ test_expect_success 'repack' '
 	export PACK
 '
 
-test_perf PERF_EXTRA 'index-pack 0 threads' '
-	rm -rf repo.git &&
-	git init --bare repo.git &&
-	GIT_DIR=repo.git git index-pack --threads=1 --stdin < $PACK
+# Rather than counting up and doubling each time, count down from the endpoint,
+# halving each time. That ensures that our final test uses as many threads as
+# CPUs, even if it isn't a power of 2.
+test_expect_success 'set up thread-counting tests' '
+	t=$(test-tool online-cpus) &&
+	threads= &&
+	while test $t -gt 0
+	do
+		threads="$t $threads"
+		t=$((t / 2))
+	done
 '
 
-test_perf PERF_EXTRA 'index-pack 1 thread ' '
-	rm -rf repo.git &&
-	git init --bare repo.git &&
-	GIT_DIR=repo.git GIT_FORCE_THREADS=1 git index-pack --threads=1 --stdin < $PACK
-'
-
-test_perf PERF_EXTRA 'index-pack 2 threads' '
-	rm -rf repo.git &&
-	git init --bare repo.git &&
-	GIT_DIR=repo.git git index-pack --threads=2 --stdin < $PACK
-'
-
-test_perf PERF_EXTRA 'index-pack 4 threads' '
+test_perf PERF_EXTRA 'index-pack 0 threads' '
 	rm -rf repo.git &&
 	git init --bare repo.git &&
-	GIT_DIR=repo.git git index-pack --threads=4 --stdin < $PACK
+	GIT_DIR=repo.git git index-pack --threads=1 --stdin < $PACK
 '
 
-test_perf PERF_EXTRA 'index-pack 8 threads' '
-	rm -rf repo.git &&
-	git init --bare repo.git &&
-	GIT_DIR=repo.git git index-pack --threads=8 --stdin < $PACK
-'
+for t in $threads
+do
+	THREADS=$t
+	export THREADS
+	test_perf PERF_EXTRA "index-pack $t threads" '
+		rm -rf repo.git &&
+		git init --bare repo.git &&
+		GIT_DIR=repo.git GIT_FORCE_THREADS=1 \
+		git index-pack --threads=$THREADS --stdin <$PACK
+	'
+done
 
 test_perf 'index-pack default number of threads' '
 	rm -rf repo.git &&
-- 
2.28.0.694.g07780f7063


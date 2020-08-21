Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5E3C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9293320702
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgHUR6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:58:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:37308 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgHUR6r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 13:58:47 -0400
Received: (qmail 19034 invoked by uid 109); 21 Aug 2020 17:58:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 17:58:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30264 invoked by uid 111); 21 Aug 2020 17:58:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 13:58:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 13:58:45 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] p5302: count up to online-cpus for thread tests
Message-ID: <20200821175845.GA3263218@coredump.intra.peff.net>
References: <20200821175153.GA3263018@coredump.intra.peff.net>
 <20200821175451.GB3263141@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200821175451.GB3263141@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 01:54:51PM -0400, Jeff King wrote:

>  t/perf/p5302-pack-index.sh | 47 +++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 23 deletions(-)

I meant to generate this diff with --patience, which is much more
readable:

diff --git a/t/perf/p5302-pack-index.sh b/t/perf/p5302-pack-index.sh
index 23011ab739..228593d9ad 100755
--- a/t/perf/p5302-pack-index.sh
+++ b/t/perf/p5302-pack-index.sh
@@ -13,35 +13,36 @@ test_expect_success 'repack' '
 	export PACK
 '
 
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
+'
+
 test_perf PERF_EXTRA 'index-pack 0 threads' '
 	rm -rf repo.git &&
 	git init --bare repo.git &&
 	GIT_DIR=repo.git git index-pack --threads=1 --stdin < $PACK
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
-	rm -rf repo.git &&
-	git init --bare repo.git &&
-	GIT_DIR=repo.git git index-pack --threads=4 --stdin < $PACK
-'
-
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


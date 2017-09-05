Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17E6F208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 13:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbdIENEH (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 09:04:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:57292 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751160AbdIENEG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 09:04:06 -0400
Received: (qmail 2053 invoked by uid 109); 5 Sep 2017 13:04:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 13:04:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12741 invoked by uid 111); 5 Sep 2017 13:04:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 09:04:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 09:04:04 -0400
Date:   Tue, 5 Sep 2017 09:04:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/10] test-lib: set LSAN_OPTIONS to abort by default
Message-ID: <20170905130404.isih63vmyyxx5aqp@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already set ASAN_OPTIONS to abort if it finds any errors.
As we start to experiment with LSAN, the leak sanitizer,
it's convenient if we give it the same treatment.

Note that ASAN is actually a superset of LSAN and can do the
leak detection itself. So this only has an effect if you
specifically build with "make SANITIZE=leak" (leak detection
but not the rest of ASAN). Building with just LSAN results
in a build that runs much faster. That makes the
build-test-fix cycle more pleasant.

In the long run, once we've fixed or suppressed all the
leaks, it will probably be worth turning leak-detection on
for ASAN and just using that (to check both leaks _and_
memory errors in a single test run). But there's still a lot
of work before we get there.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 62461a6e35..a738540ef2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -44,6 +44,11 @@ GIT_BUILD_DIR="$TEST_DIRECTORY"/..
 : ${ASAN_OPTIONS=detect_leaks=0:abort_on_error=1}
 export ASAN_OPTIONS
 
+# If LSAN is in effect we _do_ want leak checking, but we still
+# want to abort so that we notice the problems.
+: ${LSAN_OPTIONS=abort_on_error=1}
+export LSAN_OPTIONS
+
 ################################################################
 # It appears that people try to run tests without building...
 "$GIT_BUILD_DIR/git" >/dev/null
-- 
2.14.1.721.gc5bc1565f1


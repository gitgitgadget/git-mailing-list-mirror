Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA5120357
	for <e@80x24.org>; Mon, 10 Jul 2017 13:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754100AbdGJNYr (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 09:24:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:35386 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753864AbdGJNYq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 09:24:46 -0400
Received: (qmail 17813 invoked by uid 109); 10 Jul 2017 13:24:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 13:24:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5045 invoked by uid 111); 10 Jul 2017 13:24:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 09:24:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jul 2017 09:24:39 -0400
Date:   Mon, 10 Jul 2017 09:24:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/5] test-lib: turn on ASan abort_on_error by default
Message-ID: <20170710132438.euiamhjgqzkzkefg@sigill.intra.peff.net>
References: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default, ASan will exit with code 1 when it sees an
error. This means we'll notice a problem when we expected
git to succeed, but not in a test_must_fail block.

Let's ask it to actually raise SIGABRT instead. That will
give us a signal death that test_must_fail will notice. As a
bonus, it may also leave a coredump, which can be handy for
digging into a failure.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 961194a50..1b6e53f78 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -41,7 +41,7 @@ GIT_BUILD_DIR="$TEST_DIRECTORY"/..
 # the noise level. This needs to happen at the start of the script,
 # before we even do our "did we build git yet" check (since we don't
 # want that one to complain to stderr).
-: ${ASAN_OPTIONS=detect_leaks=0}
+: ${ASAN_OPTIONS=detect_leaks=0:abort_on_error=1}
 export ASAN_OPTIONS
 
 ################################################################
-- 
2.13.2.1071.gcd8104b61


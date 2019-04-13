Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C97020248
	for <e@80x24.org>; Sat, 13 Apr 2019 05:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfDMFwU (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 01:52:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:57176 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726175AbfDMFwT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 01:52:19 -0400
Received: (qmail 27695 invoked by uid 109); 13 Apr 2019 05:52:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Apr 2019 05:52:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12564 invoked by uid 111); 13 Apr 2019 05:52:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 13 Apr 2019 01:52:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Apr 2019 01:52:18 -0400
Date:   Sat, 13 Apr 2019 01:52:18 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 1/7] t5516: drop ok=sigpipe from unreachable-want tests
Message-ID: <20190413055217.GA19495@sigill.intra.peff.net>
References: <20190413055127.GA32340@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190413055127.GA32340@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We annotated our test_must_fail calls in 8bf4becf0c (add "ok=sigpipe" to
test_must_fail and use it to fix flaky tests, 2015-11-27) because the
abrupt hangup of the server meant that we'd sometimes fail on read() and
sometimes get SIGPIPE on write().

But since 143588949c (fetch: ignore SIGPIPE during network operation,
2019-03-03), we make sure that we end up with a real die(), and our
tests no longer need to work around the race.

Signed-off-by: Jeff King <peff@peff.net>
---
This is actually the only user of ok=sigpipe, so we could drop the
feature. It might come in handy later, though.

 t/t5516-fetch-push.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 37e8e80893..fc3961ec22 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1232,15 +1232,15 @@ do
 		mk_empty shallow &&
 		(
 			cd shallow &&
-			test_must_fail ok=sigpipe git fetch ../testrepo/.git $SHA1_3 &&
-			test_must_fail ok=sigpipe git fetch ../testrepo/.git $SHA1_1 &&
+			test_must_fail git fetch ../testrepo/.git $SHA1_3 &&
+			test_must_fail git fetch ../testrepo/.git $SHA1_1 &&
 			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
 			git fetch ../testrepo/.git $SHA1_1 &&
 			git cat-file commit $SHA1_1 &&
 			test_must_fail git cat-file commit $SHA1_2 &&
 			git fetch ../testrepo/.git $SHA1_2 &&
 			git cat-file commit $SHA1_2 &&
-			test_must_fail ok=sigpipe git fetch ../testrepo/.git $SHA1_3
+			test_must_fail git fetch ../testrepo/.git $SHA1_3
 		)
 	'
 done
-- 
2.21.0.931.gd0bc72a411


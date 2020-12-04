Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314D8C2BB48
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 18:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF5222CA1
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 18:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgLDSvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 13:51:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:51782 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730277AbgLDSvF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 13:51:05 -0500
Received: (qmail 31751 invoked by uid 109); 4 Dec 2020 18:50:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Dec 2020 18:50:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13990 invoked by uid 111); 4 Dec 2020 18:50:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Dec 2020 13:50:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Dec 2020 13:50:23 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 3/9] t0064: make duplicate tests more robust
Message-ID: <X8qE762PqN8svc9H@coredump.intra.peff.net>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our tests for handling duplicates in oid-array provide only a single
duplicate for each number, so our sorted array looks like:

  44 44 55 55 88 88 aa aa

A slightly more interesting test is to have multiple duplicates, which
makes sure that we not only skip the duplicate, but keep skipping until
we are out of the set of matching duplicates.

Unsurprisingly this works just fine, but it's worth beefing up this test
since we're about to change the duplicate-detection code.

Note that we do need to adjust the results on the lookup test, since it
is returning the index of the found item (and now we have more items
before our range, and the range itself is slightly larger, since we'll
accept a match of any element).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0064-oid-array.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t0064-oid-array.sh b/t/t0064-oid-array.sh
index 71034a8007..2e5438ccda 100755
--- a/t/t0064-oid-array.sh
+++ b/t/t0064-oid-array.sh
@@ -25,6 +25,7 @@ test_expect_success 'ordered enumeration' '
 test_expect_success 'ordered enumeration with duplicate suppression' '
 	echoid "" 44 55 88 aa >expect &&
 	{
+		echoid append 88 44 aa 55 &&
 		echoid append 88 44 aa 55 &&
 		echoid append 88 44 aa 55 &&
 		echo for_each_unique
@@ -52,17 +53,19 @@ test_expect_success 'lookup non-existing entry' '
 
 test_expect_success 'lookup with duplicates' '
 	{
+		echoid append 88 44 aa 55 &&
 		echoid append 88 44 aa 55 &&
 		echoid append 88 44 aa 55 &&
 		echoid lookup 55
 	} | test-tool oid-array >actual &&
 	n=$(cat actual) &&
-	test "$n" -ge 2 &&
-	test "$n" -le 3
+	test "$n" -ge 3 &&
+	test "$n" -le 5
 '
 
 test_expect_success 'lookup non-existing entry with duplicates' '
 	{
+		echoid append 88 44 aa 55 &&
 		echoid append 88 44 aa 55 &&
 		echoid append 88 44 aa 55 &&
 		echoid lookup 66
-- 
2.29.2.896.g080220a959


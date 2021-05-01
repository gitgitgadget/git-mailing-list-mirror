Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441C2C433B4
	for <git@archiver.kernel.org>; Sat,  1 May 2021 14:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED4661494
	for <git@archiver.kernel.org>; Sat,  1 May 2021 14:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhEAOEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 10:04:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:42042 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232174AbhEAOEw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 10:04:52 -0400
Received: (qmail 26399 invoked by uid 109); 1 May 2021 14:04:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 May 2021 14:04:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10069 invoked by uid 111); 1 May 2021 14:04:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 May 2021 10:04:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 May 2021 10:04:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Yiyuan guo <yguoaz@gmail.com>
Subject: [PATCH 4/5] t5316: check behavior of pack-objects --depth=0
Message-ID: <YI1f0NesWZFqh9O2@coredump.intra.peff.net>
References: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We'd expect this to cleanly produce no deltas at all (as opposed to
getting confused by an out-of-bounds value), and it does.

Note we have to adjust our max_chain test helper, which expected to find
at least one delta.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5316-pack-delta-depth.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index a8c1bc0f66..3e84df4137 100755
--- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -69,6 +69,7 @@ test_expect_success 'create series of packs' '
 max_chain() {
 	git index-pack --verify-stat-only "$1" >output &&
 	perl -lne '
+	  BEGIN { $len = 0 }
 	  /chain length = (\d+)/ and $len = $1;
 	  END { print $len }
 	' output
@@ -94,4 +95,11 @@ test_expect_success '--depth limits depth' '
 	test_cmp expect actual
 '
 
+test_expect_success '--depth=0 disables deltas' '
+	pack=$(git pack-objects --all --depth=0 </dev/null pack) &&
+	echo 0 >expect &&
+	max_chain pack-$pack.pack >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.31.1.875.g5dccece0aa


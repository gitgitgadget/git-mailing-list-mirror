Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 334411F404
	for <e@80x24.org>; Thu, 30 Aug 2018 07:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeH3LK3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 07:10:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:33546 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726169AbeH3LK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 07:10:28 -0400
Received: (qmail 11745 invoked by uid 109); 30 Aug 2018 07:09:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 07:09:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24272 invoked by uid 111); 30 Aug 2018 07:09:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 03:09:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 03:09:45 -0400
Date:   Thu, 30 Aug 2018 03:09:45 -0400
From:   Jeff King <peff@peff.net>
To:     Jann Horn <jannh@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 3/5] patch-delta: fix oob read
Message-ID: <20180830070944.GC15420@sigill.intra.peff.net>
References: <20180830070548.GA15081@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180830070548.GA15081@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jann Horn <jannh@google.com>

If `cmd` is in the range [0x01,0x7f] and `cmd > top-data`, the
`memcpy(out, data, cmd)` can copy out-of-bounds data from after `delta_buf`
into `dst_buf`.

This is not an exploitable bug because triggering the bug increments the
`data` pointer beyond `top`, causing the `data != top` sanity check after
the loop to trigger and discard the destination buffer - which means that
the result of the out-of-bounds read is never used for anything.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 patch-delta.c                         | 2 +-
 t/t5303-pack-corruption-resilience.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/patch-delta.c b/patch-delta.c
index 56e0a5ede2..b937afd2c9 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -56,7 +56,7 @@ void *patch_delta(const void *src_buf, unsigned long src_size,
 			out += cp_size;
 			size -= cp_size;
 		} else if (cmd) {
-			if (cmd > size)
+			if (cmd > size || cmd > top - data)
 				break;
 			memcpy(out, data, cmd);
 			out += cmd;
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 912e659acf..7114c31ade 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -341,7 +341,7 @@ test_expect_success \
 # \0 - empty base
 # \2 - two bytes in result
 # \2 - two literal bytes (we are short one)
-test_expect_failure \
+test_expect_success \
     'apply delta with too few literal bytes' \
     'printf "\0\2\2X" > truncated_delta &&
      test_must_fail test-tool delta -p /dev/null truncated_delta /dev/null'
-- 
2.19.0.rc1.539.g3876d0831e


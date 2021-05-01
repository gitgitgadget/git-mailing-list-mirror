Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9B2C433ED
	for <git@archiver.kernel.org>; Sat,  1 May 2021 14:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D2B614A7
	for <git@archiver.kernel.org>; Sat,  1 May 2021 14:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhEAOE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 10:04:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:42034 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232200AbhEAOE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 10:04:28 -0400
Received: (qmail 26391 invoked by uid 109); 1 May 2021 14:03:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 May 2021 14:03:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10050 invoked by uid 111); 1 May 2021 14:03:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 May 2021 10:03:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 May 2021 10:03:37 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Yiyuan guo <yguoaz@gmail.com>
Subject: [PATCH 3/5] pack-objects: clamp negative window size to 0
Message-ID: <YI1fubjvQQlrPz9D@coredump.intra.peff.net>
References: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A negative window size makes no sense, and the code in find_deltas() is
not prepared to handle it. If you pass "-1", for example, we end up
generate a 0-length array of "struct unpacked", but our loop assumes it
has at least one entry in it (and we end up reading garbage memory).

We could complain to the user about this, but it's more forgiving to
just clamp it to 0, which means "do not find any deltas at all". The
0-case is already tested earlier in the script, so we'll make sure this
does the same thing.

Reported-by: Yiyuan guo <yguoaz@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 2 ++
 t/t5300-pack-object.sh | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6d13cd3e1a..ea7a5b3ba5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3871,6 +3871,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			(1U << OE_Z_DELTA_BITS) - 1);
 		cache_max_small_delta_size = (1U << OE_Z_DELTA_BITS) - 1;
 	}
+	if (window < 0)
+		window = 0;
 
 	strvec_push(&rp, "pack-objects");
 	if (thin) {
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 887e2d8d88..5c5e53f0be 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -613,4 +613,9 @@ test_expect_success '--stdin-packs with broken links' '
 	)
 '
 
+test_expect_success 'negative window clamps to 0' '
+	git pack-objects --progress --window=-1 neg-window <obj-list 2>stderr &&
+	check_deltas stderr = 0
+'
+
 test_done
-- 
2.31.1.875.g5dccece0aa


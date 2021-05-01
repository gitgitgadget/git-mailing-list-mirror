Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C4FC433B4
	for <git@archiver.kernel.org>; Sat,  1 May 2021 14:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF1E61490
	for <git@archiver.kernel.org>; Sat,  1 May 2021 14:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhEAOF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 10:05:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:42052 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhEAOFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 10:05:25 -0400
Received: (qmail 26409 invoked by uid 109); 1 May 2021 14:04:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 May 2021 14:04:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10087 invoked by uid 111); 1 May 2021 14:04:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 May 2021 10:04:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 May 2021 10:04:34 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Yiyuan guo <yguoaz@gmail.com>
Subject: [PATCH 5/5] pack-objects: clamp negative depth to 0
Message-ID: <YI1f8jKReuE3LXVH@coredump.intra.peff.net>
References: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A negative delta depth makes no sense, and the code is not prepared to
handle it. If passed "--depth=-1" on the command line, then this line
from break_delta_chains():

	cur->depth = (total_depth--) % (depth + 1);

triggers a divide-by-zero. This is undefined behavior according to the C
standard, but on POSIX systems results in SIGFPE killing the process.
This is certainly one way to inform the use that the command was
invalid, but it's a bit friendlier to just treat it as "don't allow any
deltas", which we already do for --depth=0.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c      | 2 ++
 t/t5316-pack-delta-depth.sh | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ea7a5b3ba5..da5e0700f9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3861,6 +3861,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (pack_to_stdout != !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
 
+	if (depth < 0)
+		depth = 0;
 	if (depth >= (1 << OE_DEPTH_BITS)) {
 		warning(_("delta chain depth %d is too deep, forcing %d"),
 			depth, (1 << OE_DEPTH_BITS) - 1);
diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index 3e84df4137..759169d074 100755
--- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -102,4 +102,11 @@ test_expect_success '--depth=0 disables deltas' '
 	test_cmp expect actual
 '
 
+test_expect_success 'negative depth disables deltas' '
+	pack=$(git pack-objects --all --depth=-1 </dev/null pack) &&
+	echo 0 >expect &&
+	max_chain pack-$pack.pack >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.31.1.875.g5dccece0aa

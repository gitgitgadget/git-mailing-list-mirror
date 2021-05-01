Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED99C433ED
	for <git@archiver.kernel.org>; Sat,  1 May 2021 14:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A2561490
	for <git@archiver.kernel.org>; Sat,  1 May 2021 14:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhEAOER (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 10:04:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:42028 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232200AbhEAOEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 10:04:16 -0400
Received: (qmail 26382 invoked by uid 109); 1 May 2021 14:03:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 May 2021 14:03:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10033 invoked by uid 111); 1 May 2021 14:03:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 May 2021 10:03:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 May 2021 10:03:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Yiyuan guo <yguoaz@gmail.com>
Subject: [PATCH 2/5] t5300: check that we produced expected number of deltas
Message-ID: <YI1frTcgfGb6GA3N@coredump.intra.peff.net>
References: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We pack a set of objects both with and without --window=0, assuming that
the 0-length window will cause us not to produce any deltas. Let's
confirm that this is the case.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5300-pack-object.sh | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 1e10c832a6..887e2d8d88 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -34,8 +34,22 @@ test_expect_success 'setup' '
 	} >expect
 '
 
+# usage: check_deltas <stderr_from_pack_objects> <cmp_op> <nr_deltas>
+# e.g.: check_deltas stderr -gt 0
+check_deltas() {
+	deltas=$(perl -lne '/delta (\d+)/ and print $1' "$1") &&
+	shift &&
+	if ! test "$deltas" "$@"
+	then
+		echo >&2 "unexpected number of deltas (compared $delta $*)"
+		return 1
+	fi
+}
+
 test_expect_success 'pack without delta' '
-	packname_1=$(git pack-objects --window=0 test-1 <obj-list)
+	packname_1=$(git pack-objects --progress --window=0 test-1 \
+			<obj-list 2>stderr) &&
+	check_deltas stderr = 0
 '
 
 test_expect_success 'pack-objects with bogus arguments' '
@@ -62,15 +76,18 @@ test_expect_success 'unpack without delta' '
 '
 
 test_expect_success 'pack with REF_DELTA' '
-	packname_2=$(git pack-objects test-2 <obj-list)
+	packname_2=$(git pack-objects --progress test-2 <obj-list 2>stderr) &&
+	check_deltas stderr -gt 0
 '
 
 test_expect_success 'unpack with REF_DELTA' '
 	check_unpack test-2-${packname_2}
 '
 
 test_expect_success 'pack with OFS_DELTA' '
-	packname_3=$(git pack-objects --delta-base-offset test-3 <obj-list)
+	packname_3=$(git pack-objects --progress --delta-base-offset test-3 \
+			<obj-list 2>stderr) &&
+	check_deltas stderr -gt 0
 '
 
 test_expect_success 'unpack with OFS_DELTA' '
-- 
2.31.1.875.g5dccece0aa


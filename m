Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE3A820323
	for <e@80x24.org>; Wed, 22 Mar 2017 17:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965037AbdCVRPr (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 13:15:47 -0400
Received: from siwi.pair.com ([209.68.5.199]:47957 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964811AbdCVRPH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 13:15:07 -0400
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A8AD0846BC;
        Wed, 22 Mar 2017 13:14:50 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 6/6] name-hash: add perf test for lazy_init_name_hash
Date:   Wed, 22 Mar 2017 17:14:25 +0000
Message-Id: <1490202865-31325-7-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1490202865-31325-1-git-send-email-git@jeffhostetler.com>
References: <1490202865-31325-1-git-send-email-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Created t/perf/p0004-lazy-init-name-hash.sh test
to demonstrate correctness and performance gains
with the multithreaded version of lazy_init_name_hash().

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p0004-lazy-init-name-hash.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 t/perf/p0004-lazy-init-name-hash.sh

diff --git a/t/perf/p0004-lazy-init-name-hash.sh b/t/perf/p0004-lazy-init-name-hash.sh
new file mode 100644
index 0000000..5afa8c8
--- /dev/null
+++ b/t/perf/p0004-lazy-init-name-hash.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='Tests multi-threaded lazy_init_name_hash'
+. ./perf-lib.sh
+
+test_perf_large_repo
+test_checkout_worktree
+
+test_expect_success 'verify both methods build the same hashmaps' '
+	$GIT_BUILD_DIR/t/helper/test-lazy-init-name-hash$X --dump --single | sort >out.single &&
+	$GIT_BUILD_DIR/t/helper/test-lazy-init-name-hash$X --dump --multi  | sort >out.multi  &&
+	test_cmp out.single out.multi
+'
+
+test_expect_success 'multithreaded should be faster' '
+	$GIT_BUILD_DIR/t/helper/test-lazy-init-name-hash$X --perf >out.perf
+'
+
+test_done
-- 
2.7.4


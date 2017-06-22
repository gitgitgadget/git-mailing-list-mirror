Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 633D620802
	for <e@80x24.org>; Thu, 22 Jun 2017 20:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752741AbdFVUg1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 16:36:27 -0400
Received: from siwi.pair.com ([209.68.5.199]:20243 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752149AbdFVUgX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 16:36:23 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 36E2B84597;
        Thu, 22 Jun 2017 16:36:23 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9A8CC8458F;
        Thu, 22 Jun 2017 16:36:22 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        jrnieder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 3/3] pack-objects: add t5317 to test max-blob-size
Date:   Thu, 22 Jun 2017 20:36:15 +0000
Message-Id: <20170622203615.34135-4-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170622203615.34135-1-git@jeffhostetler.com>
References: <20170622203615.34135-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t5317-pack-objects-blob-filtering.sh | 68 ++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 t/t5317-pack-objects-blob-filtering.sh

diff --git a/t/t5317-pack-objects-blob-filtering.sh b/t/t5317-pack-objects-blob-filtering.sh
new file mode 100644
index 0000000..58124ab
--- /dev/null
+++ b/t/t5317-pack-objects-blob-filtering.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+
+test_description='pack-objects blob filtering'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	printf "%10s"   X >x10.txt   &&
+	printf "%100s"  X >x100.txt  &&
+	printf "%1000s" X >x1000.txt &&
+	git add *.txt &&
+	git commit -m txt
+'
+
+test_expect_success 'all blobs' '
+	test_when_finished "rm -f *.pack *.idx" &&
+	git pack-objects --revs --thin --stdout >z.pack <<-EOF &&
+	master
+
+	EOF
+	git index-pack z.pack &&
+	test 3 = $(git verify-pack -v z.pack | grep blob | wc -l)
+'
+
+test_expect_success 'no blobs (max equals 0)' '
+	test_when_finished "rm -f *.pack *.idx" &&
+	git pack-objects --revs --thin --stdout --max-blob-size=0 >z.pack <<-EOF &&
+	master
+
+	EOF
+	git index-pack z.pack &&
+	test 0 = $(git verify-pack -v z.pack | grep blob | wc -l)
+'
+
+test_expect_success 'small 20 blobs' '
+	test_when_finished "rm -f *.pack *.idx" &&
+	git pack-objects --revs --thin --stdout --max-blob-size=20 >z.pack <<-EOF &&
+	master
+
+	EOF
+	git index-pack z.pack &&
+	test 1 = $(git verify-pack -v z.pack | grep blob | wc -l)
+'
+
+test_expect_success 'small 200 blobs' '
+	test_when_finished "rm -f *.pack *.idx" &&
+	git pack-objects --revs --thin --stdout --max-blob-size=200 >z.pack <<-EOF &&
+	master
+
+	EOF
+	git index-pack z.pack &&
+	test 2 = $(git verify-pack -v z.pack | grep blob | wc -l)
+'
+
+test_expect_success 'special files always present' '
+	test_when_finished "rm -f *.pack *.idx" &&
+	cp x1000.txt .gitignore &&
+	git add .gitignore &&
+	git commit -m "add ignores" &&
+	git pack-objects --revs --stdout --max-blob-size=0 >z.pack <<-EOF &&
+	master
+
+	EOF
+	git index-pack z.pack &&
+	test 1 = $(git verify-pack -v z.pack | grep blob | wc -l)
+'
+
+test_done
-- 
2.9.3


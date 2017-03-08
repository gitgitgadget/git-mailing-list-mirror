Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66EF0202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 17:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbdCHRqM (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 12:46:12 -0500
Received: from siwi.pair.com ([209.68.5.199]:10647 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754070AbdCHRqI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 12:46:08 -0500
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1CAFD8460B;
        Wed,  8 Mar 2017 12:38:34 -0500 (EST)
From:   Jeff Hostetler <jeffhost@microsoft.com>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, peff@peff.net, gitster@pobox.com,
        markbt@efaref.net, benpeart@microsoft.com,
        jonathantanmy@google.com, Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH 03/10] pack-objects: test for --partial-by-size --partial-special
Date:   Wed,  8 Mar 2017 17:37:58 +0000
Message-Id: <1488994685-37403-4-git-send-email-jeffhost@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
References: <1488994685-37403-1-git-send-email-jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <git@jeffhostetler.com>

Some simple tests for pack-objects with the new --partial-by-size
and --partial-special options.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/5316-pack-objects-partial.sh | 72 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 t/5316-pack-objects-partial.sh

diff --git a/t/5316-pack-objects-partial.sh b/t/5316-pack-objects-partial.sh
new file mode 100644
index 0000000..352de34
--- /dev/null
+++ b/t/5316-pack-objects-partial.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+
+test_description='pack-object partial'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	perl -e "print \"a\" x 11;"      > a &&
+	perl -e "print \"a\" x 1100;"    > b &&
+	perl -e "print \"a\" x 1100000;" > c &&
+	echo "ignored"                   > .gitignore &&
+	git add a b c .gitignore &&
+	git commit -m test
+	'
+
+test_expect_success 'all blobs' '
+	git pack-objects --revs --thin --stdout >all.pack <<-EOF &&
+	master
+	
+	EOF
+	git index-pack all.pack &&
+	test 4 = $(git verify-pack -v all.pack | grep blob | wc -l)
+	'
+
+test_expect_success 'no blobs' '
+	git pack-objects --revs --thin --stdout --partial-by-size=0 >none.pack <<-EOF &&
+	master
+	
+	EOF
+	git index-pack none.pack &&
+	test 0 = $(git verify-pack -v none.pack | grep blob | wc -l)
+	'
+
+test_expect_success 'small blobs' '
+	git pack-objects --revs --thin --stdout --partial-by-size=1M >small.pack <<-EOF &&
+	master
+	
+	EOF
+	git index-pack small.pack &&
+	test 3 = $(git verify-pack -v small.pack | grep blob | wc -l)
+	'
+
+test_expect_success 'tiny blobs' '
+	git pack-objects --revs --thin --stdout --partial-by-size=100 >tiny.pack <<-EOF &&
+	master
+	
+	EOF
+	git index-pack tiny.pack &&
+	test 2 = $(git verify-pack -v tiny.pack | grep blob | wc -l)
+	'
+
+test_expect_success 'special' '
+	git pack-objects --revs --thin --stdout --partial-special >spec.pack <<-EOF &&
+	master
+	
+	EOF
+	git index-pack spec.pack &&
+	test 1 = $(git verify-pack -v spec.pack | grep blob | wc -l)
+	'
+
+test_expect_success 'union' '
+	git pack-objects --revs --thin --stdout --partial-by-size=0 --partial-special >union.pack <<-EOF &&
+	master
+	
+	EOF
+	git index-pack union.pack &&
+	test 1 = $(git verify-pack -v union.pack | grep blob | wc -l)
+	'
+
+test_done
+
+
-- 
2.7.4


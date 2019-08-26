Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E86D1F4B7
	for <e@80x24.org>; Mon, 26 Aug 2019 01:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfHZBoQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 21:44:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58312 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729064AbfHZBoP (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Aug 2019 21:44:15 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AA6D06081F;
        Mon, 26 Aug 2019 01:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566783850;
        bh=FfLfvtTNME7iELnEARnT73jkhI72fgAEvL/e/thv4GQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=HJqTvTwn9Vkb3lHtDXAQNwZRD22TkUu9kGif1sfumP/QtqSaKn6cZPypvgE5UrRCh
         yRWcYGbwPgcA5H7zDNaufdgIBTUVmIt6QywW+p8wfwuD8Wqp/0iqULSsNktT9GfEHo
         4JfHhCRhjVGBHiuANE9PlrDgedyMfzTZV0g3qxvhQk2TzI4vbTl5BR7/ouJCz+0U3W
         NADqlJEWYjIFmpV61haiPonvIw3iBTWKN3nGhge0QvgRizOANET5vwjTBxjk6fx6fB
         uqG9ZVbinAYST7xjoKcn+3VR7/TnHeafQxPVJYcf6Z0af42bC7n1zDZTn7rEwwtC/3
         6Myf27J184kMIGyQTE/jTgbywKFUATwFJiBaxshgVYrefpP1jpSaNxwFJzT+Yh8nI8
         6YkliKU+MKdQNsM+X6TE4oO1xqjDpddqeJqdW8X1y9geFpOrgA238OVCTj810WcjK1
         n7V8Y+DiAlSiVfYH+DxQ9BMov1Toq+gk8PVaSkk21/UdHoBIhoS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 09/14] t3600: make hash size independent
Date:   Mon, 26 Aug 2019 01:43:39 +0000
Message-Id: <20190826014344.16008-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c
In-Reply-To: <20190826014344.16008-1-sandals@crustytoothpaste.net>
References: <20190818191646.868106-1-sandals@crustytoothpaste.net>
 <20190826014344.16008-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding a fixed length invalid object ID in the test,
compute one using the lookup tables.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t3600-rm.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 66282a720e..8c8cca5bfb 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -240,12 +240,14 @@ test_expect_success 'refresh index before checking if it is up-to-date' '
 '
 
 test_expect_success 'choking "git rm" should not let it die with cruft' '
+	test_oid_init &&
 	git reset -q --hard &&
 	test_when_finished "rm -f .git/index.lock && git reset -q --hard" &&
 	i=0 &&
+	hash=$(test_oid deadbeef) &&
 	while test $i -lt 12000
 	do
-		echo "100644 1234567890123456789012345678901234567890 0	some-file-$i"
+		echo "100644 $hash 0	some-file-$i"
 		i=$(( $i + 1 ))
 	done | git update-index --index-info &&
 	git rm -n "some-file-*" | : &&

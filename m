Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AACFC433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36EDF207F5
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cE9d1PJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgG2XPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:15:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41106 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728068AbgG2XO7 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:14:59 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 70B9560CF8;
        Wed, 29 Jul 2020 23:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064494;
        bh=0rZwVYByh93rzh2MXxDDxKGY/t0UNSFe48Aet59nKXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=cE9d1PJ9dIpmRxBoZypf2A+QIOB9BekyksnSC1nhzeVCbAohUjlUT3DBKAPOucS3k
         e4pJ23W8h3NcRrX2ht/cJI1Y06wGmcrU/18XhbmQikTMk4BafzYi+KVKn5e8s1/js+
         9XzEYw+w5yslAVHk8JZ+X9k6cRhlZLkKNSW25ZOBEAdKe/IJzOzcivPC8IeFFRqLZB
         Sl8777g2t1crr6sHtX1BrmYRpn5+Nvy3SmhVBNpzmErMG32fJ+K7EjDn2HGTFT/8fP
         TwOWubimykQGtcE8IqVFTuCWq6Ei3L9nVEQV9xRKnZ2bcPezp3jA70iQpPNjhNCXzr
         JB9hs7e829ffGkOQWQzqiigLxh46v/8eLYgGKepgHOE6QZbUqhli6wIUDRK28oKlDg
         Y/sCJWAfJoJQqliCw/OSj0mQDyXi1VdWS2QTO8zrMwK6PbyFT53PTg7PGFrILe6p6G
         85VCgpG9XeGT15jpDSozBJSLFl1iIoAvE17JthPzlR7Hgvtnkrk
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 19/39] t8003: make hash size independent
Date:   Wed, 29 Jul 2020 23:14:08 +0000
Message-Id: <20200729231428.3658647-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200729231428.3658647-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One assertion in this test invokes git with core.abbrev set to "40".
Since we're expecting the full hash length, use test_oid to look up the
full hash length for the hash in use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t8003-blame-corner-cases.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 9130b887d2..b871dd4f86 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -6,7 +6,6 @@ test_description='git blame corner cases'
 pick_fc='s/^[0-9a-f^]* *\([^ ]*\) *(\([^ ]*\) .*/\1-\2/'
 
 test_expect_success setup '
-
 	echo A A A A A >one &&
 	echo B B B B B >two &&
 	echo C C C C C >tres &&
@@ -306,7 +305,7 @@ test_expect_success 'blame coalesce' '
 	$oid 1) ABC
 	$oid 2) DEF
 	EOF
-	git -c core.abbrev=40 blame -s giraffe >actual &&
+	git -c core.abbrev=$(test_oid hexsz) blame -s giraffe >actual &&
 	test_cmp expect actual
 '
 

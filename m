Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C8DC433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0336320663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Nn4rRquZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgGJCt0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:49:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40426 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726989AbgGJCsf (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:35 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E420F60A6C;
        Fri, 10 Jul 2020 02:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349312;
        bh=ESSekoAdRTmOfsf7qIhpt9ZyM67fkWjpVvr9uTkNfYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Nn4rRquZaRFUG7WGwfyEzxm1xi8GBQb7tKwrwl9oIyISaoONPSqpMXBd81EEEeAAJ
         At1TNGQstTy3f/cOH8yGXEjbsBQ1puUwjmiTFHhmvpE/5lP1yzZb1j63YL0Z+SV+jL
         FKcHDblVfndAd+N1gGJ26UMy5FZeuYhNaqEbePUrHy5uEazP8WBK/NIdEs46ihiNYr
         74o3kzsfwZ/PctmVizaDl9ruAk8T42P4oufnnLr8jD6bUB0C2r+GW/ckyPYfVgP3Ho
         xqdi1U6gmvWQ6OPpIhaOr2giAutlzAUqW1h4OX+cgZ2lTAebxzHKgMMxOXp0fMFGzw
         /J2COLSMRS4Jo15txAkKLVSyAnlo4Xfhlxb6f1rzCrzbKgIKOjZcDD+O2TdD23ySL6
         Og0bmJ4vcn9NWe0BnZpBca51ZIvEghJPutH6F4HZ5SvKLlaTC4KMcPmwhrsl9raJjm
         Ue9cFHPycQS1m0h2m0+jiT4YhowPOrZdIjgFmUktn/CoOlQwliA
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 19/38] t8003: make hash size independent
Date:   Fri, 10 Jul 2020 02:47:09 +0000
Message-Id: <20200710024728.3100527-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
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
 t/t8003-blame-corner-cases.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 9130b887d2..ebe79aa4ea 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -6,6 +6,7 @@ test_description='git blame corner cases'
 pick_fc='s/^[0-9a-f^]* *\([^ ]*\) *(\([^ ]*\) .*/\1-\2/'
 
 test_expect_success setup '
+	test_oid_init &&
 
 	echo A A A A A >one &&
 	echo B B B B B >two &&
@@ -306,7 +307,7 @@ test_expect_success 'blame coalesce' '
 	$oid 1) ABC
 	$oid 2) DEF
 	EOF
-	git -c core.abbrev=40 blame -s giraffe >actual &&
+	git -c core.abbrev=$(test_oid hexsz) blame -s giraffe >actual &&
 	test_cmp expect actual
 '
 

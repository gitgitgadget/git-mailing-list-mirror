Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F56C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50367206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="y8VJHQbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfLUTuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:12 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41996 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbfLUTuK (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:10 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8C32D607F0;
        Sat, 21 Dec 2019 19:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957809;
        bh=ctRtF2cpQuHnjVmGoIZ146ZqSUvJVPK+ogRBQsCcJRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=y8VJHQbtYMuoT11/G7/K/7H0KqJlCgY8pIVYDj/eHUXoB9LOkj333agA61bjysp9x
         1/vuUy8h1TdRs2AVZl6OUeI/UZERS5LF2L8lw/luFSxJXVQby99oiqICYug9n603xR
         L/ZwocUfPgqMDVxokk5vdgXb10TGh1099Wl/iGSBykxTbEVyreKK7LXdowXqwinX+D
         DZlSzC50U5NVzCLYmZBoAwWH6kwTiFdOzm4VNTBy6gaaoskdcTQt66kT0xgN+LCLGA
         z5Xh/X+ce7/uHO5xqy3gk7hvsRzUwgoElRkrDRYTBE0+vEJJHif1ee6s4ey2O08Htz
         wTr8SdRlvzeQeGtwdj1baywuLJunt+1fg+URRMokBEelCGKMgPgiMy1oWwRAg2vcNk
         gH3pIK6rT7oY42lA0DK0EHrx5MxLs0d304/QAtF8hcGUuu66LcdmM9wUBIZ7MWP5O/
         yrvRVp3E8w3j4Tkw2eOHpCroUR9SkEXWL3Efl+/8WMyzPvM94kY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/20] t5319: change invalid offset for SHA-256 compatibility
Date:   Sat, 21 Dec 2019 19:49:25 +0000
Message-Id: <20191221194936.1346664-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using SHA-1, the existing value of the byte we use is 0x13, so
writing the byte 0x07 serves to corrupt the test and verify that we
detect corruption.  However, when we use SHA-256, the value at that
offset is already 0x07, so our "corruption" doesn't work and the test
fails to detect it.

To provide a value that is truly out of range, let's use 0xff, which is
not likely to be a valid value as the high byte of a two-byte offset in
a multi-pack index this small.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5319-multi-pack-index.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index cd2f87be6a..464bb68e89 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -304,12 +304,12 @@ test_expect_success 'verify incorrect pack-int-id' '
 '
 
 test_expect_success 'verify incorrect offset' '
-	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\07" $objdir \
+	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
 		"incorrect object offset"
 '
 
 test_expect_success 'git-fsck incorrect offset' '
-	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\07" $objdir \
+	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
 		"incorrect object offset" \
 		"git -c core.multipackindex=true fsck"
 '

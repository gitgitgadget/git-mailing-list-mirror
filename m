Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14174C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD0482067D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NhGA1U5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgG2XOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:14:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41044 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727982AbgG2XOu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:14:50 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1E24460CF7;
        Wed, 29 Jul 2020 23:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064489;
        bh=4yUyHUGcTTGJafaEdWJ+tuJICjfgkfRNJwqrlsFsu6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=NhGA1U5r8sEy5Pg+MANk4d1lcRqsps2XnKasbH0Uz3oi/QFfkGdb6msycrJjFXCmm
         jQ4qUQpG8C0DVhvVTEkVXVjBQEsu2VXWIbmAQRkIN8eSzu/Dr2/cmvOyNr+ZGybmeJ
         cKmGM71fw/RYqUvdCkDTDAHjJbVhVTc+yyHWgddlW+nidfMGKr87Zr3RZ6eKsT4M+Z
         fBA6rkKPg9bXMX22pCOJWcY4yeVivBZ/4vsjaB0cyLJFRXXVpdqLJJOeNbziQpDEq0
         j1LMXEQ801/l70JTrnJ9MkXG0maeGnCd5f1gyUfmkxvjPdRw9P8y4MxciVO+iUN2XT
         vHTelO7vgbJajyveIC/8AQ16i+tuJ1nGMdXOWNYdCi+vg7RDXWfJheCYvr+nmCUd/o
         cZD8TXItxyzw3kXPadD9F8Kbtp1v0ybXMIdCH8JPWiQB1ca8tWV+//wf6iiP5C5HfL
         3dBmOOa7w17vJSwyiJ+nm4gHDH5ZaIsTMBOtfuVt1EHNqgbhgl9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 07/39] t6301: make hash size independent
Date:   Wed, 29 Jul 2020 23:13:56 +0000
Message-Id: <20200729231428.3658647-8-sandals@crustytoothpaste.net>
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

Instead of hard-coding a fixed length example object ID in the test,
compute one using the translation tables.  Move a variable into the
setup block so that we can ensure the exit status of test_oid is
checked.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6301-for-each-ref-errors.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index 49cc65bb58..809854fc0c 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -5,9 +5,9 @@ test_description='for-each-ref errors for broken refs'
 . ./test-lib.sh
 
 ZEROS=$ZERO_OID
-MISSING=abababababababababababababababababababab
 
 test_expect_success setup '
+	MISSING=$(test_oid deadbeef) &&
 	git commit --allow-empty -m "Initial" &&
 	git tag testtag &&
 	git for-each-ref >full-list &&

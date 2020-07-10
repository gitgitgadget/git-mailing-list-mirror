Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBF0C433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF0F20663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NiVo6+ba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgGJCtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:49:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40484 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727837AbgGJCtE (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:49:04 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 568BF60A60;
        Fri, 10 Jul 2020 02:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349312;
        bh=nz4+OtGq3fE7rGU2uzYwanb+xiaiZY8Q9Rnalz28LGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=NiVo6+ba3B3PD/SWEiziSXU9qAJyqMhgTZc+HkQf9SssO+wTOQ2ZLqZ/spcDc9h9+
         po/5bKW0uHPNZwQDbS54VTaJMLPt9jwru5FCLOprtChSfZYMcyLDZvOty7EU2JlOL0
         z8UIHM8pjb5TVe0ESDdiu4VaDrqEQZ7pPNZ+kN1gNHC389l+DNGbbPkPdwDsfZChhY
         V1UyMx9K4wbVXy4kjLqE1tRK+0GIcNsq7MXROxX/UElNtE4jYG3JLz2FzJYdOow4Yq
         UXVHx1zn62RP/3uzEx+sw92Gsfz6aY8vaJDNxe0Yz/6oNg62u7h9DETGP2NpfBIqHe
         Zizqn4anIoJSfPOLQgJObMcm/SQ5BZoMTLNvUNc2YD7AWd2zTrRKR/XqNFoGjbYraG
         vxzwXacT/yM1AL8I//i01d+XSBaSONOS8QB0++QlKXBP1Hw9tnhfG69MUAjqpqSyGQ
         WR3bfle9f0MiQq37mALvsdkbN2nUkIF5qpW96zuXSGmxOQRlSf2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 20/38] t8011: make hash size independent
Date:   Fri, 10 Jul 2020 02:47:10 +0000
Message-Id: <20200710024728.3100527-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow lines which start with either a 40- or 64-character hex object ID,
to allow for both SHA-1 and SHA-256.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t8011-blame-split-file.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t8011-blame-split-file.sh b/t/t8011-blame-split-file.sh
index 831125047b..8a4626d496 100755
--- a/t/t8011-blame-split-file.sh
+++ b/t/t8011-blame-split-file.sh
@@ -54,7 +54,7 @@ test_expect_success 'setup simulated porcelain' '
 	cat >read-porcelain.pl <<-\EOF
 	my $field = shift;
 	while (<>) {
-		if (/^[0-9a-f]{40} /) {
+		if (/^[0-9a-f]{40,64} /) {
 			flush();
 			$hash = $&;
 		} elsif (/^$field (.*)/) {

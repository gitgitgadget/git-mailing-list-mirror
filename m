Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D636C43446
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9599206D9
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 02:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lWhs6i0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgGMCtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:49:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40624 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727098AbgGMCt1 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Jul 2020 22:49:27 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E91B560A62;
        Mon, 13 Jul 2020 02:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594608566;
        bh=GOwWURZWcS80hrBtH5tnhZJpLhQbfrdP5Wk4iblxXNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=lWhs6i0evMquUux9chEZKkMSaAlQwwgkTjLA1mvc48xmQ4s1mTsc/Fj+Cj0FjYaAo
         7fHH6LJN0H8BVBpWPuPwMYLPxVPnJk01cgkL+3a6KRflFuRdOQJjeUMghpSKvSgNs5
         l10XReNXwdZyMn+LP6+BaH1tmfahIqYQFxyPJ5h5x9Z9sW+DiXam+A9qscJ/Gp6Na4
         QnQt2A6ZnWVFB2GMcPdsrlaoVnPj2X+Eu7If5bwokputvL0eRbvfnt9AQxeiR6SSWu
         NeM+7Pkusb43kdf7UCVwRaIeXZskcT59b3TpKNy6zHKl8/t4w8S+aVmfd3ekrn/bKD
         ic8y+wCrZ/f2QCADM52Dm3NfbGMgOy+sPQE1KxfM13z63uyL8WDXx/ORe21GIB0ZaV
         sLj1pVf9I7Biz6kcwqFvJojMhMNP1LXBKzjZ6WcWE36YLpl5RaaRa4D+KUSi3wNdtm
         zKnUcUWlcP+QflYyeD7oKJUjua5Z6QETcwjcsTNFbLLIhC7KmKj
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 07/39] t6301: make hash size independent
Date:   Mon, 13 Jul 2020 02:48:37 +0000
Message-Id: <20200713024909.3714837-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
References: <20200713024909.3714837-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding a fixed length example object ID in the test,
compute one using the translation tables.  Move a variable into the
setup block so that we can ensure the exit status of test_oid_init is
checked.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6301-for-each-ref-errors.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index 49cc65bb58..d545a725a5 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -5,9 +5,10 @@ test_description='for-each-ref errors for broken refs'
 . ./test-lib.sh
 
 ZEROS=$ZERO_OID
-MISSING=abababababababababababababababababababab
 
 test_expect_success setup '
+	test_oid_init &&
+	MISSING=$(test_oid deadbeef) &&
 	git commit --allow-empty -m "Initial" &&
 	git tag testtag &&
 	git for-each-ref >full-list &&

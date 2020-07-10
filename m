Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0752C433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 774E620772
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="S2DQKgLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgGJCse (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:48:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40368 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726774AbgGJCs2 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:28 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B149D60A5C;
        Fri, 10 Jul 2020 02:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349306;
        bh=GOwWURZWcS80hrBtH5tnhZJpLhQbfrdP5Wk4iblxXNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=S2DQKgLBUFzsGgofQL4kuE9pGsrxlnmvGI4PSnmoI313SJysD+n9roY7qpTg6sQ63
         valo/EPljvyx/pjdaPNFY0F3ql2JFczH7LBlSFntOQZbdNw4BQzo41Zzs4F1tDFWOb
         IAFBOU8jRvTypA7hKBQTlhMVL0GSK4z8IujMhUi0Qi5YLHoMcFBnLn2wMbb6Rkf8t6
         y8z55QI4d4cJWZ2CjcEuXIr4r9+zddyZ9YJkaGGHDt7M9VbEqY16Pdi9HTAkqsIan7
         b5FHQezSoCRRQhqtLfYZwr//pyX5tdMqIvBWzkxtd4NSAl5D1WJ+7jY1G7NLrOE9BM
         4ebWcTQqwykEVaasCbxJ7cFuY5GDgoHfb7lCNbPZW42IjqQ/+k4TAIAALH0HFqnkkJ
         L0baZGwDMmb51IIEe2kGE2Viy67niQmUYoEFMWLkx+NuS4OG++/suPwiao7EbZ9NiV
         W4vdSENJg3lHXN5QLns5Ga+XVl2twQyGMitZkDd49R3Ro7lSQPN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 07/38] t6301: make hash size independent
Date:   Fri, 10 Jul 2020 02:46:57 +0000
Message-Id: <20200710024728.3100527-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
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

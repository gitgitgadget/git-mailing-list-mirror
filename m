Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602E3C33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CBC20678
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uGE5JYUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgAMMkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:40:52 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37622 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728734AbgAMMkp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:40:45 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B7B8B60808;
        Mon, 13 Jan 2020 12:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919244;
        bh=UDDWDfHq6vQ4mafDgi/0WqfOho8EmhNcpUk8RRIhlEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=uGE5JYUx19Xt9YSDm0kc13WeujRsOsHeYgs0vS++uSYm3AJ+aayYztKp8FQrRptGJ
         7CTLY84VXY77KWEA8BMzqVNn7EZ8DK9ps6j4q5neo+TnPKhUoV090SWagp/OzY+S+k
         90TV6WrUXE0EiZTpwRoNcBYZ6bhXPpTgMBRFHffb/V/mM1PnSQT3N6G1s5iIfol62q
         kS+RAlZV+ehwS4snhCHZusOfrtegTdikKeBfsSZPGniKD29Fc1Z97nflhvRelW73Zz
         qe107yDL7yHujp13GeFa5xDYnJE+Jd7gNLomVVr8e0K1W2PxYgzUUbL2KDKK+VG9bV
         hnWkHMu9BXkRhXz5M+TnJM3vxxn+UddJPoF7cylNAQhcx/U08gvdMDQEEb/7AUihrl
         Im2squFdB1uEfajcbZ4k5A0yxWSyHE/2tSYutEg9YHb6Qn8i0cfvI0g7fYImKWShj3
         FeDI7bF/ef31h6HZHAeEfB/kTIyZZF7/hNfrwtdAqwZy/vb6Sp3
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 23/24] t6006: make hash size independent
Date:   Mon, 13 Jan 2020 12:38:56 +0000
Message-Id: <20200113123857.3684632-24-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of hard-coding the length of an object ID when creating a tree,
compute it for the hash in use using the translation tables.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6006-rev-list-format.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index ebdc49c496..7e82e43a63 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -32,6 +32,7 @@ changed_iso88591=$(echo "$changed" | iconv -f utf-8 -t $test_encoding)
 truncate_count=20
 
 test_expect_success 'setup' '
+	test_oid_init &&
 	: >foo &&
 	git add foo &&
 	git config i18n.commitEncoding $test_encoding &&
@@ -463,9 +464,10 @@ test_expect_success '--abbrev' '
 '
 
 test_expect_success '%H is not affected by --abbrev-commit' '
+	expected=$(($(test_oid hexsz) + 1)) &&
 	git log -1 --format=%H --abbrev-commit --abbrev=20 HEAD >actual &&
 	len=$(wc -c <actual) &&
-	test $len = 41
+	test $len = $expected
 '
 
 test_expect_success '%h is not affected by --abbrev-commit' '

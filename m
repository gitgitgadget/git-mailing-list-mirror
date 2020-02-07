Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860ECC35247
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B64214AF
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="O982pSV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbgBGAxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:46 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55620 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727477AbgBGAxn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:43 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 23B7760FC9;
        Fri,  7 Feb 2020 00:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036822;
        bh=UDDWDfHq6vQ4mafDgi/0WqfOho8EmhNcpUk8RRIhlEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=O982pSV/SIBuoqFbdE+Rj179B19v6ePwRcWShP/fYzvInNayBm1zbEcXSUMAaMEkz
         3nhLdm+C7wbh4nzoAeDkxcc2ddOaeJaHCCwtW4pHNEuh/3hoasq/JtDcejlEpR842c
         6n4u9SUXZxROuGocJZOuC7f6lVUpMR3q6ieCi50TvFA6qaEhxjS4ysR0aEQ5+J6kJA
         tpCba2c2YsljtLkuqCSxFCcZ5xbEBi4vfEtN1LepW6agPhg/v84c3gugG9vavdqYvN
         n33Gzdfm4kkNWFG+Q5wcXIEVDDAPv4VopzoVrvKcolj84HFE9cC5tH65MALs3aUD5D
         CsbQLnp3lRksWHs8oaiP/O/wOSKHQGT5deTNtJGyarXnYWoPOk7ckulcCCvdNam2s4
         xrf+RFjMeqIr6NLbWFuwWlPFx7S0lS4l5QXCZoMyMHG6LOZwiW+Ykufxe8TsnaCaFh
         +wYG2MybfWdnvjfxKRJPt5KAUNajebw4NgWLTEnozsVPf7Li83B
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 20/21] t6006: make hash size independent
Date:   Fri,  7 Feb 2020 00:52:53 +0000
Message-Id: <20200207005254.1495851-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7
In-Reply-To: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
References: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
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

Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C09BC433ED
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BEEC20715
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="c95WhKxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgGZTyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:54:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40712 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727905AbgGZTyu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:54:50 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A552C60CF6;
        Sun, 26 Jul 2020 19:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793289;
        bh=ESSekoAdRTmOfsf7qIhpt9ZyM67fkWjpVvr9uTkNfYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=c95WhKxYDGMrLocj7Xxs4O8ytyloFqI1GM6CB3UFkN7z5tGLDHsgPFKfD8V96+Pys
         suH51aiE0YZjet7kSg/DUin1FdP3Y5Twb+OWzywAcHedk4tm9QmQUFCqn25B6/5WaZ
         ogw0LthnNvY/HoDJUdETNCPATegEsR53U6iKA/pt56UV69pBhyCQk5PjRbtoV4hVaZ
         LF+qWWNqRLW0J7nuk/1xonI/BIb0H+MUlQ5dZbSjyZDTU9YxtWUoOnwTMxSPp6lnCR
         GuUKr3/N/upZxOIaYXHfM98nhzSC3DnRDkr5zjLeuRC3txaQFcysQwxJo/Ln+HAEmR
         tEshV11LHzaG2oNHwhjxMM9S/b+ZZQo/PU8N9jAPoiv+dp00y+my5tQ/95JcZtMR8E
         9FQABThqVduuiTsz+GM4TxG00Z++ypT09slwOpdnSzXTJ2xuRGwruWUhuzrTRRXHCA
         1iSxLF0diPWE19tH4deS1NEbMfAuPDLFYhMVy53qs9ajYj551HN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 19/39] t8003: make hash size independent
Date:   Sun, 26 Jul 2020 19:54:04 +0000
Message-Id: <20200726195424.626969-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
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
 

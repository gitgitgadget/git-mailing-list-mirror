Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE78AC433EA
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B185D2080D
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fqJ0i1kJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbgGWBKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40488 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733175AbgGWBJ7 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:09:59 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 51B7660AFD
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466598;
        bh=ESSekoAdRTmOfsf7qIhpt9ZyM67fkWjpVvr9uTkNfYg=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=fqJ0i1kJdbrFhtBnavQeYZlaMaFLveFZFHCvcEhLD++31XFwLd9p+30j968rLMD32
         +n1T7pvDs52mj4VXxKpLqpc5dfJi0RDuPjLiU7b0/rKrb9lujwMWT/ekw7ksVvA/R3
         D3+dzrEO6qZg7NCQh1GgxPqLWGb1kpdqPJlwDGlKaAYUWlVOofFgIFaHrajqaZFQe1
         A/wRsO8seZgFZOaHJlHkfzACPPDOPjN6mOcOgxUbHzDq2mkYbQVBCTKDh+YDaCIYjW
         RqHJvK7P88lYFzcu3tcs+dkGW2uFo0EKIqUINfkE+t84/DN0NSySrFvpclC0AqWJS9
         anUQoLHnPzeB/tggi3kVyw9Bald6RTbqWs2PQABcaIJh11LpRIdtAq1fTe3sNck1Gi
         xesz2u25dZAvDh1GtFDayI7FMqK1sc25bopGI4gExH3/UFRlYOXXMVciEcD36FV/ZQ
         bdHSTpWTwsf1cryWJrKDEYk84SQtyq9sewNrHwKI1gRMTSY5+I+
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 19/39] t8003: make hash size independent
Date:   Thu, 23 Jul 2020 01:09:23 +0000
Message-Id: <20200723010943.2329634-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
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
 

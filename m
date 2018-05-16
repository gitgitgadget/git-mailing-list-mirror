Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AB381F406
	for <e@80x24.org>; Wed, 16 May 2018 01:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbeEPB7F (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:59:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47532 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752535AbeEPB7C (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 May 2018 21:59:02 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D9D2D60743;
        Wed, 16 May 2018 01:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526435941;
        bh=tNmE6YX8OIp3qF4zgyIdkeJH75tkcyLNAr3nE8efhx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=1Q+z3io6A0lHmv3DoGpbj5JY19efMozm1IpjEg00CkWg6A7NSpKUavb4mJSDq6cwV
         91xqV2TarpCIGUlwjULvCXRY/0OPJCWsaW56mFxXGCEM1WPWFl0P15GJG4uEbbpEsc
         +Ot9T0ALYLiZmFGCJVegzEvxyn8dGkPYP9aaZFxC+sacAtkB0ORL1FfzLANZj4gEVj
         MqCQaqqfRQzJdRx07rf3dn0AC9iiNjh9+8gTeDv7a0FY6/qfOq1SY2ofKuY3I97FEv
         jxXiNmbT+55/bZ1BnzO3zBxAyHxhOOVnAZ6RFT7nzPQcCBkgXnel1eoGX/JXEyzONC
         30K4ZFEkEGvI+zEq4VnnJn7H/YnlGADOrkFQ84GY8A7Yamkfy9UQ/Y/gHr7MTANghk
         +j+V+t6DB9VTtLR2LyYaStVoIiM1gIEretqRydn4+kYFE6a4Ox4OTQBkxohj6/qHND
         nm48UITYki0HDSOdDoPX114et6TO0mwekhlzDp3mGUAfiPDE77a
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 24/28] t4205: sort log output in a hash-independent way
Date:   Wed, 16 May 2018 01:56:26 +0000
Message-Id: <20180516015630.661349-25-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180516015630.661349-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test enumerates log entries and then sorts them.  For SHA-1, this
produces results that happen to sort in the order specified in the test,
but for other hash algorithms they sort differently.  Ensure we sort the
log entries in a hash-independent way by sorting on the ref name instead
of the object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4205-log-pretty-formats.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 591f35daaf..2052cadb11 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -516,22 +516,22 @@ test_expect_success 'log decoration properly follows tag chain' '
 	git commit --amend -m shorter &&
 	git log --no-walk --tags --pretty="%H %d" --decorate=full >actual &&
 	cat <<-EOF >expected &&
-	$head1  (tag: refs/tags/tag2)
 	$head2  (tag: refs/tags/message-one)
 	$old_head1  (tag: refs/tags/message-two)
+	$head1  (tag: refs/tags/tag2)
 	EOF
-	sort actual >actual1 &&
+	sort -k3 actual >actual1 &&
 	test_cmp expected actual1
 '
 
 test_expect_success 'clean log decoration' '
 	git log --no-walk --tags --pretty="%H %D" --decorate=full >actual &&
 	cat >expected <<-EOF &&
-	$head1 tag: refs/tags/tag2
 	$head2 tag: refs/tags/message-one
 	$old_head1 tag: refs/tags/message-two
+	$head1 tag: refs/tags/tag2
 	EOF
-	sort actual >actual1 &&
+	sort -k3 actual >actual1 &&
 	test_cmp expected actual1
 '
 

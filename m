Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2F6C433E3
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B1EA20809
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XZYmn/t+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgG2XOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:14:52 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41044 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbgG2XOv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:14:51 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 05E0C60CF8;
        Wed, 29 Jul 2020 23:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064490;
        bh=sr50vs5pFG0GIW659uoknF77rj13bj5Saa3bKqfSbco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=XZYmn/t+4bzzozGMaA54BTQvw11ymqtOl8GQ+2pkTVevdJ3tmGEeuBqT3/FG8cyvQ
         cBYDiUpJcONfAhGct4Ll3QbseK63fPgPp+UF2+bMF8BRotID/E436EqioGzqQfeB0Z
         MzeY/GG6aWsLqn4LdpkIy1NQVz2hUM7WLFJf6nH0MLesw+4WqGISXTUDa7OQn+qFja
         mijNKA481c30L+/IZYXtaw/ScocF7ufU8P3x3QaY6Ix46cHcARBTiOqmr0uKKw9v4P
         DCMJ2GKbGXtX/zM0ImZSTT/InNd1sVeT+kDID1d5OKfIj4pSyYwZzmN0KL4rt4vm5s
         mvTtNCPQ0A7sLJO4vuslNF459+artYUQZ7AAiDU1i87R8NKzDX5fiTMwJE7mJGnMS9
         8smIZNTWUbI/Xy+iuaP1RFpZjHqGja2zF4DtP39MqWs8UnSV8Dvb0YkxRumaACCkzP
         OMu8+I5x9aOMJGGAKESy96xMJxinp1V6lBdb320nHWJixRkT0dL
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 09/39] t6501: avoid hard-coded objects
Date:   Wed, 29 Jul 2020 23:13:58 +0000
Message-Id: <20200729231428.3658647-10-sandals@crustytoothpaste.net>
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

This test contains hard-coded invalid object IDs.  Make it hash size
independent by generating invalid object IDs using the translation
tables.  Add a setup target to ensure the output of test_oid_init is
checked properly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t6501-freshen-objects.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index f30b4849b6..8a3bb4105b 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -128,9 +128,9 @@ for repack in '' true; do
 done
 
 test_expect_success 'do not complain about existing broken links (commit)' '
-	cat >broken-commit <<-\EOF &&
-	tree 0000000000000000000000000000000000000001
-	parent 0000000000000000000000000000000000000002
+	cat >broken-commit <<-EOF &&
+	tree $(test_oid 001)
+	parent $(test_oid 002)
 	author whatever <whatever@example.com> 1234 -0000
 	committer whatever <whatever@example.com> 1234 -0000
 
@@ -143,8 +143,8 @@ test_expect_success 'do not complain about existing broken links (commit)' '
 '
 
 test_expect_success 'do not complain about existing broken links (tree)' '
-	cat >broken-tree <<-\EOF &&
-	100644 blob 0000000000000000000000000000000000000003	foo
+	cat >broken-tree <<-EOF &&
+	100644 blob $(test_oid 003)	foo
 	EOF
 	tree=$(git mktree --missing <broken-tree) &&
 	git gc -q 2>stderr &&
@@ -153,8 +153,8 @@ test_expect_success 'do not complain about existing broken links (tree)' '
 '
 
 test_expect_success 'do not complain about existing broken links (tag)' '
-	cat >broken-tag <<-\EOF &&
-	object 0000000000000000000000000000000000000004
+	cat >broken-tag <<-EOF &&
+	object $(test_oid 004)
 	type commit
 	tag broken
 	tagger whatever <whatever@example.com> 1234 -0000

Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D21C3F68F
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA88620700
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JeAdZKct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfLUTuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:15 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:42008 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727382AbfLUTuL (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:11 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AB62B60787;
        Sat, 21 Dec 2019 19:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957811;
        bh=Ij8AsTxn8UmBMqPdKSFBnCn64fhTnfqnpgfTbXyoAnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=JeAdZKctHavgE+upwy+vdUsyDPuE/75+szbPQUP/5lrlOsukIoiixBWD+0rGvXyv3
         1+YabQ82SiAX5ttoqnqqQAPEhLVapkrJNHj0qqMeFTizIchrRzJYqGcYTeL0mWRZqT
         r25uRjogliAa1hNM+gAwVwzQx2iqCizsM8lFPNReTjEg7mON+L9jAoFi07i9PZMuHh
         9QHV0T6lyIxh7ZNS8EcCR3AVX97qkJlIwuK/8yn81qQxWssv4lSq0miySzwrcBl5q8
         +PbtK341y+/MR8viRTCtzvxqMzOqFpj25SlB1XRsyC4GcunqQg+c4hDzAuswkbyfzH
         G62gJvFUoETHhfHOQxxHFTOBh3DfsRMX1HQsAUSyA74KcU6hclWokm/M+w/h/xX3C2
         0oyteGF62aLcCBf0cSvomjbokXnXYQcB30WIlExSoweoI/KRm1A2z6Acs0HJPJSuqM
         TvHBhXk2vqAIslBJaK9YV9xg4AOlIpp5MKbEBJ9DHISUhKsULdw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/20] t5324: make hash size independent
Date:   Sat, 21 Dec 2019 19:49:27 +0000
Message-Id: <20191221194936.1346664-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are some offsets in the commit graph files used to corrupt data.
Compute these offsets for both SHA-1 and SHA-256 so that the test works
with either.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5324-split-commit-graph.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index c24823431f..53b2e6b455 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -11,7 +11,14 @@ test_expect_success 'setup repo' '
 	git config gc.writeCommitGraph false &&
 	infodir=".git/objects/info" &&
 	graphdir="$infodir/commit-graphs" &&
-	test_oid_init
+	test_oid_init &&
+	test_oid_cache <<-EOM
+	shallow sha1:1760
+	shallow sha256:2064
+
+	base sha1:1376
+	base sha256:1496
+	EOM
 '
 
 graph_read_expect() {
@@ -248,7 +255,7 @@ test_expect_success 'verify hashes along chain, even in shallow' '
 		cd verify &&
 		git commit-graph verify &&
 		base_file=$graphdir/graph-$(head -n 1 $graphdir/commit-graph-chain).graph &&
-		corrupt_file "$base_file" 1760 "\01" &&
+		corrupt_file "$base_file" $(test_oid shallow) "\01" &&
 		test_must_fail git commit-graph verify --shallow 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_i18ngrep "incorrect checksum" err
@@ -275,7 +282,7 @@ test_expect_success 'warn on base graph chunk incorrect' '
 		cd base-chunk &&
 		git commit-graph verify &&
 		base_file=$graphdir/graph-$(tail -n 1 $graphdir/commit-graph-chain).graph &&
-		corrupt_file "$base_file" 1376 "\01" &&
+		corrupt_file "$base_file" $(test_oid base) "\01" &&
 		git commit-graph verify --shallow 2>test_err &&
 		grep -v "^+" test_err >err &&
 		test_i18ngrep "commit-graph chain does not match" err

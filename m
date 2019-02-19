Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 272661F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbfBSAGM (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:12 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34784 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732258AbfBSAGJ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:06:09 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 326B76109C;
        Tue, 19 Feb 2019 00:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534767;
        bh=i+iyN68P9B/FcVHDzwOCiQXsXWtbtaEzx8vb7soB9qU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=HpSTNBNj+9EcS1cTAlF+I7Gp9vXAInP6QnOyVJaWXGvk7T/yTOwrA4PPJ+j45JPaH
         Ejk3XJL8D07DnKUww2cHT/4vN63yPwwdIt2T/UPZ2gM/wC8LR/Y8P1L3H5covdePy9
         BQH6eoGglHFm4mZdt6/wTfZdgdh5HrmwChFJYNwRaTq4XYaktJyqPlNM5mzpBJLwK3
         Ht0VuLt16llMmewEZFL6FllHH/XVmP2yUurW/Jrmm2+7kJs8oG6vaFv4Kmf+MTMAGu
         ok4keYn7MIer94N47TLd9IssB4TDHOW/ToCqtEkjp3GQhMotMxK7uyKenqprzE0ppQ
         LwbeOTap6OCHkdE5W+I7oFoeFF9HqYF1en0fReKeaFIl6fJ/8QuzYt/8JkQhzeETXi
         1Q1TrWMjepRaZO/3LHe7iN4xpHqnjgNmDuqrAcFk+ng88CkBQdMVnl5Sb1A+93r0nx
         rakyKKBpaPIP2evhuvyxriVTV2P0/pOMg84BbNhAU71JWM20pgQ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 26/35] hash: add a function to lookup hash algorithm by length
Date:   Tue, 19 Feb 2019 00:05:17 +0000
Message-Id: <20190219000526.476553-27-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are some cases, such as the dumb HTTP transport and bundles, where
we can only determine the hash algorithm in use by the length of the
object IDs. Provide a function that looks up the algorithm by length.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hash.h      | 2 ++
 sha1-file.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/hash.h b/hash.h
index adde708cf2..661c9f2281 100644
--- a/hash.h
+++ b/hash.h
@@ -131,6 +131,8 @@ extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
 int hash_algo_by_name(const char *name);
 /* Identical, except based on the format ID. */
 int hash_algo_by_id(uint32_t format_id);
+/* Identical, except based on the length. */
+int hash_algo_by_length(int len);
 /* Identical, except for a pointer to struct git_hash_algo. */
 static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 {
diff --git a/sha1-file.c b/sha1-file.c
index 494606f771..bcd9470bce 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -189,6 +189,14 @@ int hash_algo_by_id(uint32_t format_id)
 	return GIT_HASH_UNKNOWN;
 }
 
+int hash_algo_by_length(int len)
+{
+	int i;
+	for (i = 1; i < GIT_HASH_NALGOS; i++)
+		if (len == hash_algos[i].rawsz)
+			return i;
+	return GIT_HASH_UNKNOWN;
+}
 
 /*
  * This is meant to hold a *small* number of objects that you would

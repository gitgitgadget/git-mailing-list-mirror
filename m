Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643081F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 04:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbeKNOLs (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 09:11:48 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54416 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728686AbeKNOLr (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 09:11:47 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1BEB96045B;
        Wed, 14 Nov 2018 04:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1542168620;
        bh=pXGEHUlshsE4ZDOEaGfUfLRzTVwpMuLnzjhv4MufK78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=b0EtQ2UZHr1xSXF5TahM4RWc1i0bQay3OLqPBMg8VJ7O7KKgYjjOh9moBa6B0TjCb
         FbTr1rT1Y89HO5QKutSU2kXMbP1sNgH2DV4GkxTQNzJuiJFQ66V6DzBKbcYSdTRKak
         3ny39mVxpS2XBCBlL10SIelTbhpSN/sluR5D3V5mIhDQR35bw4o1NpJqm0y53m4Hzm
         UrbvyvJ/4uPjt00Q+R3gOrowlZW7o7jht7wn+tBy2H1H2IFh+ua7uG5XoTs8a+QZ9T
         pCTcQ0WGmiN1mTi/YmDKRC0HaOXBT9kH7Fyd83TYKoE0qcMTWU7WETPBh6x5MS/Yec
         ZLYeUBJOVIKq0nT5HxsIGG3OiRaA4kwnEluANTLMoEEwcu0xYaZFD8d9gnqsLSZK7o
         fL5tgi80uLU8SZIuXkFDoz8+zDVnzWKJ9Qu1bCYeofIGB09f/AGOlcrEz+3KCGQdco
         0QzDXvnDRss0GK1JpW4Ele+asJTTJgJkJeQ0BSVN8um1Lb26FO0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 07/12] sha1-file: add a constant for hash block size
Date:   Wed, 14 Nov 2018 04:09:33 +0000
Message-Id: <20181114040938.517289-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245
In-Reply-To: <20181114040938.517289-1-sandals@crustytoothpaste.net>
References: <20181104234458.139223-1-sandals@crustytoothpaste.net>
 <20181114040938.517289-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is one place we need the hash algorithm block size: the HMAC code
for push certs.  Expose this constant in struct git_hash_algo and expose
values for SHA-1 and for the largest value of any hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h     | 4 ++++
 hash.h      | 3 +++
 sha1-file.c | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/cache.h b/cache.h
index 8607878dbc..62b2f3a5e8 100644
--- a/cache.h
+++ b/cache.h
@@ -45,10 +45,14 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
 /* The length in bytes and in hex digits of an object name (SHA-1 value). */
 #define GIT_SHA1_RAWSZ 20
 #define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
+/* The block size of SHA-1. */
+#define GIT_SHA1_BLKSZ 64
 
 /* The length in byte and in hex digits of the largest possible hash value. */
 #define GIT_MAX_RAWSZ GIT_SHA1_RAWSZ
 #define GIT_MAX_HEXSZ GIT_SHA1_HEXSZ
+/* The largest possible block size for any supported hash. */
+#define GIT_MAX_BLKSZ GIT_SHA1_BLKSZ
 
 struct object_id {
 	unsigned char hash[GIT_MAX_RAWSZ];
diff --git a/hash.h b/hash.h
index 80881eea47..1bcf7ab6fd 100644
--- a/hash.h
+++ b/hash.h
@@ -81,6 +81,9 @@ struct git_hash_algo {
 	/* The length of the hash in hex characters. */
 	size_t hexsz;
 
+	/* The block size of the hash. */
+	size_t blksz;
+
 	/* The hash initialization function. */
 	git_hash_init_fn init_fn;
 
diff --git a/sha1-file.c b/sha1-file.c
index 93ed8c8686..c47349a5f8 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -90,6 +90,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		0x00000000,
 		0,
 		0,
+		0,
 		git_hash_unknown_init,
 		git_hash_unknown_update,
 		git_hash_unknown_final,
@@ -102,6 +103,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		0x73686131,
 		GIT_SHA1_RAWSZ,
 		GIT_SHA1_HEXSZ,
+		GIT_SHA1_BLKSZ,
 		git_hash_sha1_init,
 		git_hash_sha1_update,
 		git_hash_sha1_final,

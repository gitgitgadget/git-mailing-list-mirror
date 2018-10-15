Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0551F453
	for <e@80x24.org>; Mon, 15 Oct 2018 02:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbeJOKCX (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 06:02:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50732 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726347AbeJOKCW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 06:02:22 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C9BE961B7B;
        Mon, 15 Oct 2018 02:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539569954;
        bh=9RLhzwTFBTatRe2RNvI9WcUKN4NwuVeK9fosl6OZODU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=iGBozeYjanKaOMcPs3N4/fD4f46xu9x1rUhZO83mRQUQHyAA2RCG2hJf0j9+s2LFE
         ROVx+nAMIkQunkcA1FZOODb5X2kgqDt6VSkYlECr0U+ypGjTpMGIutgnAVdV1mOJsI
         /yQPOR53izv7apeRzRdkESCEextQKo4aazoif/9N/UqJHFVeiebet2/eSUwwTBNGAv
         lsja9YZSxuphwc/4w009ViottVAK3hTFEEkF1nic1hKnxl43cTxCMFErTVeu1mCrdU
         91r13d0pJIcl58Q9e87kUJ9nId+Dxehqxwf69bn2TwCzek4EmoGc/51rJewPeFmKtM
         w5HMOW/+43OSq0w/ZDXS1ASAuCHb9hrm/JC2Nk1dIAjYsNQAJ5RZj0x+G0VsSxOxlw
         nLWdqEIR61RVTdu0OQGD2HBhuQV+IqDfT5ro85QFLPGP7ohMD+ui3F6wcRMQpaBaNF
         0BxsL8ZKEMsPSwYwJIGPaOoRBdRbi3zO7ZbuAaAdcDndYW1luXf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/13] sha1-file: add a constant for hash block size
Date:   Mon, 15 Oct 2018 02:18:54 +0000
Message-Id: <20181015021900.1030041-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
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
index 0b88c3a344..48e736b0d5 100644
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
index 90f4344619..46dff69eb3 100644
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
index 3a75d515eb..9aadaf0c8d 100644
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

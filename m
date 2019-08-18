Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D45791F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfHRUFf (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57932 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727068AbfHRUFe (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:34 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C741060736;
        Sun, 18 Aug 2019 20:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158733;
        bh=TBcQjB7XaHafbpe/HgQ4Z66kSJ11gWytYQ1yFIJT3U8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ilaApJauB2LfttDZk065r4GsTiNaslnFqjALqyXpEzAns/FqeTPKDqs6a+qj8kGHD
         RN/K96OksS+66g6XR1Kry3hw63RprQp8iGpbujv5x9MEppaRrBj/WMkqxA/vGueYKA
         z4mek8DqS5R5x7Ytoj+s1iGKM2KBhnjTNagHVAWmZK3VbEEPrki+pYS3R/bfXJ4uxZ
         wGYqazu1mPIAhshPcdck0eXhpSTRXY2BRoitTphdPLvPBXPU9PcLgmRw+CA7rwVym7
         KyiwQba/4hoaAOapvbnqKss+KrQCFpetaqIMFWHWOqScKAx9F4/I2X7dtDnHTHs0wu
         +vltrx/s0q4NbPXdfmw8SFSjBMTFlG70qtV8QXW/U8IofCninVXgqVoBPWSrG1UDP5
         XkaT477JDs80N5XkOn0gNVPhNG6hvhG12RT5t+lHQsO5sv5f9fgs5rabfelLprVzes
         kAOJQWedr480EE+rshY+zQmj/dBASt2NZQfmmN37Ps3TJoIKfhC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 04/26] builtin/receive-pack: switch to use the_hash_algo
Date:   Sun, 18 Aug 2019 20:04:05 +0000
Message-Id: <20190818200427.870753-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The push cert code uses HMAC-SHA-1 to create a nonce.  This is a secure
use of SHA-1 which is not affected by its collision resistance (or lack
thereof).  However, it makes sense for us to use a better algorithm if
one is available, one which may even be more performant.  Futhermore,
until we have specialized functions for computing the hex value of an
arbitrary function, it simplifies the code greatly to use the same hash
algorithm everywhere.

Switch this code to use GIT_MAX_BLKSZ and the_hash_algo for computing
the push cert nonce, and rename the hmac_sha1 function to simply "hmac".

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/receive-pack.c | 44 ++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index dcf385511f..402edf34d8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -417,24 +417,22 @@ static int copy_to_sideband(int in, int out, void *arg)
 	return 0;
 }
 
-#define HMAC_BLOCK_SIZE 64
-
-static void hmac_sha1(unsigned char *out,
+static void hmac(unsigned char *out,
 		      const char *key_in, size_t key_len,
 		      const char *text, size_t text_len)
 {
-	unsigned char key[HMAC_BLOCK_SIZE];
-	unsigned char k_ipad[HMAC_BLOCK_SIZE];
-	unsigned char k_opad[HMAC_BLOCK_SIZE];
+	unsigned char key[GIT_MAX_BLKSZ];
+	unsigned char k_ipad[GIT_MAX_BLKSZ];
+	unsigned char k_opad[GIT_MAX_BLKSZ];
 	int i;
-	git_SHA_CTX ctx;
+	git_hash_ctx ctx;
 
 	/* RFC 2104 2. (1) */
-	memset(key, '\0', HMAC_BLOCK_SIZE);
-	if (HMAC_BLOCK_SIZE < key_len) {
-		git_SHA1_Init(&ctx);
-		git_SHA1_Update(&ctx, key_in, key_len);
-		git_SHA1_Final(key, &ctx);
+	memset(key, '\0', GIT_MAX_BLKSZ);
+	if (the_hash_algo->blksz < key_len) {
+		the_hash_algo->init_fn(&ctx);
+		the_hash_algo->update_fn(&ctx, key_in, key_len);
+		the_hash_algo->final_fn(key, &ctx);
 	} else {
 		memcpy(key, key_in, key_len);
 	}
@@ -446,29 +444,29 @@ static void hmac_sha1(unsigned char *out,
 	}
 
 	/* RFC 2104 2. (3) & (4) */
-	git_SHA1_Init(&ctx);
-	git_SHA1_Update(&ctx, k_ipad, sizeof(k_ipad));
-	git_SHA1_Update(&ctx, text, text_len);
-	git_SHA1_Final(out, &ctx);
+	the_hash_algo->init_fn(&ctx);
+	the_hash_algo->update_fn(&ctx, k_ipad, sizeof(k_ipad));
+	the_hash_algo->update_fn(&ctx, text, text_len);
+	the_hash_algo->final_fn(out, &ctx);
 
 	/* RFC 2104 2. (6) & (7) */
-	git_SHA1_Init(&ctx);
-	git_SHA1_Update(&ctx, k_opad, sizeof(k_opad));
-	git_SHA1_Update(&ctx, out, GIT_SHA1_RAWSZ);
-	git_SHA1_Final(out, &ctx);
+	the_hash_algo->init_fn(&ctx);
+	the_hash_algo->update_fn(&ctx, k_opad, sizeof(k_opad));
+	the_hash_algo->update_fn(&ctx, out, the_hash_algo->rawsz);
+	the_hash_algo->final_fn(out, &ctx);
 }
 
 static char *prepare_push_cert_nonce(const char *path, timestamp_t stamp)
 {
 	struct strbuf buf = STRBUF_INIT;
-	unsigned char sha1[GIT_SHA1_RAWSZ];
+	unsigned char hash[GIT_MAX_RAWSZ];
 
 	strbuf_addf(&buf, "%s:%"PRItime, path, stamp);
-	hmac_sha1(sha1, buf.buf, buf.len, cert_nonce_seed, strlen(cert_nonce_seed));
+	hmac(hash, buf.buf, buf.len, cert_nonce_seed, strlen(cert_nonce_seed));
 	strbuf_release(&buf);
 
 	/* RFC 2104 5. HMAC-SHA1-80 */
-	strbuf_addf(&buf, "%"PRItime"-%.*s", stamp, GIT_SHA1_HEXSZ, sha1_to_hex(sha1));
+	strbuf_addf(&buf, "%"PRItime"-%.*s", stamp, (int)the_hash_algo->hexsz, sha1_to_hex(hash));
 	return strbuf_detach(&buf, NULL);
 }
 

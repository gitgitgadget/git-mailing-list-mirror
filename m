Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 065E61F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfHRUGB (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:06:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58046 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727258AbfHRUFy (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:54 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2E97C6077E;
        Sun, 18 Aug 2019 20:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158752;
        bh=QImHxEB2qHPakytzU74quFT+j/P1s5yJ9AZ9Vj2CCEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=lGcBjNwj7BbXk/s2L/uaKo6O79xzwXRu06Dc+WhIjTLEovQZtNSOaJxp8VARMLWlN
         lzxyVrFjKm42TWSIOZl6TMP7j6kDwqTK8StpqVFizh2He342DtgJwDujDU2osLIahK
         ysv+oKtgmE78iv6Zb/8ffD4eqFmriTDlVyzPj9iiHdmrwxqm8woIPT7h6zWmvuUCoG
         dfE5CJcT9QmfAwsrQixlavdMojmtQA81faXMA4+28lyk3DK8XlGV5ddJteHf9jLxav
         Mzv3CEG6tWqDpFMK/sdfshOEgFF97aAyPauU9lJHJGgdXnQMpvCssd20xMn3zhBTq4
         r8iKjcBzOD0UwqLaJcejAxdOQxhb9TaN2Wo6+DvRtlzQ89e0YNGsB3vIgIkmNCyYGK
         m8jlvyHi/zrFxYqXFVPnCM6Gu/G/YqsQW60A7dfK9Te1uTIsph72ticAjOneYbge45
         bCTrOit9Luz+R6ifdzzRdrz2IIyfHnNXut4JWO4S4d8jg5iV/ie
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 23/26] builtin/receive-pack: replace sha1_to_hex
Date:   Sun, 18 Aug 2019 20:04:24 +0000
Message-Id: <20190818200427.870753-24-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since sha1_to_hex is limited to SHA-1, replace it with hash_to_hex.
Rename several variables to indicate that they can contain any hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/receive-pack.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 402edf34d8..411e0b4d99 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -466,7 +466,7 @@ static char *prepare_push_cert_nonce(const char *path, timestamp_t stamp)
 	strbuf_release(&buf);
 
 	/* RFC 2104 5. HMAC-SHA1-80 */
-	strbuf_addf(&buf, "%"PRItime"-%.*s", stamp, (int)the_hash_algo->hexsz, sha1_to_hex(hash));
+	strbuf_addf(&buf, "%"PRItime"-%.*s", stamp, (int)the_hash_algo->hexsz, hash_to_hex(hash));
 	return strbuf_detach(&buf, NULL);
 }
 
@@ -968,7 +968,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 	if (run_command(&child))
 		return "Working directory has staged changes";
 
-	read_tree[3] = sha1_to_hex(sha1);
+	read_tree[3] = hash_to_hex(sha1);
 	child_process_init(&child);
 	child.argv = read_tree;
 	child.env = env->argv;
@@ -985,13 +985,13 @@ static const char *push_to_deploy(unsigned char *sha1,
 
 static const char *push_to_checkout_hook = "push-to-checkout";
 
-static const char *push_to_checkout(unsigned char *sha1,
+static const char *push_to_checkout(unsigned char *hash,
 				    struct argv_array *env,
 				    const char *work_tree)
 {
 	argv_array_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
 	if (run_hook_le(env->argv, push_to_checkout_hook,
-			sha1_to_hex(sha1), NULL))
+			hash_to_hex(hash), NULL))
 		return "push-to-checkout hook declined";
 	else
 		return NULL;

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 208311FAE2
	for <e@80x24.org>; Sun, 28 Jan 2018 15:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbeA1P5k (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 10:57:40 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58382 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751980AbeA1P5g (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Jan 2018 10:57:36 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2370261350;
        Sun, 28 Jan 2018 15:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517155055;
        bh=1wcirzURI/Mxc9cmjRGAAy5OuoSRnubWrq+Sog3uISI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=nifGL+gCv2UEysJ+KHzJXogPV0S9oDKlBuZt/HekDLhqrp30t/6YwMRHinSnMZ/zc
         UFeGZEtIY8GdIf882oybkNF3+itT9y4a73+nbBOgvW8nJY15NOAprwvaV+LK74toMe
         upL242LiBDsFrLb/tegkYvzM7OcnSG30zRmbITvG74AXXyiaMIKQ4dkR3c8Ih/9R0G
         yxUXP5zoDtuviccgx38tmRlLkek1aW/m+0b3psutlcL5Rd540Kyn7rN4VnVmfjZ/XK
         q0vZA9GPfVadHg714i7EwveNrcPK6gNfkmKn0LEb2A0/csMl6xzKELgExP4DRKvS6i
         /tFeVzLlauYOi6EJlPZ7EnMA8Jg1OgICgyaMgX48ks30xwzk0/DXYU1Jb9nJ1p/NCC
         /oVyz5+JKjb+uM81iQBH+vXCT2zP+lPXYy9k5kwnHmSmyc2dda75kvXJx5DfWpmOUE
         D27chnIzT/UjVopLi5o6W0Anmxu1lWGA2UCTbvG93HpxGwB65ym
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 04/12] builtin/unpack-objects: switch uses of SHA-1 to the_hash_algo
Date:   Sun, 28 Jan 2018 15:57:14 +0000
Message-Id: <20180128155722.880805-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
In-Reply-To: <20180128155722.880805-1-sandals@crustytoothpaste.net>
References: <20180128155722.880805-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Switch various uses of explicit calls to SHA-1 into references to
the_hash_algo to better abstract away the various uses of it.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/unpack-objects.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 62ea264c46..813ca31979 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -21,7 +21,7 @@ static unsigned char buffer[4096];
 static unsigned int offset, len;
 static off_t consumed_bytes;
 static off_t max_input_size;
-static git_SHA_CTX ctx;
+static git_hash_ctx ctx;
 static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 
 /*
@@ -62,7 +62,7 @@ static void *fill(int min)
 	if (min > sizeof(buffer))
 		die("cannot fill %d bytes", min);
 	if (offset) {
-		git_SHA1_Update(&ctx, buffer, offset);
+		the_hash_algo->update_fn(&ctx, buffer, offset);
 		memmove(buffer, buffer + offset, len);
 		offset = 0;
 	}
@@ -345,8 +345,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 	struct object_id base_oid;
 
 	if (type == OBJ_REF_DELTA) {
-		hashcpy(base_oid.hash, fill(GIT_SHA1_RAWSZ));
-		use(GIT_SHA1_RAWSZ);
+		hashcpy(base_oid.hash, fill(the_hash_algo->rawsz));
+		use(the_hash_algo->rawsz);
 		delta_data = get_data(delta_size);
 		if (dry_run || !delta_data) {
 			free(delta_data);
@@ -564,15 +564,15 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 		/* We don't take any non-flag arguments now.. Maybe some day */
 		usage(unpack_usage);
 	}
-	git_SHA1_Init(&ctx);
+	the_hash_algo->init_fn(&ctx);
 	unpack_all();
-	git_SHA1_Update(&ctx, buffer, offset);
-	git_SHA1_Final(oid.hash, &ctx);
+	the_hash_algo->update_fn(&ctx, buffer, offset);
+	the_hash_algo->final_fn(oid.hash, &ctx);
 	if (strict)
 		write_rest();
-	if (hashcmp(fill(GIT_SHA1_RAWSZ), oid.hash))
+	if (hashcmp(fill(the_hash_algo->rawsz), oid.hash))
 		die("final sha1 did not match");
-	use(GIT_SHA1_RAWSZ);
+	use(the_hash_algo->rawsz);
 
 	/* Write the last part of the buffer to stdout */
 	while (len) {

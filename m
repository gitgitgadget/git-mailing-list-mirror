Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48D1C1FAE3
	for <e@80x24.org>; Thu,  1 Feb 2018 02:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932225AbeBACTM (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 21:19:12 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58590 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932214AbeBACTI (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Jan 2018 21:19:08 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1400B61391;
        Thu,  1 Feb 2018 02:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1517451547;
        bh=O9B97hNJOUcZAUOVbK5FOJgtnJ3P52Wol862u224ggg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=y+xZcS7JgGuV1pHHsDHW0pUKl99aOe2n0oY9gwaqwDKzjy2PgVEEVvhONlrfC0U5r
         +1YHWXAEwNy7s3SF0lgs6hdMRZzevbX1j21WwGTgOLL/6xWDPoehARu5lo4xGmvRl8
         fm8LJElR8K0W4LP+45bPqpZaUkUJgDFz84V9lxgxO8igX/1YYwYXxLGbGgweZyWaiG
         D72Rh7yFI1VQazko/Z1lIdS5eD0vns3Ph5W2hbr4huQb/5RSfij2wcxZ4+JW8pqN7l
         rUaRMB6Rj8uBvrg9Un1FAHNdxsbA4CeeaHsfiGFGV0XsLfejE+fkcRFRCF+SkdqdJE
         rHZtS1emTAzb2HWJ1u5gQJR4fmieqrZOi3SovUZzdO20CbiS10gRaiW41eSjtCayFS
         O9T40I2KsQ8+TkY7D+ha1PLozxOIQsnJIqJhDoS5Hn5gpWAOjw2gCtfeC0eNryjwbI
         anlSUi+lFJZdC1d+mzQw6nU/JwHOMfKbsQAlfIiPgqGgms//SDh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 07/12] pack-check: convert various uses of SHA-1 to abstract forms
Date:   Thu,  1 Feb 2018 02:18:43 +0000
Message-Id: <20180201021848.533188-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.315.g94e5d3ead4
In-Reply-To: <20180201021848.533188-1-sandals@crustytoothpaste.net>
References: <20180201021848.533188-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert various explicit calls to use SHA-1 functions and constants to
references to the_hash_algo.  Make several strings more generic with
respect to the hash algorithm used.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 pack-check.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/pack-check.c b/pack-check.c
index 073c1fbd46..403a572567 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -41,7 +41,7 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
 	} while (len);
 
 	index_crc = p->index_data;
-	index_crc += 2 + 256 + p->num_objects * (20/4) + nr;
+	index_crc += 2 + 256 + p->num_objects * (the_hash_algo->rawsz/4) + nr;
 
 	return data_crc != ntohl(*index_crc);
 }
@@ -54,7 +54,7 @@ static int verify_packfile(struct packed_git *p,
 {
 	off_t index_size = p->index_size;
 	const unsigned char *index_base = p->index_data;
-	git_SHA_CTX ctx;
+	git_hash_ctx ctx;
 	unsigned char hash[GIT_MAX_RAWSZ], *pack_sig;
 	off_t offset = 0, pack_sig_ofs = 0;
 	uint32_t nr_objects, i;
@@ -64,24 +64,24 @@ static int verify_packfile(struct packed_git *p,
 	if (!is_pack_valid(p))
 		return error("packfile %s cannot be accessed", p->pack_name);
 
-	git_SHA1_Init(&ctx);
+	the_hash_algo->init_fn(&ctx);
 	do {
 		unsigned long remaining;
 		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
 		offset += remaining;
 		if (!pack_sig_ofs)
-			pack_sig_ofs = p->pack_size - 20;
+			pack_sig_ofs = p->pack_size - the_hash_algo->rawsz;
 		if (offset > pack_sig_ofs)
 			remaining -= (unsigned int)(offset - pack_sig_ofs);
-		git_SHA1_Update(&ctx, in, remaining);
+		the_hash_algo->update_fn(&ctx, in, remaining);
 	} while (offset < pack_sig_ofs);
-	git_SHA1_Final(hash, &ctx);
+	the_hash_algo->final_fn(hash, &ctx);
 	pack_sig = use_pack(p, w_curs, pack_sig_ofs, NULL);
 	if (hashcmp(hash, pack_sig))
-		err = error("%s SHA1 checksum mismatch",
+		err = error("%s pack checksum mismatch",
 			    p->pack_name);
-	if (hashcmp(index_base + index_size - 40, pack_sig))
-		err = error("%s SHA1 does not match its index",
+	if (hashcmp(index_base + index_size - the_hash_algo->hexsz, pack_sig))
+		err = error("%s pack checksum does not match its index",
 			    p->pack_name);
 	unuse_pack(w_curs);
 
@@ -165,8 +165,8 @@ int verify_pack_index(struct packed_git *p)
 {
 	off_t index_size;
 	const unsigned char *index_base;
-	git_SHA_CTX ctx;
-	unsigned char sha1[20];
+	git_hash_ctx ctx;
+	unsigned char hash[GIT_MAX_RAWSZ];
 	int err = 0;
 
 	if (open_pack_index(p))
@@ -175,11 +175,11 @@ int verify_pack_index(struct packed_git *p)
 	index_base = p->index_data;
 
 	/* Verify SHA1 sum of the index file */
-	git_SHA1_Init(&ctx);
-	git_SHA1_Update(&ctx, index_base, (unsigned int)(index_size - 20));
-	git_SHA1_Final(sha1, &ctx);
-	if (hashcmp(sha1, index_base + index_size - 20))
-		err = error("Packfile index for %s SHA1 mismatch",
+	the_hash_algo->init_fn(&ctx);
+	the_hash_algo->update_fn(&ctx, index_base, (unsigned int)(index_size - the_hash_algo->rawsz));
+	the_hash_algo->final_fn(hash, &ctx);
+	if (hashcmp(hash, index_base + index_size - the_hash_algo->rawsz))
+		err = error("Packfile index for %s hash mismatch",
 			    p->pack_name);
 	return err;
 }

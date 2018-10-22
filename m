Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F4081F453
	for <e@80x24.org>; Mon, 22 Oct 2018 02:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJVLAm (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 07:00:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51758 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727348AbeJVLAl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Oct 2018 07:00:41 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:65d4:dc3c:f6f5:933b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7D99561B72;
        Mon, 22 Oct 2018 02:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540176247;
        bh=JO47WrcxS6xqFOCuXQMVntBmXlG/shMi5Dj9ObgYzOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=QSobBuxpebvSpTaTXO54f9M9O5Sv5anIIxzJ69PkZ38VSfnKgTri46AzpdF/aBTmh
         TJOjokOx2YZn/mjPd2fu99rVIPF7/LvJEVxz9TpnI3+zmeB+p6za/xd8nkKwXq3PNZ
         YrS49eQ6x97wSFY2S61+2qfHw+oJLCvCJJwFnf+MKQ5agudMJyKlJl/906DQF9HmM5
         qazJEWuRBC9qDMQCPqxrqlg8sRKscasiId8bQyK+K9UScLEYLnsnhCBIiKSVOgGRPr
         2wBTGiLY8azYE1yJNtdd1vNWHJCPg/eppH0Cbri6FYdnmudvxmS3MO0ryXbOsr6Iut
         sXfzz6c9Qe/ntryzfY60XK79OzJIqDzTJm9mRSUvIY8idDpIa8wAvDdVsOrA21oqEK
         ZycrQgRFCALTnV+UagV5+FHg/MGYfDhkVV3ArVKTwmxsADlyUz4shVSqB+4b9BY6X5
         dOwSL8XQPFNz44FWH14GkVIEM2Ukc1s3TJovynv6qASVYqY7Wqu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 04/12] cache: make hashcmp and hasheq work with larger hashes
Date:   Mon, 22 Oct 2018 02:43:34 +0000
Message-Id: <20181022024342.489564-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181022024342.489564-1-sandals@crustytoothpaste.net>
References: <20181022024342.489564-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 183a638b7d ("hashcmp: assert constant hash size", 2018-08-23), we
modified hashcmp to assert that the hash size was always 20 to help it
optimize and inline calls to memcmp.  In a future series, we replaced
many calls to hashcmp and oidcmp with calls to hasheq and oideq to
improve inlining further.

However, we want to support hash algorithms other than SHA-1, namely
SHA-256.  When doing so, we must handle the case where these values are
32 bytes long as well as 20.  Adjust hashcmp to handle two cases:
20-byte matches, and maximum-size matches.  Therefore, when we include
SHA-256, we'll automatically handle it properly, while at the same time
teaching the compiler that there are only two possible options to
consider.  This will allow the compiler to write the most efficient
possible code.

Copy similar code into hasheq and perform an identical transformation.
At least with GCC 8.2.0, making hasheq defer to hashcmp when there are
two branches prevents the compiler from inlining the comparison, while
the code in this patch is inlined properly.  Add a comment to avoid an
accidental performance regression from well-intentioned refactoring.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index 51580c4b77..bab8e8964f 100644
--- a/cache.h
+++ b/cache.h
@@ -1027,16 +1027,12 @@ extern const struct object_id null_oid;
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
 	/*
-	 * This is a temporary optimization hack. By asserting the size here,
-	 * we let the compiler know that it's always going to be 20, which lets
-	 * it turn this fixed-size memcmp into a few inline instructions.
-	 *
-	 * This will need to be extended or ripped out when we learn about
-	 * hashes of different sizes.
+	 * Teach the compiler that there are only two possibilities of hash size
+	 * here, so that it can optimize for this case as much as possible.
 	 */
-	if (the_hash_algo->rawsz != 20)
-		BUG("hash size not yet supported by hashcmp");
-	return memcmp(sha1, sha2, the_hash_algo->rawsz);
+	if (the_hash_algo->rawsz == GIT_MAX_RAWSZ)
+		return memcmp(sha1, sha2, GIT_MAX_RAWSZ);
+	return memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
 }
 
 static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
@@ -1046,7 +1042,13 @@ static inline int oidcmp(const struct object_id *oid1, const struct object_id *o
 
 static inline int hasheq(const unsigned char *sha1, const unsigned char *sha2)
 {
-	return !hashcmp(sha1, sha2);
+	/*
+	 * We write this here instead of deferring to hashcmp so that the
+	 * compiler can properly inline it and avoid calling memcmp.
+	 */
+	if (the_hash_algo->rawsz == GIT_MAX_RAWSZ)
+		return !memcmp(sha1, sha2, GIT_MAX_RAWSZ);
+	return !memcmp(sha1, sha2, GIT_SHA1_RAWSZ);
 }
 
 static inline int oideq(const struct object_id *oid1, const struct object_id *oid2)

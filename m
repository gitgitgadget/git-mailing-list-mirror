Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 742FE1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 04:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeKNOLo (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 09:11:44 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54404 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726517AbeKNOLn (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 09:11:43 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CBB3960FDF;
        Wed, 14 Nov 2018 04:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1542168617;
        bh=AbxObAq0frsdeaUeUnM/XPVolVoWiRrdQhmSt+xibCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=uA4YG0W/5pzYJKWGy1wzQ3qsGxLZ/wfrK7MNh++ChkXcA7NOuvn0uDPPmdxPZqjaO
         se8bdTzru71iqVb+71zpUOHgZLiGBEkXY/N+gDgfGgC/52QrHUOfxLjF0w8iP3kxDj
         OnkigdbwqGReozs/IcOG6u/4lpLQ683ZF8Adju5A5+U6+Sic0GvDADgrAKLBZ2xQyd
         /oDq4YL9ysP0TJppbqLNWvE7+vKPzpDtFWHHwBDiI1XLi98t/RXtxmXwd9tBLs9sjp
         +H61cHGT3OtFpHLKiyJ4JF9AGRGl2HM0ZFBeJncgfMNAr0SJD4FWT1k4C72mDTTTTm
         JK8JagQkwC/u6/j04DtEBSN91GlwToKQtbSvhuA+jbl0DDG/w47IZAIUeEASxwkNx1
         c7uLB3MiX3cTlEqRBXp99BTz9AI2Op4MCWHURvEzYiF5GjCjFdpgzn7GpcPZwhUz/B
         YDnOaKdyLgxyG9GgvkdnVta0bpkJOFPVu+dIkfAdoHOEUSFYzh4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 04/12] cache: make hashcmp and hasheq work with larger hashes
Date:   Wed, 14 Nov 2018 04:09:30 +0000
Message-Id: <20181114040938.517289-5-sandals@crustytoothpaste.net>
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
index cb7268deea..8607878dbc 100644
--- a/cache.h
+++ b/cache.h
@@ -1028,16 +1028,12 @@ extern const struct object_id null_oid;
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
@@ -1047,7 +1043,13 @@ static inline int oidcmp(const struct object_id *oid1, const struct object_id *o
 
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

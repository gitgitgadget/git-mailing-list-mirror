Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB97A2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 21:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbdCRVb0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 17:31:26 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46202 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751249AbdCRVbI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Mar 2017 17:31:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E38BC280B7;
        Sat, 18 Mar 2017 21:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489872002;
        bh=KtFOepS6DyDyFKWbDioJHBzDPmSqD9ZW6OpJz+XaSwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pdJobqzh5jozTc5rOygSi/p+WPHgbAGc3xW9j4n2rTp5gtYlqo/j72jm3v+yEOmoA
         glFcFmBIPLiXp5vMNt4FYcZGRNLZoP5Kjsa7Kbh/YDiAxVYYfsO5Dhqf0Uxlsa2Jwn
         dmvEkRRqbOGu9JaWeUGXXWQ0b0G9vCInXY1c24CuS8Wgb0qur+p2dFbxMrH2X4tu/Z
         6y7RCzJNQL7ipHQiwYnLvPY6dH9EXVCorv7Jj6h0hl0F1Qd2I0drAidoMcQ7pr5/z8
         2SfTzJyBD345EDkowZQ+bX34EkzOkEA4FboreNze0g3Sqk3tEYnkVmtoZlseQ2xD1a
         PyK0dupoAvLC9CFwK9ptg/3tdFFBKHB3puyOHXjn2cJf085Vhp1CZKTYuKGMDNyJpM
         06MlpWChmEGobw9E485jeYim6AoirmZByalS32eoXpKUrI5el+bTm5kgG7T9Nl35gk
         jLCwML2I/mG9VjlobxXr3WQoQhAobEpJ3LIxcdy+k+KMXgGIdvQ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/20] sha1_name: convert struct disambiguate_state to object_id
Date:   Sat, 18 Mar 2017 21:19:44 +0000
Message-Id: <20170318211954.564030-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318211954.564030-1-sandals@crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert struct disambiguate_state to use struct object_id by changing
the structure definition and applying the following semantic patch:

@@
struct disambiguate_state E1;
@@
- E1.bin_pfx
+ E1.bin_pfx.hash

@@
struct disambiguate_state *E1;
@@
- E1->bin_pfx
+ E1->bin_pfx.hash

@@
struct disambiguate_state E1;
@@
- E1.candidate
+ E1.candidate.hash

@@
struct disambiguate_state *E1;
@@
- E1->candidate
+ E1->candidate.hash

This conversion is needed so we can convert disambiguate_hint_fn later.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1_name.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 3db166b40b..cf6f4be0c6 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -16,11 +16,11 @@ typedef int (*disambiguate_hint_fn)(const unsigned char *, void *);
 struct disambiguate_state {
 	int len; /* length of prefix in hex chars */
 	char hex_pfx[GIT_MAX_HEXSZ + 1];
-	unsigned char bin_pfx[GIT_MAX_RAWSZ];
+	struct object_id bin_pfx;
 
 	disambiguate_hint_fn fn;
 	void *cb_data;
-	unsigned char candidate[GIT_MAX_RAWSZ];
+	struct object_id candidate;
 	unsigned candidate_exists:1;
 	unsigned candidate_checked:1;
 	unsigned candidate_ok:1;
@@ -37,10 +37,10 @@ static void update_candidates(struct disambiguate_state *ds, const unsigned char
 	}
 	if (!ds->candidate_exists) {
 		/* this is the first candidate */
-		hashcpy(ds->candidate, current);
+		hashcpy(ds->candidate.hash, current);
 		ds->candidate_exists = 1;
 		return;
-	} else if (!hashcmp(ds->candidate, current)) {
+	} else if (!hashcmp(ds->candidate.hash, current)) {
 		/* the same as what we already have seen */
 		return;
 	}
@@ -52,14 +52,14 @@ static void update_candidates(struct disambiguate_state *ds, const unsigned char
 	}
 
 	if (!ds->candidate_checked) {
-		ds->candidate_ok = ds->fn(ds->candidate, ds->cb_data);
+		ds->candidate_ok = ds->fn(ds->candidate.hash, ds->cb_data);
 		ds->disambiguate_fn_used = 1;
 		ds->candidate_checked = 1;
 	}
 
 	if (!ds->candidate_ok) {
 		/* discard the candidate; we know it does not satisfy fn */
-		hashcpy(ds->candidate, current);
+		hashcpy(ds->candidate.hash, current);
 		ds->candidate_checked = 0;
 		return;
 	}
@@ -151,7 +151,7 @@ static void unique_in_pack(struct packed_git *p,
 		int cmp;
 
 		current = nth_packed_object_sha1(p, mid);
-		cmp = hashcmp(ds->bin_pfx, current);
+		cmp = hashcmp(ds->bin_pfx.hash, current);
 		if (!cmp) {
 			first = mid;
 			break;
@@ -170,7 +170,7 @@ static void unique_in_pack(struct packed_git *p,
 	 */
 	for (i = first; i < num && !ds->ambiguous; i++) {
 		current = nth_packed_object_sha1(p, i);
-		if (!match_sha(ds->len, ds->bin_pfx, current))
+		if (!match_sha(ds->len, ds->bin_pfx.hash, current))
 			break;
 		update_candidates(ds, current);
 	}
@@ -213,12 +213,12 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 		 * same repository!
 		 */
 		ds->candidate_ok = (!ds->disambiguate_fn_used ||
-				    ds->fn(ds->candidate, ds->cb_data));
+				    ds->fn(ds->candidate.hash, ds->cb_data));
 
 	if (!ds->candidate_ok)
 		return SHORT_NAME_AMBIGUOUS;
 
-	hashcpy(sha1, ds->candidate);
+	hashcpy(sha1, ds->candidate.hash);
 	return 0;
 }
 
@@ -332,7 +332,7 @@ static int init_object_disambiguation(const char *name, int len,
 		ds->hex_pfx[i] = c;
 		if (!(i & 1))
 			val <<= 4;
-		ds->bin_pfx[i >> 1] |= val;
+		ds->bin_pfx.hash[i >> 1] |= val;
 	}
 
 	ds->len = len;

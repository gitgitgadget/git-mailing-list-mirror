Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4130E1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 22:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbeBBWgp (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 17:36:45 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35067 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbeBBWgl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 17:36:41 -0500
Received: by mail-pf0-f196.google.com with SMTP id t12so18044176pfg.2
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 14:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=pVz2WNq/OXOWy4NISiNfxuA9MDM5GjXtidO9yBno0Pw=;
        b=LPBd7lWrF7kWV7epNhn+5Eaesuxet/2fhqrXBDU/asb7KU7Whnch+ayqmrmsS41NSm
         6Woir1p8ece3CPxdDphvggRsnmHSGVQ+yEYpL+i2/yLkUKKYGo3Xyiyd8om61Ell3uhR
         sb1LM6IgAPSexM0uJ2rVgXkJS3Dl/7/1Ihr1YQx4YzLdJQRm/lpC0H7V2/2n30bsHTZF
         +eZtlXU5N13q4MZYxLCIndWrmpRwHuDHYPJd+EUtH1Lgqneg9jF2cPrAeqIieAS4SznY
         xQVDZALAb4ZUft0/eogv8mouG3C8WPfc732bb6dk4/yQ80kugA+5JYGVbukFdDeS4G27
         UuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=pVz2WNq/OXOWy4NISiNfxuA9MDM5GjXtidO9yBno0Pw=;
        b=MUV//D+2RZoRoFcrDzdzWPODqQlEw9uWPl8Pt9mx/wJZFEKwVlhLqu08kLzyGU9IyJ
         ddwpEAG+XHQvpsFktLs9bdyrcadPSEtq48IkTRSwPOWFnCbons9dYUlFlBh4FVCMcOwG
         TH1ubE2a2MqhIV65tVGZH/aL9OrxVbAMsjjPkZERp5nk5I63XxcHc0s5vi6ThbOprA7M
         6KYhFKjuIzKjonzuucqi9+GX4IIkBcjOWxRZWltHpAV6NRguzA1TsKpjEXP9FLca+rbr
         Nv4R0GNpRg8A+ahQKiYabIUTcNuegXME0HU43gUbLNI+SZdiNvtQc4TRZMXIR+9doyAe
         okSA==
X-Gm-Message-State: AKwxyteqvzH3Jnarw0kz2szQZ+fGfsG3SBMsWEuuPINC15gs+ujxbMo+
        SaU9ikB3EF+uIXCGzbSFDS7wICKRXCw=
X-Google-Smtp-Source: AH8x226SoPLNWEE0w8EuiObSe282xoIunxDCaD2IHY3o3nLtl9AafEpu2c0OHK60ffXKZg6BF4GZ6g==
X-Received: by 10.98.36.77 with SMTP id r74mr41972204pfj.31.1517611000059;
        Fri, 02 Feb 2018 14:36:40 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id b81sm5878168pfm.25.2018.02.02.14.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Feb 2018 14:36:39 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com
Subject: [PATCH 2/2] packfile: refactor hash search with fanout table
Date:   Fri,  2 Feb 2018 14:36:31 -0800
Message-Id: <007f3a4c84cb1c07255404ad1ea9f797129c5cf0.1517609773.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1517609773.git.jonathantanmy@google.com>
References: <cover.1517609773.git.jonathantanmy@google.com>
In-Reply-To: <cover.1517609773.git.jonathantanmy@google.com>
References: <cover.1517609773.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subsequent patches will introduce file formats that make use of a fanout
array and a sorted table containing hashes, just like packfiles.
Refactor the hash search in packfile.c into its own function, so that
those patches can make use of it as well.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 packfile.c    | 19 +++++--------------
 sha1-lookup.c | 24 ++++++++++++++++++++++++
 sha1-lookup.h | 21 +++++++++++++++++++++
 3 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/packfile.c b/packfile.c
index 58bdced3b..29f5dc239 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1712,7 +1712,8 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 {
 	const uint32_t *level1_ofs = p->index_data;
 	const unsigned char *index = p->index_data;
-	unsigned hi, lo, stride;
+	unsigned stride;
+	int ret;
 
 	if (!index) {
 		if (open_pack_index(p))
@@ -1725,8 +1726,6 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 		index += 8;
 	}
 	index += 4 * 256;
-	hi = ntohl(level1_ofs[*sha1]);
-	lo = ((*sha1 == 0x0) ? 0 : ntohl(level1_ofs[*sha1 - 1]));
 	if (p->index_version > 1) {
 		stride = 20;
 	} else {
@@ -1734,17 +1733,9 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 		index += 4;
 	}
 
-	while (lo < hi) {
-		unsigned mi = lo + (hi - lo) / 2;
-		int cmp = hashcmp(index + mi * stride, sha1);
-
-		if (!cmp)
-			return nth_packed_object_offset(p, mi);
-		if (cmp > 0)
-			hi = mi;
-		else
-			lo = mi+1;
-	}
+	ret = bsearch_hash(sha1, level1_ofs, index, stride);
+	if (ret >= 0)
+		return nth_packed_object_offset(p, ret);
 	return 0;
 }
 
diff --git a/sha1-lookup.c b/sha1-lookup.c
index 4cf3ebd92..d11c5e526 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -99,3 +99,27 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
 	} while (lo < hi);
 	return -lo-1;
 }
+
+int bsearch_hash(const unsigned char *sha1, const void *fanout_,
+		 const void *table_, size_t stride)
+{
+	const uint32_t *fanout = fanout_;
+	const unsigned char *table = table_;
+	int hi, lo;
+
+	hi = ntohl(fanout[*sha1]);
+	lo = ((*sha1 == 0x0) ? 0 : ntohl(fanout[*sha1 - 1]));
+
+	while (lo < hi) {
+		unsigned mi = lo + (hi - lo) / 2;
+		int cmp = hashcmp(table + mi * stride, sha1);
+
+		if (!cmp)
+			return mi;
+		if (cmp > 0)
+			hi = mi;
+		else
+			lo = mi + 1;
+	}
+	return -lo - 1;
+}
diff --git a/sha1-lookup.h b/sha1-lookup.h
index cf5314f40..3c59e9cb1 100644
--- a/sha1-lookup.h
+++ b/sha1-lookup.h
@@ -7,4 +7,25 @@ extern int sha1_pos(const unsigned char *sha1,
 		    void *table,
 		    size_t nr,
 		    sha1_access_fn fn);
+
+/*
+ * Searches for sha1 in table, using the given fanout table to determine the
+ * interval to search, then using binary search. Returns the element index of
+ * the position found if successful, -i-1 if not (where i is the index of the
+ * least element that is greater than sha1).
+ *
+ * Takes the following parameters:
+ *
+ *  - sha1: the hash to search for
+ *  - fanout: a 256-element array of NETWORK-order 32-bit integers; the integer
+ *    at position i represents the number of elements in table whose first byte
+ *    is less than or equal to i
+ *  - table: a sorted list of hashes with optional extra information in between
+ *  - stride: distance between two consecutive elements in table (should be
+ *    GIT_MAX_RAWSZ or greater)
+ *
+ * This function does not verify the validity of the fanout table.
+ */
+extern int bsearch_hash(const unsigned char *sha1, const void *fanout,
+			const void *table, size_t stride);
 #endif
-- 
2.16.0.rc1.238.g530d649a79-goog


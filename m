Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B051D1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 18:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965504AbeBMSjy (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 13:39:54 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43928 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965440AbeBMSjw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 13:39:52 -0500
Received: by mail-pg0-f68.google.com with SMTP id f6so445856pgs.10
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 10:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=P16bF2Eap83d7zq9E8SefpHXA5TZMetgN6ECrO4f0Us=;
        b=ZvSoYq0Ma0ztg2JdMF8D8OfX7fCkb85oliIfOHdkoNaA8/1fNWfo5rxwcAQQAXlddn
         SsVCTjZii8Uzx6O6Na2J4FcFmCTgnj+6R6aFZGwLnW89HpXVvswllNVibtywtMf011Ho
         Zi3ZR24wE1DV2a9aKhjQq0AsFAzpvvMr5WsbcoRdvo7pOr1FMw7lCLfXnnbIQgdqNDtS
         a0BrmLle9bgv0k39qG3TjspJTuNdUuLAqxIdPWINf7AIWHt22UrkScY1laA03FrFU8OY
         5lFw4xmPRs8AzwTCOf28g029wfqJr64wpbwUveEvcWePQ9wIWObnq7X3A4TP/m+yv9oX
         ZN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=P16bF2Eap83d7zq9E8SefpHXA5TZMetgN6ECrO4f0Us=;
        b=UZvZ/ROz6F8E3Iuv4UdmaJZMcAOHKV8oSP6FSX4DTGMXlK1Zs7hUhk/WJddB3yHG/s
         SzjRHvShqU3HK88eHkZwtOKK5pLmoQGkBEOVT4gcqlSB9k0eHI6zyw6SCD0gW20JmNE4
         jaTdDWw0Gadp3zfbFnvSJgkbdpnf+Ngi6s5dviXCGWH3YQgBICQU9hWF0Qo14InIyF3f
         aWox/ays0YFHkQaQwAEYBPEj/sEuOTOLHJpQYeQJGC+e10X8jT+Mrto0mQj7qc9CGs/6
         an+Gs37+EZn0jSZ2yO27A2wcAtA2OmBmg50zB62oQXSGS/nBiHH2MJBFxSdI7WScCKkr
         r1WQ==
X-Gm-Message-State: APf1xPAHMBYy3E8KKed5UfFIDr2UiF2IcxeQcME4x7QTBrovkYHL0N2I
        02jdwKoGtLUWdFq4zzhXhLzxZXIL8y8=
X-Google-Smtp-Source: AH8x226/53rI3nl6CbA5xia/K5BlalhX+Vcg8ThMeTaSnWmSC9L7zYrPYVB2R3YNFlyoXNSO7GZVKQ==
X-Received: by 10.99.146.68 with SMTP id s4mr1704405pgn.295.1518547191678;
        Tue, 13 Feb 2018 10:39:51 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id i69sm29944102pfk.24.2018.02.13.10.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Feb 2018 10:39:50 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     l.s.r@web.de, stolee@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 2/2] packfile: refactor hash search with fanout table
Date:   Tue, 13 Feb 2018 10:39:39 -0800
Message-Id: <2d8fa466892681737322bc9ac21c42372c40a841.1518546891.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <cover.1518546891.git.jonathantanmy@google.com>
References: <cover.1517609773.git.jonathantanmy@google.com>
 <cover.1518546891.git.jonathantanmy@google.com>
In-Reply-To: <cover.1518546891.git.jonathantanmy@google.com>
References: <cover.1518546891.git.jonathantanmy@google.com>
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
 packfile.c    | 18 ++++--------------
 sha1-lookup.c | 28 ++++++++++++++++++++++++++++
 sha1-lookup.h | 22 ++++++++++++++++++++++
 3 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/packfile.c b/packfile.c
index 58bdced3b..59648a182 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1712,7 +1712,8 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 {
 	const uint32_t *level1_ofs = p->index_data;
 	const unsigned char *index = p->index_data;
-	unsigned hi, lo, stride;
+	unsigned stride;
+	uint32_t result;
 
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
@@ -1734,17 +1733,8 @@ off_t find_pack_entry_one(const unsigned char *sha1,
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
+	if (bsearch_hash(sha1, level1_ofs, index, stride, &result))
+		return nth_packed_object_offset(p, result);
 	return 0;
 }
 
diff --git a/sha1-lookup.c b/sha1-lookup.c
index 4cf3ebd92..8d0b1db3e 100644
--- a/sha1-lookup.c
+++ b/sha1-lookup.c
@@ -99,3 +99,31 @@ int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
 	} while (lo < hi);
 	return -lo-1;
 }
+
+int bsearch_hash(const unsigned char *sha1, const uint32_t *fanout_nbo,
+		 const unsigned char *table, size_t stride, uint32_t *result)
+{
+	uint32_t hi, lo;
+
+	hi = ntohl(fanout_nbo[*sha1]);
+	lo = ((*sha1 == 0x0) ? 0 : ntohl(fanout_nbo[*sha1 - 1]));
+
+	while (lo < hi) {
+		unsigned mi = lo + (hi - lo) / 2;
+		int cmp = hashcmp(table + mi * stride, sha1);
+
+		if (!cmp) {
+			if (result)
+				*result = mi;
+			return 1;
+		}
+		if (cmp > 0)
+			hi = mi;
+		else
+			lo = mi + 1;
+	}
+
+	if (result)
+		*result = lo;
+	return 0;
+}
diff --git a/sha1-lookup.h b/sha1-lookup.h
index cf5314f40..7678b23b3 100644
--- a/sha1-lookup.h
+++ b/sha1-lookup.h
@@ -7,4 +7,26 @@ extern int sha1_pos(const unsigned char *sha1,
 		    void *table,
 		    size_t nr,
 		    sha1_access_fn fn);
+
+/*
+ * Searches for sha1 in table, using the given fanout table to determine the
+ * interval to search, then using binary search. Returns 1 if found, 0 if not.
+ *
+ * Takes the following parameters:
+ *
+ *  - sha1: the hash to search for
+ *  - fanout_nbo: a 256-element array of NETWORK-order 32-bit integers; the
+ *    integer at position i represents the number of elements in table whose
+ *    first byte is less than or equal to i
+ *  - table: a sorted list of hashes with optional extra information in between
+ *  - stride: distance between two consecutive elements in table (should be
+ *    GIT_MAX_RAWSZ or greater)
+ *  - result: if not NULL, this function stores the element index of the
+ *    position found (if the search is successful) or the index of the least
+ *    element that is greater than sha1 (if the search is not successful)
+ *
+ * This function does not verify the validity of the fanout table.
+ */
+int bsearch_hash(const unsigned char *sha1, const uint32_t *fanout_nbo,
+		 const unsigned char *table, size_t stride, uint32_t *result);
 #endif
-- 
2.16.0.rc1.238.g530d649a79-goog


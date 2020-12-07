Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791C1C4167B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C20823428
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgLGTLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:11:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:55258 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgLGTLj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 14:11:39 -0500
Received: (qmail 9034 invoked by uid 109); 7 Dec 2020 19:10:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Dec 2020 19:10:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25674 invoked by uid 111); 7 Dec 2020 19:10:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Dec 2020 14:10:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 7 Dec 2020 14:10:57 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/9] oid-array: make sort function public
Message-ID: <X85+QVRIX4L+k44J@coredump.intra.peff.net>
References: <X85+GbvmN4wIjsYY@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X85+GbvmN4wIjsYY@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We sort the oid-array as a side effect of calling the lookup or
unique-iteration functions. But callers may want to sort it themselves
(especially as we add new iteration options in future patches).

We'll also move the check of the "sorted" flag into the sort function,
so callers don't have to remember to check it.

Signed-off-by: Jeff King <peff@peff.net>
---
 oid-array.c | 10 +++++-----
 oid-array.h |  5 +++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/oid-array.c b/oid-array.c
index 8657a5cedf..29f718d835 100644
--- a/oid-array.c
+++ b/oid-array.c
@@ -14,8 +14,10 @@ static int void_hashcmp(const void *a, const void *b)
 	return oidcmp(a, b);
 }
 
-static void oid_array_sort(struct oid_array *array)
+void oid_array_sort(struct oid_array *array)
 {
+	if (array->sorted)
+		return;
 	QSORT(array->oid, array->nr, void_hashcmp);
 	array->sorted = 1;
 }
@@ -28,8 +30,7 @@ static const unsigned char *sha1_access(size_t index, void *table)
 
 int oid_array_lookup(struct oid_array *array, const struct object_id *oid)
 {
-	if (!array->sorted)
-		oid_array_sort(array);
+	oid_array_sort(array);
 	return sha1_pos(oid->hash, array->oid, array->nr, sha1_access);
 }
 
@@ -64,8 +65,7 @@ int oid_array_for_each_unique(struct oid_array *array,
 {
 	size_t i;
 
-	if (!array->sorted)
-		oid_array_sort(array);
+	oid_array_sort(array);
 
 	for (i = 0; i < array->nr; i++) {
 		int ret;
diff --git a/oid-array.h b/oid-array.h
index 2c8b64c393..6a22c0ac94 100644
--- a/oid-array.h
+++ b/oid-array.h
@@ -106,4 +106,9 @@ void oid_array_filter(struct oid_array *array,
 		      for_each_oid_fn want,
 		      void *cbdata);
 
+/**
+ * Sort the array in order of ascending object id.
+ */
+void oid_array_sort(struct oid_array *array);
+
 #endif /* OID_ARRAY_H */
-- 
2.29.2.980.g762a4e4ed3


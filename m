Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EE7C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 18:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E91522CA1
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 18:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbgLDSyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 13:54:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:51814 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbgLDSyF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 13:54:05 -0500
Received: (qmail 31812 invoked by uid 109); 4 Dec 2020 18:53:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Dec 2020 18:53:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14114 invoked by uid 111); 4 Dec 2020 18:53:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Dec 2020 13:53:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Dec 2020 13:53:23 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 6/9] oid-array: provide a for-loop iterator
Message-ID: <X8qFo+GJJTbaPV58@coredump.intra.peff.net>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We provide oid_array_for_each_unique() for iterating over the
de-duplicated items in an array. But it's awkward to use for two
reasons:

  1. It uses a callback, which means marshaling arguments into a struct
     and passing it to the callback with a void parameter.

  2. The callback doesn't know the numeric index of the oid we're
     looking at. This is useful for things like progress meters.

Iterating with a for-loop is much more natural for some cases, but the
caller has to do the de-duping itself. However, we can provide a small
helper to make this easier (see the docstring in the header for an
example use).

The caller does have to remember to sort the array first. We could add
an assertion into the helper that array->sorted is set, but I didn't
want to complicate what is otherwise a pretty fast code path.

I also considered adding a full iterator type with init/next/end
functions (similar to what we have for hashmaps). But it ended up making
the callers much harder to read. This version keeps us close to a basic
for-loop.

Yet another option would be adding an option to sort the array and
compact out the duplicates. This would mean iterating over the array an
extra time, though that's probably not a big deal (we did just do an
O(n log n) sort). But we'd still have to write a for-loop to iterate, so
it doesn't really make anything easier for the caller.

No new test, since we'll convert the callback iterator (which is covered
by t0064, among other callers) to use the new code.

Signed-off-by: Jeff King <peff@peff.net>
---
 oid-array.c |  7 ++-----
 oid-array.h | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/oid-array.c b/oid-array.c
index 29f718d835..8e1bcedc0c 100644
--- a/oid-array.c
+++ b/oid-array.c
@@ -67,11 +67,8 @@ int oid_array_for_each_unique(struct oid_array *array,
 
 	oid_array_sort(array);
 
-	for (i = 0; i < array->nr; i++) {
-		int ret;
-		if (i > 0 && oideq(array->oid + i, array->oid + i - 1))
-			continue;
-		ret = fn(array->oid + i, data);
+	for (i = 0; i < array->nr; i = oid_array_next_unique(array, i)) {
+		int ret = fn(array->oid + i, data);
 		if (ret)
 			return ret;
 	}
diff --git a/oid-array.h b/oid-array.h
index 6a22c0ac94..5d86ea5a30 100644
--- a/oid-array.h
+++ b/oid-array.h
@@ -1,6 +1,8 @@
 #ifndef OID_ARRAY_H
 #define OID_ARRAY_H
 
+#include "hash.h"
+
 /**
  * The API provides storage and manipulation of sets of object identifiers.
  * The emphasis is on storage and processing efficiency, making them suitable
@@ -111,4 +113,24 @@ void oid_array_filter(struct oid_array *array,
  */
 void oid_array_sort(struct oid_array *array);
 
+/**
+ * Find the next unique oid in the array after position "cur". You
+ * can use this to iterate over unique elements, like:
+ *
+ *   size_t i;
+ *   oid_array_sort(array);
+ *   for (i = 0; i < array->nr; i = oid_array_next_unique(array, i))
+ *	printf("%s", oid_to_hex(array->oids[i]);
+ *
+ * Non-unique iteration can just increment with "i++" to visit each element.
+ */
+static inline size_t oid_array_next_unique(struct oid_array *array, size_t cur)
+{
+	do {
+		cur++;
+	} while (cur < array->nr &&
+		 oideq(array->oid + cur, array->oid + cur - 1));
+	return cur;
+}
+
 #endif /* OID_ARRAY_H */
-- 
2.29.2.896.g080220a959


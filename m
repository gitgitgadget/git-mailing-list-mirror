Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060EEC35641
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D3820661
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgBXEh4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:37:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:52360 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727186AbgBXEhz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 23:37:55 -0500
Received: (qmail 5258 invoked by uid 109); 24 Feb 2020 04:37:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 04:37:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7021 invoked by uid 111); 24 Feb 2020 04:47:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Feb 2020 23:47:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Feb 2020 23:37:54 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 10/10] packfile: drop nth_packed_object_sha1()
Message-ID: <20200224043754.GJ1018190@coredump.intra.peff.net>
References: <20200224042625.GA1015553@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224042625.GA1015553@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once upon a time, nth_packed_object_sha1() was the primary way to get
the oid of a packfile's index position. But these days we have the more
type-safe nth_packed_object_id() wrapper, and all callers have been
converted.

Let's drop the "sha1" version (turning the safer wrapper into a single
function) so that nobody is tempted to introduce new callers.

Signed-off-by: Jeff King <peff@peff.net>
---
 packfile.c | 23 +++++++----------------
 packfile.h | 12 +++---------
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/packfile.c b/packfile.c
index 90cb5a05ac..f4e752996d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1867,35 +1867,26 @@ int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32
 			    index_lookup, index_lookup_width, result);
 }
 
-const unsigned char *nth_packed_object_sha1(struct packed_git *p,
-					    uint32_t n)
+int nth_packed_object_id(struct object_id *oid,
+			 struct packed_git *p,
+			 uint32_t n)
 {
 	const unsigned char *index = p->index_data;
 	const unsigned int hashsz = the_hash_algo->rawsz;
 	if (!index) {
 		if (open_pack_index(p))
-			return NULL;
+			return -1;
 		index = p->index_data;
 	}
 	if (n >= p->num_objects)
-		return NULL;
+		return -1;
 	index += 4 * 256;
 	if (p->index_version == 1) {
-		return index + (hashsz + 4) * n + 4;
+		oidread(oid, index + (hashsz + 4) * n + 4);
 	} else {
 		index += 8;
-		return index + hashsz * n;
+		oidread(oid, index + hashsz * n);
 	}
-}
-
-int nth_packed_object_id(struct object_id *oid,
-			 struct packed_git *p,
-			 uint32_t n)
-{
-	const unsigned char *hash = nth_packed_object_sha1(p, n);
-	if (!hash)
-		return -1;
-	hashcpy(oid->hash, hash);
 	return 0;
 }
 
diff --git a/packfile.h b/packfile.h
index 95b83ba25b..240aa73b95 100644
--- a/packfile.h
+++ b/packfile.h
@@ -121,15 +121,9 @@ void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
 int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32_t *result);
 
 /*
- * Return the SHA-1 of the nth object within the specified packfile.
- * Open the index if it is not already open.  The return value points
- * at the SHA-1 within the mmapped index.  Return NULL if there is an
- * error.
- */
-const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t n);
-/*
- * Like nth_packed_object_sha1, but write the data into the object specified by
- * the the first argument.  Returns 0 on success, negative otherwise.
+ * Write the oid of the nth object within the specified packfile into the first
+ * parameter. Open the index if it is not already open.  Returns 0 on success,
+ * negative otherwise.
  */
 int nth_packed_object_id(struct object_id *, struct packed_git *, uint32_t n);
 
-- 
2.25.1.823.g95c5488cf7

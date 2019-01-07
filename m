Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4647E1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 08:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfAGIjC (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 03:39:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:56390 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726257AbfAGIjC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 03:39:02 -0500
Received: (qmail 1711 invoked by uid 109); 7 Jan 2019 08:39:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Jan 2019 08:39:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 819 invoked by uid 111); 7 Jan 2019 08:38:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 Jan 2019 03:38:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jan 2019 03:39:00 -0500
Date:   Mon, 7 Jan 2019 03:39:00 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 08/11] sha1-file: drop has_sha1_file()
Message-ID: <20190107083900.GH29431@sigill.intra.peff.net>
References: <20190107083150.GC21362@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107083150.GC21362@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are no callers left of has_sha1_file() or its with_flags()
variant. Let's drop them, and convert has_object_file() from a wrapper
into the "real" function. Ironically, the sha1 variant was just copying
into an object_id internally, so the resulting code is actually shorter!

We can also drop the coccinelle rules for catching has_sha1_file()
callers. Since the function no longer exists, the compiler will do that
for us.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/coccinelle/object_id.cocci | 32 ------------------------------
 object-store.h                     | 12 ++++-------
 sha1-file.c                        | 16 ++-------------
 3 files changed, 6 insertions(+), 54 deletions(-)

diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
index 73886ae583..6a7cf3e02d 100644
--- a/contrib/coccinelle/object_id.cocci
+++ b/contrib/coccinelle/object_id.cocci
@@ -147,35 +147,3 @@ expression E1, E2;
 - hashcmp(E1, E2) != 0
 + !hasheq(E1, E2)
   ...>}
-
-@@
-struct object_id OID;
-@@
-- has_sha1_file(OID.hash)
-+ has_object_file(&OID)
-
-@@
-identifier f != has_object_file;
-struct object_id *OIDPTR;
-@@
-  f(...) {<...
-- has_sha1_file(OIDPTR->hash)
-+ has_object_file(OIDPTR)
-  ...>}
-
-@@
-struct object_id OID;
-expression E;
-@@
-- has_sha1_file_with_flags(OID.hash, E)
-+ has_object_file_with_flags(&OID, E)
-
-@@
-identifier f != has_object_file_with_flags;
-struct object_id *OIDPTR;
-expression E;
-@@
-  f(...) {<...
-- has_sha1_file_with_flags(OIDPTR->hash, E)
-+ has_object_file_with_flags(OIDPTR, E)
-  ...>}
diff --git a/object-store.h b/object-store.h
index 6b1c408753..9e8ac6a1d4 100644
--- a/object-store.h
+++ b/object-store.h
@@ -209,20 +209,16 @@ int read_loose_object(const char *path,
 		      void **contents);
 
 /*
- * Convenience for sha1_object_info_extended() with a NULL struct
+ * Convenience for oid_object_info_extended() with a NULL struct
  * object_info. OBJECT_INFO_SKIP_CACHED is automatically set; pass
  * nonzero flags to also set other flags.
  */
-extern int has_sha1_file_with_flags(const unsigned char *sha1, int flags);
-static inline int has_sha1_file(const unsigned char *sha1)
+int has_object_file_with_flags(const struct object_id *oid, int flags);
+static inline int has_object_file(const struct object_id *oid)
 {
-	return has_sha1_file_with_flags(sha1, 0);
+	return has_object_file_with_flags(oid, 0);
 }
 
-/* Same as the above, except for struct object_id. */
-extern int has_object_file(const struct object_id *oid);
-extern int has_object_file_with_flags(const struct object_id *oid, int flags);
-
 /*
  * Return true iff an alternate object database has a loose object
  * with the specified name.  This function does not respect replace
diff --git a/sha1-file.c b/sha1-file.c
index 449456f2ad..da6d78976f 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1752,26 +1752,14 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	return ret;
 }
 
-int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
+int has_object_file_with_flags(const struct object_id *oid, int flags)
 {
-	struct object_id oid;
 	if (!startup_info->have_repository)
 		return 0;
-	hashcpy(oid.hash, sha1);
-	return oid_object_info_extended(the_repository, &oid, NULL,
+	return oid_object_info_extended(the_repository, oid, NULL,
 					flags | OBJECT_INFO_SKIP_CACHED) >= 0;
 }
 
-int has_object_file(const struct object_id *oid)
-{
-	return has_sha1_file(oid->hash);
-}
-
-int has_object_file_with_flags(const struct object_id *oid, int flags)
-{
-	return has_sha1_file_with_flags(oid->hash, flags);
-}
-
 static void check_tree(const void *buf, size_t size)
 {
 	struct tree_desc desc;
-- 
2.20.1.470.g640a3e2614


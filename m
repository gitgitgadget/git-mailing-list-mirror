Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECB4C46467
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 13:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjAGNug (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 08:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjAGNuf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 08:50:35 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9947C61462
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 05:50:34 -0800 (PST)
Received: (qmail 23512 invoked by uid 109); 7 Jan 2023 13:50:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 07 Jan 2023 13:50:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23821 invoked by uid 111); 7 Jan 2023 13:50:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Jan 2023 08:50:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Jan 2023 08:50:33 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 4/5] repo_read_object_file(): stop wrapping
 read_object_file_extended()
Message-ID: <Y7l4qX4rcnal5R+N@coredump.intra.peff.net>
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The only caller of read_object_file_extended() is the thin wrapper of
repo_read_object_file(). Instead of wrapping, let's just rename the
inner function and let people call it directly. This cleans up the
namespace and reduces confusion.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c  |  8 ++++----
 object-store.h | 18 +++++-------------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/object-file.c b/object-file.c
index f472f2d6a0..80b08fc389 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1695,10 +1695,10 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
  * deal with them should arrange to call oid_object_info_extended() and give
  * error messages themselves.
  */
-void *read_object_file_extended(struct repository *r,
-				const struct object_id *oid,
-				enum object_type *type,
-				unsigned long *size)
+void *repo_read_object_file(struct repository *r,
+			    const struct object_id *oid,
+			    enum object_type *type,
+			    unsigned long *size)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	unsigned flags = OBJECT_INFO_DIE_IF_CORRUPT | OBJECT_INFO_LOOKUP_REPLACE;
diff --git a/object-store.h b/object-store.h
index 6ccacc947b..1a713d89d7 100644
--- a/object-store.h
+++ b/object-store.h
@@ -241,17 +241,10 @@ const char *loose_object_path(struct repository *r, struct strbuf *buf,
 void *map_loose_object(struct repository *r, const struct object_id *oid,
 		       unsigned long *size);
 
-void *read_object_file_extended(struct repository *r,
-				const struct object_id *oid,
-				enum object_type *type,
-				unsigned long *size);
-static inline void *repo_read_object_file(struct repository *r,
-					  const struct object_id *oid,
-					  enum object_type *type,
-					  unsigned long *size)
-{
-	return read_object_file_extended(r, oid, type, size);
-}
+void *repo_read_object_file(struct repository *r,
+			    const struct object_id *oid,
+			    enum object_type *type,
+			    unsigned long *size);
 #ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
 #define read_object_file(oid, type, size) repo_read_object_file(the_repository, oid, type, size)
 #endif
@@ -358,8 +351,7 @@ void assert_oid_type(const struct object_id *oid, enum object_type expect);
 /*
  * Enabling the object read lock allows multiple threads to safely call the
  * following functions in parallel: repo_read_object_file(), read_object_file(),
- * read_object_file_extended(), read_object_with_reference(),
- * oid_object_info() and oid_object_info_extended().
+ * read_object_with_reference(), oid_object_info() and oid_object_info_extended().
  *
  * obj_read_lock() and obj_read_unlock() may also be used to protect other
  * section which cannot execute in parallel with object reading. Since the used
-- 
2.39.0.469.g9000b9c396


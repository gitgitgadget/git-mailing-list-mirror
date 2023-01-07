Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAFBC54EBC
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 13:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjAGNuW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 08:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjAGNuV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 08:50:21 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701415DE56
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 05:50:20 -0800 (PST)
Received: (qmail 23506 invoked by uid 109); 7 Jan 2023 13:50:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 07 Jan 2023 13:50:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23817 invoked by uid 111); 7 Jan 2023 13:50:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Jan 2023 08:50:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Jan 2023 08:50:19 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 3/5] read_object_file_extended(): drop lookup_replace option
Message-ID: <Y7l4m22z4ZT5SQkG@coredump.intra.peff.net>
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our sole caller always passes in "1", so we can just drop the parameter
entirely. Anybody who doesn't want this behavior could easily call
oid_object_info_extended() themselves, as we're just a thin wrapper
around it.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c  | 7 ++-----
 object-store.h | 4 ++--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/object-file.c b/object-file.c
index ed1babbac2..f472f2d6a0 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1698,18 +1698,15 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 void *read_object_file_extended(struct repository *r,
 				const struct object_id *oid,
 				enum object_type *type,
-				unsigned long *size,
-				int lookup_replace)
+				unsigned long *size)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
-	unsigned flags = OBJECT_INFO_DIE_IF_CORRUPT;
+	unsigned flags = OBJECT_INFO_DIE_IF_CORRUPT | OBJECT_INFO_LOOKUP_REPLACE;
 	void *data;
 
 	oi.typep = type;
 	oi.sizep = size;
 	oi.contentp = &data;
-	if (lookup_replace)
-		flags |= OBJECT_INFO_LOOKUP_REPLACE;
 	if (oid_object_info_extended(r, oid, &oi, flags))
 	    return NULL;
 
diff --git a/object-store.h b/object-store.h
index f0aa03bbb9..6ccacc947b 100644
--- a/object-store.h
+++ b/object-store.h
@@ -244,13 +244,13 @@ void *map_loose_object(struct repository *r, const struct object_id *oid,
 void *read_object_file_extended(struct repository *r,
 				const struct object_id *oid,
 				enum object_type *type,
-				unsigned long *size, int lookup_replace);
+				unsigned long *size);
 static inline void *repo_read_object_file(struct repository *r,
 					  const struct object_id *oid,
 					  enum object_type *type,
 					  unsigned long *size)
 {
-	return read_object_file_extended(r, oid, type, size, 1);
+	return read_object_file_extended(r, oid, type, size);
 }
 #ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
 #define read_object_file(oid, type, size) repo_read_object_file(the_repository, oid, type, size)
-- 
2.39.0.469.g9000b9c396


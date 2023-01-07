Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F71C46467
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 13:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjAGNs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 08:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjAGNs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 08:48:57 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D93C6144A
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 05:48:56 -0800 (PST)
Received: (qmail 23483 invoked by uid 109); 7 Jan 2023 13:48:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 07 Jan 2023 13:48:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23772 invoked by uid 111); 7 Jan 2023 13:48:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Jan 2023 08:48:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Jan 2023 08:48:55 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 1/5] object-file: inline calls to read_object()
Message-ID: <Y7l4RznPhTr+O8ZP@coredump.intra.peff.net>
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since read_object() is these days just a thin wrapper around
oid_object_info_extended(), and since it only has two callers, let's
just inline those calls. This has a few positive outcomes:

  - it's a net reduction in source code lines

  - even though the callers end up with a few extra lines, they're now
    more flexible and can use object_info flags directly. So no more
    need to convert die_if_corrupt between parameter/flag, and we can
    ask for lookup replacement with a flag rather than doing it
    ourselves.

  - there's one fewer function in an already crowded namespace (e.g.,
    the difference between read_object() and read_object_file() was not
    immediately obvious; now we only have one of them).

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c  | 45 +++++++++++++++++----------------------------
 object-store.h |  2 +-
 2 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/object-file.c b/object-file.c
index 80a0cd3b35..ed1babbac2 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1671,23 +1671,6 @@ int oid_object_info(struct repository *r,
 	return type;
 }
 
-static void *read_object(struct repository *r,
-			 const struct object_id *oid, enum object_type *type,
-			 unsigned long *size,
-			 int die_if_corrupt)
-{
-	struct object_info oi = OBJECT_INFO_INIT;
-	void *content;
-	oi.typep = type;
-	oi.sizep = size;
-	oi.contentp = &content;
-
-	if (oid_object_info_extended(r, oid, &oi, die_if_corrupt
-				     ? OBJECT_INFO_DIE_IF_CORRUPT : 0) < 0)
-		return NULL;
-	return content;
-}
-
 int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 			struct object_id *oid)
 {
@@ -1709,25 +1692,28 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
 
 /*
  * This function dies on corrupt objects; the callers who want to
- * deal with them should arrange to call read_object() and give error
- * messages themselves.
+ * deal with them should arrange to call oid_object_info_extended() and give
+ * error messages themselves.
  */
 void *read_object_file_extended(struct repository *r,
 				const struct object_id *oid,
 				enum object_type *type,
 				unsigned long *size,
 				int lookup_replace)
 {
+	struct object_info oi = OBJECT_INFO_INIT;
+	unsigned flags = OBJECT_INFO_DIE_IF_CORRUPT;
 	void *data;
-	const struct object_id *repl = lookup_replace ?
-		lookup_replace_object(r, oid) : oid;
 
-	errno = 0;
-	data = read_object(r, repl, type, size, 1);
-	if (data)
-		return data;
+	oi.typep = type;
+	oi.sizep = size;
+	oi.contentp = &data;
+	if (lookup_replace)
+		flags |= OBJECT_INFO_LOOKUP_REPLACE;
+	if (oid_object_info_extended(r, oid, &oi, flags))
+	    return NULL;
 
-	return NULL;
+	return data;
 }
 
 void *read_object_with_reference(struct repository *r,
@@ -2255,15 +2241,18 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 {
 	void *buf;
 	unsigned long len;
+	struct object_info oi = OBJECT_INFO_INIT;
 	enum object_type type;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 	int ret;
 
 	if (has_loose_object(oid))
 		return 0;
-	buf = read_object(the_repository, oid, &type, &len, 0);
-	if (!buf)
+	oi.typep = &type;
+	oi.sizep = &len;
+	oi.contentp = &buf;
+	if (oid_object_info_extended(the_repository, oid, &oi, 0))
 		return error(_("cannot read object for %s"), oid_to_hex(oid));
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
diff --git a/object-store.h b/object-store.h
index 98c1d67946..f0aa03bbb9 100644
--- a/object-store.h
+++ b/object-store.h
@@ -358,7 +358,7 @@ void assert_oid_type(const struct object_id *oid, enum object_type expect);
 /*
  * Enabling the object read lock allows multiple threads to safely call the
  * following functions in parallel: repo_read_object_file(), read_object_file(),
- * read_object_file_extended(), read_object_with_reference(), read_object(),
+ * read_object_file_extended(), read_object_with_reference(),
  * oid_object_info() and oid_object_info_extended().
  *
  * obj_read_lock() and obj_read_unlock() may also be used to protect other
-- 
2.39.0.469.g9000b9c396


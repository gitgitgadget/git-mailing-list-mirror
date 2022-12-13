Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902B7C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 11:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbiLMLNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 06:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbiLMLMa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 06:12:30 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DE81EC58
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 03:11:58 -0800 (PST)
Received: (qmail 14464 invoked by uid 109); 13 Dec 2022 11:11:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Dec 2022 11:11:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4292 invoked by uid 111); 13 Dec 2022 11:11:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Dec 2022 06:11:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Dec 2022 06:11:57 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/9] blob: drop unused parts of parse_blob_buffer()
Message-ID: <Y5hd/bOiM76stTNt@coredump.intra.peff.net>
References: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our parse_blob_buffer() takes a ptr/len combo, just like
parse_tree_buffer(), etc, and returns success or failure. But it doesn't
actually do anything with them; we just set the "parsed" flag in the
object and return success, without even looking at the contents.

There could be some value to keeping these unused parameters:

  - it's consistent with the parse functions for other object types. But
    we already lost that consistency in 837d395a5c (Replace parse_blob()
    with an explanatory comment, 2010-01-18).

  - As the comment from 837d395a5c explains, callers are supposed to
    make sure they have the object content available. So in theory
    asking for these parameters could serve as a signal. But there are
    only two callers, and one of them always passes NULL (after doing a
    streaming check of the object hash).

    This shows that there aren't likely to be a lot of callers (since
    everyone either uses the type-generic parse functions, or handles
    blobs individually), and that they need to take special care anyway
    (because we usually want to avoid loading whole blobs in memory if
    we can avoid it).

So let's just drop these unused parameters, and likewise the useless
return value. While we're touching the header file, let's move the
declaration of parse_blob_buffer() right below that explanatory comment,
where it's more likely to be seen by people looking for the function.

Signed-off-by: Jeff King <peff@peff.net>
---
 blob.c   | 3 +--
 blob.h   | 3 +--
 object.c | 5 ++---
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/blob.c b/blob.c
index 182718aba9..8f83523b0c 100644
--- a/blob.c
+++ b/blob.c
@@ -13,8 +13,7 @@ struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
 	return object_as_type(obj, OBJ_BLOB, 0);
 }
 
-int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size)
+void parse_blob_buffer(struct blob *item)
 {
 	item->object.parsed = 1;
-	return 0;
 }
diff --git a/blob.h b/blob.h
index 1664872055..74555c90c4 100644
--- a/blob.h
+++ b/blob.h
@@ -11,15 +11,14 @@ struct blob {
 
 struct blob *lookup_blob(struct repository *r, const struct object_id *oid);
 
-int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
-
 /**
  * Blobs do not contain references to other objects and do not have
  * structured data that needs parsing. However, code may use the
  * "parsed" bit in the struct object for a blob to determine whether
  * its content has been found to actually be available, so
  * parse_blob_buffer() is used (by object.c) to flag that the object
  * has been read successfully from the database.
  **/
+void parse_blob_buffer(struct blob *item);
 
 #endif /* BLOB_H */
diff --git a/object.c b/object.c
index 682b852a46..344087de4d 100644
--- a/object.c
+++ b/object.c
@@ -212,8 +212,7 @@ struct object *parse_object_buffer(struct repository *r, const struct object_id
 	if (type == OBJ_BLOB) {
 		struct blob *blob = lookup_blob(r, oid);
 		if (blob) {
-			if (parse_blob_buffer(blob, buffer, size))
-				return NULL;
+			parse_blob_buffer(blob);
 			obj = &blob->object;
 		}
 	} else if (type == OBJ_TREE) {
@@ -292,7 +291,7 @@ struct object *parse_object_with_flags(struct repository *r,
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
-		parse_blob_buffer(lookup_blob(r, oid), NULL, 0);
+		parse_blob_buffer(lookup_blob(r, oid));
 		return lookup_object(r, oid);
 	}
 
-- 
2.39.0.546.g5ea984bc66


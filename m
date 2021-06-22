Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915A7C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72890610C7
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFVQI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:08:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:36038 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230064AbhFVQI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 12:08:58 -0400
Received: (qmail 5838 invoked by uid 109); 22 Jun 2021 16:06:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jun 2021 16:06:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28334 invoked by uid 111); 22 Jun 2021 16:06:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jun 2021 12:06:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Jun 2021 12:06:41 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 4/5] object.h: add lookup_object_by_type() function
Message-ID: <YNIKkY9dBo+6pSwi@coredump.intra.peff.net>
References: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some cases it's useful for efficiency reasons to get the type of an
object before deciding whether to parse it, but we still want an object
struct. E.g., in reachable.c, bitmaps give us the type, but we just want
to mark flags on each object. Likewise, we may loop over every object
and only parse tags in order to peel them; checking the type first lets
us avoid parsing the non-tags.

But our lookup_blob(), etc, functions make getting an object struct
annoying: we have to call the right function for every type. And we
cannot just use the generic lookup_object(), because it only returns an
already-seen object; it won't allocate a new object struct.

Let's provide a function that dispatches to the correct lookup_*
function based on a run-time type. In fact, reachable.c already has such
a helper, so we'll just make that public.

I did change the return type from "void *" to "struct object *". While
the former is a clever way to avoid casting inside the function, it's
less safe and less informative to people reading the function
declaration.

The next commit will add a new caller.

Signed-off-by: Jeff King <peff@peff.net>
---
 object.c    | 18 ++++++++++++++++++
 object.h    |  7 +++++++
 reachable.c | 18 ------------------
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/object.c b/object.c
index 14188453c5..07fcf23d7b 100644
--- a/object.c
+++ b/object.c
@@ -185,6 +185,24 @@ struct object *lookup_unknown_object(struct repository *r, const struct object_i
 	return obj;
 }
 
+struct object *lookup_object_by_type(struct repository *r,
+			    const struct object_id *oid,
+			    enum object_type type)
+{
+	switch (type) {
+	case OBJ_COMMIT:
+		return (struct object *)lookup_commit(r, oid);
+	case OBJ_TREE:
+		return (struct object *)lookup_tree(r, oid);
+	case OBJ_TAG:
+		return (struct object *)lookup_tag(r, oid);
+	case OBJ_BLOB:
+		return (struct object *)lookup_blob(r, oid);
+	default:
+		die("BUG: unknown object type %d", type);
+	}
+}
+
 struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
 {
 	struct object *obj;
diff --git a/object.h b/object.h
index eb7e481c39..3b38c9cc98 100644
--- a/object.h
+++ b/object.h
@@ -158,6 +158,13 @@ struct object *parse_object_buffer(struct repository *r, const struct object_id
  */
 struct object *lookup_unknown_object(struct repository *r, const struct object_id *oid);
 
+/*
+ * Dispatch to the appropriate lookup_blob(), lookup_commit(), etc, based on
+ * "type".
+ */
+struct object *lookup_object_by_type(struct repository *r, const struct object_id *oid,
+				     enum object_type type);
+
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p);
 
diff --git a/reachable.c b/reachable.c
index c59847257a..84e3d0d75e 100644
--- a/reachable.c
+++ b/reachable.c
@@ -159,24 +159,6 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 				      FOR_EACH_OBJECT_LOCAL_ONLY);
 }
 
-static void *lookup_object_by_type(struct repository *r,
-				   const struct object_id *oid,
-				   enum object_type type)
-{
-	switch (type) {
-	case OBJ_COMMIT:
-		return lookup_commit(r, oid);
-	case OBJ_TREE:
-		return lookup_tree(r, oid);
-	case OBJ_TAG:
-		return lookup_tag(r, oid);
-	case OBJ_BLOB:
-		return lookup_blob(r, oid);
-	default:
-		die("BUG: unknown object type %d", type);
-	}
-}
-
 static int mark_object_seen(const struct object_id *oid,
 			     enum object_type type,
 			     int exclude,
-- 
2.32.0.352.gff02c21e72


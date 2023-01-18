Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9674AC38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 20:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjARUoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 15:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjARUn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 15:43:58 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537E45F3B1
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 12:43:55 -0800 (PST)
Received: (qmail 3369 invoked by uid 109); 18 Jan 2023 20:43:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Jan 2023 20:43:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24995 invoked by uid 111); 18 Jan 2023 20:43:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Jan 2023 15:43:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Jan 2023 15:43:53 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 5/6] fsck: provide a function to fsck buffer without object
 struct
Message-ID: <Y8haCbAQIV9s/95l@coredump.intra.peff.net>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fsck code has been slowly moving away from requiring an object
struct in commits like 103fb6d43b (fsck: accept an oid instead of a
"struct tag" for fsck_tag(), 2019-10-18), c5b4269b57 (fsck: accept an
oid instead of a "struct commit" for fsck_commit(), 2019-10-18), etc.

However, the only external interface that fsck.c provides is
fsck_object(), which requires an object struct, then promptly discards
everything except its oid and type. Let's factor out the post-discard
part of that function as fsck_buffer(), leaving fsck_object() as a thin
wrapper around it. That will provide more flexibility for callers which
may not have a struct.

Signed-off-by: Jeff King <peff@peff.net>
---
This is obviously preparation for the next patch. But I suspect it could
be used elsewhere, too. Regular fsck wants object structs anyway to hold
flags, I think, but index-pack could probably save some memory and
effort by avoiding them. I didn't look too closely, as it's all out of
scope for this series.

 fsck.c | 29 ++++++++++++++++++-----------
 fsck.h |  8 ++++++++
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/fsck.c b/fsck.c
index 47eaeedd70..c2c8facd2d 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1237,19 +1237,26 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 	if (!obj)
 		return report(options, NULL, OBJ_NONE, FSCK_MSG_BAD_OBJECT_SHA1, "no valid object to fsck");
 
-	if (obj->type == OBJ_BLOB)
-		return fsck_blob(&obj->oid, data, size, options);
-	if (obj->type == OBJ_TREE)
-		return fsck_tree(&obj->oid, data, size, options);
-	if (obj->type == OBJ_COMMIT)
-		return fsck_commit(&obj->oid, data, size, options);
-	if (obj->type == OBJ_TAG)
-		return fsck_tag(&obj->oid, data, size, options);
-
-	return report(options, &obj->oid, obj->type,
+	return fsck_buffer(&obj->oid, obj->type, data, size, options);
+}
+
+int fsck_buffer(const struct object_id *oid, enum object_type type,
+		void *data, unsigned long size,
+		struct fsck_options *options)
+{
+	if (type == OBJ_BLOB)
+		return fsck_blob(oid, data, size, options);
+	if (type == OBJ_TREE)
+		return fsck_tree(oid, data, size, options);
+	if (type == OBJ_COMMIT)
+		return fsck_commit(oid, data, size, options);
+	if (type == OBJ_TAG)
+		return fsck_tag(oid, data, size, options);
+
+	return report(options, oid, type,
 		      FSCK_MSG_UNKNOWN_TYPE,
 		      "unknown type '%d' (internal fsck error)",
-		      obj->type);
+		      type);
 }
 
 int fsck_error_function(struct fsck_options *o,
diff --git a/fsck.h b/fsck.h
index fcecf4101c..668330880e 100644
--- a/fsck.h
+++ b/fsck.h
@@ -183,6 +183,14 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
 int fsck_object(struct object *obj, void *data, unsigned long size,
 	struct fsck_options *options);
 
+/*
+ * Same as fsck_object(), but for when the caller doesn't have an object
+ * struct.
+ */
+int fsck_buffer(const struct object_id *oid, enum object_type,
+		void *data, unsigned long size,
+		struct fsck_options *options);
+
 /*
  * fsck a tag, and pass info about it back to the caller. This is
  * exposed fsck_object() internals for git-mktag(1).
-- 
2.39.1.616.gd06fca9e99


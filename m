Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B3BC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 21:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiHJVBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 17:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHJVBU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 17:01:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251A47A519
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 14:01:19 -0700 (PDT)
Received: (qmail 6835 invoked by uid 109); 10 Aug 2022 21:01:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Aug 2022 21:01:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15536 invoked by uid 111); 10 Aug 2022 21:01:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Aug 2022 17:01:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Aug 2022 17:01:17 -0400
From:   Jeff King <peff@peff.net>
To:     Xavier Morel <xavier.morel@masklinn.net>
Cc:     git@vger.kernel.org
Subject: [PATCH 1/3] tree-walk: add a mechanism for getting non-canonicalized
 modes
Message-ID: <YvQcnW0yvwRwUVKg@coredump.intra.peff.net>
References: <YvQcNpizy9uOZiAz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvQcNpizy9uOZiAz@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using init_tree_desc() and tree_entry() to iterate over a tree, we
always canonicalize the modes coming out of the tree. This is a good
thing to prevent bugs or oddities in normal code paths, but it's
counter-productive for tools like fsck that want to see the exact
contents.

We can address this by adding an option to avoid the extra
canonicalization. A few notes on the implementation:

  - I've attached the new option to the tree_desc struct itself. The
    actual code change is in decode_tree_entry(), which is in turn
    called by the public update_tree_entry(), tree_entry(), and
    init_tree_desc() functions, plus their "gently" counterparts.

    By letting it ride along in the struct, we can avoid changing the
    signature of those functions, which are called many times. Plus it's
    conceptually simpler: you really want a particular iteration of a
    tree to be "raw" or not, rather than individual calls.

  - We still have to set the new option somewhere. The struct is
    initialized by init_tree_desc(). I added the new flags field only to
    the "gently" version. That avoids disturbing the much more numerous
    non-gentle callers, and it makes sense that anybody being careful
    about looking at raw modes would also be careful about bogus trees
    (i.e., the caller will be something like fsck in the first place).

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c      |  4 ++--
 packfile.c  |  2 +-
 tree-walk.c | 14 +++++++++-----
 tree-walk.h |  8 +++++++-
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fsck.c b/fsck.c
index dd4822ba1b..5acc982a7c 100644
--- a/fsck.c
+++ b/fsck.c
@@ -308,7 +308,7 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 		return -1;
 
 	name = fsck_get_object_name(options, &tree->object.oid);
-	if (init_tree_desc_gently(&desc, tree->buffer, tree->size))
+	if (init_tree_desc_gently(&desc, tree->buffer, tree->size, 0))
 		return -1;
 	while (tree_entry_gently(&desc, &entry)) {
 		struct object *obj;
@@ -578,7 +578,7 @@ static int fsck_tree(const struct object_id *tree_oid,
 	const char *o_name;
 	struct name_stack df_dup_candidates = { NULL };
 
-	if (init_tree_desc_gently(&desc, buffer, size)) {
+	if (init_tree_desc_gently(&desc, buffer, size, 0)) {
 		retval += report(options, tree_oid, OBJ_TREE,
 				 FSCK_MSG_BAD_TREE,
 				 "cannot be parsed as a tree");
diff --git a/packfile.c b/packfile.c
index 6b0eb9048e..5ae3ce8ea9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2231,7 +2231,7 @@ static int add_promisor_object(const struct object_id *oid,
 		struct tree *tree = (struct tree *)obj;
 		struct tree_desc desc;
 		struct name_entry entry;
-		if (init_tree_desc_gently(&desc, tree->buffer, tree->size))
+		if (init_tree_desc_gently(&desc, tree->buffer, tree->size, 0))
 			/*
 			 * Error messages are given when packs are
 			 * verified, so do not print any here.
diff --git a/tree-walk.c b/tree-walk.c
index 506234b4b8..74f4d710e8 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -47,17 +47,20 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
 
 	/* Initialize the descriptor entry */
 	desc->entry.path = path;
-	desc->entry.mode = canon_mode(mode);
+	desc->entry.mode = (desc->flags & TREE_DESC_RAW_MODES) ? mode : canon_mode(mode);
 	desc->entry.pathlen = len - 1;
 	oidread(&desc->entry.oid, (const unsigned char *)path + len);
 
 	return 0;
 }
 
-static int init_tree_desc_internal(struct tree_desc *desc, const void *buffer, unsigned long size, struct strbuf *err)
+static int init_tree_desc_internal(struct tree_desc *desc, const void *buffer,
+				   unsigned long size, struct strbuf *err,
+				   enum tree_desc_flags flags)
 {
 	desc->buffer = buffer;
 	desc->size = size;
+	desc->flags = flags;
 	if (size)
 		return decode_tree_entry(desc, buffer, size, err);
 	return 0;
@@ -66,15 +69,16 @@ static int init_tree_desc_internal(struct tree_desc *desc, const void *buffer, u
 void init_tree_desc(struct tree_desc *desc, const void *buffer, unsigned long size)
 {
 	struct strbuf err = STRBUF_INIT;
-	if (init_tree_desc_internal(desc, buffer, size, &err))
+	if (init_tree_desc_internal(desc, buffer, size, &err, 0))
 		die("%s", err.buf);
 	strbuf_release(&err);
 }
 
-int init_tree_desc_gently(struct tree_desc *desc, const void *buffer, unsigned long size)
+int init_tree_desc_gently(struct tree_desc *desc, const void *buffer, unsigned long size,
+			  enum tree_desc_flags flags)
 {
 	struct strbuf err = STRBUF_INIT;
-	int result = init_tree_desc_internal(desc, buffer, size, &err);
+	int result = init_tree_desc_internal(desc, buffer, size, &err, flags);
 	if (result)
 		error("%s", err.buf);
 	strbuf_release(&err);
diff --git a/tree-walk.h b/tree-walk.h
index a5058469e9..6305d53150 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -34,6 +34,11 @@ struct tree_desc {
 
 	/* counts the number of bytes left in the `buffer`. */
 	unsigned int size;
+
+	/* option flags passed via init_tree_desc_gently() */
+	enum tree_desc_flags {
+		TREE_DESC_RAW_MODES = (1 << 0),
+	} flags;
 };
 
 /**
@@ -79,7 +84,8 @@ int update_tree_entry_gently(struct tree_desc *);
  */
 void init_tree_desc(struct tree_desc *desc, const void *buf, unsigned long size);
 
-int init_tree_desc_gently(struct tree_desc *desc, const void *buf, unsigned long size);
+int init_tree_desc_gently(struct tree_desc *desc, const void *buf, unsigned long size,
+			  enum tree_desc_flags flags);
 
 /*
  * Visit the next entry in a tree. Returns 1 when there are more entries
-- 
2.37.1.917.gf0c714241f


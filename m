Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C5F41F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 04:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441842AbfJREyP (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 00:54:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:51666 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728053AbfJREyN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 00:54:13 -0400
Received: (qmail 9389 invoked by uid 109); 18 Oct 2019 04:54:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 04:54:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14121 invoked by uid 111); 18 Oct 2019 04:57:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 00:57:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 00:54:12 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/23] fsck: require an actual buffer for non-blobs
Message-ID: <20191018045412.GH17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fsck_object() function takes in a buffer, but also a "struct
object". The rules for using these vary between types:

  - for a commit, we'll use the provided buffer; if it's NULL, we'll
    fall back to get_commit_buffer(), which loads from either an
    in-memory cache or from disk. If the latter fails, we'd die(), which
    is non-ideal for fsck.

  - for a tag, a NULL buffer will fall back to loading the object from
    disk (and failure would lead to an fsck error)

  - for a tree, we _never_ look at the provided buffer, and always use
    tree->buffer

  - for a blob, we usually don't look at the buffer at all, unless it
    has been marked as a .gitmodule file. In that case we check the
    buffer given to us, or assume a NULL buffer is a very large blob
    (and complain about it)

This is much more complex than it needs to be. It turns out that nobody
ever feeds a NULL buffer that isn't a blob:

  - git-fsck calls fsck_object() only from fsck_obj(). That in turn is
    called by one of:

      - fsck_obj_buffer(), which is a callback to verify_pack(), which
	unpacks everything except large blobs into a buffer (see
	pack-check.c, lines 131-141).

      - fsck_loose(), which hits a BUG() on non-blobs with a NULL buffer
	(builtin/fsck.c, lines 639-640)

    And in either case, we'll have just called parse_object_buffer()
    anyway, which would segfault on a NULL buffer for commits or tags
    (not for trees, but it would install a NULL tree->buffer which would
    later cause a segfault)

  - git-index-pack asserts that the buffer is non-NULL unless the object
    is a blob (see builtin/index-pack.c, line 832)

  - git-unpack-objects always writes a non-NULL buffer into its
    obj_buffer hash, which is then fed to fsck_object(). (There is
    actually a funny thing here where it does not store blob buffers at
    all, nor does it call fsck on them; it does check any needed blobs
    via fsck_finish() though).

Let's make the rules simpler, which reduces the amount of code and gives
us more flexibility in refactoring the fsck code. The new rules are:

  - only blobs are allowed to pass a NULL buffer

  - we always use the provided buffer, never pulling information from
    the object struct

We don't have to adjust any callers, because they were already adhering
to these. Note that we do drop a few fsck identifiers for missing tags,
but that was all dead code (because nobody passed a NULL tag buffer).

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 51 +++++++++------------------------------------------
 fsck.h |  6 +++++-
 2 files changed, 14 insertions(+), 43 deletions(-)

diff --git a/fsck.c b/fsck.c
index 79ce3a97c8..347a0ef5c9 100644
--- a/fsck.c
+++ b/fsck.c
@@ -49,13 +49,11 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 	FUNC(MISSING_SPACE_BEFORE_EMAIL, ERROR) \
 	FUNC(MISSING_TAG, ERROR) \
 	FUNC(MISSING_TAG_ENTRY, ERROR) \
-	FUNC(MISSING_TAG_OBJECT, ERROR) \
 	FUNC(MISSING_TREE, ERROR) \
 	FUNC(MISSING_TREE_OBJECT, ERROR) \
 	FUNC(MISSING_TYPE, ERROR) \
 	FUNC(MISSING_TYPE_ENTRY, ERROR) \
 	FUNC(MULTIPLE_AUTHORS, ERROR) \
-	FUNC(TAG_OBJECT_NOT_TAG, ERROR) \
 	FUNC(TREE_NOT_SORTED, ERROR) \
 	FUNC(UNKNOWN_TYPE, ERROR) \
 	FUNC(ZERO_PADDED_DATE, ERROR) \
@@ -541,7 +539,9 @@ static int verify_ordered(unsigned mode1, const char *name1, unsigned mode2, con
 	return c1 < c2 ? 0 : TREE_UNORDERED;
 }
 
-static int fsck_tree(struct tree *item, struct fsck_options *options)
+static int fsck_tree(struct tree *item,
+		     const char *buffer, unsigned long size,
+		     struct fsck_options *options)
 {
 	int retval = 0;
 	int has_null_sha1 = 0;
@@ -558,7 +558,7 @@ static int fsck_tree(struct tree *item, struct fsck_options *options)
 	unsigned o_mode;
 	const char *o_name;
 
-	if (init_tree_desc_gently(&desc, item->buffer, item->size)) {
+	if (init_tree_desc_gently(&desc, buffer, size)) {
 		retval += report(options, &item->object, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
 		return retval;
 	}
@@ -733,8 +733,8 @@ static int fsck_ident(const char **ident, struct object *obj, struct fsck_option
 	return 0;
 }
 
-static int fsck_commit_buffer(struct commit *commit, const char *buffer,
-	unsigned long size, struct fsck_options *options)
+static int fsck_commit(struct commit *commit, const char *buffer,
+		       unsigned long size, struct fsck_options *options)
 {
 	struct object_id tree_oid, oid;
 	unsigned author_count;
@@ -788,47 +788,15 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 	return 0;
 }
 
-static int fsck_commit(struct commit *commit, const char *data,
-	unsigned long size, struct fsck_options *options)
-{
-	const char *buffer = data ?  data : get_commit_buffer(commit, &size);
-	int ret = fsck_commit_buffer(commit, buffer, size, options);
-	if (!data)
-		unuse_commit_buffer(commit, buffer);
-	return ret;
-}
-
-static int fsck_tag(struct tag *tag, const char *data,
+static int fsck_tag(struct tag *tag, const char *buffer,
 		    unsigned long size, struct fsck_options *options)
 {
 	struct object_id oid;
 	int ret = 0;
-	const char *buffer;
-	char *to_free = NULL, *eol;
+	char *eol;
 	struct strbuf sb = STRBUF_INIT;
 	const char *p;
 
-	if (data)
-		buffer = data;
-	else {
-		enum object_type type;
-
-		buffer = to_free =
-			read_object_file(&tag->object.oid, &type, &size);
-		if (!buffer)
-			return report(options, &tag->object,
-				FSCK_MSG_MISSING_TAG_OBJECT,
-				"cannot read tag object");
-
-		if (type != OBJ_TAG) {
-			ret = report(options, &tag->object,
-				FSCK_MSG_TAG_OBJECT_NOT_TAG,
-				"expected tag got %s",
-			    type_name(type));
-			goto done;
-		}
-	}
-
 	ret = verify_headers(buffer, size, &tag->object, options);
 	if (ret)
 		goto done;
@@ -889,7 +857,6 @@ static int fsck_tag(struct tag *tag, const char *data,
 
 done:
 	strbuf_release(&sb);
-	free(to_free);
 	return ret;
 }
 
@@ -979,7 +946,7 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 	if (obj->type == OBJ_BLOB)
 		return fsck_blob((struct blob *)obj, data, size, options);
 	if (obj->type == OBJ_TREE)
-		return fsck_tree((struct tree *) obj, options);
+		return fsck_tree((struct tree *) obj, data, size, options);
 	if (obj->type == OBJ_COMMIT)
 		return fsck_commit((struct commit *) obj, (const char *) data,
 			size, options);
diff --git a/fsck.h b/fsck.h
index b95595ae5f..e479461075 100644
--- a/fsck.h
+++ b/fsck.h
@@ -52,7 +52,11 @@ struct fsck_options {
  *    0		everything OK
  */
 int fsck_walk(struct object *obj, void *data, struct fsck_options *options);
-/* If NULL is passed for data, we assume the object is local and read it. */
+
+/*
+ * Blob objects my pass a NULL data pointer, which indicates they are too large
+ * to fit in memory. All other types must pass a real buffer.
+ */
 int fsck_object(struct object *obj, void *data, unsigned long size,
 	struct fsck_options *options);
 
-- 
2.23.0.1228.gee29b05929


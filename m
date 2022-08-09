Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6930EC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 23:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiHIX27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 19:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHIX26 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 19:28:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E6B7E829
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 16:28:57 -0700 (PDT)
Received: (qmail 31963 invoked by uid 109); 9 Aug 2022 23:28:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Aug 2022 23:28:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6255 invoked by uid 111); 9 Aug 2022 23:28:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Aug 2022 19:28:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Aug 2022 19:28:55 -0400
From:   Jeff King <peff@peff.net>
To:     Xavier Morel <xavier.morel@masklinn.net>
Cc:     git@vger.kernel.org
Subject: Re: fsck: BAD_FILEMODE diagnostic broken / never triggers
Message-ID: <YvLttyyaZWm4pitu@coredump.intra.peff.net>
References: <B3488A12-BCE3-48C8-915C-E2AC4E71ECD2@masklinn.net>
 <YvLkU3X9lBsG8wXp@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvLkU3X9lBsG8wXp@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 09, 2022 at 06:48:51PM -0400, Jeff King wrote:

> On Sat, Aug 06, 2022 at 03:43:56PM +0200, Xavier Morel wrote:
> 
> > However looking at fsck_tree, it does have a fair amount of code to
> > validate entry modes and a dedicated message id for this (BAD_FILEMODE
> > / badFilemode), it even has a code path for legacy entries with
> > S_IWGRP set (extensively documented under `git fsck --strict`).
> > 
> > I guess, over time mode canonicalisation has slowly creeped earlier
> > the tree-parsing code, and (seemingly for several years) it has been
> > occurring before "git fsck" gets tree entry information, so git fsck
> > simply can not see invalid entry modes?
> 
> Yes, I think you're right. I didn't bisect, but I suspect this goes back
> to 7146e66f08 (tree-walk: finally switch over tree descriptors to
> contain a pre-parsed entry, 2014-02-06).

Hmm, actually, I think this may have been broken since the beginning of
fsck. At least I could not find a version for which the test below
behaves as expected.

> We probably need to provide version of decode_tree_entry() which gives
> the non-canonical mode, and to call it from fsck.

Perhaps something like the patch below.

Note that these are treated with a severity of "warning", so fsck won't
give a non-zero exit. I think it still enough for transfer.fsckObjects
to mark them. I kind of wonder if fixing this at this point might create
more problems than it solves though (e.g., if people have broken modes
in historical objects that servers may now reject).

---
diff --git a/fsck.c b/fsck.c
index dd4822ba1b..b3da1d68c0 100644
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
+	if (init_tree_desc_gently(&desc, buffer, size, TREE_DESC_RAW_MODES)) {
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
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index ab7f31f1dc..d2051e0fda 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -364,6 +364,17 @@ test_expect_success 'tree entry with type mismatch' '
 	test_i18ngrep ! "dangling blob" out
 '
 
+test_expect_success 'tree entry with bogus mode' '
+	test_when_finished "remove_object \$blob" &&
+	test_when_finished "remove_object \$tree" &&
+	blob=$(echo blob | git hash-object -w --stdin) &&
+	blob_oct=$(echo $blob | hex2oct) &&
+	tree=$(printf "100000 foo\0${blob_oct}" |
+	       git hash-object -t tree --stdin -w --literally) &&
+	git fsck 2>err &&
+	grep "$tree: badFilemode" err
+'
+
 test_expect_success 'tag pointing to nonexistent' '
 	badoid=$(test_oid deadbeef) &&
 	cat >invalid-tag <<-EOF &&
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

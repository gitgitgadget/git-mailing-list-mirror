Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B939EC6FA86
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 10:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiIVKL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 06:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiIVKLr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 06:11:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A883474F5
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 03:11:45 -0700 (PDT)
Received: (qmail 5652 invoked by uid 109); 22 Sep 2022 10:11:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Sep 2022 10:11:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 974 invoked by uid 111); 22 Sep 2022 10:11:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Sep 2022 06:11:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Sep 2022 06:11:43 -0400
From:   Jeff King <peff@peff.net>
To:     John Cai <johncai86@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 1/3] fsck: free tree buffers after walking unreachable objects
Message-ID: <Yyw031PqCyYlEqCX@coredump.intra.peff.net>
References: <Yyw0PSVe3YTQGgRS@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yyw0PSVe3YTQGgRS@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After calling fsck_walk(), a tree object struct may be left in the
parsed state, with the full tree contents available via tree->buffer.
It's the responsibility of the caller to free these when it's done with
the object to avoid having many trees allocated at once.

In a regular "git fsck", we hit fsck_walk() only from fsck_obj(), which
does call free_tree_buffer(). Likewise for "--connectivity-only", we see
most objects via traverse_one_object(), which makes a similar call.

The exception is in mark_unreachable_referents(). When using both
"--connectivity-only" and "--dangling" (the latter of which is the
default), we walk all of the unreachable objects, and there we forget to
free. Most cases would not notice this, because they don't have a lot of
unreachable objects, but you can make a pathological case like this:

  git clone --bare /path/to/linux.git repo.git
  cd repo.git
  rm packed-refs ;# now everything is unreachable!
  git fsck --connectivity-only

That ends up with peak heap usage ~18GB, which is (not coincidentally)
close to the size of all uncompressed trees in the repository. After
this patch, the peak heap is only ~2GB.

A few things to note:

  - it might seem like fsck_walk(), if it is parsing the trees, should
    be responsible for freeing them. But the situation is quite tricky.
    In the non-connectivity mode, after we call fsck_walk() we then
    proceed with fsck_object() which actually does the type-specific
    sanity checks on the object contents. We do pass our own separate
    buffer to fsck_object(), but there's a catch: our earlier call to
    parse_object_buffer() may have attached that buffer to the object
    struct! So by freeing it, we leave the rest of the code with a
    dangling pointer.

    Likewise, the call to fsck_walk() in index-pack is subtle. It
    attaches a buffer to the tree object that must not be freed! And
    so rather than calling free_tree_buffer(), it actually detaches it
    by setting tree->buffer to NULL.

    These cases would _probably_ be fixable by having fsck_walk() free
    the tree buffer only when it was the one who allocated it via
    parse_tree(). But that would still leave the callers responsible for
    freeing other cases, so they wouldn't be simplified. While the
    current semantics for fsck_walk() make it easy to accidentally leak
    in new callers, at least they are simple to explain, and it's not a
    function that's likely to get a lot of new call-sites.

    And in any case, it's probably sensible to fix the leak first with
    this simple patch, and try any more complicated refactoring
    separately.

  - a careful reader may notice that fsck_obj() also frees commit
    buffers, but neither the call in traverse_one_object() nor the one
    touched in this patch does so. And indeed, this is another problem
    for --connectivity-only (and accounts for most of the 2GB heap after
    this patch), but it's one we'll fix in a separate commit.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index f7916f06ed..34e575a170 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -228,6 +228,8 @@ static void mark_unreachable_referents(const struct object_id *oid)
 
 	options.walk = mark_used;
 	fsck_walk(obj, NULL, &options);
+	if (obj->type == OBJ_TREE)
+		free_tree_buffer((struct tree *)obj);
 }
 
 static int mark_loose_unreachable_referents(const struct object_id *oid,
-- 
2.38.0.rc1.583.ga560cd8328


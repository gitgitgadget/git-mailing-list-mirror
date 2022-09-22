Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AE4C6FA82
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 10:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiIVKPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 06:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiIVKPl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 06:15:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B1A27DD9
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 03:15:39 -0700 (PDT)
Received: (qmail 5671 invoked by uid 109); 22 Sep 2022 10:15:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Sep 2022 10:15:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1012 invoked by uid 111); 22 Sep 2022 10:15:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Sep 2022 06:15:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Sep 2022 06:15:38 -0400
From:   Jeff King <peff@peff.net>
To:     John Cai <johncai86@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 3/3] parse_object_buffer(): respect save_commit_buffer
Message-ID: <Yyw1ytQv35+m76VC@coredump.intra.peff.net>
References: <Yyw0PSVe3YTQGgRS@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yyw0PSVe3YTQGgRS@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the global variable "save_commit_buffer" is set to 0, then
parse_commit() will throw away the commit object data after parsing it,
rather than sticking it into a commit slab. This goes all the way back
to 60ab26de99 ([PATCH] Avoid wasting memory in git-rev-list,
2005-09-15).

But there's another code path which may similarly stash the buffer:
parse_object_buffer(). This is where we end up if we parse a commit via
parse_object(), and it's used directly in a few other code paths like
git-fsck.

The original goal of 60ab26de99 was avoiding extra memory usage for
rev-list. And there it's not all that important to catch parse_object().
We use that function only for looking at the tips of the traversal, and
the majority of the commits are parsed by following parent links, where
we use parse_commit() directly. So we were wasting some memory, but only
a small portion.

It's much easier to see the effect with fsck. Since we now turn off
save_commit_buffer by default there, we _should_ be able to drop the
freeing of the commit buffer in fsck_obj(). But if we do so (taking the
first hunk of this patch without the rest), then the peak heap of "git
fsck" in a clone of git.git goes from 136MB to 194MB. Teaching
parse_object_buffer() to respect save_commit_buffer brings that down to
134.5MB (it's hard to tell from massif's output, but I suspect the
savings comes from avoiding the overhead of the mostly-empty commit
slab).

Other programs should see a small improvement. Both "rev-list --all" and
"fsck --connectivity-only" improve by a few hundred kilobytes, as they'd
avoid loading the tip objects of their traversals.

Most importantly, no code should be hurt by doing this. Any program that
turns off save_commit_buffer is already making the assumption that any
commit it sees may need to have its object data loaded on demand, as it
doesn't know which ones were parsed by parse_commit() versus
parse_object(). Not to mention that anything parsed by the commit graph
may be in the same boat, even if save_commit_buffer was not disabled.

This should be the only spot that needs to be fixed. Grepping for
set_commit_buffer() shows that this and parse_commit() are the only
relevant calls.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c | 3 ---
 object.c       | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index b45de003d4..41acbc229e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -439,9 +439,6 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 out:
 	if (obj->type == OBJ_TREE)
 		free_tree_buffer((struct tree *)obj);
-	if (obj->type == OBJ_COMMIT)
-		free_commit_buffer(the_repository->parsed_objects,
-				   (struct commit *)obj);
 	return err;
 }
 
diff --git a/object.c b/object.c
index 2e4589bae5..8a74eb85e9 100644
--- a/object.c
+++ b/object.c
@@ -233,7 +233,8 @@ struct object *parse_object_buffer(struct repository *r, const struct object_id
 		if (commit) {
 			if (parse_commit_buffer(r, commit, buffer, size, 1))
 				return NULL;
-			if (!get_cached_commit_buffer(r, commit, NULL)) {
+			if (save_commit_buffer &&
+			    !get_cached_commit_buffer(r, commit, NULL)) {
 				set_commit_buffer(r, commit, buffer, size);
 				*eaten_p = 1;
 			}
-- 
2.38.0.rc1.583.ga560cd8328

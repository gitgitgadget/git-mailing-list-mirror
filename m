Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1315DC04FDE
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 11:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiLMLN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 06:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbiLMLNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 06:13:16 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EBE6419
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 03:12:10 -0800 (PST)
Received: (qmail 14471 invoked by uid 109); 13 Dec 2022 11:12:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Dec 2022 11:12:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4299 invoked by uid 111); 13 Dec 2022 11:12:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Dec 2022 06:12:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Dec 2022 06:12:09 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/9] list-objects: drop process_gitlink() function
Message-ID: <Y5heCZ7uak1kymiV@coredump.intra.peff.net>
References: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our object graph traversal code has a process_gitlink() function which
we call when we see a gitlink entry. The function does nothing; it was
added in the early days of gitlinks by 6e2f441bd4 (Teach git
list-objects logic to not follow gitlinks, 2007-04-13).

The comment above the function talks about some things we _could_ do.
But in the intervening 15 years, nobody has touched the function, and
the submodule code usually makes its own decisions about when and how to
examine the links. At the generic traversal layer, we can't assume that
the pointed-to commit is available.

Let's drop this placeholder that isn't really helping anything. This
silences some -Wunused-parameter warnings, and also gets rid of a crufty
use of "const unsigned char *" to pass a raw hash value.

Signed-off-by: Jeff King <peff@peff.net>
---
 list-objects.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 250d9de41c..7528fe1db2 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -81,36 +81,6 @@ static void process_blob(struct traversal_context *ctx,
 	strbuf_setlen(path, pathlen);
 }
 
-/*
- * Processing a gitlink entry currently does nothing, since
- * we do not recurse into the subproject.
- *
- * We *could* eventually add a flag that actually does that,
- * which would involve:
- *  - is the subproject actually checked out?
- *  - if so, see if the subproject has already been added
- *    to the alternates list, and add it if not.
- *  - process the commit (or tag) the gitlink points to
- *    recursively.
- *
- * However, it's unclear whether there is really ever any
- * reason to see superprojects and subprojects as such a
- * "unified" object pool (potentially resulting in a totally
- * humongous pack - avoiding which was the whole point of
- * having gitlinks in the first place!).
- *
- * So for now, there is just a note that we *could* follow
- * the link, and how to do it. Whether it necessarily makes
- * any sense what-so-ever to ever do that is another issue.
- */
-static void process_gitlink(struct traversal_context *ctx,
-			    const unsigned char *sha1,
-			    struct strbuf *path,
-			    const char *name)
-{
-	/* Nothing to do */
-}
-
 static void process_tree(struct traversal_context *ctx,
 			 struct tree *tree,
 			 struct strbuf *base,
@@ -149,8 +119,7 @@ static void process_tree_contents(struct traversal_context *ctx,
 			process_tree(ctx, t, base, entry.path);
 		}
 		else if (S_ISGITLINK(entry.mode))
-			process_gitlink(ctx, entry.oid.hash,
-					base, entry.path);
+			; /* ignore gitlink */
 		else {
 			struct blob *b = lookup_blob(ctx->revs->repo, &entry.oid);
 			if (!b) {
-- 
2.39.0.546.g5ea984bc66


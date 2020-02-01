Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640C8C33C9E
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 11:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BBA206E3
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 11:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgBALjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 06:39:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:50352 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726297AbgBALjX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 06:39:23 -0500
Received: (qmail 21237 invoked by uid 109); 1 Feb 2020 11:39:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Feb 2020 11:39:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8244 invoked by uid 111); 1 Feb 2020 11:47:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 Feb 2020 06:47:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 Feb 2020 06:39:22 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] tree-walk.c: break circular dependency with unpack-trees
Message-ID: <20200201113922.GE1864948@coredump.intra.peff.net>
References: <20200130095155.GA839988@coredump.intra.peff.net>
 <20200130095338.GC840531@coredump.intra.peff.net>
 <CABPp-BE7E--8Yz3PAcjPQX2RCsbq0Q0gURi3RJuE64KM0eo6mA@mail.gmail.com>
 <20200131092936.GA2916051@coredump.intra.peff.net>
 <CABPp-BFXwin5mR7z7Ocx9bq5LadFF4CxZR03HzZxh5f=1+F6NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFXwin5mR7z7Ocx9bq5LadFF4CxZR03HzZxh5f=1+F6NQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 10:52:30AM -0800, Elijah Newren wrote:

> As far as I can tell, before your change, we can remove the
>    #include "unpack-trees.h"
> from tree-walk.c; nothing uses it.  I do like snipping includes and
> dependencies where they aren't necessary, and this one seems like one
> that could be removed.

Yeah, I think that is the case.

> But, it's not a big deal; if you want to leave that for future work
> for someone else (perhaps even asking me to turn my paragraph above
> into a commit message that rips it out and defines one #define in
> terms of the other), that's fine.

Let's do it now while we're thinking about it. How about the patch below
on top of my series?

-- >8 --
Subject: [PATCH] tree-walk.c: break circular dependency with unpack-trees

The unpack-trees API depends on the tree-walk API. But we've recently
introduced a dependency in tree-walk.c on MAX_UNPACK_TREES, which
doesn't otherwise care about unpack-trees at all.

Let's break that dependency by reversing the constants: we'll introduce
a new MAX_TRAVERSE_TREES which belongs to the tree-walk API. And then we
can define MAX_UNPACK_TREES in terms of that (since unpack-trees cannot
possibly work with more trees than it can traverse at once via
tree-walk).

The value for both will remain at 8. This is somewhat arbitrary and
probably more than is necessary, per ca885a4fe6 (read-tree() and
unpack_trees(): use consistent limit, 2008-03-13), but there's not
really any pressing need to reduce it.

Suggested-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 tree-walk.c    | 3 +--
 tree-walk.h    | 2 ++
 unpack-trees.h | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 3093cf7098..bb0ad34c54 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "tree-walk.h"
-#include "unpack-trees.h"
 #include "dir.h"
 #include "object-store.h"
 #include "tree.h"
@@ -410,7 +409,7 @@ int traverse_trees(struct index_state *istate,
 		   struct traverse_info *info)
 {
 	int error = 0;
-	struct name_entry entry[MAX_UNPACK_TREES];
+	struct name_entry entry[MAX_TRAVERSE_TREES];
 	int i;
 	struct tree_desc_x tx[ARRAY_SIZE(entry)];
 	struct strbuf base = STRBUF_INIT;
diff --git a/tree-walk.h b/tree-walk.h
index 826396c8ed..a5058469e9 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -3,6 +3,8 @@
 
 #include "cache.h"
 
+#define MAX_TRAVERSE_TREES 8
+
 /**
  * The tree walking API is used to traverse and inspect trees.
  */
diff --git a/unpack-trees.h b/unpack-trees.h
index ca94a421a5..ae1557fb80 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -6,7 +6,7 @@
 #include "string-list.h"
 #include "tree-walk.h"
 
-#define MAX_UNPACK_TREES 8
+#define MAX_UNPACK_TREES MAX_TRAVERSE_TREES
 
 struct cache_entry;
 struct unpack_trees_options;
-- 
2.25.0.538.g1d5d7023b0


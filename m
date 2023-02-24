Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C643DC61DA3
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 08:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBXIHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 03:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBXIHe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 03:07:34 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548E055070
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 00:07:33 -0800 (PST)
Received: (qmail 4230 invoked by uid 109); 24 Feb 2023 08:07:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 08:07:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31716 invoked by uid 111); 24 Feb 2023 08:07:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 03:07:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 03:07:32 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/3] fsck: factor out index fsck
Message-ID: <Y/hwRCwaH/pglVVI@coredump.intra.peff.net>
References: <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code to fsck an index operates directly on the_index. Let's move it
into its own function in preparation for handling the index files from
other worktrees.

Since we now have only a single reference to the_index, let's drop
our USE_THE_INDEX_VARIABLE definition and just use the_repository.index
directly. That's a minor cleanup, but also ensures that we didn't miss
any references when moving the code into fsck_index().

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c | 54 ++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d207bd909b..fa101e0db2 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "cache.h"
 #include "repository.h"
@@ -796,6 +795,35 @@ static int fsck_resolve_undo(struct index_state *istate)
 	return 0;
 }
 
+static void fsck_index(struct index_state *istate)
+{
+	unsigned int i;
+
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(istate);
+	for (i = 0; i < istate->cache_nr; i++) {
+		unsigned int mode;
+		struct blob *blob;
+		struct object *obj;
+
+		mode = istate->cache[i]->ce_mode;
+		if (S_ISGITLINK(mode))
+			continue;
+		blob = lookup_blob(the_repository,
+				   &istate->cache[i]->oid);
+		if (!blob)
+			continue;
+		obj = &blob->object;
+		obj->flags |= USED;
+		fsck_put_object_name(&fsck_walk_options, &obj->oid,
+				     ":%s", istate->cache[i]->name);
+		mark_object_reachable(obj);
+	}
+	if (istate->cache_tree)
+		fsck_cache_tree(istate->cache_tree);
+	fsck_resolve_undo(istate);
+}
+
 static void mark_object_for_connectivity(const struct object_id *oid)
 {
 	struct object *obj = lookup_unknown_object(the_repository, oid);
@@ -959,29 +987,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		verify_index_checksum = 1;
 		verify_ce_order = 1;
 		repo_read_index(the_repository);
-		/* TODO: audit for interaction with sparse-index. */
-		ensure_full_index(&the_index);
-		for (i = 0; i < the_index.cache_nr; i++) {
-			unsigned int mode;
-			struct blob *blob;
-			struct object *obj;
-
-			mode = the_index.cache[i]->ce_mode;
-			if (S_ISGITLINK(mode))
-				continue;
-			blob = lookup_blob(the_repository,
-					   &the_index.cache[i]->oid);
-			if (!blob)
-				continue;
-			obj = &blob->object;
-			obj->flags |= USED;
-			fsck_put_object_name(&fsck_walk_options, &obj->oid,
-					     ":%s", the_index.cache[i]->name);
-			mark_object_reachable(obj);
-		}
-		if (the_index.cache_tree)
-			fsck_cache_tree(the_index.cache_tree);
-		fsck_resolve_undo(&the_index);
+		fsck_index(the_repository->index);
 	}
 
 	check_connectivity();
-- 
2.39.2.981.g6157336f25


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ED4C433EF
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 03:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiFSDzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 23:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiFSDzS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 23:55:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BFC11A36
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 20:55:17 -0700 (PDT)
Received: (qmail 23655 invoked by uid 109); 19 Jun 2022 03:55:17 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 19 Jun 2022 03:55:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Sat, 18 Jun 2022 23:55:16 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 2/2] branch: drop unused worktrees variable
Message-ID: <Yq6eJFUPPTv/zc0o@coredump.intra.peff.net>
References: <Yq6deQf96g8M5wdg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yq6deQf96g8M5wdg@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After b489b9d9aa (branch: use branch_checked_out() when deleting refs,
2022-06-14), we no longer look at our local "worktrees" variable, since
branch_checked_out() handles it under the hood. The compiler didn't
notice the unused variable because we call functions to initialize and
free it (so it's not totally unused, it just doesn't do anything
useful).

Signed-off-by: Jeff King <peff@peff.net>
---
It would be neat if there was some way to mark a function as "this is
just allocating a structure, with no useful side effects" and another as
"this is just freeing", which would let the compiler notice that we
don't do anything useful with the structure in between the two. I have a
feeling adding such annotations might be more work than occasionally
finding and cleaning up such useless variables, though. :)

 builtin/branch.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index f875952e7b..55cd9a6e99 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -204,7 +204,6 @@ static void delete_branch_config(const char *branchname)
 static int delete_branches(int argc, const char **argv, int force, int kinds,
 			   int quiet)
 {
-	struct worktree **worktrees;
 	struct commit *head_rev = NULL;
 	struct object_id oid;
 	char *name = NULL;
@@ -242,8 +241,6 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			die(_("Couldn't look up commit object for HEAD"));
 	}
 
-	worktrees = get_worktrees();
-
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
 		int flags = 0;
@@ -314,7 +311,6 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 
 	free(name);
 	strbuf_release(&bname);
-	free_worktrees(worktrees);
 
 	return ret;
 }
-- 
2.37.0.rc1.385.g5f9aa3aa78

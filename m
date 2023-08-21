Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B51EE49A0
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 20:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjHUURa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHUUR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 16:17:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3948CBE
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:17:28 -0700 (PDT)
Received: (qmail 17368 invoked by uid 109); 21 Aug 2023 20:17:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Aug 2023 20:17:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18662 invoked by uid 111); 21 Aug 2023 20:17:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Aug 2023 16:17:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Aug 2023 16:17:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Romain Chossart <romainchossart@gmail.com>, git@vger.kernel.org
Subject: [PATCH v2 4/7] diff: die when failing to read index in git-diff
 builtin
Message-ID: <20230821201727.GD1798590@coredump.intra.peff.net>
References: <20230821201358.GA2663749@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821201358.GA2663749@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the git-diff program fails to read the index in its diff-files or
diff-index helper functions, it propagates the error up the stack. This
eventually lands in diff_result_code(), which does not handle it well
(as discussed in the previous patch).

Since the only sensible thing here is to exit with an error code (and
what we were expecting the propagated error code to cause), let's just
do that directly.

There's no test here, as I'm not even sure this case can be triggered.
The index-reading functions tend to die() themselves when encountering
any errors, and the return value is just the number of entries in the
file (and so always 0 or positive). But let's err on the conservative
side and keep checking the return value. It may be worth digging into as
a separate topic (though index-reading is low-level enough that we
probably want to eventually teach it to propagate errors anyway for
lib-ification purposes, at which point this code would already be doing
the right thing).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/diff.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index d0e187ec18..005f415d36 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -163,12 +163,10 @@ static int builtin_diff_index(struct rev_info *revs,
 		setup_work_tree();
 		if (repo_read_index_preload(the_repository,
 					    &revs->diffopt.pathspec, 0) < 0) {
-			perror("repo_read_index_preload");
-			return -1;
+			die_errno("repo_read_index_preload");
 		}
 	} else if (repo_read_index(the_repository) < 0) {
-		perror("repo_read_cache");
-		return -1;
+		die_errno("repo_read_cache");
 	}
 	return run_diff_index(revs, option);
 }
@@ -289,8 +287,7 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 	setup_work_tree();
 	if (repo_read_index_preload(the_repository, &revs->diffopt.pathspec,
 				    0) < 0) {
-		perror("repo_read_index_preload");
-		return -1;
+		die_errno("repo_read_index_preload");
 	}
 	return run_diff_files(revs, options);
 }
-- 
2.42.0.rc2.423.g967ecb4f2b


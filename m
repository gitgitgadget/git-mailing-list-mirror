Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C7CC7EE2D
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 22:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjBZWak (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 17:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjBZWac (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 17:30:32 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499F419F09
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 14:29:55 -0800 (PST)
Received: (qmail 1928 invoked by uid 109); 26 Feb 2023 22:29:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Feb 2023 22:29:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9560 invoked by uid 111); 26 Feb 2023 22:29:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Feb 2023 17:29:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 26 Feb 2023 17:29:43 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 4/3] fsck: check even zero-entry index files
Message-ID: <Y/vdV4bjorvRYoaR@coredump.intra.peff.net>
References: <c6246ed5-bffc-7af9-1540-4e2071eff5dc@kdbg.org>
 <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
 <xmqqr0uf0y4b.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0uf0y4b.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2023 at 09:30:44AM -0800, Junio C Hamano wrote:

> So we had a separate worktree with its index pointing at an object
> by its resolve-undo (or cache-tree) extension, but somehow lost that
> object to gc (I agree with your assessment that it should no longer
> happen since 2017).  gc these days knows about looking at the index
> of all worktrees, finds the issue, and stops for safety.  fsck that
> is run in the primary worktree may not have noticed but fsck run
> from that worktree would notice the issue.
> 
> Sounds like a frustrating one.  
> 
> Thanks, both, for finding and fixing.

I saw that this hit next, but I had a few fixups that I had planned to
squash in. I saw you got the leak-fix one, but I have one more. Since
this is the end of the cycle, we _could_ just squash it in when we
rewind next. But having now written it as a patch on top, I think the
explanation kind of merits its own commit.

-- >8 --
Subject: [PATCH] fsck: check even zero-entry index files

In fb64ca526a (fsck: check index files in all worktrees, 2023-02-24), we
swapped out a call to vanilla repo_read_index() for a series of
read_index_from() calls, one per worktree. The code for the latter was
copied from add_index_objects_to_pending(), which checks for a positive
return value from the index reading function, and we do the same here in
fsck now.

But this is probably the wrong thing. I had interpreted the check as
"don't operate on the index struct if there was an error". But in
reality, if there is an error then the index-reading code will simply
die (which admittedly is not great for fsck, but that is not a new
problem).

The return value here is actually the number of entries read. So it
makes sense for add_index_objects_to_pending() to ignore a zero-entry
index (there is nothing to add). But for fsck, we would still want to
check any extensions, etc (though presumably it is unlikely to have them
in an empty index, I don't think it's impossible).

So we should ignore the return value from read_index_from() entirely.
This matches the behavior before fb64ca526a, when we ignored the return
value from repo_read_index().

Signed-off-by: Jeff King <peff@peff.net>
---
On top of jk/fsck-indices-in-worktrees.

 builtin/fsck.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 1b032eebb1..64614b43b2 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1007,9 +1007,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			 * while we're examining the index.
 			 */
 			path = xstrdup(worktree_git_path(wt, "index"));
-			if (read_index_from(&istate, path,
-					    get_worktree_git_dir(wt)) > 0)
-				fsck_index(&istate, path, wt->is_current);
+			read_index_from(&istate, path, get_worktree_git_dir(wt));
+			fsck_index(&istate, path, wt->is_current);
 			discard_index(&istate);
 			free(path);
 		}
-- 
2.40.0.rc0.479.g8b3a13b6b0


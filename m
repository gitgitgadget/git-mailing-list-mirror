Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5363EC64ED8
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 08:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBXIFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 03:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBXIFj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 03:05:39 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BBF311C2
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 00:05:37 -0800 (PST)
Received: (qmail 4224 invoked by uid 109); 24 Feb 2023 08:05:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 08:05:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31696 invoked by uid 111); 24 Feb 2023 08:05:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 03:05:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 03:05:36 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/3] fsck index files from all worktrees
Message-ID: <Y/hv0MXAyBY3HEo9@coredump.intra.peff.net>
References: <c6246ed5-bffc-7af9-1540-4e2071eff5dc@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6246ed5-bffc-7af9-1540-4e2071eff5dc@kdbg.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 18, 2023 at 10:38:33AM +0100, Johannes Sixt wrote:

> I see three problems here:
> 
> - git fsck should detect the problem (if it really is one) in the
> worktree index. It seems that it is just an index extension that is
> affected. Perhaps it should be just a warning, not an error.

We do fsck the resolve-undo extension, but I think fsck just doesn't
know anything about worktrees. That should be easy enough to fix.
Patches below.

> - If the objects mentioned in the index extension are precious, they
> should not have been garbage-collected in earlier rounds of git gc
> (which I certainly did at some point).

Correct, but the gc error you're getting indicates that we _are_ trying
to treat them as included. I wonder if you ran git-gc long ago with an
older version of Git, and this breakage was waiting to surface. AFAICT
this was all fixed by 8a044c7f1d (Merge branch 'nd/prune-in-worktree',
2017-09-19).

> - I can't git gc the repository now, which is particularly annoying when
> auto-gc is attempted after almost every git command. Of course, I know
> how to get out of the situation, but it took some time to identify the
> worktree index as the culprit. Not something that a beginner would be
> able to do easily.

I think in general that "oops, there's something corrupt" can be hard to
get out of, just because there are so many possibilities. But if we can
at least report the nature of the problem and the offending filename via
git-fsck, that would help with pointing people in the right direction.

> The repository I use for the above commands is attached. I hope vger
> doesn't strip it away.

Thanks, it was nice to have a test case. I ended up writing a separate
test with a missing blob, just because that's simpler to do. It looks
like we don't test fsck_resolve_undo() or fsck_cache_tree() at all. That
might be a nice addition, but I punted for now to stay focused on the
worktree aspects.

  [1/3]: fsck: factor out index fsck
  [2/3]: fsck: check index files in all worktrees
  [3/3]: fsck: mention file path for index errors

 builtin/fsck.c  | 93 ++++++++++++++++++++++++++++++++-----------------
 t/t1450-fsck.sh | 30 ++++++++++++++++
 2 files changed, 92 insertions(+), 31 deletions(-)

-Peff

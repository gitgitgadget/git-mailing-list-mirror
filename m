Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ECC01F404
	for <e@80x24.org>; Thu, 30 Aug 2018 07:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeH3LzZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 07:55:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:33652 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727203AbeH3LzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 07:55:25 -0400
Received: (qmail 13492 invoked by uid 109); 30 Aug 2018 07:54:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 07:54:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24518 invoked by uid 111); 30 Aug 2018 07:54:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 03:54:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 03:54:31 -0400
Date:   Thu, 30 Aug 2018 03:54:31 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/9] worktree: fix bugs and broaden --force applicability
Message-ID: <20180830075431.GF11944@sigill.intra.peff.net>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180828212026.21989-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 05:20:17PM -0400, Eric Sunshine wrote:

> This series started as a fix for a bug reported by Peff[1] in which the
> "database" of worktrees could be corrupted (or at least become
> internally inconsistent) by having multiple worktree entries associated
> with the same path.
> 
> Peff's particular use-case for git-worktree is Documentation/doc-diff
> which wants to re-use a worktree if it exists or create it anew if it
> doesn't. Unfortunately, this is a bit more difficult than it should be
> if the worktree directory is deleted manually (without pruning the
> worktree entry) between script invocations. To simplify this use-case
> for tools, it was suggested[2] that "git worktree add --force" could
> deal with the problem of a registered-but-missing worktree (much as a
> tool might rely upon "mkdir -p" to create or re-use an existing
> directory). This series implements that proposal, as well.
> 
> Fixing the original bug revealed another existing bug, and after several
> additional "while we're here" changes, the series ended up a bit longer
> than expected.

Thanks for working on this. I think this nicely solves the problem I was
having.  I had a few minor comments which I sent in reply to individual
patches, but overall it looks very good. I'd be happy to see it picked
up with or without any changes based on my comments.

I'd want to do this on top. :)

-- >8 --
Subject: [PATCH] doc-diff: force worktree add

We avoid re-creating our temporary worktree if it's already
there. But we may run into a situation where the worktree
has been deleted, but an entry still exists in
$GIT_DIR/worktrees.

Older versions of git-worktree would annoyingly create a
series of duplicate entries. Recent versions now detect and
prevent this, allowing you to override with "-f". Since we
know that the worktree in question was just our temporary
workspace, it's safe for us to always pass "-f".

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/doc-diff | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index f483fe427c..19d841ddeb 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -54,7 +54,7 @@ fi
 # results that don't differ between the two trees.
 if ! test -d "$tmp/worktree"
 then
-	git worktree add --detach "$tmp/worktree" "$from" &&
+	git worktree add -f --detach "$tmp/worktree" "$from" &&
 	dots=$(echo "$tmp/worktree" | sed 's#[^/]*#..#g') &&
 	ln -s "$dots/config.mak" "$tmp/worktree/config.mak"
 fi
-- 
2.19.0.rc1.539.g3876d0831e


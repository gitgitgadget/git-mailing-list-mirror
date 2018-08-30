Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD3601F404
	for <e@80x24.org>; Thu, 30 Aug 2018 07:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeH3Lhb (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 07:37:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:33620 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727344AbeH3Lhb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 07:37:31 -0400
Received: (qmail 12811 invoked by uid 109); 30 Aug 2018 07:36:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 07:36:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24451 invoked by uid 111); 30 Aug 2018 07:36:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 03:36:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 03:36:42 -0400
Date:   Thu, 30 Aug 2018 03:36:42 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 6/9] worktree: teach 'add' to respect --force for
 registered but missing path
Message-ID: <20180830073642.GC11944@sigill.intra.peff.net>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
 <20180828212026.21989-7-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180828212026.21989-7-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 05:20:23PM -0400, Eric Sunshine wrote:

> For safety, "git worktree add <path>" will refuse to add a new
> worktree at <path> if <path> is already associated with a worktree
> entry, even if <path> is missing (for instance, has been deleted or
> resides on non-mounted removable media or network share). The typical
> way to re-create a worktree at <path> in such a situation is either to
> prune all "broken" entries ("git worktree prune") or to selectively
> remove the worktree entry manually ("git worktree remove <path>").
> 
> However, neither of these approaches ("prune" nor "remove") is
> especially convenient, and they may be unsuitable for scripting when a
> tool merely wants to re-use a worktree if it exists or create it from
> scratch if it doesn't (much as a tool might use "mkdir -p" to re-use
> or create a directory).
> 
> Therefore, teach 'add' to respect --force as a convenient way to
> re-use a path already associated with a worktree entry if the path is
> non-existent. For a locked worktree, require --force to be specified
> twice.

This makes sense to me, and...

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  Documentation/git-worktree.txt |  8 ++++++--
>  builtin/worktree.c             | 10 ++++++++--
>  t/t2025-worktree-add.sh        | 13 ++++++++++++-
>  3 files changed, 26 insertions(+), 5 deletions(-)

The patch looks quite good. One minor comment:

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 1122f27b5f..3eb2f89b0f 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -241,10 +241,16 @@ static void validate_worktree_add(const char *path, const struct add_opts *opts)
>  		goto done;
>  
>  	locked = !!is_worktree_locked(wt);
> +	if ((!locked && opts->force) || (locked && opts->force > 1)) {
> +		if (delete_git_dir(wt->id))
> +		    die(_("unable to re-add worktree '%s'"), path);
> +		goto done;
> +	}

This "unable to re-add" seemed funny to me at first, since the failure
is in deletion. I guess we're relying on delete_git_dir() to already
have said "I had trouble deleting $GIT_DIR/worktrees/foo", and this is
just the follow-up to tell that the whole operation is cancelled. So
that makes sense.

I wonder if we should volunteer the information that we're overwriting
an existing worktree. I guess the user would generally know that
already, though, since they just specified "-f", so it's probably just
being overly chatty to do so.

-Peff

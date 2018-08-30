Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3813F1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 07:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeH3L24 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 07:28:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:33610 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727185AbeH3L24 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 07:28:56 -0400
Received: (qmail 12477 invoked by uid 109); 30 Aug 2018 07:28:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 07:28:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24428 invoked by uid 111); 30 Aug 2018 07:28:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 03:28:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 03:28:08 -0400
Date:   Thu, 30 Aug 2018 03:28:08 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 5/9] worktree: disallow adding same path multiple times
Message-ID: <20180830072808.GB11944@sigill.intra.peff.net>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
 <20180828212026.21989-6-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180828212026.21989-6-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 05:20:22PM -0400, Eric Sunshine wrote:

> A given path should only ever be associated with a single registered
> worktree. This invariant is enforced by refusing to create a new
> worktree at a given path if that path already exists. For example:
> 
>     $ git worktree add -q --detach foo
>     $ git worktree add -q --detach foo
>     fatal: 'foo' already exists
> 
> However, the check can be fooled, and the invariant broken, if the
> path is missing. Continuing the example:
> [...]

Nicely explained.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 46c93771e8..1122f27b5f 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -221,8 +221,33 @@ static const char *worktree_basename(const char *path, int *olen)
>  
>  static void validate_worktree_add(const char *path, const struct add_opts *opts)
>  {
> +	struct worktree **worktrees;
> +	struct worktree *wt;
> +	int locked;
> +
>  	if (file_exists(path) && !is_empty_dir(path))
>  		die(_("'%s' already exists"), path);
> +
> +	worktrees = get_worktrees(0);
> +	/*
> +	 * find_worktree()'s suffix matching may undesirably find the main
> +	 * rather than a linked worktree (for instance, when the basenames
> +	 * of the main worktree and the one being created are the same).
> +	 * We're only interested in linked worktrees, so skip the main
> +	 * worktree with +1.
> +	 */
> +	wt = find_worktree(worktrees + 1, NULL, path);

Very appropriate use of a comment. :)

I wondered whether find_worktree() would discover a collision like this:

  git worktree add --detach foo
  rm -rf foo
  git worktree add --detach bar/foo

but it is smart enough to actually compare the gitdirs and so we
(correctly) create "foo" and "foo1" in $GIT_DIR/worktrees.

> +	if (!wt)
> +		goto done;
> +
> +	locked = !!is_worktree_locked(wt);
> +	if (locked)
> +		die(_("'%s' is a missing but locked worktree;\nuse 'unlock' and 'prune' or 'remove' to clear"), path);
> +	else
> +		die(_("'%s' is a missing but already registered worktree;\nuse 'prune' or 'remove' to clear"), path);

Nice, I like giving separate messages for the locked and unlocked cases
(which I imagine will become even more obvious as you add --force
support).

The formatting of the message itself is a little funny:

  $ git worktree add --detach foo
  fatal: 'foo' is a missing but already registered worktree;
  use 'prune' or 'remove' to clear

I'd say that the second line would ideally be advise(), since we're
dying. You could do:

  error(%s is missing...)
  advise(use prune...)
  exit(128);

but that loses the "fatal" in the first message. I wonder if just
manually writing "hint:" would be so bad.

> +done:
> +	free_worktrees(worktrees);

You could easily avoid this goto with:

  if (wt) {
     /* check wt or die */
  }

  free_worktrees(worktrees);

but it may not be worth it if the logic gets more complicated in future
patches.

-Peff

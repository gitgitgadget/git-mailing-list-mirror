Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AE3E208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 19:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753132AbdHJTQQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 15:16:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:34984 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752816AbdHJTQP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 15:16:15 -0400
Received: (qmail 23263 invoked by uid 109); 10 Aug 2017 19:16:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 19:16:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8264 invoked by uid 111); 10 Aug 2017 19:16:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 15:16:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 15:16:13 -0400
Date:   Thu, 10 Aug 2017 15:16:13 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Willford <kcwillford@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH] commit: skip discarding the index if there is no
 pre-commit hook
Message-ID: <20170810191613.kpmhzg4seyxy3cpq@sigill.intra.peff.net>
References: <20170810185416.8224-1-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170810185416.8224-1-kewillf@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 02:54:16PM -0400, Kevin Willford wrote:

> If there is not a pre-commit hook, there is no reason to discard
> the index and reread it.
> 
> This change checks to presence of a pre-commit hook and then only
> discards the index if there was one.

Sounds like a smart optimization.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index e7a2cb6285..443949d87b 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -671,12 +671,22 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	const char *hook_arg2 = NULL;
>  	int clean_message_contents = (cleanup_mode != CLEANUP_NONE);
>  	int old_display_comment_prefix;
> +	const char *precommit_hook = NULL;

The return value from find_hook() points to storage that may later be
overwritten or even freed.  I know your patch doesn't actually look at
the contents of precommit_hook, but it seems like it's setting up a
potential bomb for somebody later.

Can we make this:

  int have_precommit_hook = 0;
  ...
  have_precommit_hook = !!find_hook("pre-commit");

? Though see below.

> -	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
> -		return 0;
> +
> +	if (!no_verify) {
> +		/*
> +		 * Check to see if there is a pre-commit hook
> +		 * If there not one we can skip discarding the index later on
> +		 */
> +		precommit_hook = find_hook("pre-commit");
> +		if (precommit_hook &&
> +		    run_commit_hook(use_editor, index_file, "pre-commit", NULL))
> +			return 0;
> +	}

We'll find the hook again in run_commit_hook(), but it's not so
expensive that it's worth trying to pass down the hook path we found
(and if we switch to an integer flag we don't have the path anyway ;) ).

But note that we don't even care about precommit_hook here. We could
just call run_commit_hook() regardless. We only care later whether we
ran it or not. So we could drop this hunk and the precommit_hook
variable entirely, and...

> @@ -940,12 +950,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		return 0;
>  	}
>  
> -	/*
> -	 * Re-read the index as pre-commit hook could have updated it,
> -	 * and write it out as a tree.  We must do this before we invoke
> -	 * the editor and after we invoke run_status above.
> -	 */
> -	discard_cache();
> +	if (!no_verify && precommit_hook) {
> +		/*
> +		 * Re-read the index as pre-commit hook could have updated it,
> +		 * and write it out as a tree.  We must do this before we invoke
> +		 * the editor and after we invoke run_status above.
> +		 */
> +		discard_cache();
> +	}

Just make this:

  if (!no_verify && find_hook("pre-commit"))
     ... discard cache ...

That is racy if somebody removes the hook while we're running (so is
your patch, but in the opposite direction). What we really want to know
is "did we run the hook" and annoyingly run_hook_ve() doesn't tell us
that.  So I think the most robust solution would be refactoring that to
pass out the information, and then use the flag here. But I'm not sure
it's actually worth worrying about such a race in practice.

-Peff

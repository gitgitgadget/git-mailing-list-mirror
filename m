Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D74E1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 02:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeJCJAR (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 05:00:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:39366 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726341AbeJCJAR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 05:00:17 -0400
Received: (qmail 28443 invoked by uid 109); 3 Oct 2018 02:14:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Oct 2018 02:14:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8695 invoked by uid 111); 3 Oct 2018 02:13:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Oct 2018 22:13:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2018 22:13:58 -0400
Date:   Tue, 2 Oct 2018 22:13:58 -0400
From:   Jeff King <peff@peff.net>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/3] help: redirect to aliased commands for "git cmd
 --help"
Message-ID: <20181003021358.GA20553@sigill.intra.peff.net>
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
 <20181001112107.28956-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181001112107.28956-1-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 01, 2018 at 01:21:05PM +0200, Rasmus Villemoes wrote:

> As discussed in the thread for v1 of this patch [1] [2], this changes the
> rules for "git foo --help" when foo is an alias.
> 
> (0) When invoked as "git help foo", we continue to print the "foo is
> aliased to bar" message and nothing else.
> 
> (1) If foo is an alias for a shell command, print "foo is aliased to
> !bar" as usual.
> 
> (2) Otherwise, break the alias string into words, and pretend that "git
> word0 --help" was called.
> 
> At least for me, getting the man page for git-cherry-pick directly with
> "git cp --help" is more useful (and how I expect an alias to behave)
> than the short "is aliased to" notice. It is also consistent with
> "--help" generally providing more comprehensive help than "-h".

Makes sense.

> I believe that printing the "is aliased to" message also in case (2) has
> value: Depending on pager setup, or if the user has help.format=web, the
> message is still present immediately above the prompt when the user
> quits the pager/returns to the terminal. That serves as an explanation
> for why one was redirected to "man git-cherry-pick" from "git cp
> --help", and if cp is actually 'cherry-pick -n', it reminds the user
> that using cp has some flag implicitly set before firing off the next
> command.
> 
> It also provides some useful info in case we end up erroring out, either
> in the "bad alias string" check, or in the "No manual entry for gitbar"
> case.

OK, I buy that line of reasoning. And in the other cases, it shouldn't
_hurt_ anything.

> diff --git a/builtin/help.c b/builtin/help.c
> index 8d4f6dd301..4802a06f37 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -415,9 +415,29 @@ static const char *check_git_cmd(const char* cmd)
>  
>  	alias = alias_lookup(cmd);
>  	if (alias) {
> -		printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
> -		free(alias);
> -		exit(0);
> +		const char **argv;
> +		int count;
> +
> +		/*
> +		 * If we were invoked as "git help cmd", or cmd is an
> +		 * alias for a shell command, we inform the user what
> +		 * cmd is an alias for and do nothing else.
> +		 */
> +		if (!exclude_guides || alias[0] == '!') {
> +			printf_ln(_("'%s' is aliased to '%s'"), cmd, alias);
> +			free(alias);
> +			exit(0);
> +		}

I'm not sure I understand why exclude_guides is relevant. We check it
below when we know that we _don't_ have an alias. Hrm. I guess you're
using it here as a proxy for "git foo --help" being used instead of "git
help foo". The comment probably needs to spell out that exclude_guides
is the same as your "we were invoked as...".

I wonder if we could change the name of that option. It is an
undocumented, hidden option that we use internally, so it should be OK
to do so (or we could always add another one). That might prevent
somebody in the future from using --exclude-guides in more places and
breaking your assumption here.

> +		/*
> +		 * Otherwise, we pretend that the command was "git
> +		 * word0 --help.
> +		 */
> +		fprintf_ln(stderr, _("'%s' is aliased to '%s'"), cmd, alias);
> +		count = split_cmdline(alias, &argv);
> +		if (count < 0)
> +			die(_("bad alias.%s string: %s"), cmd,
> +			    split_cmdline_strerror(count));
> +		return alias;

So we split only to find argv[0] here. But then we don't return it. That
works because the split is done in place, meaning we must have inserted
a NUL in alias. That's sufficiently subtle that it might be worth
spelling it out in a comment.

We don't need to free alias here as we do above, because we're passing
it back. We should free argv, though, I think (not its elements, just
the array itself).

Unfortunately the caller is going to leak our returned "alias", but I'm
not sure we can do much about it. I'm not overly concerned with the
memory, but it is going to trigger leak-checkers (and we're trying to
quiet them down, not go the other way). I think it may be OK to overlook
that and just UNLEAK() it in cmd_help().

-Peff

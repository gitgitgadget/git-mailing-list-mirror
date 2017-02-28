Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3FE3201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 12:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbdB1Mv6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 07:51:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:35599 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752352AbdB1Mv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 07:51:57 -0500
Received: (qmail 23198 invoked by uid 109); 28 Feb 2017 12:23:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 12:23:40 +0000
Received: (qmail 25476 invoked by uid 111); 28 Feb 2017 12:23:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 07:23:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 07:23:39 -0500
Date:   Tue, 28 Feb 2017 07:23:39 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/8] interpret_branch_name: allow callers to restrict
 expansions
Message-ID: <20170228122338.xkefanyhtwbomoit@sigill.intra.peff.net>
References: <20170228120633.zkwfqms57fk7dkl5@sigill.intra.peff.net>
 <20170228121434.2dhngs4peq5acic2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170228121434.2dhngs4peq5acic2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 07:14:34AM -0500, Jeff King wrote:

> However, out-parameters make calling interface somewhat
> cumbersome. Instead, let's do the opposite: let the caller
> tell us which elements to expand. That's easier to pass in,
> and none of the callers give more precise error messages
> than "@{upstream} isn't a valid branch name" anyway (which
> should be sufficient).

Two things to call attention to:

> -extern int interpret_branch_name(const char *str, int len, struct strbuf *);
> + *
> + * If "allowed" is non-zero, it is a treated as a bitfield of allowable
> + * expansions: local branches ("refs/heads/"), remote branches
> + * ("refs/remotes/"), or "HEAD". If no "allowed" bits are set, any expansion is
> + * allowed, even ones to refs outside of those namespaces.
> + */
> +#define INTERPRET_BRANCH_LOCAL (1<<0)
> +#define INTERPRET_BRANCH_REMOTE (1<<1)
> +#define INTERPRET_BRANCH_HEAD (1<<2)

Is the "0 allows everything, but any bit turns on restrictions"
convention too confusing? It's convenient to use in the callers which do
not need restrictions, but we could add an INTERPRET_BRANCH_ALL flag if
that is more clear (but note that it _isn't_ just bitwise-AND of the
other flags, because technically an @{upstream} could point to
"refs/foo" or some other location).

> -int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
> +int interpret_branch_name(const char *name, int namelen, struct strbuf *buf,
> +			  unsigned allowed)
>  {
>  	char *at;
>  	const char *start;
> @@ -1254,24 +1275,29 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
>  		if (len == namelen)
>  			return len; /* consumed all */
>  		else
> -			return reinterpret(name, namelen, len, buf);
> +			return reinterpret(name, namelen, len, buf, allowed);
>  	}

It's hard to see from this context, but a careful reader may note that
we do not check "allowed" at all before calling
interpret_nth_prior_checkout(). This is looking for branch names via
HEAD, so I don't think it can ever return anything but a local name.

Which, hmm. I guess was valid when the flag was "only_branches", but
would not be valid under INTERPRET_BRANCH_REMOTE. I wonder if

  git branch -r -D @{-1}

incorrectly deletes refs/remotes/origin/master if you previously had
refs/heads/origin/master checked out.

-Peff

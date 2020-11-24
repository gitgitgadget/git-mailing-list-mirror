Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB2DC56201
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 07:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A81120719
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 07:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbgKXHmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 02:42:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:39896 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730073AbgKXHmU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 02:42:20 -0500
Received: (qmail 32651 invoked by uid 109); 24 Nov 2020 07:42:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Nov 2020 07:42:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12158 invoked by uid 111); 24 Nov 2020 07:42:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Nov 2020 02:42:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Nov 2020 02:42:19 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] refspec: make @ a valid refspec
Message-ID: <X7y5Wxu1eY4k6753@coredump.intra.peff.net>
References: <20201122164641.2091160-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201122164641.2091160-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 22, 2020 at 10:46:41AM -0600, Felipe Contreras wrote:

> Since commit 9ba89f484e git learned how to push to a remote branch using
> the source @, for example:
> 
>   git push origin @:master
> 
> However, if the right-hand side is missing, the push fails:
> 
>   git push origin @

Yeah, I think this probably makes sense. I find the "@:master" refspec a
bit weird, but it is a natural consequence of parsing "@" on the LHS as
an arbitrary object to lookup (not a ref).

I did find the implementation a little curious:

> -	item->src = xstrndup(lhs, llen);
> +	if (llen == 1 && *lhs == '@')
> +		item->src = xstrdup("HEAD");
> +	else
> +		item->src = xstrndup(lhs, llen);

We already know we are parsing the LHS, so why must we expand a bare @,
whereas we do not in "@:master". The answer is that the "@" is not
expanded until later, and parse_refspec() gets unhappy that "@" is also
the implicit value for the RHS.

This also means that:

  git push origin @:foo

will now work when "foo" doesn't exist on the remote (if we find no
match on the remote, we guess how it should be fully qualified; one of
our heuristics involves seeing that HEAD points to a branch, and
therefore the other side should be a branch, too).

> It is obvious what is the desired behavior, and allowing the push makes
> things more consistent.

This same code is used by fetch, as well. There "git fetch origin
@:master" does not work at all now. This would make that work (to fetch
the remote HEAD into master), along with "git fetch origin @" (into
FETCH_HEAD only). Both seem sensible, and I cannot think of any other
reasonable meaning for them.

> ---
>  refspec.c             | 5 ++++-
>  t/t5511-refspec.sh    | 2 ++
>  t/t5516-fetch-push.sh | 9 +++++++++
>  3 files changed, 15 insertions(+), 1 deletion(-)

Would we want to cover the extra cases I mentioned above (@:foo, and the
two fetches), as well?

I wondered if there was a good place to mention this in the refspec
documentation, but it may just be an obvious fallout of the "@ is a
shortcut for HEAD" definition in gitrevisions(7). The only change is
that we're resolving the shortcut sooner so that more code can take
advantage of it.

-Peff

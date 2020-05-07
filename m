Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06571C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 20:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC4D124959
	for <git@archiver.kernel.org>; Thu,  7 May 2020 20:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgEGUVt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 16:21:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:40884 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726470AbgEGUVt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 16:21:49 -0400
Received: (qmail 2479 invoked by uid 109); 7 May 2020 20:21:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 20:21:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21708 invoked by uid 111); 7 May 2020 20:21:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 16:21:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 16:21:48 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH 6/8] commit-graph.c: simplify 'fill_oids_from_commits'
Message-ID: <20200507202148.GD29683@coredump.intra.peff.net>
References: <cover.1588641176.git.me@ttaylorr.com>
 <7e9d8c1f1a124171ebb5b4d874718053d1c9064a.1588641176.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e9d8c1f1a124171ebb5b4d874718053d1c9064a.1588641176.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 07:13:54PM -0600, Taylor Blau wrote:

> In the previous handful of commits, both 'git commit-graph write
> --reachable' and '--stdin-commits' learned to peel tags down to the
> commits which they refer to before passing them into the commit-graph
> internals.
> 
> This makes the call to 'lookup_commit_reference_gently()' inside of
> 'fill_oids_from_commits()' a noop, since all OIDs are commits by that
> point.
> 
> As such, remove the call entirely, as well as the progress meter, which
> has been split and moved out to the callers in the aforementioned
> earlier commits.

Yep, all this makes sense. I agree with Stolee that it's unfortunate we
can't just reuse the oidset now, but we do need the flattened array view
here. We could perhaps create such an array from the beginning (perhaps
using an oid_array), but we do need to care about de-duping the input.
That can be done easily with the sorted list, but there are pathological
corner cases where the performance is worse (e.g., if you have a ton of
refs all pointing to the same tags, like if you happened to be storing
the refs for 20,000 forks of the kernel all in one giant repo).

I think we'd eventually turn all these into "struct commit" (and indeed,
we already do in --stdin-commits when we try to peel). So another
alternative would be passing in an object_array(). But I guess that
would require surgery to the rest of the commit-graph code to work with
that instead of the oid list.

>  	while ((oid = oidset_iter_next(&iter))) {
> -		struct commit *result;
> -
> -		display_progress(ctx->progress, ++i);
> -
> -		result = lookup_commit_reference_gently(ctx->r, oid, 1);
> -		if (result) {
> -			ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
> -			oidcpy(&ctx->oids.list[ctx->oids.nr], &(result->object.oid));
> -			ctx->oids.nr++;
> -		} else if (ctx->check_oids) {
> -			error(_("invalid commit object id: %s"),
> -			      oid_to_hex(oid));
> -			return -1;
> -		}
> +		ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
> +		oidcpy(&ctx->oids.list[ctx->oids.nr], oid);
> +		ctx->oids.nr++;
>  	}

I wondered if it's worth asserting that everything we got here is a
commit. But it's not cheap to make that check, and anyway we'd
presumably just barf later on when we try to resolve the oids to
commits. So there's little point in spending cycles to catch it here.

-Peff

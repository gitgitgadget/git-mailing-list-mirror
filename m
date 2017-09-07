Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D1CE208CD
	for <e@80x24.org>; Thu,  7 Sep 2017 14:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932291AbdIGOun (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 10:50:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:59762 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932275AbdIGOum (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 10:50:42 -0400
Received: (qmail 686 invoked by uid 109); 7 Sep 2017 14:50:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 14:50:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 475 invoked by uid 111); 7 Sep 2017 14:51:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 10:51:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Sep 2017 10:50:40 -0400
Date:   Thu, 7 Sep 2017 10:50:40 -0400
From:   Jeff King <peff@peff.net>
To:     Aleksandr Makarov <aleksandr.o.makarov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] match_name_as_path: Pass WM_CASEFOLD to wildmatch
Message-ID: <20170907145040.eazbv4qh6rg25gus@sigill.intra.peff.net>
References: <79c946a2-532e-1c9b-7bf2-1f1ccbff721e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79c946a2-532e-1c9b-7bf2-1f1ccbff721e@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 07, 2017 at 04:51:36PM +0300, Aleksandr Makarov wrote:

> ---

Your commit message leaves me with a lot of questions. Let me see if I
can answer them. :)

Can this code path be triggered? We need to set filter->ignore_case,
but also filter->match_as_patch. So "git branch --ignore-case" works,
but "git for-each-ref --ignore-case" is totally broken.

When did this break? It looks like ignore-case never worked with
for-each-ref. This should have been part of Duy's (+cc) 3bb16a8bf2 (tag,
branch, for-each-ref: add --ignore-case for sorting and filtering,
2016-12-04). It got the match_pattern() one right, but missed this tweak
in match_as_path.

How come we didn't notice? Because 3bb16a8bf2 has tests for branch and
tag, but not for-each-ref. We should probably add one as part of this
fix.

And finally, your patch needs a sign-off to be included in the project
(see Documentation/SubmittingPatches).

> diff --git a/ref-filter.c b/ref-filter.c
> index bc591f4..3746628 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1663,7 +1663,7 @@ static int match_name_as_path(const struct ref_filter *filter, const char *refna
>  		     refname[plen] == '/' ||
>  		     p[plen-1] == '/'))
>  			return 1;
> -		if (!wildmatch(p, refname, WM_PATHNAME))
> +		if (!wildmatch(p, refname, flags))

The patch itself looks correct to me. Thanks.

-Peff

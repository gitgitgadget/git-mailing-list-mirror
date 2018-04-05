Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63A251F404
	for <e@80x24.org>; Thu,  5 Apr 2018 17:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbeDERt2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 13:49:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:54870 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751488AbeDERt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 13:49:28 -0400
Received: (qmail 32294 invoked by uid 109); 5 Apr 2018 17:49:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Apr 2018 17:49:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18200 invoked by uid 111); 5 Apr 2018 17:50:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 05 Apr 2018 13:50:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2018 13:49:26 -0400
Date:   Thu, 5 Apr 2018 13:49:26 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, sxlijin@gmail.com
Subject: Re: [RFC PATCH 2/7] dir.c: fix off-by-one error in
 match_pathspec_item
Message-ID: <20180405174925.GA19974@sigill.intra.peff.net>
References: <20180405173446.32372-1-newren@gmail.com>
 <20180405173446.32372-3-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180405173446.32372-3-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 10:34:41AM -0700, Elijah Newren wrote:

> For a pathspec like 'foo/bar' comparing against a path named "foo/",
> namelen will be 4, and match[namelen] will be 'b'.  The correct location
> of the directory separator is namelen-1.
> 
> The reason the code worked anyway was that the following code immediately
> checked whether the first matchlen characters matched (which they do) and
> then bailed and return MATCHED_RECURSIVELY anyway since wildmatch doesn't
> have the ability to check if "name" can be matched as a directory (or
> prefix) against the pathspec.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/dir.c b/dir.c
> index 19212129f0..c915a69385 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -384,7 +384,7 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
>  	if (flags & DO_MATCH_SUBMODULE) {
>  		/* name is a literal prefix of the pathspec */
>  		if ((namelen < matchlen) &&
> -		    (match[namelen] == '/') &&
> +		    (match[namelen-1] == '/') &&
>  		    !ps_strncmp(item, match, name, namelen))
>  			return MATCHED_RECURSIVELY;

Do we care about matching the name "foo" against the patchspec_item "foo/"?

That matches now, but wouldn't after your patch.

-Peff

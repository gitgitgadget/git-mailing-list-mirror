Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAECC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E337621707
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIRR1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:27:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:33462 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgIRR1s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 13:27:48 -0400
Received: (qmail 11128 invoked by uid 109); 18 Sep 2020 17:27:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Sep 2020 17:27:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23112 invoked by uid 111); 18 Sep 2020 17:27:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Sep 2020 13:27:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Sep 2020 13:27:47 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Guyot-Sionnest <tguyot@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, dermoth@aei.ca
Subject: Re: [PATCH 1/2] diff: Fix modified lines stats with --stat and
 --numstat
Message-ID: <20200918172747.GD183026@coredump.intra.peff.net>
References: <20200918113256.8699-1-tguyot@gmail.com>
 <20200918113256.8699-2-tguyot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200918113256.8699-2-tguyot@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 07:32:55AM -0400, Thomas Guyot-Sionnest wrote:

> In builtin_diffstat(), when both files are coming from "stdin" (which
> could be better described as the file's content being written directly
> into the file object), oideq() compares two null hashes and ignores the
> actual differences for the statistics.
> 
> This patch checks if is_stdin flag is set on both sides and compare
> contents directly.

I'm somewhat puzzled how we could have two filespecs that came from
stdin, since we'd generally read to EOF. But looking at the test, it
seems this is a weird range-diff hack to set is_stdin.

Looking at your patch:

> diff --git a/diff.c b/diff.c
> index a5114fa864..2995527896 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3681,7 +3681,10 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
>  		return;
>  	}
>  
> -	same_contents = oideq(&one->oid, &two->oid);
> +	if (one->is_stdin && two->is_stdin)
> +		same_contents = !strcmp(one->data, two->data);
> +	else
> +		same_contents = oideq(&one->oid, &two->oid);

...should this actually be checking the oid_valid flag in each filespec?
That would presumably cover the is_stdin case, too. I also wonder
whether range-diff ought to be using that flag instead of is_stdin.

-Peff

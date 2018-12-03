Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 769DD211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 21:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbeLCVYd (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 16:24:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:57642 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725903AbeLCVYd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 16:24:33 -0500
Received: (qmail 2825 invoked by uid 109); 3 Dec 2018 21:24:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Dec 2018 21:24:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14028 invoked by uid 111); 3 Dec 2018 21:24:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 03 Dec 2018 16:24:00 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2018 16:24:31 -0500
Date:   Mon, 3 Dec 2018 16:24:31 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com
Subject: Re: [PATCH] revisions.c: put promisor option in specialized struct
Message-ID: <20181203212431.GB8700@sigill.intra.peff.net>
References: <20181201194424.GB28918@sigill.intra.peff.net>
 <20181203192356.51432-1-matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181203192356.51432-1-matvore@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 03, 2018 at 11:23:56AM -0800, Matthew DeVore wrote:

> Put the allow_exclude_promisor_objects flag in setup_revision_opt. When
> it was in rev_info, it was unclear when it was used, since rev_info is
> passed to functions that don't use the flag. This resulted in
> unnecessary setting of the flag in prune.c, so fix that as well.
> 
> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---
>  builtin/pack-objects.c |  7 +++++--
>  builtin/prune.c        |  1 -
>  builtin/rev-list.c     |  6 ++++--
>  revision.c             | 10 ++++++----
>  revision.h             |  4 ++--
>  5 files changed, 17 insertions(+), 11 deletions(-)

Thanks, this mostly looks good to me (with or without tweaking the
initializers as discussed in the other part of the thread).

One thing I noticed:

> @@ -297,7 +296,8 @@ struct setup_revision_opt {
>  	const char *def;
>  	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
>  	const char *submodule;	/* TODO: drop this and use rev_info->repo */
> -	int assume_dashdash;
> +	int assume_dashdash : 1;
> +	int allow_exclude_promisor_objects : 1;
>  	unsigned revarg_opt;
>  };

I don't know that we need to penny-pinch bytes in this struct, but in
general it shouldn't hurt either awy. However, a signed bit-field with 1
bit is funny. I'm not even sure what the standard has to say, but in
twos-complement that would store "-1" and "0" (gcc -Wpedantic also
complains about overflow in assigning "1" to it).

So this probably ought to be "unsigned".

-Peff

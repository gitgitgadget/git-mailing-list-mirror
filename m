Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F482207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 03:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980370AbdDYD3c (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 23:29:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:39512 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S980310AbdDYD3a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 23:29:30 -0400
Received: (qmail 17040 invoked by uid 109); 25 Apr 2017 03:29:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Apr 2017 03:29:29 +0000
Received: (qmail 18176 invoked by uid 111); 25 Apr 2017 03:29:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 23:29:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Apr 2017 23:29:27 -0400
Date:   Mon, 24 Apr 2017 23:29:27 -0400
From:   Jeff King <peff@peff.net>
To:     Miguel Torroja <miguel.torroja@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] fast-export: deletion action first
Message-ID: <20170425032927.74btvfcexbdq4rmz@sigill.intra.peff.net>
References: <1493079137-1838-1-git-send-email-miguel.torroja@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1493079137-1838-1-git-send-email-miguel.torroja@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2017 at 02:12:16AM +0200, Miguel Torroja wrote:

> The delete operations of the fast-export output should precede any addition
> belonging to the same commit, Addition and deletion with the same name
> entry could happen in case of file to directory and viceversa.
> 
> The fast-export sorting was added in 060df62 (fast-export: Fix output
> order of D/F changes). That change was made in order to fix the case of
> directory to file in the same commit, but it broke the reverse case
> (File to directory).

That explanation makes sense.

>  builtin/fast-export.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)

Perhaps we would want a test for the case you are fixing (to be sure it
is not re-broken), as well as confirming that we have not re-broken the
original case (it looks like 060df62 added a test, so we may be OK with
that).

> +/*
> + * Compares two diff types to order based on output priorities.
> + */
> +static int diff_type_cmp(const void *a_, const void *b_)
> [...]
> +	/*
> +	 * Move Delete entries first so that an addition is always reported after
> +	 */
> +	cmp = (b->status == DIFF_STATUS_DELETED) - (a->status == DIFF_STATUS_DELETED);
>  	if (cmp)
>  		return cmp;
>  	/*

So we sort deletions first. And the bit that the context doesn't quite
show here is that we then compare renames and push them to the end.
Everything else will compare equal.

Is qsort() guaranteed to be stable? If not, then we'll get the majority
of entries in a non-deterministic order. Should we fallback to strcmp()
so that within a given class, the entries are sorted by name?

-Peff

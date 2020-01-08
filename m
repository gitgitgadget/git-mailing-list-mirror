Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15A5C00523
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 07:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3149206DB
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 07:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgAHHP0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 02:15:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:60028 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725944AbgAHHP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 02:15:26 -0500
Received: (qmail 19993 invoked by uid 109); 8 Jan 2020 07:15:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Jan 2020 07:15:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7744 invoked by uid 111); 8 Jan 2020 07:21:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Jan 2020 02:21:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Jan 2020 02:15:25 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] unpack-trees: watch for out-of-range index position
Message-ID: <20200108071525.GB1675456@coredump.intra.peff.net>
References: <20200108023127.219429-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200108023127.219429-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 07, 2020 at 06:31:27PM -0800, Emily Shaffer wrote:

> This issue came in via a bugreport from a user who had done some nasty
> things like deleting various files in .git/ (and then couldn't remember
> how they had done it). The concern was primarily that a segfault is ugly
> and scary, and possibly dangerous; I didn't see much problem with
> checking for index-out-of-range if the result is a fatal error
> regardless.
>
> [...]
>  	if (pos >= 0)
>  		BUG("This is a directory and should not exist in index");
>  	pos = -pos - 1;
> -	if (!starts_with(o->src_index->cache[pos]->name, name.buf) ||
> +	if (pos >= o->src_index->cache_nr ||
> +	    !starts_with(o->src_index->cache[pos]->name, name.buf) ||
>  	    (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, name.buf)))
> -		BUG("pos must point at the first entry in this directory");
> +		BUG("pos %d doesn't point to the first entry of %s in index",
> +		    pos, name.buf);

The new condition you added looks correct to me. I suspect this BUG()
should not be a BUG() at all, though. It's not necessarily a logic error
inside Git, but as you showed it could indicate corrupt data we read
from disk. The true is probably same of the "pos >= 0" condition checked
above.

It's mostly an academic distinction, though, as I think it would be
pretty reasonable for now to just die() here (eventually, though, we
might want to turn it into an error return).

-Peff

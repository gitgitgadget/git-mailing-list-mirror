Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537DC20248
	for <e@80x24.org>; Thu, 28 Mar 2019 03:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfC1DNQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 23:13:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:38544 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725601AbfC1DNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 23:13:16 -0400
Received: (qmail 13923 invoked by uid 109); 28 Mar 2019 03:13:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Mar 2019 03:13:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2487 invoked by uid 111); 28 Mar 2019 03:13:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 27 Mar 2019 23:13:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Mar 2019 23:13:14 -0400
Date:   Wed, 27 Mar 2019 23:13:14 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: binary search when storing wanted-refs
Message-ID: <20190328031314.GB10032@sigill.intra.peff.net>
References: <20190327211110.46327-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190327211110.46327-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 27, 2019 at 02:11:10PM -0700, Jonathan Tan wrote:

> In do_fetch_pack_v2(), the "sought" array is sorted by name, and it is
> not subsequently reordered (within the function). Therefore,
> receive_wanted_refs() can assume that "sought" is sorted, and can thus
> use a binary search when storing wanted-refs retrieved from the server.
> 
> Replace the existing linear search with a binary search. This improves
> performance significantly when mirror cloning a repository with more
> than 1 million refs.

This looks good.

The flow in do_fetch_pack_v2() is a little funny. I wanted to
double-check that we always sorted the sought list, because it only
happens in the CHECK_LOCAL state of the state machine.

But as far as I can tell we always begin the function in CHECK_LOCAL, it
always transitions out to another state, and we never go back to it. So
all of that part of the state-machine switch could really just be done
once before entering the state-machine's while loop.

Not really relevant to your patch, but maybe worth tweaking separately
(or maybe not, if people find the all-in-a-state-machine style more
readable; I found it more confusing to reason about).

> +static int cmp_name_ref(const void *name, const void *ref)
> +{
> +	return strcmp(name, (*(struct ref **)ref)->name);
> +}

After some errors with qsort comparison functions a while back[1], I
double-checked that this has the right number of asterisks. I believe it
does. :)

-Peff

[1] https://public-inbox.org/git/d1b58614-989f-5998-6c53-c19eee409a2f@web.de/
    and the child thread it spawned are interesting reading, though I
    don't think we ever followed up on it.

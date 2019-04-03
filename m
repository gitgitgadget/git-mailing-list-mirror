Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD2F720248
	for <e@80x24.org>; Wed,  3 Apr 2019 19:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfDCTl4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 15:41:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:45910 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726064AbfDCTl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 15:41:56 -0400
Received: (qmail 8060 invoked by uid 109); 3 Apr 2019 19:41:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Apr 2019 19:41:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11392 invoked by uid 111); 3 Apr 2019 19:42:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Apr 2019 15:42:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Apr 2019 15:41:50 -0400
Date:   Wed, 3 Apr 2019 15:41:50 -0400
From:   Jeff King <peff@peff.net>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: do faster object check for partial clones
Message-ID: <20190403194150.GA27199@sigill.intra.peff.net>
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 03, 2019 at 10:27:21AM -0700, Josh Steadmon wrote:

> For partial clones, doing a full connectivity check is wasteful; we skip
> promisor objects (which, for a partial clone, is all known objects), and
> excluding them all from the connectivity check can take a significant
> amount of time on large repos.
> 
> At most, we want to make sure that we get the objects referred to by any
> wanted refs. For partial clones, just check that these objects were
> transferred.

This isn't strictly true, since we could get objects from elsewhere via
--shared or --reference. Those might not be promisor objects.

Shouldn't we be able to stop a traversal as soon as we see that an
object is in a promisor pack?

I.e., here:

> +	if (opt->check_refs_only) {
> +		/*
> +		 * For partial clones, we don't want to walk the full commit
> +		 * graph because we're skipping promisor objects anyway. We
> +		 * should just check that objects referenced by wanted refs were
> +		 * transferred.
> +		 */
> +		do {
> +			if (!repo_has_object_file(the_repository, &oid))
> +				return 1;
> +		} while (!fn(cb_data, &oid));
> +		return 0;
> +	}

for each object where you ask "do we have this?" we could, for the same
cost, ask "do we have this in a promisor pack?". And the answer would be
yes for each in a partial clone.

But that would also cleanly handle --shared, etc, that I mentioned. And
more importantly, it would _also_ work on fetches. If I fetch from you
and get a promisor pack, then there is no point in me enumerating every
tree you sent. As long as you gave me a tip tree, then you have promised
that you'd give me all the others if I ask.

So it seems like this should be a feature of the child rev-list, to stop
walking the graph at any object that is in a promisor pack.

-Peff

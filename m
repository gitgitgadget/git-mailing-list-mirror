Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23081201B0
	for <e@80x24.org>; Mon, 27 Feb 2017 10:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbdB0Kx7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 05:53:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:34701 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751687AbdB0Kx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 05:53:58 -0500
Received: (qmail 24152 invoked by uid 109); 27 Feb 2017 10:53:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 10:53:32 +0000
Received: (qmail 20663 invoked by uid 111); 27 Feb 2017 10:53:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 05:53:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2017 05:53:30 -0500
Date:   Mon, 27 Feb 2017 05:53:30 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Wong <e@80x24.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        ttaylorr@github.com
Subject: Re: [PATCH v2] convert: add "status=delayed" to filter process
 protocol
Message-ID: <20170227105330.gv5qk6dszrv56kmg@sigill.intra.peff.net>
References: <20170226184816.30010-1-larsxschneider@gmail.com>
 <20170227095825.jhdspwy6oa6mvvvm@sigill.intra.peff.net>
 <E4A6D866-D046-4CF3-8050-666FD6C98F7B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E4A6D866-D046-4CF3-8050-666FD6C98F7B@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 11:32:47AM +0100, Lars Schneider wrote:

> I completely agree - I need to change that. However, the goal of the v2
> iteration was to get the "convert" interface in an acceptable state.
> That's what I intended to say in the patch comment section:
> 
>     "Please ignore all changes behind async_convert_to_working_tree() and 
>      async_filter_finish() for now as I plan to change the implementation 
>      as soon as the interface is in an acceptable state."

Ah, sorry, I missed that. I would think the underlying approach would
influence the interface to some degree. But as long as the interface
is sufficiently abstract, I think it gives you enough flexibility.

> > From Git's side, the loop is something like:
> > 
> >  while (delayed_items > 0) {
> > 	/* issue a wait, and get back the status/index pair */
> > 	status = send_wait(&index);
> > 	delayed_items--;
> > 
> > 	/*
> > 	 * use "index" to find the right item in our list of files;
> > 	 * the format can be opaque to the filter, so we could index
> > 	 * it however we like. But probably numeric indices in an array
> > 	 * are the simplest.
> > 	 */
> > 	assert(index > 0 && index < nr_items);
> > 	item[index].status = status;
> > 	if (status == SUCCESS)
> > 		read_content(&item[index]);
> >  }
> > 
> > and the filter side just attaches the "index" string to whatever its
> > internal queue structure is, and feeds it back verbatim when processing
> > that item finishes.
> 
> That could work! I had something like that in mind:
> 
> I teach Git a new command "list_completed" or similar. The filter
> blocks this call until at least one item is ready for Git. 
> Then the filter responds with a list of paths that identify the
> "ready items". Then Git asks for these ready items just with the
> path and not with any content. Could that work? Wouldn't the path
> be "unique" to identify a blob per filter run?

I think that could work, though I think there are few minor downsides
compared to what I wrote above:

  - if you respond with "these items are ready", and then make Git ask
    for each again, it's an extra round-trip for each set of ready
    items. You could just say "an item is ready; here it is" in a single
    response. For a local pipe the latency is probably negligible,
    though.

  - using paths as the index would probably work, but it means Git has
    to use the path to find the "struct checkout_entry" again. Which
    might mean a hashmap (though if you have them all in a sorted list,
    I guess you could also do a binary search).

  - Using an explicit index communicates to the filter not only what the
    index is, but also that Git is prepared to accept a delayed response
    for the item. For backwards compatibility, the filter would probably
    advertise "I have the 'delayed' capability", and then Git could
    choose to use it or not on a per-item basis. Realistically it would
    not change from item to item, but rather operation to operation. So
    that means we can easily convert the call-sites in Git to the async
    approach incrementally. As each one is converted, it turns on the
    flag that causes the filter code to send the "index" tag.

-Peff

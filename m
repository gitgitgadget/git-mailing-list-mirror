Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F8F41F404
	for <e@80x24.org>; Fri,  7 Sep 2018 03:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeIGICq (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 04:02:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:42274 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726495AbeIGICq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 04:02:46 -0400
Received: (qmail 15152 invoked by uid 109); 7 Sep 2018 03:24:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Sep 2018 03:24:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10816 invoked by uid 111); 7 Sep 2018 03:24:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Sep 2018 23:24:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2018 23:24:02 -0400
Date:   Thu, 6 Sep 2018 23:24:02 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>,
        gitster@pobox.com, pclouds@gmail.com
Subject: Re: ordered string-list considered harmful, was Re: [PATCH v3] Allow
 aliases that include other aliases
Message-ID: <20180907032401.GB31728@sigill.intra.peff.net>
References: <20180906191203.GA26184@sigill.intra.peff.net>
 <20180906192021.GB26575@sigill.intra.peff.net>
 <20180906235033.GA100309@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180906235033.GA100309@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 04:50:33PM -0700, Jonathan Nieder wrote:

> Hi,
> 
> Jeff King wrote:
> 
> > But what I think is harmful is a _sorted_ list, because of the
> > "accidentally quadratic" nature, and because it's easy to call its
> > functions on an unsorted list.
> 
> I agree --- in general, it tends to be better to build an unsorted
> string list and then sort it.
> 
> Once I've done so, what is your advice about getting fast lookups
> in the result?  Should I build an auxiliary hashmap as well?  Or
> is this an argument for the 'sorted' flag + BUG approach you
> already mentioned?

I don't see any point in generating a sorted list and _then_ making an
auxiliary hashmap. My idea was that if you're using a sorted string-list
for lookup, then you can replace the whole thing with a hash (inserting
as you go, rather than sorting at the end).

I.e., imagine there are three use cases for string lists:

  1. Build a list via append(), sort at the end, then do a series of
     efficient queries.

  2. Build a list via insert(), which is always sorted. Possibly query
     while building, or after finished building.

  3. Build an unsorted list and iterate over it.

We know that (2) is potentially quadratic during the build-and-sort
step. It would be nice to turn it into (1), but it's not always possible
if we query it while still building. Turning these into a hashmap is an
easy fix with no real downsides.

Case (1) actually isn't a problem for run-time. We'd like to get rid of
it only because the string_list functions are a bit confusing in terms
of which ones expect us to be sorted or not (and if ever forget to sort
before querying, we'd see all kinds of subtle bugs).

Converting these cases to use a hashmap is one way we might get rid of
the confusing string-list functions. And it doesn't carry any big-O
downside, though it may be slower in practice (e.g., hashmaps tend to be
a bit malloc-heavy).

Case (3) is the one we'd like to preserve as the "right" use of
string-list, since it's hard to get wrong (after we remove the sorting
functions).

I think Stefan pointed out a "case 4" in the other part of the thread:
ones where we really care not just about fast lookup, but actual
iteration order.  These ones may need some special care, but I don't
think there are many of them.

So that's _one_ way to make the world better.

Another way is to try to make the functions harder to misuse. E.g.,
maybe putting "sorted" into the name of string_list_has_string(), so
it's on an equal footing with the unsorted variant. Or the sorted flag I
mentioned. Those can help the misuse problem, but they don't help with
the case (2) quadratic ones. It's probably less work, though.

I think I like the hashmap way, if the conversion isn't too painful. As
I said to Stefan in the other part of the thread, I'm mostly at the
"does this seem like a terrible idea" stage. I'd have to start
conversions to see how many of each case we have (and if there are ones
that don't fit into my taxonomy above).

-Peff

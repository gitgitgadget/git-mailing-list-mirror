Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A9721F576
	for <e@80x24.org>; Mon, 26 Feb 2018 08:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751594AbeBZIzL (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 03:55:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:36908 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751022AbeBZIzK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 03:55:10 -0500
Received: (qmail 32286 invoked by uid 109); 26 Feb 2018 08:55:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Feb 2018 08:55:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10805 invoked by uid 111); 26 Feb 2018 08:55:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Feb 2018 03:55:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Feb 2018 03:55:08 -0500
Date:   Mon, 26 Feb 2018 03:55:08 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 08/27] pack: move approximate object count to object store
Message-ID: <20180226085508.GA30343@sigill.intra.peff.net>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-9-sbeller@google.com>
 <20180222004710.GF127348@google.com>
 <CAGZ79kahS_mk8gFONUAxBjw7iV=5q1ff-ZgjLnQ7rMw=kBKThw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kahS_mk8gFONUAxBjw7iV=5q1ff-ZgjLnQ7rMw=kBKThw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 02:22:14PM -0800, Stefan Beller wrote:

> >> +     /*
> >> +      * A fast, rough count of the number of objects in the repository.
> >> +      * These two fields are not meant for direct access. Use
> >> +      * approximate_object_count() instead.
> >> +      */
> >> +     unsigned long approximate_object_count;
> >> +     unsigned approximate_object_count_valid : 1;
> >
> > Patch looks fine and is effectively a no-op, though what is the need for
> > both of these variables?  Maybe it can be simplified down to just use
> > one?  Just musing as its out of the scope of this patch and we probably
> > shouldn't try to change that in this series.
> 
> I agree we should. It was introduced in e323de4ad7f (sha1_file:
> allow sha1_loose_object_info to handle arbitrary repositories, 2017-08-30)
> and I think it was seen as a clever optimization trick back then?

I think you meant 8e3f52d778 (find_unique_abbrev: move logic out of
get_short_sha1(), 2016-10-03)?

Yes, it was just to avoid the dual-meaning of "0" for "not set" and a
repository with no packfiles.  It would probably be fine to get rid of
it. If you have no packfiles then you probably don't have enough objects
to worry about micro-optimizing. And anyway, the "wasted" case wouldn't
even make any syscalls (it would do a noop prepare_packed_git() and then
realize the packed_git list is empty).

-Peff

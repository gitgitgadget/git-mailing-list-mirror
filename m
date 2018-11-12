Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B4941F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 12:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbeKLWZj (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 17:25:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:35374 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729351AbeKLWZj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 17:25:39 -0500
Received: (qmail 24061 invoked by uid 109); 12 Nov 2018 12:32:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 12:32:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10221 invoked by uid 111); 12 Nov 2018 12:31:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 07:31:54 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 07:32:32 -0500
Date:   Mon, 12 Nov 2018 07:32:32 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/10] fast-export: avoid dying when filtering by paths
 and old tags exist
Message-ID: <20181112123232.GF3956@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-5-newren@gmail.com>
 <20181111064442.GD30850@sigill.intra.peff.net>
 <CABPp-BFy1aS3mHGF99Lr=+APruzC3pF5PCEph8SU71uuyOnQ7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFy1aS3mHGF99Lr=+APruzC3pF5PCEph8SU71uuyOnQ7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 11:38:45PM -0800, Elijah Newren wrote:

> > Hmm. That's the right thing to do if we're considering the export to be
> > an independent unit. But what if I'm just rewriting a portion of history
> > like:
> >
> >   git fast-export HEAD~5..HEAD | some_filter | git fast-import
> >
> > ? If I have a tag pointing to HEAD~10, will this delete that? Ideally I
> > think it would be left alone.
> 
> A couple things:
>   * This code path only triggers in a very specific case: If a tag is
> requested for export but points to a commit which is filtered out by
> something else (e.g. path limiters and the commit in question didn't
> modify any of the relevant paths), AND the user explicitly specified
> --tag-of-filtered-object=rewrite (so that the tag in question can be
> rewritten to the nearest non-filtered ancestor).

Right, I think this is the bit I was missing: somebody has to have
explicitly asked to export the tag. At which point the only sensible
thing to do is drop it.

-Peff

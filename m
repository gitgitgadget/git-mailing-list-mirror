Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EFEA1F461
	for <e@80x24.org>; Sat, 29 Jun 2019 07:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfF2Hnv (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 03:43:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:54854 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726796AbfF2Hnv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jun 2019 03:43:51 -0400
Received: (qmail 18546 invoked by uid 109); 29 Jun 2019 07:43:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Jun 2019 07:43:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23324 invoked by uid 111); 29 Jun 2019 07:44:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 29 Jun 2019 03:44:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Jun 2019 03:43:49 -0400
Date:   Sat, 29 Jun 2019 03:43:49 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] check_everything_connected: assume alternate ref tips
 are valid
Message-ID: <20190629074348.GA5080@sigill.intra.peff.net>
References: <20190628101131.GA22862@sigill.intra.peff.net>
 <601d8561-6e24-559c-6fbb-fa25a7389fa0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <601d8561-6e24-559c-6fbb-fa25a7389fa0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 08:51:04AM -0400, Derrick Stolee wrote:

> On 6/28/2019 6:11 AM, Jeff King wrote:
> > When we receive a remote ref update to sha1 "X", we want to check that
> > we have all of the objects needed by "X". We can assume that our
> > repository is not currently corrupted, and therefore if we have a ref
> > pointing at "Y", we have all of its objects. So we can stop our
> > traversal from "X" as soon as we hit "Y".
> > 
> > If we make the same non-corruption assumption about any repositories we
> > use to store alternates, then we can also use their ref tips to shorten
> > the traversal.
> 
> I was confused by this paragraph, because I didn't know about
> for_each_alternate_ref() and how refs_From_alternate_cb() will
> strip the "/objects" and append "/refs" to check refs if they
> exist. All of that logic is in transport.c but used by
> fetch-pack.c and builtin/receive-pack.c. But now we are adding
> to revision.c, so the restriction to "this helps data transfer"
> is getting murkier.

Using it for data transfer is still the main thing for our internal
calls, but I think it's worth exposing it for general use via rev-list.
I imagine it would mostly be for poking around and debugging, but it
should allow things like:

  # what do we have that our alternate does not
  git rev-list --all --not --alternate-refs

> Is this something that should be extracted to the object-store
> layer? Or is it so tricky to use that we shouldn't make it too
> easy to fall into a bad pattern?

I'm not sure what you have in mind, exactly. If you are asking whether
there are more places that alternate refs could be used, I can't think
of any. If you are asking whether this is in the wrong place, no, I
think it's the right place. :)

-Peff

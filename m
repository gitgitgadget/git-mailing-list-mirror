Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4792D211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 21:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeLCVP6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 16:15:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:57616 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725903AbeLCVP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 16:15:58 -0500
Received: (qmail 2461 invoked by uid 109); 3 Dec 2018 21:15:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 03 Dec 2018 21:15:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13982 invoked by uid 111); 3 Dec 2018 21:15:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 03 Dec 2018 16:15:25 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2018 16:15:55 -0500
Date:   Mon, 3 Dec 2018 16:15:55 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        gitster@pobox.com, pclouds@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com
Subject: Re: [RFC 2/2] exclude-promisor-objects: declare when option is
 allowed
Message-ID: <20181203211555.GA8700@sigill.intra.peff.net>
References: <cover.1540256910.git.matvore@google.com>
 <931421945c040ba4518d91f7af9f386d0136bd2f.1540256910.git.matvore@google.com>
 <20181121164019.GA24621@sigill.intra.peff.net>
 <19c82fb0-e0d6-0b15-06ab-cfba4d699d94@comcast.net>
 <20181201194424.GB28918@sigill.intra.peff.net>
 <80a08b99-14cb-e398-e6c2-2aa94a5fdda3@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80a08b99-14cb-e398-e6c2-2aa94a5fdda3@comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 03, 2018 at 11:10:49AM -0800, Matthew DeVore wrote:

> > > +	memset(&s_r_opt, 0, sizeof(s_r_opt));
> > > +	s_r_opt.allow_exclude_promisor_objects = 1;
> > > +	setup_revisions(ac, av, &revs, &s_r_opt);
> > 
> > I wonder if a static initializer for setup_revision_opt is worth it. It
> > would remove the need for this memset. Probably not a big deal either
> > way, though.
> I think you mean something like this:
> 
> static struct setup_revision_opt s_r_opt = {NULL, NULL, NULL, 0, 1, 0};
> 
> This is a bit cryptic (I have to read the struct declaration in order to
> know what is being set to 1) and if the struct ever gets a new field before
> allow_exclude_promisor_objects, this initializer has to be updated.

I agree that's pretty awful.  I meant something like this:

  struct setup_revision_opt s_r_opt = { NULL };
  ...

  s_r_opt.allow_exclude_promisor_objects = 1;
  setup_revisions(...);

It's functionally equivalent to the memset(), but you don't have to
wonder about whether we peek at the uninitialized state in between.

That said, our C99 designated initializer weather-balloons haven't
gotten any complaints yet. So I think you could actually do:

  struct setup_revision_opt s_r_opt = {
	.allow_exclude_promisor_objects = 1,
  };
  ...
  setup_revisions(...);

which is pretty nice.

-Peff

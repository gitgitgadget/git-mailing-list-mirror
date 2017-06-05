Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 655AC209FD
	for <e@80x24.org>; Mon,  5 Jun 2017 08:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbdFEISs (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 04:18:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:34695 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751352AbdFEISs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 04:18:48 -0400
Received: (qmail 20058 invoked by uid 109); 5 Jun 2017 08:18:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Jun 2017 08:18:46 +0000
Received: (qmail 12102 invoked by uid 111); 5 Jun 2017 08:19:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Jun 2017 04:19:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jun 2017 04:18:45 -0400
Date:   Mon, 5 Jun 2017 04:18:45 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCHv4 1/2] clone: respect additional configured fetch
 refspecs during initial fetch
Message-ID: <20170605081845.tvzidc5nblbnuner@sigill.intra.peff.net>
References: <CAM0VKjnOSxQg_VCBO2cgtbqesmNYx+e_H7m=36PsNWi9K9rQ1Q@mail.gmail.com>
 <20170530071244.32257-1-szeder.dev@gmail.com>
 <20170531042304.unkxkuw6s3tcpzkm@sigill.intra.peff.net>
 <CAM0VKjkfuyBzZmpJL47xmK24EOh6X5OjrxtxVdsgGupAseT_wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjkfuyBzZmpJL47xmK24EOh6X5OjrxtxVdsgGupAseT_wQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 11:34:23AM +0200, SZEDER Gábor wrote:

> >> +void add_and_parse_fetch_refspec(struct remote *remote, const char *refspec)
> >> +{
> >> +     struct refspec *rs;
> >> +
> >> +     add_fetch_refspec(remote, refspec);
> >> +     rs = parse_fetch_refspec(1, &refspec);
> >> +     REALLOC_ARRAY(remote->fetch, remote->fetch_refspec_nr);
> >> +     remote->fetch[remote->fetch_refspec_nr - 1] = *rs;
> >> +
> >> +     /* Not free_refspecs(), as we copied its pointers above */
> >> +     free(rs);
> >> +}
> >
> > What happens here if remote->fetch isn't already initialized? I think
> > we'd end up with a bunch of garbage values. That's what I was trying to
> > protect against in my original suggestion.
> >
> > I'm not sure if that's possible or not. We seem to initialize it in both
> > remote_get() and for_each_remote(), and I don't think there are any
> > other ways to get a remote.
> 
> The only place creating remotes is remote.c:make_remote(), which
> calloc()s the required memory, making all of struct remote's fields
> zero-initialized.  In case of clone the common case is that the user
> doesn't specify any additional fetch refspecs, so remote->fetch will
> still be NULL after full initialization and when
> add_and_parse_fetch_refspec() is called with the default fetch
> refspec, meaning we can't 'if (remote->fetch) { parse ... }'.  OTOH,
> all functions involved can cope with the fetch-refspec-related fields
> being 0/NULL, and at the time remote->fetch_refspec_nr-1 is used for
> array indexing it's not 0 anymore.

Yeah, I agree it is safe now. I'm just worried about some function in
remote.c later doing:

   read_config();
   add_and_parse_fetch_refspec(remotes[0], whatever);

which leaves the struct in an inconsistent state (we realloc NULL which
allocates from scratch, and all of the other entries in remote->fetch
end up uninitialized).  Can we at least add an assertion like:

  if (!remote->fetch)
	BUG("cannot add refspec to an unparsed remote");

?

-Peff

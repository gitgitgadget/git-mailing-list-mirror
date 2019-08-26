Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B651F461
	for <e@80x24.org>; Mon, 26 Aug 2019 18:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733243AbfHZSoq (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 14:44:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:56234 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1733169AbfHZSoq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 14:44:46 -0400
Received: (qmail 6737 invoked by uid 109); 26 Aug 2019 18:44:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Aug 2019 18:44:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22605 invoked by uid 111); 26 Aug 2019 18:46:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Aug 2019 14:46:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Aug 2019 14:44:44 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fast-import: duplicate parsed encoding string
Message-ID: <20190826184444.GD23399@sigill.intra.peff.net>
References: <20190825080640.GA31453@sigill.intra.peff.net>
 <20190825080821.GA31824@sigill.intra.peff.net>
 <CABPp-BG3ScDk6_QcjyouqnHrXO2A1mWPEcPh5FnS1popKFzr-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BG3ScDk6_QcjyouqnHrXO2A1mWPEcPh5FnS1popKFzr-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 11:28:58AM -0700, Elijah Newren wrote:

> On Sun, Aug 25, 2019 at 1:08 AM Jeff King <peff@peff.net> wrote:
> >
> > We read each line of the fast-import stream into the command_buf strbuf.
> > When reading a commit, we parse a line like "encoding foo" by storing a
> > pointer to "foo", but not making a copy. We may then read an unbounded
> > number of other lines (e.g., one for each modified file in the commit),
> > each of which writes into command_buf.
> >
> > This works out in practice for small cases, because we hand off
> > ownership of the heap buffer from command_buf to the cmd_hist array, and
> > read new commands into a fresh heap buffer. And thus the pointer to
> > "foo" remains valid as long as there aren't so many intermediate lines
> > that we end up dropping the original "encoding" line from the history.
> >
> > But as the test modification shows, if we go over our default of 100
> > lines, we end up with our encoding string pointing into freed heap
> > memory. This seems to fail reliably by writing garbage into the output,
> > but running under ASan definitely detects this as a user-after-free.
> 
> s/user-after-free/use-after-free/

Wow. I self-corrected "user-after-free" at least three other times while
writing this thread. I clearly have a problem. :)

> > We can fix it by duplicating the encoding value, just as we do for other
> > parsed lines (e.g., an author line ends up in parse_ident, which copies
> > it to a new string).
> 
> Eek!  Thanks for fixing this up for me; patch looks good.

No problem. On the plus side, finding your bug made me think much harder
about the implications of patch 2 (because it's quite subtle and an easy
mistake to make).

-Peff

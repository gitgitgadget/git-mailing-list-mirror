Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6616220281
	for <e@80x24.org>; Sat,  4 Nov 2017 09:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756594AbdKDJfm (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 05:35:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:46282 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756478AbdKDJfl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 05:35:41 -0400
Received: (qmail 1657 invoked by uid 109); 4 Nov 2017 09:35:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 04 Nov 2017 09:35:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7896 invoked by uid 111); 4 Nov 2017 09:35:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 04 Nov 2017 05:35:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Nov 2017 05:35:38 -0400
Date:   Sat, 4 Nov 2017 05:35:38 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Simon Ruderich <simon@ruderich.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: factor out rewrite_file()
Message-ID: <20171104093537.glucmbljnjlw3htq@sigill.intra.peff.net>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
 <20171101194732.fn4n46wppl35e2z2@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1711012240500.6482@virtualbox>
 <20171101221618.4ioog7jlp7n2nd53@sigill.intra.peff.net>
 <20171103103248.4p45r4klojk5cf2g@ruderich.org>
 <xmqqpo8zpjdj.fsf@gitster.mtv.corp.google.com>
 <20171103191309.sth4zjokgcupvk2e@sigill.intra.peff.net>
 <b074d6fa-8778-ea0d-d53b-7cc35bc4264a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b074d6fa-8778-ea0d-d53b-7cc35bc4264a@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 04, 2017 at 10:05:43AM +0100, René Scharfe wrote:

> >> How about *not* printing the error at the place where you notice the
> >> error, and instead return an error code to the caller to be noticed
> >> which dies with an error message?
> > 
> > That ends up giving less-specific errors.
> 
> Not necessarily.  Function could return different codes for different
> errors, e.g. -1 for an open(2) error and -2 for a write(2) error, and
> the caller could use that to select the message to show.
> 
> Basically all of the messages in wrapper.c consist of some text mixed
> with the affected path path and a strerror(3) string, so they're
> compatible in that way.  A single function (get_path_error_format()?)
> could thus be used and callers would be able to combine its result with
> die(), error(), or warning().

I think we've had this discussion before, a while ago. Yes, returning an
integer error code is nice because you don't have pass in an extra
parameter. But I think there are two pitfalls:

  1. Integers may not be descriptive enough to cover all cases, which is
     how we ended up with the strbuf-passing strategy in the ref code.
     Certainly you could add an integer for every possible bespoke
     message, but then I'm not sure it's buying that much over having
     the function simply fill in a strbuf.

  2. For complex functions there may be multiple errors that need to
     stack. I think the refs code has cases like this, where a syscall
     fails, which causes a fundamental ref operation to fail, which
     causes a higher-level operation to fail. It's only the caller of
     the higher-level operation that knows how to report the error.

Certainly an integer error code would work for _this_ function, but I'd
rather see us grow towards consistent error handling.

-Peff

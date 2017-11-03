Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32BEA20450
	for <e@80x24.org>; Fri,  3 Nov 2017 18:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbdKCS5h (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 14:57:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:45764 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751743AbdKCS5g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 14:57:36 -0400
Received: (qmail 725 invoked by uid 109); 3 Nov 2017 18:57:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Nov 2017 18:57:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3793 invoked by uid 111); 3 Nov 2017 18:57:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Nov 2017 14:57:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Nov 2017 14:57:33 -0400
Date:   Fri, 3 Nov 2017 14:57:33 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Simon Ruderich <simon@ruderich.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: factor out rewrite_file()
Message-ID: <20171103185732.jr6a5wo2bmvh4onb@sigill.intra.peff.net>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
 <20171101194732.fn4n46wppl35e2z2@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1711012240500.6482@virtualbox>
 <20171101221618.4ioog7jlp7n2nd53@sigill.intra.peff.net>
 <20171103103248.4p45r4klojk5cf2g@ruderich.org>
 <alpine.DEB.2.21.1.1711031425420.6482@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1711031425420.6482@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 03, 2017 at 03:46:44PM +0100, Johannes Schindelin wrote:

> > I tried looking into this by adding a new write_file_buf_gently()
> > (or maybe renaming write_file_buf to write_file_buf_or_die) and
> > using it from write_file_buf() but I don't know the proper way to
> > handle the error-case in write_file_buf(). Just calling
> > die("write_file_buf") feels ugly, as the real error was already
> > printed on screen by error_errno() and I didn't find any function
> > to just exit without writing a message (which still respects
> > die_routine). Suggestions welcome.
> 
> In my ideal world, we could use all those fancy refactoring tools that are
> currently en vogue and simply turn *all* error()/error_errno() calls into
> context-aware functions that can be told to die() right away, or to return
> the error in an error buffer, depending hwhat the caller (or the call
> chain, really) wants.
> 
> This is quite a bit more object-oriented than Git's code base, though, and
> besides, I am not aware of any refactoring tool that would make this
> painless (it's not just a matter of adding a parameter, you also have to
> pass it through all of the call chain, something you get for free when
> working with an object-oriented language).

FWIW, I sketched this out a bit here:

  https://public-inbox.org/git/20160928085841.aoisson3fnuke47q@sigill.intra.peff.net/

And you can see the patches I played with while writing that here:

  https://github.com/peff/git/compare/cb5918aa0d50f50e83787f65c2ddc3dcb10159fe...4d61927e66dcfdbdb6cc6c88ec4018e2142e826c

(but note they don't quite compile, as some of the conversions are
half-done; it was really just to get a sense of the flavor of the
thing).

One of the complaints was that it makes it harder to see when we are
calling die() (because it's now happening via an error callback). That
maybe confusing for users, but it may also affect generated code since
the code paths that hit the NORETURN function are obscured.

But we could stop short of adding error_die, and just have error_silent,
error_warn, and error_print (and callers can turn error_print into a
die() themselves).

-Peff

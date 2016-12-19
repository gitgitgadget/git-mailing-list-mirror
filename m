Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 412E11FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 20:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753741AbcLSUDE (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 15:03:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:58690 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753610AbcLSUDC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 15:03:02 -0500
Received: (qmail 25308 invoked by uid 109); 19 Dec 2016 20:03:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Dec 2016 20:03:02 +0000
Received: (qmail 487 invoked by uid 111); 19 Dec 2016 20:03:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Dec 2016 15:03:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Dec 2016 15:03:00 -0500
Date:   Mon, 19 Dec 2016 15:03:00 -0500
From:   Jeff King <peff@peff.net>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] mailinfo.c: move side-effects outside of assert
Message-ID: <20161219200259.nqqyvk6c72bcoaui@sigill.intra.peff.net>
References: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 17, 2016 at 11:54:18AM -0800, Kyle J. McKay wrote:

> Since 6b4b013f18 (mailinfo: handle in-body header continuations,
> 2016-09-20, v2.11.0) mailinfo.c has contained new code with an
> assert of the form:
> 
> 	assert(call_a_function(...))
> 
> The function in question, check_header, has side effects.  This
> means that when NDEBUG is defined during a release build the
> function call is omitted entirely, the side effects do not
> take place and tests (fortunately) start failing.
> 
> Move the function call outside of the assert and assert on
> the result of the function call instead so that the code
> still works properly in a release build and passes the tests.
> 
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
> 
> Notes:
>     Please include this PATCH in 2.11.x maint

This is obviously an improvement, but it makes me wonder if we should be
doing:

  if (!check_header(mi, &mi->inbody_header_accum, mi->s_hdr_data))
	die("BUG: some explanation of why this can never happen");

which perhaps documents the intended assumptions more clearly. A comment
regarding the side effects might also be helpful.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A040207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 02:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759292AbdDSCuU (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 22:50:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:35729 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755752AbdDSCuT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 22:50:19 -0400
Received: (qmail 29424 invoked by uid 109); 19 Apr 2017 02:50:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Apr 2017 02:50:19 +0000
Received: (qmail 18382 invoked by uid 111); 19 Apr 2017 02:50:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 22:50:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Apr 2017 22:50:16 -0400
Date:   Tue, 18 Apr 2017 22:50:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] various: disallow --no-no-OPT for --no-opt options
Message-ID: <20170419025016.we3tfuvgppuamc7g@sigill.intra.peff.net>
References: <20170418170914.9701-1-avarab@gmail.com>
 <de79d366-3609-8efe-b23a-7e793036b3ef@web.de>
 <20170419014143.56io56xn6mawy5xi@sigill.intra.peff.net>
 <xmqqh91lce6y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh91lce6y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 07:40:37PM -0700, Junio C Hamano wrote:

> > It might even be possible to detect the existing line and
> > have parse-options automatically respect "--foo" when "--no-foo" is
> > present.  But that may run afoul of callers that add both "--foo" and
> > "--no-foo" manually.
> 
> True but wouldn't that something we would want to avoid anyway?
> That is, "git cmd [--OPT | --no-OPT | --no-no-OPT]" from the end
> user's point of view should be an error because it is unclear what
> difference there are between --OPT and --no-no-OPT.  And we should
> be able to add a rule to parse_options_check() to catch such an
> error.

I meant that if you have something like this in your options array:

  { 0, "foo", OPTION_INTEGER, &foo, 1 },
  { 0, "no-foo", OPTION_INTEGER, &foo, 2 },

that if we start magically treating "--no-foo" magically, it will
conflict with "--foo" (in this case that's maybe OK because --foo comes
first, but as a general rule it's dangerous to existing options arrays).

> Having said that, I am not sure if we want to go the route of
> "existing line that begins with 'no-' behaves magical".  For
> boolean, I suspect we may be get away with such a magic without
> confusing ourselves too much, though.

Yeah, at which point we might as well ask callers to explicitly ask for
the behavior with OPT_NEGBOOL.

-Peff

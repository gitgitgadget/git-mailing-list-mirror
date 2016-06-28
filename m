Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DDF82018A
	for <e@80x24.org>; Tue, 28 Jun 2016 21:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbcF1VDZ (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 17:03:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:37256 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752712AbcF1VDX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 17:03:23 -0400
Received: (qmail 3876 invoked by uid 102); 28 Jun 2016 21:03:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jun 2016 17:03:13 -0400
Received: (qmail 12381 invoked by uid 107); 28 Jun 2016 21:03:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jun 2016 17:03:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Jun 2016 17:03:09 -0400
Date:	Tue, 28 Jun 2016 17:03:09 -0400
From:	Jeff King <peff@peff.net>
To:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	sschuberth@gmail.com
Subject: Re: [PATCH v2 0/2] Config conditional include
Message-ID: <20160628210309.GC21002@sigill.intra.peff.net>
References: <20160626070617.30211-1-pclouds@gmail.com>
 <20160628172641.26381-1-pclouds@gmail.com>
 <20160628202809.GA21002@sigill.intra.peff.net>
 <vpqk2h9qbp8.fsf@anie.imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vpqk2h9qbp8.fsf@anie.imag.fr>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 28, 2016 at 10:51:15PM +0200, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Jun 28, 2016 at 07:26:39PM +0200, Nguyễn Thái Ngọc Duy wrote:
> >
> >> There's a surprise about core.ignorecase. We are matching paths, so we
> >> should match case-insensitively if core.ignorecase tells us so. And it
> >> gets a bit tricky if core.ignorecase is defined in the same config
> >> file. I don't think we have ever told the user that keys are processed
> >> from top down. We do now.
> >
> > Hrm. I'm not excited about introducing ordering issues into the config
> > parsing.
> 
> There's already at least one case of ordering-sensitive variables, that
> we encountered when writting the config cache during Tanay Abhra's GSoC:
> diff.<driver>.funcname Vs diff.<driver>.xfuncname. Git applies the "last
> one wins" policy, which is the normal rule for a single-valued variable,
> but in this case, a "funcname" definition can override an "xfuncname"
> def. To preserve this behavior we had to introduce ordering in the
> cache, but to me this was a design mistake to rely on order.
> 
> In short: we already have one, but I'm not excited either about
> introducing new ones.

I still see funcname versus xfuncname as fundamentally a "last one wins"
scenario; it's just that the two options are sort-of synonyms. But we
are still talking about the same linear-ish parsing scheme, and I think
it just makes the implementation a little more complicated.

I'm much more worried about something that impacts how we parse the
config, and is set up in a possibly unrelated config-parsing sequence.
So whether ignorecase will work depends on more variables:

 - are we doing our config parse before or after somebody has called
   git_config() at the start of a program?

 - if before (or during), does our callback call git_default_core_config()?

 - if so, did core.ignorecase appear before our include? (Almost
   certainly not, if our include is in ~/.gitconfig, because we parse
   from least-specific to most-specific).

So here it is not the implementation that is complicated, but the
user-facing behavior. It's very difficult to predict when your include
will kick in, and there is a good chance it will behave differently for
different programs.

In general I think the best bet here is to lazy-load such values from
the config-cache (so we _know_ that we got a complete parse before we
look at the value). But that creates a recursion problem when we try to
lazy-load from inside the config parser itself.

-Peff

Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4181BC4363D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 05:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01AC123A84
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 05:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgIVFI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 01:08:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:36486 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbgIVFI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 01:08:57 -0400
Received: (qmail 13744 invoked by uid 109); 22 Sep 2020 05:08:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Sep 2020 05:08:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29346 invoked by uid 111); 22 Sep 2020 05:08:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Sep 2020 01:08:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Sep 2020 01:08:55 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: sub-fetches discard --ipv4|6 option
Message-ID: <20200922050855.GC528837@coredump.intra.peff.net>
References: <20200914121906.GD4705@pflmari>
 <20200914194951.GA2819729@coredump.intra.peff.net>
 <20200915115025.GA18984@pflmari>
 <20200915130506.GA2839276@coredump.intra.peff.net>
 <20200915140613.GB18984@pflmari>
 <20200915152730.GA2853972@coredump.intra.peff.net>
 <20200915160357.GC18984@pflmari>
 <20200916163218.GA17726@coredump.intra.peff.net>
 <20200917143339.GF8079@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917143339.GF8079@pflmari>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 04:33:39PM +0200, Alex Riesen wrote:

> > Adding a new strvec pointer to parse_options() works, but means updating
> > all of the callers, most of which will pass NULL. Possibly the existing
> > "flags" parameter to parse_options() could grow into a struct. That
> > requires modifying each caller, but at least solves the problem once and
> > for all.
> 
> With such complication a step-wise parsing sounds easier, given that at the
> moment there is only one user for the feature. Are there *existing* callers
> of parse_options with similar requirements?

I don't know offhand. I'd suspect some of the command which take
--recurse-submodules do something similar, but the number of steps
between the main command the submodule argv may make it awkward to use
a parse-options solution. I don't think we have a "push to each of these
remotes" option the way we do for fetch.

> I feel that doing this kind of selection work in parse_options is an overkill:
> if it is specific for just this use case, the implementation might be more
> complex than necessary, while profiting just one caller.

Yeah, I agree it's complex, and I'm happy with simpler solutions (or
just fixing these ones as you did and punting on it for now).

> > Another option is to stick it into parse_opt_ctx_t. That's used only be
> > step-wise callers, of which there are very few.
> 
> Does that mean that currently there is no way to find out which option
> corresponds to the last parsed command-line argument after a call to
> parse_options_step? Which in turn makes the marking of recursive options
> inaccessible to step-wise command line parsing code, right?

I'm not super familiar with the internals of parse-options, but it
doesn't look like it. Each step consumes an argv and matches it to a
"struct option", but I don't think you get to know which struct it was
matched to. It would be reasonable for it to keep a pointer in the
parse_opt_ctx_t (and of course you'd need some bit in the option struct
itself to say "I am a recursive option").

-Peff

Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D259EC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB9E206B2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgIPUPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:15:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:58448 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbgIPRcb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 13:32:31 -0400
Received: (qmail 24758 invoked by uid 109); 16 Sep 2020 16:32:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Sep 2020 16:32:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29507 invoked by uid 111); 16 Sep 2020 16:32:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Sep 2020 12:32:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Sep 2020 12:32:18 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: sub-fetches discard --ipv4|6 option
Message-ID: <20200916163218.GA17726@coredump.intra.peff.net>
References: <20200914121906.GD4705@pflmari>
 <20200914194951.GA2819729@coredump.intra.peff.net>
 <20200915115025.GA18984@pflmari>
 <20200915130506.GA2839276@coredump.intra.peff.net>
 <20200915140613.GB18984@pflmari>
 <20200915152730.GA2853972@coredump.intra.peff.net>
 <20200915160357.GC18984@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915160357.GC18984@pflmari>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 15, 2020 at 06:03:57PM +0200, Alex Riesen wrote:

> > If you go that route, we have some "_F" macros that take flags. Probably
> > would make sense to add it more consistently, which lets you convert:
> > 
> >   OPT_BOOL('f', "foo", &foo, "the foo option");
> > 
> > into:
> > 
> >   OPT_BOOL_F('f', "foo", &foo, "the foo option", PARSE_OPT_RECURSIVE);
> > 
> > but could also be used for other flags.
> 
> This part (marking of the options) was easy. What's left is finding out if an
> option was actually specified in the command-line. The ...options[] arrays are
> not update by parse_options() with what was given, are they?

Oh right. Having the list of options is not that helpful because
add_options_argv() is actually working off the parsed data in individual
variables. Sorry for leading you in a (maybe) wrong direction.

I think this approach would have to be coupled with some mechanism for
looking over the original list of options (either saving the original
argv before parsing, or teaching parse-options the kind of two-pass
"don't parse these the first time" mechanism discussed elsewhere in the
thread).

> Maybe extend struct option with a field to store given command-line argument
> (as it was specified) and parse_options() will update the field if
> PARSE_OPT_RECURSIVE is present in .flags?
> Is it allowed for parse_options() to modify the options array?

No, we take the options array as a const pointer, so many callers would
likely need to be updated to handle that. Plus it's possible some may
actually re-use the array multiple times in some cases.

> Or is it possible to use something in parse-options.h API to note the
> arguments somewhere while they are parse? I mean, there are
> parse_options_start/step/end, can cmd_fetch argument parsing use those
> so that the options marked recursive can be saved for sub-fetches?

Possibly the step-wise parsing could help. But I think it might be
easier to just let parse_options() save a copy of parsed options. And
then our PARSE_OPT_RECURSIVE really becomes PARSE_OPT_SAVE or similar,
which would cause parse-options to save the original option (and any
value argument) in its original form.

There's one slight complication, which is how the array of saved options
gets communicated back to the caller. Leaving them in the original argv
probably isn't a good idea (because the caller relies on it having
options removed in order to find the non-option arguments).

Adding a new strvec pointer to parse_options() works, but means updating
all of the callers, most of which will pass NULL. Possibly the existing
"flags" parameter to parse_options() could grow into a struct. That
requires modifying each caller, but at least solves the problem once and
for all.

Another option is to stick it into parse_opt_ctx_t. That's used only be
step-wise callers, of which there are very few.

-Peff

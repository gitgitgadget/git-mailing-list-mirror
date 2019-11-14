Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C6901F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 06:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfKNG3B (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 01:29:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:47140 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726190AbfKNG3B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 01:29:01 -0500
Received: (qmail 22342 invoked by uid 109); 14 Nov 2019 06:29:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Nov 2019 06:29:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1187 invoked by uid 111); 14 Nov 2019 06:32:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Nov 2019 01:32:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Nov 2019 01:29:00 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] builtin/config: canonicalize "value_regex" with
 `--type=bool[-or-int]`
Message-ID: <20191114062900.GD10643@sigill.intra.peff.net>
References: <cover.1573670565.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1573670565.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 13, 2019 at 07:54:59PM +0100, Martin Ågren wrote:

> To find all config items "foo.*" that are configured as the Boolean
> value "true", you can try executing
> 
>   git config --type=bool --name-only --get-regexp '^foo\.' true
> 
> ... and hope that you didn't spell "true" as "on", "True" or "1" back
> when you populated your config. This shortcoming has been mentioned as a
> left-over bit [1] [2].

This seems like a good idea, but I wonder why we'd limit it to bools?
It seems like any type would probably be better off matching a
normalized version.

We already have two functions in builtin/config.c which handle types:

  - format_config() is for actually interpreting an existing value and
    writing it to stdout

  - normalize_value() is used when writing a new value into a config
    file, and normalizing what the user provided on the command-line

I don't think you'd want to use format_config() here. For example, if I
say:

  git config --type=color --get-regexp ^foo red

I want to match the original "red" color, but _output_ the ANSI code.
But normalize_value(), by contrast, leaves colors intact. So maybe it's
a good match?

OTOH, I'd probably expect to match expanded pathnames or expiration
dates there, too, and it doesn't expand those. Those ones are less clear
to me. The whole premise of this series is making an assumption that
"--type" is about how you want to match, and not just about what you
want to output. In your example above it's clear that you don't care
about the output type (because you're using --name-only), but for:

  git config --type=path --get-regexp ^foo /home/peff

it's unclear if you want to match a value of "~peff/foo", or if you
simply want to output the expansion.

I wonder if we'd want to allow specifying the output type and the
matching type separately? Maybe that just makes it more awkward to use
for little benefit (I admit that it's hard to imagine somebody wanting
to normalize bools on output but _not_ for matching).

Anyway. It would be nice if we could build on the existing logic in some
way, rather than making a third place that has to handle every type we
know about.

> `--type=bool-or-int` gets the same treatment, except we need to to be
> able to handle the ints and regexes matching particular ints that we
> must expect. That said, even with `--type=bool` we can't move too
> aggressively towards *requiring* that the incoming "value_regex"
> canonializes as a Boolean value. The penultimate patch starts to warn on
> non-canonicalizing values; the final patch makes us bail out entirely.
> 
> The last patch is not meant for immediate inclusion, but I post it
> anyway. I can re-submit it at an appropriate time, or maybe it could
> slumber on pu until the time is ripe for completing the switch.

I think bailing on values that can't be converted is normal for other
code paths. E.g., just trying to print:

  $ git -c foo.bar=abc config --type=bool foo.abr
  fatal: bad numeric config value 'abc' for 'foo.bar': invalid unit

-Peff

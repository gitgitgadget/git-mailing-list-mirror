Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E151C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 15:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D24207F7
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 15:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHLPhG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:37:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:56460 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgHLPhG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 11:37:06 -0400
Received: (qmail 9787 invoked by uid 109); 12 Aug 2020 15:37:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Aug 2020 15:37:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32306 invoked by uid 111); 12 Aug 2020 15:37:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Aug 2020 11:37:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Aug 2020 11:37:05 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [PATCH v2] test_cmp: diagnose incorrect arguments
Message-ID: <20200812153705.GC33189@coredump.intra.peff.net>
References: <20200809060810.31370-1-sunshine@sunshineco.com>
 <20200809174209.15466-1-sunshine@sunshineco.com>
 <20200811183258.GB33865@syl.lan>
 <CAPig+cSroWZEoOL78COmPS4rkvKLE-yCiqh6Part+5gUgVon+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSroWZEoOL78COmPS4rkvKLE-yCiqh6Part+5gUgVon+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 03:25:03PM -0400, Eric Sunshine wrote:

> 'test' can accept both switches (i.e. "-e") and non-switch arguments.
> Keep in mind, too, that all the quoting is stripped by the shell
> _before_ 'test' ever sees its arguments. Let's say that the caller has
> a filename whose name actually is "-e" and passes that in as $1. So,
> what does 'test' see?
> 
>     test -e = -
> 
> Rather than comparing literal string "-e" to literal string "-", it's
> instead (almost) asking if the file named "=" exists; I say "almost"
> because it's actually an error since switch -e only accepts one
> argument, but it's being given two arguments, "=" and "-".

I don't think this is an error. The program can tell which you meant by
the number of arguments. POSIX lays out some rules here (from "man
1posix test" on my system, but I'm sure you can find it online):

  3 arguments:
    *  If $2 is a binary primary, perform the binary test of $1 and $3.

    *  If $1 is '!', negate the two-argument test of $2 and $3.

    *  If $1 is '(' and $3 is ')', perform the unary test of $2.  On
       systems that do not support the XSI option, the results are
       unspecified if $1 is '(' and $3 is ')'.

    *  Otherwise, produce unspecified results.

So we'd see that "=" is a binary primary (the complete set is defined
earlier). Likewise "! -e -" would hit the second rule. We wouldn't get
fooled by trying to compare the string "!" because it knows that "=" is
a binary operator and "-e" is a unary operator.

It gets weird with "-a" joining expressions. There's some discussion in
the Rationale section of the posix page, and it even warns explicitly
against "-a" (in favor of "test expr1 && test expr1").

> which may or may not be an error in a particular implementation of
> 'test'. Some implementations may understand that "-" is not a valid
> switch, thus infer that you're actually asking for an equality
> comparison between arguments, but other implementations may complain
> either that there is no switch named "-" or that those arguments
> simply make no sense.

Yeah, historically I think there were shells that were not quite so
clever. I have no idea which ones, or whether any are still around. I
don't think we've generally been that concerned with this case in Git,
and nobody has complained. I'd be totally unsurprised to hear that SunOS
/bin/sh doesn't get this right, but we've already written it off as
unusable (it doesn't even support $() expansion).

-Peff

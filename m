Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD44C203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 20:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbcGVUFs (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 16:05:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:48853 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751576AbcGVUFs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 16:05:48 -0400
Received: (qmail 22933 invoked by uid 102); 22 Jul 2016 20:05:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 16:05:48 -0400
Received: (qmail 9504 invoked by uid 107); 22 Jul 2016 20:06:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jul 2016 16:06:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2016 16:05:45 -0400
Date:	Fri, 22 Jul 2016 16:05:45 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Richard Soderberg <rsoderberg@gmail.com>, git@vger.kernel.org
Subject: Re: git-prompt.sh incompatible with non-basic global grep.patternType
Message-ID: <20160722200545.GA18286@sigill.intra.peff.net>
References: <CAEvc1UQvXKtQCXvCmt-774A84--bkK-sb94BtFeqDDr0Gsf7qw@mail.gmail.com>
 <20160720134211.GA19359@sigill.intra.peff.net>
 <xmqqwpkgcbp9.fsf@gitster.mtv.corp.google.com>
 <20160720205207.GA578@sigill.intra.peff.net>
 <xmqqr3ala37o.fsf@gitster.mtv.corp.google.com>
 <20160722192811.GA18079@sigill.intra.peff.net>
 <xmqqa8h9a1uj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa8h9a1uj.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 22, 2016 at 12:51:00PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> This comes from b22520a3 (grep: allow -E and -n to be turned on by
> >> default via configuration, 2011-03-30) back when we didn't have a
> >> more generic grep.patternType configuration mechanism in v1.7.5
> >> days, and it probably need to be deprecated to maintain our sanity.
> >> ...
> > I am not even sure we need to deprecate it. Once it becomes merely a
> > historical synonym for "grep.patternType=extended" we can live with it
> > indefinitely (and I do not think we need a deprecation period to go
> > there; the existing behavior is simply buggy).
> 
> I grossed over an important detail.
> 
> Pretending as if grep.patternType=extended were given when we see
> grep.extendedregexp=true and grep.patternType=basic is given when
> grep.extendedregexp=false changes the behaviour in a way that can be
> seen as the violation of (crazy) expectations t7810 makes.
> 
> Any user who depends on that crazy expectation will be broken by
> such a change, even if we do not deprecate and remove the
> configuration variable.

Ah. Reading 84befcd (grep: add a grep.patternType configuration setting,
2012-08-03) explains the rules, although I agree they are crazy (mostly
because "basic" is different "fixed").

So I think there are two crazy things going on:

  1. grep.extendedregexp takes precedence over the command-line (or at
     least "--basic" on the command line).

  2. The weird rules in 84befcd, where patternType=fixed has higher
     precedence than extendedRegexp, but patternType=basic does not.

It seems like (1) is a bug, and one we should not have to worry about
compatibility while fixing. It stems from not telling the difference
between "the user asked for nothing, so we defaulted to basic" and "the
user explicitly asked for basic".

I think (2) _is_ kind of crazy, and stems from similar confusion. I
dunno. Part of me wants to say "I find it highly unlikely that anybody
ever actually relied on this, and therefore it is OK to bring it closer
to sanity without a deprecation period". But I admit that is just a gut
feeling.

But even that is a lesser breakage than taking away grep.extendedRegexp
entirely. Taking it away breaks anybody who uses it; tweaking (2) only
breaks people who set both config variables. But why would anyone do
that?

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30012027C
	for <e@80x24.org>; Sat, 15 Jul 2017 11:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbdGOLIm (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 07:08:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:41422 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751161AbdGOLIl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 07:08:41 -0400
Received: (qmail 15774 invoked by uid 109); 15 Jul 2017 11:08:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 15 Jul 2017 11:08:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17291 invoked by uid 111); 15 Jul 2017 11:08:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 15 Jul 2017 07:08:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Jul 2017 07:08:39 -0400
Date:   Sat, 15 Jul 2017 07:08:39 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
Message-ID: <20170715110839.hefdnf4eqhdwboxq@sigill.intra.peff.net>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
 <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org>
 <xmqq4luk58ot.fsf@gitster.mtv.corp.google.com>
 <962da692-8874-191c-59d4-65b9562cf87f@kdbg.org>
 <xmqqy3rw3rc8.fsf@gitster.mtv.corp.google.com>
 <xmqqlgnrq9qi.fsf@gitster.mtv.corp.google.com>
 <20170714224309.7p4a4vuuv3k2cdjg@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170714224309.7p4a4vuuv3k2cdjg@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 15, 2017 at 07:43:09AM +0900, Mike Hommey wrote:

> >  - There were occasional cases where we wished if variable-length
> >    arrays, flexible array members and variadic macros were available
> >    in our codebase during the course of this project.  We would
> >    probably want to add a similar test baloon patch for each of
> >    them to this series that is currently two-patch long.
> 
> FWIW, variadic macros have subtle implementation differences that can
> cause problems.
> For instance, MSVC only supports ##__VA_ARGS__ by way of
> ignoring ## somehow, but has the default behavior of dropping the comma
> when __VA_ARGS__ is empty, which means , __VA_ARGS__ *without* ## has a
> different behavior.
> See also https://connect.microsoft.com/VisualStudio/feedback/details/380090/variadic-macro-replacement

When there's any other non-optional argument, you can work around this
by just lumping that argument in with the varargs. So don't do:

  #define FOO(fmt, ...) printf(fmt, __VA_ARGS__)

which fails when the format has no placeholders.  Instead do:

  #define FOO(...) printf(__VA_ARGS__)

That limits your interface for variadic macros, but in practice it
doesn't usually come up (there are also disgusting macro tricks you can
do to cover the true 0-arg case portably, but we haven't had to turn to
them yet).

-Peff

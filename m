Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84C1E1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 21:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757719AbcK3VZP (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 16:25:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:49259 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757469AbcK3VZN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 16:25:13 -0500
Received: (qmail 14261 invoked by uid 109); 30 Nov 2016 21:25:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 21:25:12 +0000
Received: (qmail 24647 invoked by uid 111); 30 Nov 2016 21:25:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 16:25:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2016 16:25:10 -0500
Date:   Wed, 30 Nov 2016 16:25:10 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] difftool.c: mark a file-local symbol with static
Message-ID: <20161130212510.ihcmvig7jq44p3nx@sigill.intra.peff.net>
References: <4ddad7ea-5ac8-20b2-da9e-5843c486878a@ramsayjones.plus.com>
 <alpine.DEB.2.20.1611301204020.117539@virtualbox>
 <29abc89b-9ca5-930f-8e90-ca446ac2b96a@ramsayjones.plus.com>
 <xmqqtwaod7ly.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtwaod7ly.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 12:40:25PM -0800, Junio C Hamano wrote:

> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
> > [I have fixed my config.mak file now, so I don't see the warning
> > anymore! Having -Wno-format-zero-length in DEVELOPER_CFLAGS, or
> > not, is a separate matter.]
> 
> I suspect that 658df95a4a ("add DEVELOPER makefile knob to check for
> acknowledged warnings", 2016-02-25) took it from me (namely, Make
> script in my 'todo' branch).  In turn, I added it to my set of flags
> in order to squelch this exact warning, so...

For anybody interested in the history, we started using this when
status_printf() got the format attribute. Relevant patch and discussion:

  http://public-inbox.org/git/20130710002328.GC19423@sigill.intra.peff.net/T/#u

We went with disabling the warning because it really is wrong. It makes
an assumption that calling a format function with an empty string
doesn't do anything, but that's only true of the stock printf functions.
Our custom functions _do_ have a side effect in this case.

The other options are to have a special function for "print a warning
(or status) line with no content". Or to teach those functions to handle
newlines specially. We've often discussed that you should be able to do:

  warning("foo\nbar");

and have it print:

  warning: foo
  warning: bar

That's useful in itself, and would probably make cases like this easier
to handle, too. But it's a pretty big change. Another option would be to
just teach formatting functions to handle a single "\n" as a synonym for
the empty string (or even detect trailing newlines and avoid appending
our own in that case). That would mean you could do:

  warning("\n");

to print a blank line. That's arguably more obvious about the intent to
a reader (I say arguably because the new behavior _is_ subtle if you
happen to know that warning() usually appends a newline).

Anyway. Those are all options, but I don't think there is any problem
with sticking with warning("") for now. It is not the first part of the
code that tickles the format-zero-length warning.

-Peff

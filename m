Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BD5E1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 13:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeDCN1V (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 09:27:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:51800 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750722AbeDCN1T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 09:27:19 -0400
Received: (qmail 31249 invoked by uid 109); 3 Apr 2018 13:27:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Apr 2018 13:27:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25348 invoked by uid 111); 3 Apr 2018 13:28:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Apr 2018 09:28:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2018 09:27:17 -0400
Date:   Tue, 3 Apr 2018 09:27:17 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: A potential approach to making tests faster on Windows
Message-ID: <20180403132717.GC18824@sigill.intra.peff.net>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
 <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
 <20180329194159.GB2939@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
 <87fu4hwgfa.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1804031150030.5026@qfpub.tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1804031150030.5026@qfpub.tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 03, 2018 at 01:43:10PM +0200, Johannes Schindelin wrote:

> > I don't have time or interest to work on this now, but thought it was
> > interesting to share. This assumes that something in shellscript like:
> > 
> >     while echo foo; do echo bar; done
> > 
> > Is no slower on Windows than *nix, since it's purely using built-ins, as
> > opposed to something that would shell out.
> 
> It is still interpreting stuff. And it still goes through the POSIX
> emulation layer.
> 
> I did see reports on the Git for Windows bug tracker that gave me the
> impression that such loops in Unix shell scripts may not, in fact, be as
> performant in MSYS2's Bash as you would like to believe:
> 
> https://github.com/git-for-windows/git/issues/1533#issuecomment-372025449

The main problem with `read` loops in shell is that the shell makes one
read() syscall per character. It has to, because doing otherwise is
user-visible in cases where the descriptor may get passed to a different
process.

There's unfortunately no portable way to say "please just read this
quickly, I promise nobody else is going to read the descriptor". And nor
do I know of any shell which is smart enough to know that it's going to
consume to EOF anyway (as you would for something like "cmd | while
read").

If you know you have bash, you can use "-N" to get a more efficient
read:

  $ echo foo | strace -e read bash -c 'read foo'
  [...]
  read(0, "f", 1)                         = 1
  read(0, "o", 1)                         = 1
  read(0, "o", 1)                         = 1
  read(0, "\n", 1)                        = 1

  $ echo foo | strace -e read bash -c 'read -N 10 foo'
  [...]
  read(0, "foo\n", 10)                    = 4
  read(0, "", 6)                          = 0

but then you have another problem: how to split the resulting buffer
into lines in shell. ;)

But if we're at the point of creating custom C builtins for
busybox/dash/etc, you should be able to create a primitive for "read
this using buffered stdio, other processes be damned, and return one
line at a time".

-Peff

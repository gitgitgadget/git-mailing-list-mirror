Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D35C91FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 17:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbcHZRVg (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 13:21:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:33624 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753255AbcHZRVf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 13:21:35 -0400
Received: (qmail 24087 invoked by uid 109); 26 Aug 2016 17:21:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Aug 2016 17:21:34 +0000
Received: (qmail 25910 invoked by uid 111); 26 Aug 2016 17:21:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Aug 2016 13:21:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Aug 2016 13:21:31 -0400
Date:   Fri, 26 Aug 2016 13:21:31 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>
Subject: Re: [PATCH v6 06/13] pkt-line: add functions to read/write flush
 terminated packet streams
Message-ID: <20160826172130.v2zh7dbazg6ac2zj@sigill.intra.peff.net>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
 <20160825110752.31581-7-larsxschneider@gmail.com>
 <CAGZ79kaVg40H-LeDtFfDYqDFDDbr+um3ZYj8oAaqGu+q6k5e+A@mail.gmail.com>
 <xmqqvayojx9e.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xrYM_r+Q_27hWM2FwbreV90AqPgoiH-qPZN0hoPiHpKhQ@mail.gmail.com>
 <CAGZ79kYD7KSzdhe-60fs5iUKmYcMd6+V3fSN513+sr15q+g39Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYD7KSzdhe-60fs5iUKmYcMd6+V3fSN513+sr15q+g39Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 26, 2016 at 10:02:52AM -0700, Stefan Beller wrote:

> Yeah. To me it seems this design explicitly makes it hard for side bands.
> As we do not need sidebands for local transfers, this is fine for sure.
> 
> (If we wanted to make it sideband friendly, I'd expect you could register
> callbacks for either all packets or for a given sideband until the next
> flush comes.)
> 
> So as hinted by this design, we want a protocol that
> * doesn't care about sidebands
> * cares about large data (hence maybe throughput)
> * has easy/clean interface
> 
> And one large packet would suffice for these three points as well
> and additionally has benefits for the network stuff.
> 
> The 320kB additional transmission are negligible overhead, so I was not
> concerned about the size, but rather the code being bloated, i.e. we need
> one layer of additional code to cope with the repetitive packets.

Maybe I don't understand what you mean by "one large packet". But if you
mean sending "I am about to send you 100MB" followed by the 100MB, the
point is that the sender does not necessarily have that exact value
ahead of time. So it would want to write it in chunks.

E.g., consider a clean which replaces s/foo/bar/ in its content. It
would write out all the content up to the next "foo", then write "bar",
and repeat.

We could let each chunk be arbitrarily big. I.e., "I am about to send
you 50MB", then "here are 3 bytes", then "here are the other 50MB".

But using a fixed-size length header makes the packets easy to generate
and parse. And 64KB is small enough that senders and receivers can
easily buffer single packets, making interfaces simpler. And it's big
enough that the overhead (4 bytes per 64KB) is negligible.

Anyway. It certainly does not seem worth moving the network protocols to
a new data format. The compatibility changes would not be worth it. But
if we _were_ to do so, there are tons of efficient well-thought-out
data-marshaling formats we could use rather than inventing our own. But
I just don't see the benefit.

> ---
> My background is mostly submodule related, and whenever I come up
> with a shiny novel idea that would help submodules tremendously, someone
> (mostly Peff) comes along and suggests a broader more generic thing, that
> works just as well for submodules but is applicable to all of Git.

Heh. It is not always a good thing, if it derails the original purpose
of the code (and I include some of my suggestions in that). :)

The trick is to make it general enough, without getting lost in the
weeds of what _might_ happen in the future and wasting time (and
adding complexity).

-Peff

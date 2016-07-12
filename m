Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC6B51F744
	for <e@80x24.org>; Tue, 12 Jul 2016 05:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932981AbcGLFYk (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 01:24:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:43289 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750972AbcGLFYj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 01:24:39 -0400
Received: (qmail 14875 invoked by uid 102); 12 Jul 2016 05:24:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 01:24:35 -0400
Received: (qmail 5203 invoked by uid 107); 12 Jul 2016 05:24:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 01:24:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2016 01:24:30 -0400
Date:	Tue, 12 Jul 2016 01:24:30 -0400
From:	Jeff King <peff@peff.net>
To:	Shawn Pearce <spearce@spearce.org>
Cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, e@80x24.org, dwwang@google.com,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
Message-ID: <20160712052430.GA23897@sigill.intra.peff.net>
References: <20160709003113.26930-1-sbeller@google.com>
 <20160709003113.26930-3-sbeller@google.com>
 <CAJo=hJtUyF=-iZeA1qBi42KBCP0pE6KsK4_MDP4JZEOf-K0waQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJo=hJtUyF=-iZeA1qBi42KBCP0pE6KsK4_MDP4JZEOf-K0waQ@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 10, 2016 at 10:06:12AM -0700, Shawn Pearce wrote:

> On Fri, Jul 8, 2016 at 5:31 PM, Stefan Beller <sbeller@google.com> wrote:
> > +
> > +       /* NEEDSWORK: expose the limitations to be configurable. */
> > +       int max_options = 32;
> > +
> > +       /*
> > +        * NEEDSWORK: expose the limitations to be configurable;
> > +        * Once the limit can be lifted, include a way for payloads
> > +        * larger than one pkt, e.g allow a payload of up to
> > +        * LARGE_PACKET_MAX - 1 only, and reserve the last byte
> > +        * to indicate whether the next pkt continues with this
> > +        * push option.
> > +        */
> > +       int max_size = 1024;
> 
> Instead of this, what about a new config variable
> receive.maxCommandBytes[1] that places a limit on the number of bytes
> of pkt-line data the client can supply in both the command list ("old
> new ref"), push signature framing, and option list?

Hmm, I hadn't thought about that. Just for RAM usage, I don't really see
a huge need for individual limits Sometimes meta-limits like this can be
confusing to set ("I have a huge repo with 50,000 refs that I want to
mirror-push; what do I set the byte-limit to?"), but for the most part
people shouldn't need to be touching it.  And I wonder if this could
simply be done at the pkt-line level.

OTOH, if the true goal is just to limit memory usage, I wonder if git
should be involved at all. Sadly, things like ulimit or cgroups are not
greated for limiting heap memory. ulimit doesn't count non-brk() memory
on most operating systems, and cgroups is too eager to count shared
packfile mmaps. You can try hooking xmalloc/free to keep stats, but you
have to know the size of each allocation in free(), which means either
being intimate with the underlying malloc implementation, or doing dirty
tricks (e.g., increasing the allocation by a few bytes and shoving the
size there). So it feels like there should be a way to ask the malloc
implementation not to allocate more than N bytes at a time, but AFAIK
glibc malloc does not have such a feature. Maybe other allocators do.

I also think there are some reasons besides RAM usage to limit things.

For instance, there is definitely some per-ref work that receive-pack
does (and hooks may do, as well). That remains proportional to the
amount of data sent, but an annoying client can min-max the parameters
by sending a bunch of short ref names, maximizing the size of the "# of
refs" parameter.

Similarly, I'm as much interested in total RAM usage as I am in making
sure we don't hit weird pathological cases. For instance, places where
tree entry names are so long that they overflow "int" and cause bogus
size computations and access memory outside of the array. That probably
wouldn't be an issue here, if the total data size is on the order of
megabytes (so your worst-case is somebody minimizes all parameters but
one, and then that maximizes the other one; but if it still caps out at
a few megabytes, that's not going to overflow anything).

> I studied a lot of repositories[2] and most use ref names under 200
> bytes in length. A 3 MiB default for receive.maxCommandBytes gives
> users something like 11,115 references in a single git push invocation
> if they used all 200 bytes in every name. Most users don't have ref
> names this long. Unlike a cap on each ref, it allows users to use the
> full 65449 bytes in a reference name available in pkt-line, but you
> can only send 48 such references. Likewise for options. :)

My usual "worst case" for refs is:

  https://github.com/JetBrains/intellij-community

A mirror push of that needs more like 4MiB. I'd probably say something
like 10MiB is a reasonable default.

-Peff

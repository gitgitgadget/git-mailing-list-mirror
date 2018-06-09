Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49F721F403
	for <e@80x24.org>; Sat,  9 Jun 2018 06:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752771AbeFIGvf (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 02:51:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:39830 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752610AbeFIGve (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 02:51:34 -0400
Received: (qmail 21304 invoked by uid 109); 9 Jun 2018 06:51:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Jun 2018 06:51:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 991 invoked by uid 111); 9 Jun 2018 06:51:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 09 Jun 2018 02:51:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Jun 2018 02:51:32 -0400
Date:   Sat, 9 Jun 2018 02:51:32 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
Message-ID: <20180609065132.GD30224@sigill.intra.peff.net>
References: <20180607145313.25015-1-git@jeffhostetler.com>
 <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
 <20180608090758.GA15112@sigill.intra.peff.net>
 <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de>
 <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org>
 <87fu1w53af.fsf@evledraar.gmail.com>
 <CACsJy8BPhzs5M4peHN2HczmDxGmAuKZ0corzT66i+rJ2UQRTHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BPhzs5M4peHN2HczmDxGmAuKZ0corzT66i+rJ2UQRTHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 09, 2018 at 07:03:53AM +0200, Duy Nguyen wrote:

> > > Am 08.06.2018 um 18:00 schrieb Thomas Braun:
> > >> I for my part would much rather prefer that to be a compile time
> > >> option so that I don't need to check on every git update on windows
> > >> if  this is now enabled or not.
> > >
> > > This exactly my concern, too! A compile-time option may make it a good
> > > deal less worrisome.
> >
> > Can you elaborate on how someone who can maintain inject malicious code
> > into your git package + config would be thwarted by this being some
> > compile-time option, wouldn't they just compile it in?
> 
> Look at this from a different angle. This is driven by the needs to
> collect telemetry in _controlled_ environment (mostly server side, I
> guess) and it should be no problem to make custom builds there for
> you. Not making it a compile-time option could force [1] linux distro
> to carry this function to everybody even if they don't use it (and
> it's kinda dangerous to misuse if you don't anonymize the data
> properly). I also prefer this a compile time option.

I actually think this could be useful for normal users, too. We have
GIT_TRACE for dumping debug output, and we sometimes ask users to turn
it on to help diagnose a problem (not to mention that we use it
ourselves).

AFAICT this telemetry data is the same thing, but for performance. When
somebody says "why does this command take so long", wouldn't it be nice
for us to be able to tell them to flip a switch that will collect data
on which operations are taking a long time?

> [1] Of course many distros can choose to patch it out. But it's the
> same argument as bringing this option in in the first place: you guys
> already have that code in private and now want to put it in stock git
> to reduce maintenance cost, why add extra cost on linux distro
> maintenance?

We don't do performance telemetry like this at GitHub, but we do collect
a few variables that we dump to a custom over a Unix socket (e.g., our
upload-pack records clone vs fetch and shallow vs non-shallow for each
request).

In my experience the maintenance burden is not in the "connect to a
socket" part, but the fact that you have to sprinkle the entry points
throughout the code (e.g., "set 'cloning' flag to 1" or "I'm entering
the pack generation phase of the fetch"). So I'd love to see us do that
sprinkling _once_ where everyone can benefit, whether they want better
tracing for debugging, telemetry across their installed base, or
whatever.

The mechanism to handle those calls is much easier to plug in and out,
then. And I don't have a huge preference for compile-time versus
run-time, or whether bits are in-tree or out-of-tree. Obviously we'd
have some basic "write to stderr or a file" consumer in-tree.

For myself, I'm happy with compile-time (I'm instrumenting the server
side, so I really only care about my specific build) and out-of-tree
(the protocol to our custom daemon consumer is not something anybody
else would care about anyway).

For people collecting from clients, I imagine it's more convenient to be
able to let them use official builds and just tweak a knob, even if they
_could_ build a custom Git and push it out to everybody. I don't know
anything about Windows event tracing, but if it's a standard facility
then I doubt we're talking about a huge maintenance burden to have it
in-tree as a configurable option.

So IMHO that really leaves the "is it too scary to have a config knob
that lets tracing go to this event facility versus to a file"? I guess I
just don't see it, as long as the user has to enable it explicitly. That
seems like complaining that GIT_TRACE could go to syslog. If you don't
want to store it, then don't turn on the feature.

-Peff

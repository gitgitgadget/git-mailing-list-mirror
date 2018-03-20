Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E2FA1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 05:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeCTFwF (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 01:52:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:35544 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750888AbeCTFwE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 01:52:04 -0400
Received: (qmail 1561 invoked by uid 109); 20 Mar 2018 05:52:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Mar 2018 05:52:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29427 invoked by uid 111); 20 Mar 2018 05:52:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Mar 2018 01:52:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Mar 2018 01:52:00 -0400
Date:   Tue, 20 Mar 2018 01:52:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        lars.schneider@autodesk.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/2] routines to generate JSON data
Message-ID: <20180320055200.GD15813@sigill.intra.peff.net>
References: <20180316194057.77513-1-git@jeffhostetler.com>
 <20180316211837.GB12333@sigill.intra.peff.net>
 <87tvtfd3sl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvtfd3sl.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 12:00:26AM +0100, Ævar Arnfjörð Bjarmason wrote:

> 
> On Fri, Mar 16 2018, Jeff King jotted:
> 
> > I really like the idea of being able to send our machine-readable output
> > in some "standard" syntax for which people may already have parsers. But
> > one big hangup with JSON is that it assumes all strings are UTF-8.
> 
> FWIW It's not UTF-8 but "Unicode characters", i.e. any Unicode encoding
> is valid, not that it changes anything you're pointing out, but people
> on Win32 could use UTF-16 as-is if their filenames were in that format.

But AIUI, non-UTF8 has to come as "\u" escapes, right? That at least
gives us an "out" for exotic characters, but I don't think we can just
blindly dump pathnames into quoted strings, can we?

> > Some possible solutions I can think of:
> >
> >   1. Ignore the UTF-8 requirement, making a JSON-like output (which I
> >      think is what your patches do). I'm not sure what problems this
> >      might cause on the parsing side.
> 
> Maybe some JSON parsers are more permissive, but they'll commonly just
> die on non-Unicode (usually UTF-8) input, e.g.:
> 
>     $ (echo -n '{"str ": "'; head -c 3 /dev/urandom ; echo -n '"}') | perl -0666 -MJSON::XS -wE 'say decode_json(<>)->{str}'
>     malformed UTF-8 character in JSON string, at character offset 10 (before "\x{fffd}e\x{fffd}"}") at -e line 1, <> chunk 1.

OK, that's about what I expected.

> >   2. Specially encode non-UTF-8 bits. I'm not familiar enough with JSON
> >      to know the options here, but my understanding is that numeric
> >      escapes are just for inserting unicode code points. _Can_ you
> >      actually transport arbitrary binary data across JSON without
> >      base64-encoding it (yech)?
> 
> There's no way to transfer binary data in JSON without it being shoved
> into a UTF-8 encoding, so you'd need to know on the other side that
> such-and-such a field has binary in it, i.e. you'll need to invent your
> own schema.

Yuck. That's what I was afraid of. Is there any kind of standard scheme
here? It seems like we lose all of the benefits of JSON if the receiver
has to know whether and when to de-base64 (or whatever) our data.

> I think for git's use-case we're probably best off with JSON. It's going
> to work almost all of the time, and when it doesn't it's going to be on
> someone's weird non-UTF-8 repo, and those people are probably used to
> dealing with crap because of that anyway and can just manually decode
> their thing after it gets double-encoded.

That sounds a bit hand-wavy. While I agree that anybody using non-utf8
at this point is slightly insane, Git _does_ actually work with
arbitrary encodings in things like pathnames. It just seems kind of lame
to settle on a new universal encoding format for output that's actually
less capable than the current output.

> That sucks, but given that we'll be using this either for just ASCII
> (telemetry) or UTF-8 most of the time, and that realistically other
> formats either suck more or aren't nearly as ubiquitous...

I'd hoped to be able to output something like "git status" in JSON,
which is inherently going to deal with user paths.

-Peff

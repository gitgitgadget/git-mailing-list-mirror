Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C13A1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 23:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932925AbeAXXcX (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 18:32:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:56444 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932072AbeAXXcW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 18:32:22 -0500
Received: (qmail 13240 invoked by uid 109); 24 Jan 2018 23:32:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Jan 2018 23:32:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30903 invoked by uid 111); 24 Jan 2018 23:33:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 18:33:00 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 18:32:20 -0500
Date:   Wed, 24 Jan 2018 18:32:20 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Git packs friendly to block-level deduplication
Message-ID: <20180124233220.GB11348@sigill.intra.peff.net>
References: <87bmhiykvw.fsf@evledraar.gmail.com>
 <CABPp-BE0u9x_TtEHmfS11ZV-50rSvCi_y7cmTVV7z=2zT3atvg@mail.gmail.com>
 <878tcmyhyk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878tcmyhyk.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 12:06:59AM +0100, Ævar Arnfjörð Bjarmason wrote:

> >> Has anyone here barked up this tree before? Suggestions? Tips on where
> >> to start hacking the repack code to accomplish this would be most
> >> welcome.
> >
> > Does this overlap with the desire to have resumable clones?  I'm
> > curious what would happen if you did the same experiment with two
> > separate clones of git/git, cloned one right after the other so that
> > hopefully the upstream git/git didn't receive any updates between your
> > two separate clones.  (In other words, how much do packfiles differ in
> > practice for different packings of the same data?)
> 
> If you clone git/git from Github twice in a row you get the exact same
> pack, and AFAICT this is true of git in general (but may change between
> versions).

That's definitely not guaranteed. It _tends_ to be the case over the
short term because we use --threads=1 on the server. But it may differ
if:

  - we repack on the server, which we do based on pushes

  - somebody pushes, even to another fork. The exact results depend
    on the packs in which we find the objects, and a new push may
    duplicate some existing objects but with a different representation,
    (e.g., a different delta base).

I'm actually interested in adding an etags-like protocol extension that
would work something like this:

  - server says "here's a pack, and its opaque tag is XYZ".

  - on resume, the client says "can I resume pack with tag XYZ"?

  - the server then decides if the on-disk state is sufficient for it to
    agree to recreate XYZ (e.g., number and identity of packs). If yes,
    then it resumes. If no, then it says "nope" and the two sides go
    through a normal fetch again.

The important thing is that the tag is opaque to the client. So a stock
implementation could use the on-disk state to decide. But a server could
choose to cache the packs it sends for a period of time (especially if
the client hangs up before we've sent the whole thing). We already do
this to a limited degree at GitHub in order to efficiently serve
multiple clients simultaneously fetching the same pack (e.g., imagine a
fleet of AWS machines all triggering "git fetch" at once).

I think that's a tangent to what you're looking for in this thread,
though.

-Peff

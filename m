Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1705EC433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 14:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbhLNOmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 09:42:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:51598 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233241AbhLNOmR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 09:42:17 -0500
Received: (qmail 13948 invoked by uid 109); 14 Dec 2021 14:42:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Dec 2021 14:42:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25087 invoked by uid 111); 14 Dec 2021 14:42:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Dec 2021 09:42:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Dec 2021 09:42:15 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 02/10] range-diff.c: don't use st_mult() for signed
 "int"
Message-ID: <YbitRxAmkM/O7xDg@coredump.intra.peff.net>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <RFC-patch-02.10-bd7d014c531-20211209T191653Z-avarab@gmail.com>
 <YbLL/YWbjc/sPRyH@coredump.intra.peff.net>
 <211210.86lf0sdah1.gmgdl@evledraar.gmail.com>
 <YbM85W3N0ySi5k+H@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2112101526540.90@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2112101526540.90@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 03:27:24PM +0100, Johannes Schindelin wrote:

> > I'm not sure if this is helpful or not, but this is the minimal fix I
> > came up with that runs the testcase I showed earlier. It's basically
> > just swapping out "int" for "ssize_t" for any variables we use to index
> > the arrays (though note a few are themselves held in arrays, and we have
> > to cross some function boundaries).
> >
> > I won't be surprised if it doesn't hit all cases, or if it even hits a
> > few it doesn't need to (e.g., should "phase" be dragged along with "i"
> > and "j" in the first hunk?). I mostly did guess-and-check on the
> > test-case, fixing whatever segfaulted and then running again until it
> > worked. I didn't even really read the code very carefully.
> >
> > I think you _did_ do more of that careful reading, and broke down the
> > refactorings into separate patches in your series. Which is good. So I
> > think what we'd want is to pick out those parts of your series that end
> > up switching the variable type. My goal in sharing this here is just to
> > show that the end result of the fix can (and IMHO should) be around this
> > same order of magnitude.
> 
> I am in favor of this patch. Will you have time to submit this with a
> commit message?

I'm not at all sure that it's sufficient. It avoids overflowing the
cost array accesses, and was tested on a square input of 2^15. But:

  - some of the other ints may need changing, too (e.g., column_count).
    Probably 2^31 commits is out of reach in practice (and probably
    other parts of Git run into problems there anyway). But some of
    those arguments may just be (a->nr * b->nr), whereas I was testing
    overflow at (a->nr + b->nr)^2.

  - I threw around ssize_t willy-nilly. Some of those could be size_t,
    and I think Ævar's patches go in the direction of splitting the two,
    which is good.

  - some light refactoring may be helpful to split those cases ahead of
    time.

So I was hoping Ævar would take this approach and run with it. I just
reviewed his follow-up series, though, and it looks like it is still
putting bounds-checks into the COST macro, which I think is not
sufficient.

-Peff

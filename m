Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEBAC1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 17:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeHJTqb (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:46:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:50034 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727381AbeHJTqb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:46:31 -0400
Received: (qmail 15311 invoked by uid 109); 10 Aug 2018 17:15:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Aug 2018 17:15:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20777 invoked by uid 111); 10 Aug 2018 17:15:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 10 Aug 2018 13:15:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2018 13:15:46 -0400
Date:   Fri, 10 Aug 2018 13:15:46 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] t5552: fix flakiness by introducing proper locking
 for GIT_TRACE
Message-ID: <20180810171546.GA32713@sigill.intra.peff.net>
References: <pull.17.git.gitgitgadget@gmail.com>
 <20180809194712.GC32376@sigill.intra.peff.net>
 <xmqqo9ebb6z3.fsf@gitster-ct.c.googlers.com>
 <20180810140908.GA23507@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1808101833330.71@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1808101833330.71@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 10, 2018 at 06:43:07PM +0200, Johannes Schindelin wrote:

> > > Correct.  But I am more worried about the "mixed/overwriting"
> > > breakage, if there is one; it means we may need to be prepared for
> > > systems that lack O_APPEND that works correctly.  I initially just
> > > assumed that it was what Dscho was seeing, but after re-reading his
> > > message, I am not sure anymore.
> > > 
> > > I think the "do not trace the other side" approach you suggest for
> > > these tests that only care about one side is more appropriate
> > > solution for this particular case.  We then do not have to worry
> > > about overwriting or output from both sides mixed randomly.
> 
> Just so everybody knows: I never received the above two mails. Something
> is seriously rotten in GMX. This seems to have started a week or two ago.

I think it may just have been that they went to the gitgitgadget
address; I explicitly added you as a cc when I sent the patch with a
commit message, which was when I first noticed you weren't cc'd on the
earlier bits.

> What you cannot see easily, unless you go the route that I offered
> Jonathan (open a PR on gitgitgadget/git which will automatically run the
> test suite on Windows, macOS and Linux, and of course you can do anything
> in a PR, including narrowing down what tests are run) is that sometimes
> those lines in the `trace` file were clearly *incomplete*. That is, even
> if both processes tried to write atomically, one managed to overwrite the
> other's buffer in flight.
> 
> This is a pretty serious thing, even worse than the failing test suite,
> and I don't think that your patch acknowledges how serious this is.

I don't see anything in what you wrote above or in your original cover
letter or series that contradicts the notion that O_APPEND is simply not
atomic on Windows. Overwriting the same byte ranges in the file is what
I would expect on Linux, as well, if the file were opened without
O_APPEND.

I have mixed reports from searching online whether an equivalent to
O_APPEND exists. Some sources seem to say that FILE_APPEND_DATA is.  I
couldn't find anything definitive in Microsoft documentation about
whether it actually provides atomicity.  From my (admittedly limited)
digging, that does not seem to be used by the msys2 runtime, so it might
be worth exploring.

> And please don't give me that "but it works on Linux" response. Seriously.
> Sheesh.

But it does. And it's designed to. There is literally nothing to fix on
Linux.

> Even if you have not managed to trigger it, the POSIX standard seems not
> to define clearly what the behavior is of two competing write() calls,
> unless you lock the files appropriately, as my patch series does.

POSIX says:

  If the O_APPEND flag of the file status flags is set, the file offset
  shall be set to the end of the file prior to each write and no
  intervening file modification operation shall occur between changing
  the file offset and the write operation.

and:

  This volume of POSIX.1-2017 does not specify the behavior of
  concurrent writes to a regular file from multiple threads, except that
  each write is atomic.

I admit the writing is a little turgid, but I think between the two it
is promising the behavior that we expect (and I think that
interpretation is pretty common in the Unix world).

> So unless you are willing to ignore, to willfully keep this breakage, I
> would suggest not to introduce the ugliness of an overridden upload-pack
> for the sole purpose of disabling the tracing on one side, but instead to
> get this here bug fixed, by helping me with this here patch series.

I'm OK if you want to live with the broken test in the interim. But
after your complaining about the imminence of it "infecting" master, I
thought you might be happy to see a solution that was more immediate.

I have tried to help with the actual problem, by identifying the root
cause (that the trace code's strategy is not fundamentally broken, but
that it relies on O_APPEND whose guarantees are obviously not portable
to Windows) and exploring possible solutions there (FILE_APPEND_DATA).

Lacking any kind of Windows development environment, I'd just as soon
stop there and let more knowledgeable people take over. But please don't
characterize my presence in this thread as some kind of willful harm or
ignoring of the problem.

-Peff

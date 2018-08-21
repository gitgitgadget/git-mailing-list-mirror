Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 113B71F954
	for <e@80x24.org>; Tue, 21 Aug 2018 01:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbeHUEZI (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 00:25:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:49976 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725773AbeHUEZI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 00:25:08 -0400
Received: (qmail 30149 invoked by uid 109); 21 Aug 2018 01:07:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 01:07:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12530 invoked by uid 111); 21 Aug 2018 01:07:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 20 Aug 2018 21:07:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Aug 2018 21:07:12 -0400
Date:   Mon, 20 Aug 2018 21:07:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
Subject: Re: Antw: Re: non-smooth progress  indication for git fsck and git gc
Message-ID: <20180821010712.GA32126@sigill.intra.peff.net>
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
 <20180816155714.GA22739@sigill.intra.peff.net>
 <87bma2qcba.fsf@evledraar.gmail.com>
 <20180816205556.GA8257@sigill.intra.peff.net>
 <5B7A7CDC020000A10002CDCF@gwsmtp1.uni-regensburg.de>
 <87woslpg9i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87woslpg9i.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 10:57:13AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > That seems to apply. BTW: Is there a way go get some repository statistics
> > like a histogram of object sizes (or whatever that might be useful to help
> > making decisions)?
> 
> The git-sizer program is really helpful in this regard:
> https://github.com/github/git-sizer

Yeah, I'd very much agree that's the best tool for a general overview of
the repository stats.

Ulrich, if you want to more analysis (like a histogram), probably
something like:

  git cat-file --batch-all-objects --batch-check='%(objectsize)'

might be a good starting place to dump information (see the "BATCH
OUTPUT" section of "git help cat-file" for more format items).

> > If it's sorting, maybe add some code like (wild guess):
> >
> > if (objects_to_sort > magic_number)
> >    message("Sorting something...");
> 
> I think a good solution to these cases is to just introduce something to
> the progress.c mode where it learns how to display a counter where we
> don't know what the end-state will be. Something like your proposed
> magic_number can just be covered under the more general case where we
> don't show the progress bar unless it's been 1 second (which I believe
> is the default).

Yeah.  We already have open-ended counters (e.g., "counting objects"),
and delayed meters (we actually normalized the default to 2s recently).

I _think_ they should work together OK without further modification.
Once upon a time the caller had to say "don't show if we're past N%
after M seconds", but I think with the current code we'd just show it if
we're not completely finished after 2 seconds.

So it really should just be a simple:

  progress = start_delayed_progress("Hashing packfile", 0);

That said, counting bytes would probably be ugly (just because the
numbers get really big). We'd probably prefer to show a throughput or
something. And as you noted, there's some refactoring to be done with
pack-check for it to show multiple progress meters.

(I still think in the long run we would want to scrap that code, but
that's a much bigger job; I'm fine if somebody wants to do incremental
improvements in the meantime).

-Peff

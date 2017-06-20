Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 668E920282
	for <e@80x24.org>; Tue, 20 Jun 2017 19:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbdFTTFC (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:05:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:46628 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751763AbdFTTFC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:05:02 -0400
Received: (qmail 10388 invoked by uid 109); 20 Jun 2017 19:05:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Jun 2017 19:05:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15753 invoked by uid 111); 20 Jun 2017 19:05:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Jun 2017 15:05:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jun 2017 15:05:00 -0400
Date:   Tue, 20 Jun 2017 15:05:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] die routine: change recursion limit from 1 to 1024
Message-ID: <20170620190500.ioqbo72usj6dmdqy@sigill.intra.peff.net>
References: <20170619220036.22656-1-avarab@gmail.com>
 <20170620155459.a6e7pypxx6vpdbvs@sigill.intra.peff.net>
 <87lgom8pew.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lgom8pew.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2017 at 08:49:59PM +0200, Ævar Arnfjörð Bjarmason wrote:

> As you can see the third most common case is that we needlessly print
> out the warning, i.e. we have only one error anyway, but we can't
> guarantee that, so it probably makes sense to emit it.

Right, my suggestion actually doesn't help much with the multi-threaded
case. The warning is pointless but it will still be racily shown,
because we can't tell the difference between races and recursion. So
it's better, but fundamentally still pretty ugly. And we'd want to
actually fix the real problem.

> To reply to your 20170620161514.ygbflanx4pldc7n7@sigill.intra.peff.net
> downthread here (where you talk about setting up a custom die handler
> for grep) yeah that would make sense, but as long as we're supplying
> this default behavior (and not outlawing using it with pthreads) it
> makes sense to get out of our own way with this recursion detection.

I actually was more or less proposing that we consider stock die (no
custom handler) with pthreads to be outlawed. It sometimes kind of does
the right thing, but in a racy way. Probably threads calling die()
should consider their error-handling a bit more carefully.

That said, in my other mail I arrived at "just put a mutex into die()"
which I think would remove the raciness, and give the default behavior
of "the first thread to call die will take down the whole process and
get its single error printed". That actually seems pretty reasonable.
And it makes the "recursion or race?" question go away.

I'm not quite sure how to implement it, though. I think you'd want to
take the lock in die() itself, because it would make the is-recursing
check all the way to the exit an atomic unit. But who is responsible for
unlocking then?  The point of die_routine() is that it never returns.
That's fine if it truly calls exit(), but the threaded die handler in
run-command.c does a pthread_exit(). So _somebody_ has to unlock that so
other threads don't block if they try to die().

What a mess.

> I think my patch (possibly with the fixup above, depending on what we
> think about dupe warnings) is just fine to fix this. This is already a
> super-rare edge case in grep, and to the extent that it would be a
> problem for anyone it's because our paranoid recursion detector totally
> hides the error, I don't think it's worth worrying about us printing a
> few dupe error messages under threading for something that almost never
> happens.
> 
> At least, that's starting to go beyond my bothering to hack on it :)

Yes, I think your patch with my suggestion above is a strict improvement
over what's there. You'd see the warning any time you might have seen
"die is recursing", but at least you _also_ get to see the real error.

-Peff

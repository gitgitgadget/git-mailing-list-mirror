Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44DAA208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 07:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbdHTHnW (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 03:43:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:43814 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751607AbdHTHnV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 03:43:21 -0400
Received: (qmail 20706 invoked by uid 109); 20 Aug 2017 07:43:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 07:43:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12453 invoked by uid 111); 20 Aug 2017 07:43:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 03:43:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Aug 2017 03:43:19 -0400
Date:   Sun, 20 Aug 2017 03:43:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Kevin Willford <kcwillford@gmail.com>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH] progress: simplify "delayed" progress API
Message-ID: <20170820074318.3fchxwbuux5zbkah@sigill.intra.peff.net>
References: <20170531150427.7820-1-kewillf@microsoft.com>
 <20170810183256.12668-2-kewillf@microsoft.com>
 <20170810232033.46ujnozvnodkguog@sigill.intra.peff.net>
 <xmqqwp69ycim.fsf@gitster.mtv.corp.google.com>
 <EA124B72FA7542DBA1C31213235F1B94@PhilipOakley>
 <20170813043940.muj7z3dvl3nh4k6a@sigill.intra.peff.net>
 <xmqqpobyw11t.fsf@gitster.mtv.corp.google.com>
 <xmqqshguuhe2.fsf@gitster.mtv.corp.google.com>
 <20170814222947.edvuz7b2hxuwcsqj@sigill.intra.peff.net>
 <xmqqy3qf8nj6.fsf_-_@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3qf8nj6.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 19, 2017 at 10:39:41AM -0700, Junio C Hamano wrote:

> We used to expose the full power of the delayed progress API to the
> callers, so that they can specify, not just the message to show and
> expected total amount of work that is used to compute the percentage
> of work performed so far, the percent-threshold parameter P and the
> delay-seconds parameter N.  The progress meter starts to show at N
> seconds into the operation only if the amount of work completed
> exceeds P.
> 
> Most callers used either (0%, 2s) or (50%, 1s) as (P, N), but there
> are oddballs that chose more random-looking values like 95%.
> 
> For a smoother workload, (50%, 1s) would allow us to start showing
> the progress meter earlier than (0%, 2s), while keeping the chance
> of not showing progress meter for long running operation the same as
> the latter.  For a task that would take 2s or more to complete, it
> is likely that less than half of it would complete within the first
> second, if the workload is smooth.  But for a spiky workload whose
> earlier part is easier, such a setting is likely to fail to show the
> progress meter entirely and (0%, 2s) is more appropriate.
> 
> But that is merely a theory.  Realistically, it is of dubious value
> to ask each codepath to carefully consider smoothness of their
> workload and specify their own setting by passing two extra
> parameters.  Let's simplify the API by dropping both parameters and
> have everybody use (0%, 2s).

Nicely explained (modulo the reversal you noticed in the first
paragraph). The patch looks good to me.

> Oh, by the way, the percent-threshold parameter and the structure
> member were consistently misspelled, which also is now fixed ;-)

Heh, that was bugging me, too. :)

>  * So before I forget all about this topic, here is a patch to
>    actually do this.
> 
>    > So I'd vote to drop that parameter entirely. And if 1 second seems
>    > noticeably snappier, then we should probably just move everything to a 1
>    > second delay (I don't have a strong feeling either way).
> 
>    I was also tempted to do this, but decided to keep it closer to
>    the original for majority of callers by leaving the delay at 2s.
>    With this patch, such a change as a follow-up is made a lot
>    easier (somebody may want to even make a configuration out of it,
>    but that would not be me).

Yeah, I agree that it can come later on top (if at all).

Thanks for finishing this off.

-Peff

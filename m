Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80AC01F597
	for <e@80x24.org>; Fri, 27 Jul 2018 08:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbeG0J2w (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 05:28:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:60828 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725988AbeG0J2w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 05:28:52 -0400
Received: (qmail 14733 invoked by uid 109); 27 Jul 2018 08:08:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Jul 2018 08:08:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23828 invoked by uid 111); 27 Jul 2018 08:08:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 27 Jul 2018 04:08:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jul 2018 04:08:08 -0400
Date:   Fri, 27 Jul 2018 04:08:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 1/4] automatically ban strcpy()
Message-ID: <20180727080807.GA11932@sigill.intra.peff.net>
References: <20180724092329.GA24250@sigill.intra.peff.net>
 <20180724092618.GA3288@sigill.intra.peff.net>
 <CAPig+cRpcUOA5+k7v3Gy3WsLohedEb=j-a_fCGc3g0ktDfsDVA@mail.gmail.com>
 <20180726065840.GA27349@sigill.intra.peff.net>
 <20180726072105.GA6057@sigill.intra.peff.net>
 <xmqqfu05rjfc.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfu05rjfc.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 26, 2018 at 10:33:27AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So here's a replacement for just patch 1 (I'm assuming this creates less
> > work than re-posting them all, but it may not be if Junio prefers
> > dealing with a whole new mbox rather than a "rebase -i", "reset --hard
> > HEAD^", "git am" -- let me know if you'd prefer it the other way).
> 
> A single patch replacement that is clearly marked which one to
> replace and which other ones to keep, like you did here, is fine.
> The amount of work is about the same either way.
> 
> 0) I would first do these to make sure that I can replace:
> [..]

Thanks. As always, I find it interesting to see your workflows.

> 1-b) With a single patch replacement, it is quite different.
> 
>  $ git checkout HEAD~4	        ;# we are replacing 1/4 of the original
>  $ git am -s mbox               ;# that single patch
>  $ git show-branch HEAD @{-1}
> [...]
> The most natural thing to do at this point is
> 
>  $ git cherry-pick -3 @{-1}
> 
> But we know range-pick is buggy and loses core.rewriteref, so
> instead I did this, which I know carries the notes forward:
> 
>  $ git rebase --onto HEAD @{-1}~3 @{-1}^0

Interesting. I'd have probably done it with an interactive rebase:

  $ git rebase -i HEAD~4
  [change first "pick" to "edit"; after stopping...]
  $ git reset --hard HEAD^ ;# throw away patch 1
  $ git am -s mbox         ;# apply single patch
  $ git rebase --continue

Which is really the same thing, but "cheats" around the cherry-pick
problem by using rebase (which I think handles the rewriteref stuff
correctly even in interactive mode).

I guess if we wanted to be really fancy, just replacing the first "pick"
with "x git am -s mbox" would automate it. That might be handy for the
multi-patch case.

Anyway, thanks for handling it. :)

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A61120281
	for <e@80x24.org>; Thu, 21 Sep 2017 05:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbdIUFIj (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 01:08:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:45642 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750795AbdIUFIi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 01:08:38 -0400
Received: (qmail 2720 invoked by uid 109); 21 Sep 2017 05:08:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 05:08:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19218 invoked by uid 111); 21 Sep 2017 05:09:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 01:09:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Sep 2017 01:08:36 -0400
Date:   Thu, 21 Sep 2017 01:08:36 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] git: add --no-optional-locks option
Message-ID: <20170921050835.mrbgx2zryy3jusdk@sigill.intra.peff.net>
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
 <xmqqbmm4lkf5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmm4lkf5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 21, 2017 at 01:55:58PM +0900, Junio C Hamano wrote:

> The phrase 'optional lock' does not answer this question clearly,
> though: does it make sense to extend the coverage of this option in
> the future to things more than the "opportunistic update to the
> index file"?
> 
> If the answer is no, then having 'index' instead of 'lock' in the
> name of the option would make more sense (and 'opportunistic' over
> 'optional', too), because what the change is about is to allow other
> processes that are directly interacting with the user to update the
> index, and 'lock' being hindrance is merely an implementation
> detail.  The comment on the "test" in the log message mentions as if
> it were a short-coming that it does not check the lock but checks
> if the index is written, but I think that is testing what matters
> and preferable than testing "did we lock and then unlock it?"
> 
> On the other hand, if the answer is yes, then I am curious what
> other things this may extend to, and if these other things are also
> opportunistic optimizations.

I left it intentionally vague exactly because I thought we might want to
leave room for the answer to change to "yes" eventually.  For instance,
imagine that we had a ref storage format that required periodic
compaction, and readers might sometimes choose to compact in order to
save future readers from repeating some work they've done. If that
compaction means holding a lock even for a brief period, I think it
would fall under this option.

I admit that's just adding more hand-waving to the pile. But I don't
think it really _hurts_ to leave that door open (aside from making the
documentation a bit wishy-washy). And it helps because callers would
pick up the new features automatically, without having to learn about a
new option.

And I think that's really what this option is. It is less about the
caller asking for some specific behavior, and more about them telling
Git about the context in which it's executing so it can make intelligent
decisions.

And in that sense, something descriptive like --background-process
perhaps would be a better name. Except that I couldn't come up with a
name that isn't confusing (certainly --background-process implies to me
that Git would itself run in the background, which makes no sense here).

I also considered something like "--read-only" to tell Git that we
should avoid writing to the repository. But that's really not what this
does. It just avoids writes that may cause contention, not all writes.

I also considered using the word "opportunistic" in the option name, but
decided it was too long and hard to spell.

So there. I am open to a better name, but I could not come up with one.

> Thanks (and sorry for not being Johannes ;-).

You lack his rugged good looks, but your review was still welcome.

-Peff

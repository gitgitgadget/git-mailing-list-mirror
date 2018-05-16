Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 535BF1F406
	for <e@80x24.org>; Wed, 16 May 2018 20:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeEPUHF (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 16:07:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:43440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751155AbeEPUHE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 16:07:04 -0400
Received: (qmail 17117 invoked by uid 109); 16 May 2018 20:07:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 16 May 2018 20:07:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26605 invoked by uid 111); 16 May 2018 20:07:10 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 16 May 2018 16:07:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 May 2018 13:06:59 -0700
Date:   Wed, 16 May 2018 13:06:59 -0700
From:   Jeff King <peff@peff.net>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Subject: Re: worktrees vs. alternates
Message-ID: <20180516200658.GC4036@sigill.intra.peff.net>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <3289a942-3f0d-ff63-7eab-95fe06c4c0f6@linuxfoundation.org>
 <20180516193744.GA4036@sigill.intra.peff.net>
 <42435260.5sd4EuToWN@mfick-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42435260.5sd4EuToWN@mfick-lnx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 16, 2018 at 01:40:56PM -0600, Martin Fick wrote:

> > In theory the fetch means that it's safe to actually prune
> > in the mother repo, but in practice there are still
> > races. They don't come up often, but if you have enough
> > repositories, they do eventually. :)
> 
> Peff,
> 
> I would be very curious to hear what you think of this 
> approach to mitigating the effect of those races?
> 
> https://git.eclipse.org/r/c/122288/2

The crux of the problem is that we have no way to atomically mark an
object as "I am using this -- do not delete" with respect to the actual
deletion. 

So if I'm reading your approach correctly, you put objects into a
purgatory rather than delete them, and let some operations rescue them
from purgatory if we had a race.  That's certainly a direction we've
considered, but I think there are some open questions, like:

  1. When do you rescue from purgatory? Any time the object is
     referenced? Do you then pull in all of its reachable objects too?

  2. How do you decide when to drop an object from purgatory? And
     specifically, how do you avoid racing with somebody using the
     object as you're pruning purgatory?

  3. How do you know that an operation has been run that will actually
     rescue the object, as opposed to silently having a corrupted state
     on disk?

     E.g., imagine this sequence:

       a. git-prune computes reachability and finds that commit X is
          ready to be pruned

       b. another process sees that commit X exists and builds a commit
          that references it as a parent

       c. git-prune drops the object into purgatory

     Now we have a corrupt state created by the process in (b), since we
     have a reachable object in purgatory. But what if nobody goes back
     and tries to read those commits in the meantime?

I think this might be solvable by using the purgatory as a kind of
"lock", where prune does something like:

  1. compute reachability

  2. move candidate objects into purgatory; nobody can look into
     purgatory except us

  3. compute reachability _again_, making sure that no purgatory objects
     are used (if so, rollback the deletion and try again)

But even that's not quite there, because you need to have some
consistent atomic view of what's "used". Just checking refs isn't
enough, because some other process may be planning to reference a
purgatory object but not yet have updated the ref. So you need some
atomic way of saying "I am interested in using this object".

-Peff

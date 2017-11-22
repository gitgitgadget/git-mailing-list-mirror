Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36F6820954
	for <e@80x24.org>; Wed, 22 Nov 2017 21:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751987AbdKVVRe (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 16:17:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:37982 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751982AbdKVVRc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 16:17:32 -0500
Received: (qmail 2782 invoked by uid 109); 22 Nov 2017 21:17:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Nov 2017 21:17:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4854 invoked by uid 111); 22 Nov 2017 21:17:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 22 Nov 2017 16:17:47 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Nov 2017 16:17:29 -0500
Date:   Wed, 22 Nov 2017 16:17:29 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git status always modifies index?
Message-ID: <20171122211729.GA2854@sigill>
References: <a039d139-dba5-683e-afbf-4044cd32ab1d@neulinger.org>
 <20171122153028.olssotkcf3dd6ron@LykOS.localdomain>
 <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
 <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
 <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
 <20171122202720.GD11671@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171122202720.GD11671@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 12:27:20PM -0800, Jonathan Nieder wrote:

> Nathan Neulinger wrote[1]:
> 
> > I just got an answer to my stackoverflow question on this,
> > apparently it's already implemented:
> >
> > https://stackoverflow.com/questions/47436939/how-to-run-git-status-without-modifying-git-index-such-as-in-a-prompt-command
> >
> > There is a "--no-optional-locks" command in 2.15 that looks like it
> > does exactly what I need.
> 
> I was about to point to
> https://public-inbox.org/git/20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net/
> about exactly this thing. :)
> 
> That said, I wonder if this use case is an illustration that a name
> like --no-lock-index (as was used in Git for Windows when this feature
> first appeared) or --no-refresh-on-disk-index (sorry, I am terrible at
> coming up with option names) would make the feature easier to
> discover.

Yeah, it's interesting that Nathan does not care about the simultaneous
locking here, but rather about the effect of writing to the repo for
what would otherwise be a read-only operation.

Under the original intent of --no-optional-locks I think if we could
somehow magically update the on-disk index without lock contention, it
would be OK to do so. But that would make it no longer work for this
particular case.

And I would also not be surprised if there are other cases where we
write in a lockless way that would best be avoided in a multi-user
setup. I'm thinking specifically of the way that some merge-y operations
may write out intermediate objects, even though they're only needed
inside the process. It _should_ be a read-only operation to ask "can
these two things be merged cleanly", and you should be able to ask that
without accidentally creating root-owned files in .git/objects.

So I actually think what Nathan wants is not exactly the same as
--no-optional-locks in the first place. But in practice, for a limited
set of operations and with the way that locks work in Git, it
accomplishes the same thing. Maybe that points to having a broader
option. Or maybe having two separate options that largely have the same
effect. Or maybe just living with the minor philosophical rough edges,
since it seems OK in practice.

-Peff

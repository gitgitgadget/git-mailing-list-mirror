Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B1B1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 05:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755666AbeFOFNZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 01:13:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:45424 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755640AbeFOFNX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 01:13:23 -0400
Received: (qmail 21421 invoked by uid 109); 15 Jun 2018 05:13:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Jun 2018 05:13:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19054 invoked by uid 111); 15 Jun 2018 05:13:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 15 Jun 2018 01:13:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2018 01:13:21 -0400
Date:   Fri, 15 Jun 2018 01:13:21 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bryan Turner <bturner@atlassian.com>,
        Brandon Williams <bmwill@google.com>,
        Ben Humphreys <behumphreys@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
Message-ID: <20180615051321.GA5840@sigill.intra.peff.net>
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
 <CAGyf7-FQp4q2vvH1ponQvmVDTu0hiMSK1JKytQZ4O1i0MCnz7g@mail.gmail.com>
 <20180103053516.GB87855@aiede.mtv.corp.google.com>
 <20180608045028.GA17528@sigill.intra.peff.net>
 <xmqqzi009deu.fsf@gitster-ct.c.googlers.com>
 <20180614183018.GA1911@sigill.intra.peff.net>
 <20180614185522.GA255581@aiede.svl.corp.google.com>
 <20180614193943.GA2226@sigill.intra.peff.net>
 <20180615042033.GB255581@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180615042033.GB255581@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 09:20:33PM -0700, Jonathan Nieder wrote:

> What we've switched to is a versioned interface.  By setting
> GIT_SSH_VARIANT=simple, you are asking Git to promise to pass exactly
> <x> options.  If Git has a new option it wants to pass (like the "-o
> SendEnv" thing) but can live without it, then it can avoid breaking
> your wrapper and continue to follow this new promise.
> 
> The trouble is that GIT_SSH_VARIANT=simple is too... simple.  You
> would like a variant that passes in [-p port] [-4] [-6] as well.  We
> didn't implement that because we didn't have the attention of any
> wrapper writer who wanted it; in absence of a potential user, we
> decided to wait for a user to propose the interface they want.  Now we
> can celebrate, since that day has come.

I'm not sure I'm celebrating. It seems like work for not much benefit.
I'd just as soon use VARIANT=ssh and deal with any fallouts if my script
does not behave exactly like openssh in all regards.

> How would you like your ssh variant to work?  Some possibilities to
> get the thought process going:
> 
>  A. Would you want to set a variable 'GIT_SSH_SUPPORTS_OPTIONS=p46'
>     to inform Git about what options you support?

Not really. That just creates more work when I have to later use "op46"
to support "-o", even though my script already handles it fine (or
worse, since "-o" is open-ended).

>  B. Alternatively, what about a 'GIT_SSH_VARIANT=capabilities' variant
>     that calls "your-ssh-variant --capabailities" to get a
>     machine-readable list of capabilities it supports?

Not really. Now I have to implement this --capabilities thing. This is
literally a 10 line script.

>  C. Alternatively, would you like all parameters to come in on stdin,
>     credential helper style?

That's even worse. ;)

>  D. Other ideas?

I really am happy just saying "look, my script is basically openssh, so
just assume that". If it breaks, it breaks, and I'll fix it.

The one thing I was left puzzled by is why "-G" didn't work in the first
place, since the script really does just pass through its options.
Poking around, I think the problem actually _is_ the old ssh version
thing. I have a new one on my workstation, but our CI boxes are jessie,
and have openssh 1:6.7p1-5+deb8u4. And that's where I was digging into
the failure.

So sorry for misleading you earlier. The wrapper script looks like it's
a red herring to some degree (I guess its name not being "ssh"
contributed, but then the -G detection failed).

> If you were using an old version of OpenSSH, this would be a reason to
> revive the old patch, but I'm tempted to stall longer just to get more
> use cases like this to come out of the woodwork.

So apparently I am using an old version. Just switching to use "-V"
seems like it might be another solution, then.

-Peff

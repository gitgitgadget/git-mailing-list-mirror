Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB9E320899
	for <e@80x24.org>; Wed, 23 Aug 2017 15:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932187AbdHWPf5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 11:35:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:46702 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932090AbdHWPf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 11:35:56 -0400
Received: (qmail 10938 invoked by uid 109); 23 Aug 2017 15:35:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 Aug 2017 15:35:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 885 invoked by uid 111); 23 Aug 2017 15:36:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 Aug 2017 11:36:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Aug 2017 11:35:54 -0400
Date:   Wed, 23 Aug 2017 11:35:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrew Ardill <andrew.ardill@gmail.com>,
        Anatolii Borodin <anatoly.borodin@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Please fix the useless email prompts
Message-ID: <20170823153553.jg4g55f4biqzu5mw@sigill.intra.peff.net>
References: <CAH8yC8=i33rtopVt=sgg0k+P4JQO+1EVpPJ+u5CPGEXKvZ+PBA@mail.gmail.com>
 <xmqqbmnba50e.fsf@gitster.mtv.corp.google.com>
 <CAH8yC8mpPRN2y1k07_Jk9QP88=gpLKNWfV3W0QQwXTWxyL5STQ@mail.gmail.com>
 <20170820091807.l23h44gnjajfv5bn@sigill.intra.peff.net>
 <CAH5451m58n8mYvt=BC_t2=EAv0HOOdAWrCHCNEPQ3NVjT174nQ@mail.gmail.com>
 <CACNzp2kao+hu6a2nO=gVaLctzoDauB+xyj=cfQLUdNOXTNKQfQ@mail.gmail.com>
 <CAH5451kcb0Y4mm2U804ruqBewB2AV991Hm0_-8ExdEoDTF8DJw@mail.gmail.com>
 <xmqqinhh7pz1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqinhh7pz1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 20, 2017 at 04:56:50PM -0700, Junio C Hamano wrote:

> Andrew Ardill <andrew.ardill@gmail.com> writes:
> 
> > Is there any reason `git pull` can't delay that check until the point
> > where it actually tries to create a new commit? It's fair enough to
> > error if a new commit needs to be made, and there is no user
> > configured, but for the use cases discussed here it seems a little
> > eager to error on the chance that the user will be needed.
> 
> I personally do not think it is a good trade-off.
> 
> In theory [*1*],
> [...]
> *1* We actually might already do such an "optimization"; I didn't
>     check.

I think we already do. Reflogs do not ask for strict identity, and we've
addressed similar cases (e.g., 1e461c4f1fc which was motivated by
pull.rebase not handling this).

> But before running "fetch", you cannot tell if the "pull" will
> fast-forward, so such an "optimization" may actually be a net loss
> for end users, who have to wait for network delay only to be told
> that you'd end up with a history with bogus identity and need to
> redo the operation after fixing your identity.  Then after that,
> they are likely to do another "git pull", which will avoid the cost
> of retransmission of objects if (and only if) the initial "git pull"
> uses remote-tracking branches.

I agree that in the common case where the command might or might not
need to create a commit, it's nicer if we tell the user up front.

But there are also cases where the user can reasonably expect that a
commit will not need to be created. Certainly --ff-only is one hint. But
in general a pull-only repository for testing will just see repeated
fetch+fast-forward pulls. People with that kind of setup would see it as
a regression if pull started failing to say "I don't know yet whether
we'll need to create a commit, but I'm failing early to let you know
that it won't work".

If we could reliably tell the difference between those two cases, it
might be worth doing the up-front check. But I'm not sure we can do that
without declaring that people in the ff-only case should be using a
different workflow (e.g., fetch + "reset --hard").

-Peff

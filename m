Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44D9F20899
	for <e@80x24.org>; Fri, 18 Aug 2017 06:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbdHRGUZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 02:20:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:42400 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751204AbdHRGUY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 02:20:24 -0400
Received: (qmail 20857 invoked by uid 109); 18 Aug 2017 06:20:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Aug 2017 06:20:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32632 invoked by uid 111); 18 Aug 2017 06:20:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Aug 2017 02:20:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Aug 2017 02:20:22 -0400
Date:   Fri, 18 Aug 2017 02:20:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Marko Kungla <marko.kungla@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
Message-ID: <20170818062021.gqhsose5kepth55h@sigill.intra.peff.net>
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
 <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
 <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
 <20170717172709.GL93855@aiede.mtv.corp.google.com>
 <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
 <xmqqy3qhevaq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3qhevaq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 02:30:53PM -0700, Junio C Hamano wrote:

> > I'm not sure I buy that. What does "turning it into a branch name" even
> > mean when you are not in a repository? Clearly @{-1} must fail. And
> > everything else is just going to output the exact input you provided.
> 
> This "just going to output the exact input" is not entirely correct;
> there is just one use case for it.
> 
> "git check-ref-format --branch a..b" would fail with a helpful error
> message, while the command run with "a.b" would tell you the name is
> safe.

Well, yes. It's checking the syntax, as well. But you don't need
--branch for that.

> Use of 'check-ref-format --branch "@{-1}"' *IS* a nonsense, whether
> it is inside or outside a repository; it is OK to fail it outside a
> repository and I would say it is even OK to fail it inside a
> repository.  After all "check-ref-format" is about checking if the
> string is a sensible name to use.
> 
> I think calling interpret_branch_name() in the codepath is a mistake
> and we should instead report if "refs/heads/@{-1}" literally is a
> valid refname we could create instead.

I don't think it's nonsense. It's the reason the feature was added in
the first place. See your own a31dca0393 (check-ref-format --branch:
give Porcelain a way to grok branch shorthand, 2009-03-21). Without
that interpretation, it does nothing that you could not equally well do
as:

  git check-ref-format refs/heads/$name

I _do_ think it's a misfeature to put it in check-ref-format. It should
be part of rev-parse. Which admittedly is a kitchen sink, but this kind
of resolving is one of the main things it should be doing. And in fact
you can already do:

  git rev-parse --symbolic-full-name @{-1}

But I stopped short of suggesting we remove the feature entirely. It
would obviously require a deprecation period.

-Peff

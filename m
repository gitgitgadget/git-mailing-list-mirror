Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288DE1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 23:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932102AbeCLXwD (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 19:52:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:54782 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751312AbeCLXwC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 19:52:02 -0400
Received: (qmail 14183 invoked by uid 109); 12 Mar 2018 23:52:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Mar 2018 23:52:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19159 invoked by uid 111); 12 Mar 2018 23:52:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Mar 2018 19:52:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Mar 2018 19:52:00 -0400
Date:   Mon, 12 Mar 2018 19:52:00 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 04/35] upload-pack: convert to a builtin
Message-ID: <20180312235200.GF1968@sigill.intra.peff.net>
References: <20180222180715.GB185096@google.com>
 <20180222181400.GA19035@sigill.intra.peff.net>
 <20180222193814.GA256918@aiede.svl.corp.google.com>
 <20180222201940.GB23561@sigill.intra.peff.net>
 <20180222202150.GA23985@sigill.intra.peff.net>
 <20180222212634.GC256918@aiede.svl.corp.google.com>
 <20180222214457.GB30638@sigill.intra.peff.net>
 <20180312224355.GC58506@aiede.svl.corp.google.com>
 <20180312232844.GB1968@sigill.intra.peff.net>
 <20180312233747.GB235366@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180312233747.GB235366@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 12, 2018 at 04:37:47PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > We could even give it an environment variable, which would allow
> > something like:
> >
> >   tar xf maybe-evil.git.tar
> >   cd maybe-evil
> >   export GIT_TRUST_REPO=false
> >   git log
> [...]
> As an internal implementation detail, this is so obviously fragile
> that it wouldn't give me any feeling of security. ;-)  So it should be
> strictly an improvement.
> 
> As a public-facing feature, I suspect it's a bad idea for exactly that
> reason.

So that pretty much kills off the GIT_TRUST_REPO idea, I guess.

> FWIW for pager specifically I am going for a whitelisting approach:
> new commands would have to explicitly set ALLOW_PAGER if they want to
> respect pager config.  That doesn't guarantee people think about it
> again as things evolve but it should at least help with getting the
> right setting for new plumbing.

I suspect we'd be about as well off with the "don't trust the repo"
internal flag. Touching the ALLOW_PAGER setup code is about as likely to
set off red flags for the developers (or reviewers) as code that checks
the "trust" flag.

Forcing a whitelist on ALLOW_PAGER _is_ more likely to catch people
adding new commands. But I don't think we actually want to add more
commands to the "safe to run in a malicious repo" list. It's already a
slightly sketchy concept. This is really all about upload-pack and its
existing promises.

But ALLOW_PAGER would _just_ fix the pager issue. When we inevitably
find another problem spot, it won't help us there. But a global "trust"
flag might.

I dunno. I guess I'm OK with either approach, but it seems like the
global trust flag has more room to grow.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4D36202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 18:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbdGLSRV (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 14:17:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:38194 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751075AbdGLSRU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 14:17:20 -0400
Received: (qmail 3743 invoked by uid 109); 12 Jul 2017 18:17:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jul 2017 18:17:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25610 invoked by uid 111); 12 Jul 2017 18:17:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jul 2017 14:17:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jul 2017 14:17:17 -0400
Date:   Wed, 12 Jul 2017 14:17:17 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 0/3] Convert grep to recurse in-process
Message-ID: <20170712181717.uj7paoz5btfv7ocz@sigill.intra.peff.net>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170712074220.565z3gahruqb2e7q@sigill.intra.peff.net>
 <20170712180603.GE65927@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170712180603.GE65927@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 11:06:03AM -0700, Brandon Williams wrote:

> > I didn't follow the rest of the "struct repository" series closely, but
> > I don't feel like we ever reached a resolution on how config would be
> > handled. I notice that the in-process "ls-files" behaves differently
> > than the old one when config differs between the submodule and the
> > parent repository. As we convert more commands (that use more config)
> > this will become more likely to be noticed by somebody.
> > 
> > Do we have a plan for dealing with this? Is our solution just "recursed
> > operations always respect the parent config, deal with it"?
> 
> Each 'struct repository' does have its own config so we could
> potentially want a config in a submodule to override some config in the
> superproject.  Though for right now it may be simpler to not worry about
> doing this overriding, mostly because you would only want to allow
> overriding of some configuration and not all configuration.  One example
> would be the number of threads allowed in grep, it doesn't make much
> sense to let a submodule's configuration of this to trump the
> superproject's since the command was invoked in the context of the
> superproject.

I'm not sure I agree 100% with that example. What makes threads special,
I think, is not the config but the total count spread across all of the
recursive processes. So it's not that we don't want to respect submodule
config so much as we want to take the submodule config into account, but
throttle it based on what other threads are running.

So if your superproject says "1" and the submodule says "8", I'd expect
"8" threads to run in the submodule. If you're already running another 3
threads on behalf of another submodule, I think it would be reasonable
to do some job control and only give the submodule 5 slots. But I don't
think that should happen at the config layer. It should probably happen
when the submodule decides to spawn threads, and it should ask of the
superproject "how many slots am I allowed?".

I think that's probably one of the more complicated cases, and I don't
think it really needs to be done on day one. Setting differing thread
counts is even more unlikely than the rest of the config. I suspect
doing job management in general would come up first, because people
don't want to fork-bomb themselves.

Anyway, that got pretty far afield. What I was trying to say is that I
think you can treat the config uniformly, without making special
exceptions for things like grep.threads.

-Peff

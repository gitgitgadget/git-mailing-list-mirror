Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1459620357
	for <e@80x24.org>; Wed, 12 Jul 2017 18:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbdGLS1z (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 14:27:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:38232 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751015AbdGLS1y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 14:27:54 -0400
Received: (qmail 4158 invoked by uid 109); 12 Jul 2017 18:27:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jul 2017 18:27:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25850 invoked by uid 111); 12 Jul 2017 18:28:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jul 2017 14:28:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jul 2017 14:27:51 -0400
Date:   Wed, 12 Jul 2017 14:27:51 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH 0/3] Convert grep to recurse in-process
Message-ID: <20170712182751.nzpp4v3vqyrj65sb@sigill.intra.peff.net>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170712074220.565z3gahruqb2e7q@sigill.intra.peff.net>
 <20170712180923.GE93855@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170712180923.GE93855@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 11:09:23AM -0700, Jonathan Nieder wrote:

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
> For settings like branch.<name>.remote, I don't think anyone would
> disagree that the right thing to do is to use the per-repository
> config of the submodule.  The repository object is already able to
> handle per-repository config, so this just involves callers being
> careful not to cache values locally in a way that conflates
> repositories.  It should be pretty straightforward (for commands like
> "git fetch --recurse-submodules", for example).

I agree that's the right approach. What I'm worried about is that I see
in-process work proceeding without the "callers being careful" part
being audited, which can lead to regressions (e.g., ls-files with
core.quotepath is "broken" in next right now). Though at least the
regression would be limited to people using submodules.

> For settings like grep.patternType, on the other hand, it would be
> very strange for the behavior to change when grep crosses the
> submodule boundary.  So I think using the parent project config is the
> right thing to do and the old behavior was simply wrong.  In other
> words, I don't think this is so much a case of "deal with it" as
> "sorry we got the behavior so wrong before --- we've finally fixed it
> now".

I think that's not actually about the parent project's config, as much
as it is about the parameters of the current operation. I.e., the
argument is that this particular grep operation is using a particular
pattern type, no matter how we arrived at that decision, and it should
be used for all of the recursive bits. So whether the superproject has
its own grep.patternType set, or whether the user used "-P" on the
command line, the result is the same: we need to tell the submodule to
ignore any config and use the parameters we feed it.

In a multi-process model, that should happen by converting all of the
bits in "struct grep_opt" back into command-line parameters and feeding
them to the recursive processes (which would then give them precedence
over any config). But I'm pretty sure we don't do that.

In the in-process model, that would hopefully be a bit simpler, as we'd
just pass in a pre-made grep_opt.

-Peff

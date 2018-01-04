Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F36C71F404
	for <e@80x24.org>; Thu,  4 Jan 2018 23:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbeADXGe (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 18:06:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:53728 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751091AbeADXGd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 18:06:33 -0500
Received: (qmail 23289 invoked by uid 109); 4 Jan 2018 23:06:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Jan 2018 23:06:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11119 invoked by uid 111); 4 Jan 2018 23:07:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Jan 2018 18:07:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Jan 2018 18:06:31 -0500
Date:   Thu, 4 Jan 2018 18:06:31 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 0/5] Add --no-ahead-behind to status
Message-ID: <20180104230630.GA2599@sigill.intra.peff.net>
References: <20180103214733.797-1-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180103214733.797-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 03, 2018 at 09:47:28PM +0000, Jeff Hostetler wrote:

> Config values of true and false control non-porcelain formats
> for compatibility reasons as previously discussed.  In the
> last commit I added a new value of 2 for the config setting
> to allow porcelain formats to inherit the new setting.  I've
> marked this experimental for now or so that we can discuss
> it.

I'm mildly negative on this "level 2" config. If influencing the
porcelain via config creates compatibility headaches, then why would we
allow it here? And if it doesn't, then why do we need to protect against
it? This seems to exist in a funny middle ground that cannot decide
whether it is bad or not.

It's like we're inserting a foot-gun, but putting it just far enough out
of reach that we can blame the user when they shoot themselves with it.

Is there a compelling use case for this? From the previous discussion,
this is the strawman I came up with:

  Scripted callers like Visual Studio don't want to unconditionally pass
  --no-ahead-behind, because it makes sense only for large repositories
  (and small ones would prefer the more exact answer, if we can get it
  cheaply). So we'd like the user to trigger "this is large" on a
  per-repo basis, and accept the consequences of possibly broken
  porcelain callers.

I think we could have the best of both worlds, though, if the existing
config option were coupled with a command-line option to say "yes, I
understand no-ahead-behind, so use it for the porcelain if applicable".
IOW, the user does:

  git config status.aheadbehind false

and VS does:

  git status --ahead-behind=maybe

and together both sides have assented to the "quick" thing.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF9571F462
	for <e@80x24.org>; Wed, 19 Jun 2019 18:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfFSSje (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 14:39:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:44346 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726175AbfFSSje (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 14:39:34 -0400
Received: (qmail 11537 invoked by uid 109); 19 Jun 2019 18:36:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Jun 2019 18:36:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8129 invoked by uid 111); 19 Jun 2019 18:40:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Jun 2019 14:40:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Jun 2019 14:39:32 -0400
Date:   Wed, 19 Jun 2019 14:39:32 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Boxuan Li <liboxuan@connect.hku.hk>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [RFC PATCH] userdiff: ship built-in driver config file
Message-ID: <20190619183931.GA28145@sigill.intra.peff.net>
References: <20190617165450.81916-1-liboxuan@connect.hku.hk>
 <488f215a-cb32-db3f-4a45-0062f0f0a0a9@kdbg.org>
 <20190619034929.GA515@sigill.intra.peff.net>
 <1da78555-96eb-1206-679b-527911f6af29@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1da78555-96eb-1206-679b-527911f6af29@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 08:30:25AM +0200, Johannes Sixt wrote:

> >> Why place this file in .git? To have per-repository diff drivers, we can
> >> already specify them via 'git config'. This file should be installed in
> >> the system.
> > 
> > I think it _could_ actually just be part of the system /etc/gitconfig,
> > though it is kind of big, and Git has a tendency to parse the config
> > more than necessary. I wonder if would add a noticeable slowdown.
> 
> But /etc/gitconfig would be the wrong place, because it would not be
> updated when a new version ships with new patterns.

I was thinking it would be, but I guess there is a merging problem if
the admin has made their own changes.

> I would suggest to install the file as $prefix/share/git-core/userdiff
> although the name "userdiff" sounds like an accident. How about
> .../filetypes?

Does it need to be specific to userdiff or filetypes? Could this be a
generic fourth level of config: repo, user, system, builtin? We
effectively already have that, except the "builtin" ones are truly baked
into the binary, which means they are not visible. So right now you
cannot say "git config diff.tex.xfuncname" and get any useful
information, even though we clearly are going to respect it.

On the other hand, this would make "git config --list" quite a bit
longer. And any solution that involves putting it into the generic
config paths may suffer from the bloating/slowdown problem I mentioned.

But without that, I have to wonder what problem we are really solving.
Now it's baked into the binary. Later it will be baked into the
distribution, but we still don't want anybody to touch it because their
changes will be overwritten. I guess it's a little easier for somebody
to find .../share/git-core/userdiff and use it as a template than it is
to find the definitions in the source. But it's not exactly easy.

-Peff

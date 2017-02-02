Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F363520A79
	for <e@80x24.org>; Thu,  2 Feb 2017 04:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750876AbdBBEgM (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 23:36:12 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:38902 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750842AbdBBEgM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 23:36:12 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 182CA20A78;
        Thu,  2 Feb 2017 04:36:11 +0000 (UTC)
Date:   Thu, 2 Feb 2017 04:36:10 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: git-scm.com status report
Message-ID: <20170202043610.GA12738@starla>
References: <20170202023349.7fopb3a6pc6dkcmd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170202023349.7fopb3a6pc6dkcmd@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> With the caveat that I know very little about web hosting, $230/mo
> sounds like an awful lot for what is essentially a static web site.

Yes, that's a lot.

Fwiw, that covers a year of low-end VPS hosting for the main
public-inbox.org/git machine + mail host
(~1GB git objects + ~3GB Xapian index).

> The site does see a lot of hits, but most of the content is a few basic
> web pages, and copies of other static content that is updated
> only occasionally (manpage content, lists of downloads, etc).  The biggest
> dynamic component is the site search, I think.

Maybe optimize search if that's slowest, first.  public-inbox
uses per-host Xapian indexes so there's no extra network latency
and it seems to work well.  But maybe you don't get FS write
access without full VPS access on Heroku...

nginx handles static content easily, and since it looks like you
guys use unicorn[*] for running the Ruby part.  I really hope
nginx is in front of unicorn, since (AFAIK) Heroku doesn't put
nginx in front of it by default.


[*] I wrote and maintain unicorn; and have not yet recommended
    any reverse proxy besides nginx to buffer for it.
    However, having varnish or any other caching layer in
    between nginx and unicorn is great, too.  I dunno how Heroku
    (or any proprietary deployment systems) handle it, though.

> I do wonder if there's room for improvement either:
> 
>   - by measuring and optimizing the Heroku deploy. I have no idea about
>     scaling Rails or Heroku apps. Do we really need three expensive
>     dynos, or a $50/mo database plan? I'm not even sure what to measure,
>     or how. There are some analytics on the site, but I don't have
>     access to them (I could probably dig around for access if there was
>     somebody who actually knew how to do something productive with
>     them).

I track down the most expensive requests in per-request timing
logs and work on profiling + optimizations from there...
Nothing fancy and no relying on proprietary tools like NewRelic.

I also watch for queueing in listen socket backlog (with
raindrops <https://raindrops-demo.bogomips.org/> or ss(8) to
notice overloading.  Again, I don't know how much visibility
you have with Heroku.

>   - by moving to a simpler model. I wonder if we could build the site
>     once and then deploy a more static variant of it to a cheaper
>     hosting platform. I'm not really sure what our options would be, how
>     much work it would take to do the conversion, and if we'd lose any
>     functionality.

*shrug*  That'd be more work, at least.  I'd figure out what's
slow, first.

Fwiw, Varnish definitely helps public-inbox when slammed by
HN/Reddit traffic.  It's great as long as you don't have
per-user data to invalidate, which seems to be the case for
git-scm.

> If anybody is interested in tackling a project like this, let me know,
> and I can try to provide access to whatever parts are needed.

While I'm not up-to-date with modern Rails or deployment stuff,
I'm available via email if you have any lower-level
Ruby/unicorn/nginx-related questions.  I'm sure GitHub/GitLab
also has folks familiar with nginx+unicorn deployment on
bare metal or VPS who could also help.

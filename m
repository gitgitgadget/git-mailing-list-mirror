Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3DE12027C
	for <e@80x24.org>; Fri,  2 Jun 2017 19:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbdFBTjj (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 15:39:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:34042 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbdFBTji (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 15:39:38 -0400
Received: (qmail 21679 invoked by uid 109); 2 Jun 2017 18:39:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 18:39:36 +0000
Received: (qmail 30251 invoked by uid 111); 2 Jun 2017 18:40:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 14:40:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Jun 2017 14:39:33 -0400
Date:   Fri, 2 Jun 2017 14:39:33 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 04/31] setup: don't perform lazy initialization of
 repository state
Message-ID: <20170602183933.pcjfdi4jtkk4epmg@sigill.intra.peff.net>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170531214417.38857-5-bmwill@google.com>
 <CAGZ79kafXpn+BXdMOVOPSX7eaFgcWBUULGR_PBXpMhjKjLEM-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kafXpn+BXdMOVOPSX7eaFgcWBUULGR_PBXpMhjKjLEM-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 01, 2017 at 12:23:25PM -0700, Stefan Beller wrote:

> On Wed, May 31, 2017 at 2:43 PM, Brandon Williams <bmwill@google.com> wrote:
> > Under some circumstances (bogus GIT_DIR value or the discovered gitdir
> > is '.git') 'setup_git_directory()' won't initialize key repository
> > state.  This leads to inconsistent state after running the setup code.
> > To account for this inconsistent state, lazy initialization is done once
> > a caller asks for the repository's gitdir or some other piece of
> > repository state.  This is confusing and can be error prone.
> >
> > Instead let's tighten the expected outcome of 'setup_git_directory()'
> > and ensure that it initializes repository state in all cases that would
> > have been handled by lazy initialization.
> 
> Lazy init is usually there for a reason. (As in: it took too long to perform
> it at all times, so it has been optimized to only perform the init when needed).

In the case of setup_git_env(), I think it was less about doing work and
more that we didn't want to have to do explicit setup in each program.
But over the years we've moved away from that, and in fact if you hit
the lazy initialization these days you'll generally BUG() anyway.

_But_ I suspect there are still some cases you'd need to handle. For
instance, it's still OK to skip calling setup_git_directory() if you've
got $GIT_DIR in the environment (which is why we have have_git_dir()
instead of checking startup_info->have_repository).

I think it would be nice to do away with that, too, but we're not quite
there yet (and if I am reading this patch correctly, we'd probably hit
these BUGs in such cases).

-Peff

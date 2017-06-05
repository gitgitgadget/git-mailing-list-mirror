Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF1471F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 18:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbdFESUJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 14:20:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:34937 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751183AbdFESUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 14:20:09 -0400
Received: (qmail 28709 invoked by uid 109); 5 Jun 2017 18:20:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Jun 2017 18:20:08 +0000
Received: (qmail 16140 invoked by uid 111); 5 Jun 2017 18:20:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Jun 2017 14:20:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jun 2017 14:20:07 -0400
Date:   Mon, 5 Jun 2017 14:20:07 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
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
Message-ID: <20170605182007.vvpk3ge73lrojxqw@sigill.intra.peff.net>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170531214417.38857-5-bmwill@google.com>
 <CAGZ79kafXpn+BXdMOVOPSX7eaFgcWBUULGR_PBXpMhjKjLEM-A@mail.gmail.com>
 <20170602183933.pcjfdi4jtkk4epmg@sigill.intra.peff.net>
 <20170605174352.GA40426@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170605174352.GA40426@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 05, 2017 at 10:43:52AM -0700, Brandon Williams wrote:

> > In the case of setup_git_env(), I think it was less about doing work and
> > more that we didn't want to have to do explicit setup in each program.
> > But over the years we've moved away from that, and in fact if you hit
> > the lazy initialization these days you'll generally BUG() anyway.
> > 
> > _But_ I suspect there are still some cases you'd need to handle. For
> > instance, it's still OK to skip calling setup_git_directory() if you've
> > got $GIT_DIR in the environment (which is why we have have_git_dir()
> > instead of checking startup_info->have_repository).
> 
> Yes there are a couple places that rely on the lazy initialization but
> that's not due to setup not being run.  Rather it has to do with GIT_DIR
> being set to a bogus directory so when setup is run gently it does
> nothing.  Then at a later point in time the command tries to access
> files in the gitdir (which triggers lazy init of the git environment).
> 
> So I think that explicitly doing the 'lazy init' portion (which ensures
> that the env gets setup even if GIT_DIR is bogus) at the end of setup
> should be sufficient, least it seems to be so though perhaps we can't
> rely on our tests to tell us that.

In have_git_dir() we do:

  int have_git_dir(void)
  {
	  return startup_info->have_repository
		  || git_dir
		  || getenv(GIT_DIR_ENVIRONMENT);
  }

and generally call that right before calling a function that might do
setup_git_env(). We can assume that if have_repository is set that we
have an actual git_dir (we can check all of the assignment spots and
verify that they always set it in tandem with the global git_dir).
And obviously if git_dir is set, we're good.

But if that third condition ever triggers, it's because we're relying on
the lazy setup to copy it into git_dir. And if I understand correctly,
that would turn into a BUG with your patch.

I guess my question is: does that third condition actually trigger in
practice? I added those conditions in b9605bc4f (config: only read
.git/config from configured repos, 2016-09-12). I remember there being
some reason for needing those back then, but the commit message doesn't
say. But if I remove them and just check have_repository (either on top
of that commit or on top of the current master) the tests all still
pass.

So I'm not sure at this point what the case was that motivated it, or if
it really was just an abundance of caution. But if there is such a case,
I suspect it's broken by your patch series.

I'm not sure we have a good way to find out, though. Like the current
BUG() in setup_git_env, I think we'll just have to cook the patches for
a long time, see if anybody triggers it, and deal with it on a case by
case basis.

I do kind of wonder if we should simplify have_git_dir(), if those other
conditions aren't actually triggering.

-Peff

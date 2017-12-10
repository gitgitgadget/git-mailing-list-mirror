Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0DF81F407
	for <e@80x24.org>; Sun, 10 Dec 2017 14:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751616AbdLJOXM (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 09:23:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:53666 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751499AbdLJOXM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 09:23:12 -0500
Received: (qmail 29090 invoked by uid 109); 10 Dec 2017 14:23:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 10 Dec 2017 14:23:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13589 invoked by uid 111); 10 Dec 2017 14:23:34 -0000
Received: from pool-96-236-18-62.albyny.fios.verizon.net (HELO sigill.intra.peff.net) (96.236.18.62)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 10 Dec 2017 09:23:34 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Dec 2017 09:23:09 -0500
Date:   Sun, 10 Dec 2017 09:23:09 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 4/4] t/Makefile: introduce TEST_SHELL_PATH
Message-ID: <20171210142309.GA19453@sigill.intra.peff.net>
References: <20171208104647.GA4016@sigill.intra.peff.net>
 <20171208104722.GD4939@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1712081602570.4318@virtualbox>
 <20171208220046.GA26270@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1712091443560.4318@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1712091443560.4318@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 09, 2017 at 02:44:44PM +0100, Johannes Schindelin wrote:

> > > ... and we could simply see whether the environment variable
> > > TEST_SHELL_PATH (which we would set in t/Makefile from the passed-in
> > > SHELL_PATH) is set, and override it again.
> > > 
> > > I still think we can do without recording test-phase details in the
> > > build-phase (which may, or may not, know what the test-phase wants to do).
> > > 
> > > In other words, I believe that we can make the invocation you mentioned
> > > above work, by touching only t/Makefile (to pass SHELL_PATH as
> > > TEST_SHELL_PATH) and t/test-lib.sh (to override the SHELL_PATH from
> > > GIT-BUILD-OPTIONS with TEST_SHELL_PATH, if set).
> > 
> > We could do that, but it makes TEST_SHELL_PATH inconsistent with all of
> > the other config.mak variables.
> 
> It is already inconsistent with the other variables because its scope is
> the "test" phase, not the "build" phase.

I'm not sure that's true. Look at what already goes into
GIT-BUILD-OPTIONS: TEST_OUTPUT_DIRECTORY, GIT_TEST_CMP, GIT_PERF_*, etc.

Interestingly, many of those do something like this in the Makefile:

  ifdef GIT_TEST_CMP
	@echo GIT_TEST_OPTS=... >>$@+
  endif

which seems utterly confusing to me. Because it means that if you build
with those options set, then they will override anything in the
environment. But if you don't, then you _may_ override them in the
environment. In other words:

  make
  cd t
  GIT_TEST_CMP=foo ./t0000-*

will respect that variable. But:

  make GIT_TEST_CMP=foo
  cd t
  GIT_TEST_CMP=bar ./t0000-*

will not. Which seems weird.  But I guess we could follow that pattern
with TEST_SHELL_PATH.

-Peff

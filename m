Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E89041F406
	for <e@80x24.org>; Fri, 15 Dec 2017 10:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755593AbdLOKlM (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 05:41:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:40540 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755450AbdLOKlD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 05:41:03 -0500
Received: (qmail 2275 invoked by uid 109); 15 Dec 2017 10:41:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Dec 2017 10:41:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8285 invoked by uid 111); 15 Dec 2017 10:41:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 15 Dec 2017 05:41:27 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Dec 2017 05:41:01 -0500
Date:   Fri, 15 Dec 2017 05:41:01 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 4/4] t/Makefile: introduce TEST_SHELL_PATH
Message-ID: <20171215104101.GA11637@sigill.intra.peff.net>
References: <20171208104647.GA4016@sigill.intra.peff.net>
 <20171208104722.GD4939@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1712081602570.4318@virtualbox>
 <20171208220046.GA26270@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1712091443560.4318@virtualbox>
 <20171210142309.GA19453@sigill.intra.peff.net>
 <xmqq4lox57c9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4lox57c9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 11, 2017 at 12:37:42PM -0800, Junio C Hamano wrote:

> > Interestingly, many of those do something like this in the Makefile:
> >
> >   ifdef GIT_TEST_CMP
> > 	@echo GIT_TEST_OPTS=... >>$@+
> >   endif
> >
> > which seems utterly confusing to me. Because it means that if you build
> > with those options set, then they will override anything in the
> > environment. But if you don't, then you _may_ override them in the
> > environment. In other words:
> >
> >   make
> >   cd t
> >   GIT_TEST_CMP=foo ./t0000-*
> >
> > will respect that variable. But:
> >
> >   make GIT_TEST_CMP=foo
> >   cd t
> >   GIT_TEST_CMP=bar ./t0000-*
> >
> > will not. Which seems weird.  But I guess we could follow that pattern
> > with TEST_SHELL_PATH.
> 
> Or perhaps we can start setting a better example with the new
> variable, and migrate those weird existing ones over to the new way
> of not forbidding run-time overriding?

This turns out to be quite tricky, because GIT-BUILD-OPTIONS must be
parsed as both a Makefile and shell-script.

So we can do:

  1. Omit them from GIT-BUILD-OPTIONS, which means they don't work for
     cases where the tests aren't started from the Makefile (which would
     have put them in the environment). I think this is a non-starter.

  2. Add a Makefile-level ifdef when generating GIT-BUILD-OPTIONS, so
     that unused options can be overridden by the environment That's the
     "weird" thing above that we do now for some variables.

  3. Add something like:

       test -z "$FOO" && FOO=...

     when building GIT-BUILD-OPTIONS (instead of just FOO=...). But that
     doesn't work because it must parse as Makefile.

  4. In test-lib.sh, save and restore each such variable so that the
     existing environment takes precedence. Like:

       FOO_save=$FOO
       BAR_save=$BAR
       ...etc for each...

       . GIT-BUILD-OPTIONS

       test -n "$FOO_save" && FOO=$FOO_save
       test -n "$BAR_save" && BAR=$BAR_save
       ...etc...

      We have to do the save/restore dance rather than just reordering
      the assignments, because the existing environment is being passed
      into us (so we can't just "assign" it to overwrite what's in the
      build options file).

      This could be made slightly less tedious with a loop and an eval.
      It could possibly be made very succinct but very magical with
      something like:

        saved=$(export)
	. GIT-BUILD-OPTIONS
	eval "$saved"

  5. Give up on the dual nature of GIT-BUILD-OPTIONS, and generate two
     such files (with identical values but different syntax).

I think (4) and (5) are the only things that actually change the
behavior in a meaningful way. But they're a bit more hacky and
repetitive than I'd like. Especially given that I'm not really sure
we're solving an interesting problem. I'm happy enough with the patch as
shown, and I do not recall anybody complaining about the current
behavior of these options.

> There is a long outstanding NEEDSWORK comment in help.c that wonders
> if we want to embed contents from GIT-BUILD-OPTIONS in the resulting
> binary, and the distinction Dscho brought up between "build" and
> "test" phases would start to matter even more once we go in that
> direction.

I guess you're implying having a GIT-BUILD-OPTIONS and a
GIT-TEST-OPTIONS here. But that doesn't save us from the Makefile/shell
duality, unfortunately. Some of the test options need to be read by
t/Makefile, and some need to be read by test-lib.sh (and I suspect there
are some needed in both places).

-Peff

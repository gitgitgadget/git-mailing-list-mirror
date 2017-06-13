Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C02AF20282
	for <e@80x24.org>; Tue, 13 Jun 2017 06:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbdFMGpg (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 02:45:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:38838 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752167AbdFMGpf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 02:45:35 -0400
Received: (qmail 11737 invoked by uid 109); 13 Jun 2017 06:45:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 06:45:34 +0000
Received: (qmail 21017 invoked by uid 111); 13 Jun 2017 06:45:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 02:45:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Jun 2017 02:45:32 -0400
Date:   Tue, 13 Jun 2017 02:45:32 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 4/4] config: don't implicitly use gitdir
Message-ID: <20170613064532.pucjnyrftulmjinj@sigill.intra.peff.net>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170612213406.83247-5-bmwill@google.com>
 <20170613010518.GB133952@aiede.mtv.corp.google.com>
 <20170613012337.GH154599@google.com>
 <20170613013817.GE133952@aiede.mtv.corp.google.com>
 <20170613025945.v54vrza2n23tk5pw@sigill.intra.peff.net>
 <20170613061627.GJ154599@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170613061627.GJ154599@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 11:16:27PM -0700, Brandon Williams wrote:

> > If the parameter is now required, then it might make sense for it to
> > become an actual function parameter instead of being stuffed into the
> > config_options struct. That would give you your breaking change, plus
> > make it more obvious to the reader that it is not optional.
> > 
> > The downside is that has to get shuttled around manually through the
> > callstack. Most of the damage is in builtin/config.c, where we call
> > git_config_with_options() a lot.
> > 
> > include_by_gitdir is also a bit annoying, as we pass around the
> > config_options struct through our void-pointer callbacks. But we can
> > solve that by sticking the git_dir into the include_data struct (whose
> > exact purpose is to carry the information we need to handle includes).
> > 
> > The patch below (on top of Brandon's series does that).
> 
> I really don't understand why this has to be so difficult and why a
> 'breaking change' is even needed.  Duy just added the 'git_dir' field to
> the config_options struct in April of this year (2185fde56 config:
> handle conditional include when $GIT_DIR is not set up) and now we want
> to strip it out again?  That's not even two months. Seems very counter
> productive and makes the api more unwieldy.

I could go either way on it. But note that you're not just changing the
existing opt->git_dir behavior.

If I call git_config_with_options() without having set opt->git_dir, the
call will now quietly ignore repo config. But even before opt->git_dir
existed, calling that function would always have read from repo config
(when we're in one, of course). So if there's a patch in flight that
adds a call to git_config_with_options(), it's now very subtly broken.

The reason I say "I could go either way" is that we can make a guess as
to whether there are any topics in flight that add such a call.

There aren't any in pu right now. That's not the whole world, of course;
people may have topics they haven't yet published. Or they may have long
running forks. Git for Windows is one, and I maintain one that GitHub
uses internally. But GfW is public and doesn't have any new calls (and
nor does my fork).  In general, it's kind of an unlikely call for a fork
or a new branch to add.

So at some point I think we say "good enough, it's not worth the hassle"
and this may be such a case.

-Peff

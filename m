Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 005C220D0C
	for <e@80x24.org>; Wed, 14 Jun 2017 06:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750828AbdFNGZI (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 02:25:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:39729 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbdFNGZI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 02:25:08 -0400
Received: (qmail 2284 invoked by uid 109); 14 Jun 2017 06:25:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 06:25:08 +0000
Received: (qmail 8679 invoked by uid 111); 14 Jun 2017 06:25:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 02:25:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jun 2017 02:25:05 -0400
Date:   Wed, 14 Jun 2017 02:25:05 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2 4/6] config: don't implicitly use gitdir
Message-ID: <20170614062505.zojevt553sfhbt2h@sigill.intra.peff.net>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170613210321.152978-1-bmwill@google.com>
 <20170613210321.152978-5-bmwill@google.com>
 <20170613210806.GJ133952@aiede.mtv.corp.google.com>
 <20170613213815.GP154599@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170613213815.GP154599@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 02:38:15PM -0700, Brandon Williams wrote:

> > The same comments as before still apply:
> > 
> > - this changes API to make opts->git_dir mandatory, which is error prone
> >   and easily avoidable, e.g. by making git_dir an argument to
> >   git_config_with_options
> 
> I still don't agree with this.  I have looked at all callers and ensured
> that 'git_dir' will be set when appropriate in the 'config_options'
> struct.  I find the notion ridiculous that I would need to change a
> function's name or arguments every time the internals of the function
> are adjusted or when an options struct obtains a new field.  Plus, there
> is already an aptly named parameter of type 'config_options' with which
> to hold options for the config machinery.  This struct is also added to
> in a later patch to include commondir so that the gitdir vs commondir
> issue can be resolved.

I've already said "I'm OK either way for this case", but let me clarify
a bit.

It's not about changing a function's internals, or even the struct
obtaining a new field. The key change here is that the _interface_
changed. Callers used to be able to pass NULL for the git_dir and have
the function behave one way, and now if they do so it behaves
differently. That leads to spooky action at a distance. Code which you
didn't know about still compiles but does something subtly different.

We can catch that at the compile stage, or we can catch it at the test
stage, or we can decide it's somebody else's problem to deal with if
they wrote code that the rest of the project hasn't seen.

But it is a real thing that comes up in a big, open project. There is no
"looked at all the callers", because you can't see the whole universe of
code. I do think it's a much bigger deal in a project like the kernel,
which has hundreds of long-lasting forks. Git has only a handful, and we
don't necessarily need to bend over backwards for people whose code
hasn't been shared.

> > - the commit message doesn't say anything about to git dir vs common dir
> >   change.  It needs to, or even better, the switch to use common dir
> >   instead of git dir can happen as a separate patch.
> 
> There really isn't any switching in this patch.  One of the following
> patches in this series addresses this problem in more detail though.

I would have expected that patch to actually come earlier. That fixes
the bug there, and then this conversion patch becomes that much more
straightforward.

-Peff

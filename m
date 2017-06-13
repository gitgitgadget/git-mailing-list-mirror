Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DF3120282
	for <e@80x24.org>; Tue, 13 Jun 2017 07:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbdFMHIS (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 03:08:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:38850 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752304AbdFMHIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 03:08:16 -0400
Received: (qmail 13075 invoked by uid 109); 13 Jun 2017 07:08:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 07:08:15 +0000
Received: (qmail 21166 invoked by uid 111); 13 Jun 2017 07:08:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 03:08:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Jun 2017 03:08:14 -0400
Date:   Tue, 13 Jun 2017 03:08:14 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 4/4] config: don't implicitly use gitdir
Message-ID: <20170613070813.v3vthqlqsga7djgz@sigill.intra.peff.net>
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

> > > *puzzled* Why wasn't this needed before, then?  The rest of the patch
> > > should result in no functional change, but this part seems different.
> > 
> > Now I'm puzzled, too. The original that got filled in lazily by the
> > config functions was always get_git_dir(). I can buy the argument that
> > this was a bug (I'm not familiar enough with worktree to say one way or
> > the other), but if it's a fix it should definitely go into another
> > patch.
> 
> Well actually... in do_git_config_sequence 'git_path("config")' is
> called which will convert gitdir to commondir under the hood.  you can't
> use vanilla gitdir because the config isn't stored in a worktree's
> gitdir but rather in the commondir as the config is shared by all
> worktrees.

Sorry, I missed the fact that there were two sites changed on the first
read.

> So maybe we actually need to add a field to the 'config_options' struct
> of 'commondir' such that the commondir can be used to load the actual
> config file and 'gitdir' can be used to handle the 'IncludeIf' stuff.

On reflection, I suspect that probably is the case. If you have a
workdir in ~/foo, you probably want to match IncludeIf against that
instead of wherever the common dir happens to be.

-Peff

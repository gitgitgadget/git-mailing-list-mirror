Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 621091FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 05:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754415AbdFNF61 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 01:58:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:39703 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbdFNF61 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 01:58:27 -0400
Received: (qmail 513 invoked by uid 109); 14 Jun 2017 05:58:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 05:58:27 +0000
Received: (qmail 8515 invoked by uid 111); 14 Jun 2017 05:58:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 01:58:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jun 2017 01:58:24 -0400
Date:   Wed, 14 Jun 2017 01:58:24 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/6] Use the early config machinery to expand aliases
Message-ID: <20170614055824.p2ueyiyfsdf6inve@sigill.intra.peff.net>
References: <cover.1497355444.git.johannes.schindelin@gmx.de>
 <822765b002488f03523bf440097492be3c14931a.1497355444.git.johannes.schindelin@gmx.de>
 <20170613182606.GO154599@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170613182606.GO154599@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 11:26:06AM -0700, Brandon Williams wrote:

> So because I've been looking at the config machinery lately, I've
> noticed a lot of issues with how things are handled with respect to
> gitdir vs commondir.  Essentially the config resides at commondir/config
> always, and only at gitdir/config when not working with a worktree.
> Because of this, your patches point out a bug in how early config is
> handled.  I'll illustrate this using aliases.
> 
> Before this series (because aliases are read using the standard config
> machinery):
> 
>   > git init main
>   > git -C main config alias.test '!echo hello'
>   > git -C main test
>     hello
>   > git -C main worktree add ../worktree
>   > git -C worktree test
>     hello
> 
> After this series (using read_early_config()):
> 
>   > git init main
>   > git -C main config alias.test '!echo hello'
>   > git -C main test
>     hello
>   > git -C main worktree add ../worktree
>   > git -C worktree test
>     git: 'test' is not a git command. See 'git --help'.
> 
> The issue is that read_early_config passes the gitdir and not the
> commondir when reading the config.

Good catch.

> The solution would be to add a 'commondir' field to the config_options
> struct and populate that before reading the config.  I'm planning on
> fixing this in v2 of my config cleanup series which I'll hopefully have
> finished by the end of the day.

I think that read_early_config() really meant to set the commondir, as
it was always about actual config-file lookup. So it was sort-of buggy
already, though I suspect it was pretty hard to trigger.

But I agree that since include_by_gitdir now reads the same struct
field, swapping it out fixes the config-reading at the cost of breaking
that function. And we really need to pass both in.

I'm not sure whether we should care about this for Dscho's series or
not. I think his series _does_ make the problem easier to trigger. But
it's a minor enough bug that I think I'd be OK with letting your
solution proceed independently.

-Peff

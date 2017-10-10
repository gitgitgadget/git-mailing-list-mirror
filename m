Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 865FB2036B
	for <e@80x24.org>; Tue, 10 Oct 2017 13:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932071AbdJJNGF (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 09:06:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:48254 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755165AbdJJNGE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 09:06:04 -0400
Received: (qmail 10957 invoked by uid 109); 10 Oct 2017 13:06:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Oct 2017 13:06:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26087 invoked by uid 111); 10 Oct 2017 13:06:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Oct 2017 09:06:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Oct 2017 09:06:02 -0400
Date:   Tue, 10 Oct 2017 09:06:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nazri Ramliy <ayiehere@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What happened to "git status --color=(always|auto|never)"?
Message-ID: <20171010130602.ivhsbu2ymnzt7gko@sigill.intra.peff.net>
References: <CAEY4ZpO2G-kTmuReE5gwKpftFqLfAqdpQwCK4R+qYbogCgGtUA@mail.gmail.com>
 <20171010001619.GL19555@aiede.mtv.corp.google.com>
 <CAEY4ZpPj3=+gL_wBW548qzAuS=aC=qswuPx-4H9DS=X10iJWVw@mail.gmail.com>
 <20171010005942.GO19555@aiede.mtv.corp.google.com>
 <CAEY4ZpMKE6yf2baaJt+x6c_esorFnyWvLZ=_KS1iRs6XbL42hw@mail.gmail.com>
 <20171010102509.e7ucbyon6ka6722l@sigill.intra.peff.net>
 <xmqqfuarp3mt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfuarp3mt.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2017 at 09:51:38PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > :( I was worried that this might hit some third-party scripts.
> > ...
> > All that said, should we revisit the decision from 6be4595edb? The two
> > code changes we could make are:
> >
> >   1. Adding a "--color" option to "git status". Commit 0c88bf5050
> >      (provide --color option for all ref-filter users, 2017-10-03) from
> >      that same series shows some prior art.
> >
> >      This is a clean solution, but it does mean that scripts have to
> >      adapt (and would potentially need to care about which Git version
> >      they're relying on).
> 
> If we view that "always" issue is a regression, then this is not a
> "solution".  It is a part of an ideal world where we never allowed
> "always" as a value for color.ui, which is not the world we live in.

Right, this doesn't solve any regression. It solves the "there's no way
to do this thing I might want to" that exists in either world (one where
"always" never existed, or one where "always" does not do that anymore
but we accept it as either not a regression or an acceptable
regression).

> >   2. Re-allow "color.always" config from the command-line. It's actually
> >      on-disk config that we want to downgrade, but I wanted to avoid
> >      making complicated rules about how the config would behave in
> >      different scopes. The patch for this would look something like the
> >      one below.
> 
> Yuck, ugly.  The code is simple (thanks to the "who ordered it?"
> thing), but the behaviour is rather embarrassing to explain.

Yes, it's definitely the most ugly of all the options. The reason I
mention it is that it's also the only one that solves the "git -c
color.ui=always" regression (if we consider it one) without making a
huge and risky change.

> >   3. Revert the original series, and revisit the original "respect
> >      color.ui via porcelain" commit which broke add--interactive in
> >      v2.14.2 (136c8c8b8fa).
> 
> Which one do you mean is "the original series"?  The one that made
> plumbing to pay attention to the color config?

No, I meant reverting jk/ui-color-always-to-auto. But if we revert that,
it leaves "add -p" broken when you set color.ui=always. So we must
either accept that, or _also_ revert 136c8c8b8fa and come up with a
different solution.

> I think it would be
> the cleanest "solution" in the world we live in, but the series (and
> the follow-on changes that started assuming that config_default
> reads the color config) have a rather large footprint and it will be
> quite painful to vet the result.

I agree that is a risk.  It might not be _too_ bad, though this is an
area that historically has poor test coverage. I know that for-each-ref
and tag are two that would need touched (and it was them that led me
down to the path to 136c8c8b8fa in the first place).

> I think the right fix to the original problem (you cannot remove
> auto-color from the plumbing) is to stop paying attention to color
> configuration from the default config.  I wonder if something like
> this would work?
> 
>  - Initialize color.c::git_use_color_default to GIT_COLOR_UNKNOWN;
> 
>  - When git_color_config() is called, and if git_use_color_default
>    is still GIT_COLOR_UNKNOWN, set it to GIT_COLOR_AUTO (regardless
>    of the variable git_color_config() is called for).
> 
>  - In color.c::want_color(), when git_use_color_default is used,
>    notice if it is GIT_COLOR_UNKNOWN and behave as if it is
>    GIT_COLOR_NEVER.
>
> Then we make sure that git_color_config() is never called by any
> plumbing command.  The fact it is (ever) called can be taken as a
> clue that we are running a Porcelain (hence we transition from
> UNKNOWN to AUTO), so we'd get the desirable "no default color for
> plumbing, auto color for Porcelain", I would think.

Yes, I think that's the simplest way to implement the "plumbing should
never do color without a command-line option" scheme.

I do wonder if people would end up seeing some corner cases as
regressions, though. Right now "diff-tree" _does_ color the output by
default, and it would stop doing so under your scheme. That's the right
thing to do by the plumbing/porcelain distinction, but users with
scripts that use diff-tree (or other plumbing) to generate user-visible
output may unexpectedly lose their color, until the calling script is
fixed to add back in a --color option[1].

-Peff

[1] Actually, just saying "--color" isn't enough, since you'd want to
    respect the user's color options. add--interactive does this, but
    it's a slight pain. It would be nice to have a --color=config
    variant that just calls git_color_config(). But if we are talking
    regression-fixes before v2.15, I don't think we need to have such
    niceties.

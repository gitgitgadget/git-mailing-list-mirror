Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E09E20281
	for <e@80x24.org>; Tue,  3 Oct 2017 06:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750983AbdJCGPU (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 02:15:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:58622 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750767AbdJCGPT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 02:15:19 -0400
Received: (qmail 8520 invoked by uid 109); 3 Oct 2017 06:15:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 06:15:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5117 invoked by uid 111); 3 Oct 2017 06:15:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 02:15:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 02:15:16 -0400
Date:   Tue, 3 Oct 2017 02:15:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
Message-ID: <20171003061515.72l35fpvcf63vsf6@sigill.intra.peff.net>
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
 <20171002230017.GT19555@aiede.mtv.corp.google.com>
 <xmqqpoa5kp0c.fsf@gitster.mtv.corp.google.com>
 <xmqqinfxklw7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqinfxklw7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 11:25:44AM +0900, Junio C Hamano wrote:


> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jonathan Nieder <jrnieder@gmail.com> writes:
> >
> >> Yet another alternative would be to treat color.ui=always as a
> >> deprecated synonym for color.ui=auto.  I think that's my preferred
> >> fix.
> >
> > It is mine, too.  And I do not think color.ui=absolutely-always for
> > those who want to keep the current behaviour is unneeded.
> 
> Having said that, I do not mind solving what 136c8c8b ("color: check
> color.ui in git_default_config()", 2017-07-13) tried to do in a
> different way.  If 4c7f1819b that made even plumbing to default to
> auto was wrong (because plumbing did not pay attention to color.ui
> so people could not override that 'auto' default), we can partially
> revert 4c7f1819 ("make color.ui default to 'auto'", 2013-06-10) to
> make the default 'auto' not apply to plumbing.
> 
> In any case, I think the first step may be to revert 136c8c8b from
> both 'master' and 2.14.x.  These alternative solutions can come on
> top.
> 
> Thoughts?

I'd prefer not to revert. I think setting any of the color config to
"always" in an on-disk file is basically a broken config. It was
exacerbated by 4c7f1819b, but it was already broken for scripts that
call "git log" or "git diff", or even just something as simple as piping
those programs on the command line.

The two reasonable paths forward to me are:

  1. Do nothing. Putting "color.ui = always" in your on-disk config is a
     bad idea, and the right fix is to stop doing it.

  2. Make "always" a synonym for "auto". This has the advantage over (1)
     that you can't shoot yourself in the foot with it (so the expanded
     foot-shooting capabilities of 4c7f1819b don't matter). The
     disadvantage is that you can no longer do:

       git -c color.ui=always foo >not-a-tty

     to ask for color in all sub-programs of "foo". I have no idea if
     anybody cares. I came up with that example in 4c7f1819b as the most
     plausible reason somebody might actually care about "always", but
     I've never used it myself.

     And there _is_ a way to get the same thing, which is:

       GIT_PAGER_IN_USE=1 git foo >not-a-tty

     I.e., stay in "auto" but make the claim that "auto" really ought to
     be showing color because the output is going to be consumed
     eventually by a human.  While it looks a bit funny in my made-up
     example above (because the variables says "pager" but we're not
     actually piping to a pager directly), I think this is the most
     plausible reason that an actual program might want to override the
     auto-color decision.

-Peff

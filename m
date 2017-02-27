Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 060C31F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 20:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdB0U6h (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 15:58:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:35118 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751419AbdB0U6e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 15:58:34 -0500
Received: (qmail 28212 invoked by uid 109); 27 Feb 2017 20:51:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 20:51:53 +0000
Received: (qmail 19610 invoked by uid 111); 27 Feb 2017 20:51:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Feb 2017 15:51:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2017 15:51:51 -0500
Date:   Mon, 27 Feb 2017 15:51:51 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t6300: avoid creating refs/heads/HEAD
Message-ID: <20170227205151.rjhod347ddhmdmxp@sigill.intra.peff.net>
References: <20170227092931.7iquwaxomeuuusi2@sigill.intra.peff.net>
 <xmqqzih7whrw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzih7whrw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 11:33:23AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This comes originally from Junio's 84679d470. I cannot see how naming
> > the new branch HEAD would make any difference to the test, but perhaps I
> > am missing something.
> 
> Nah, I think it was just a random string that came to mind and the
> topic being "ah we blindly dereference something when showing %(HEAD)"
> it was plausible I thought of "H E A D" as that random string before
> I used my usual other random strings like frotz ;-)

OK, thanks for confirming.

> > I noticed this while digging on a nearby issue around "git branch -m @".
> > This does happen to be the only test that checks that we can make a
> > branch called refs/heads/HEAD, and I found it because it triggers if you
> > try to disallow "git branch -m HEAD". :)
> 
> About that "nearby" one, does it even make sense to do the interpret
> thing on the <new> name?  I can understand "please rename the branch
> I was previously on to this new name" wanting to say @{-1} when the
> user does not recall the exact spelling of a long name, but I do not
> quite see how "to this new name" part benefits by the "interpret
> branch name" magic in the first place.

Yeah, it's arguable whether the "new" side of a rename should do any
interpretation at all. At the same time, the bug is in the underlying
function that assumes you can slap "refs/heads/" in front of the results
of interpret_branch_name(). And that function gets used in a lot of
places, including the "old" side of a rename. So:

  git branch @{-1} foo

should clearly work. Doing:

  git branch @{upstream} foo

is more debatable. It _does_ work, but only if your upstream is actually
a local branch (otherwise it tries to rename refs/heads/origin/master or
some such nonsense. It happens to fail most of the time because you
probably don't have such a branch, but it's still wrong to even look at
that).

I suspect there are a lot of other places that are less clear cut. E.g.,
I think just:

  git branch foo bar

will put "foo" through the same interpretation. So you could do:

  git branch -f @{-1} bar

Is that insane? Maybe. But it does work now.

-Peff

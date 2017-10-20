Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE0BF202DD
	for <e@80x24.org>; Fri, 20 Oct 2017 06:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbdJTGEq (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 02:04:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:58708 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751441AbdJTGEp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 02:04:45 -0400
Received: (qmail 23628 invoked by uid 109); 20 Oct 2017 06:04:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Oct 2017 06:04:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15072 invoked by uid 111); 20 Oct 2017 06:04:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Oct 2017 02:04:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Oct 2017 02:04:43 -0400
Date:   Fri, 20 Oct 2017 02:04:43 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: "Cannot fetch git.git" (worktrees at fault? or origin/HEAD) ?
Message-ID: <20171020060443.l6v74ik4v4jdt4ky@sigill.intra.peff.net>
References: <CAGZ79kYP0z1G_H3nwfmSHraWHMBOcik5LepUXKj0nveeBrihiw@mail.gmail.com>
 <20171020031630.44zvzh3d2vlhglv4@sigill.intra.peff.net>
 <CAGZ79kZc+O9gM97bVZETE3sgkmc-t78Nf_Hq6=K4Gf2yaE79zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZc+O9gM97bVZETE3sgkmc-t78Nf_Hq6=K4Gf2yaE79zA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 10:27:28PM -0700, Stefan Beller wrote:

> > If my analysis above is correct, then it's already fixed. You just had
> > leftover corruption.
> 
> Well fetching yesterday worked and the commit in question is from
> 8/23, the merge  8a044c7f1d56cef657be342e40de0795d688e882
> occurred 9/18, so I suspect there is something else at play.
> (I do not remember having a gc between yesterday and today.
> Though maybe one in the background?)

Even a gc between yesterday and today should have used the new code,
which would have been safe. So yeah, maybe it is something else
entirely.

> I am curious how you can have a worktree owned by multiple
> repositories [1] (?).

Sorry, I forgot my footnote. I saw this with my "ci" script:

  https://github.com/peff/git/blob/7905ff395adecdd2bb7ab045a24223dfb103e0e9/ci

I check out the contents of my "meta" branch as "Meta", and it contains
that script. It basically just waits for ref updates, then walks over
all the commits and runs "make test" on them in the background (caching
the results, thanks to the git-test[1] script). So I kick off "Meta/ci"
in a terminal and forget about it, and magically it builds my commits in
the background as I work.

It operates in a worktree inside the Meta directory (Meta/tmp-ci), so as
not to disturb what I'm doing. So far so good.

But I actually have _two_ clones of Git on my system. One on which I do
most of my work, and then the other which has the fork we use in
production at GitHub. I symlink the Meta directory from the first into
the latter, which means they both see the same worktree directory. And
somehow running "Meta/ci" in the second corrupted things.

I can get some funniness now, but I think it's mostly caused by the
script being confused about the worktree existing but not having access
to our branches. That's not a corruption, just a confusion. I _think_ I
had a bogus HEAD in the worktree at one point, but I may be
mis-remembering. I can't seem to trigger it now.

-Peff

[1] https://github.com/mhagger/git-test

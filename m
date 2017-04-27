Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D07F207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 20:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968879AbdD0UmY (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 16:42:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:41330 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753896AbdD0UmW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 16:42:22 -0400
Received: (qmail 22191 invoked by uid 109); 27 Apr 2017 20:42:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 20:42:21 +0000
Received: (qmail 26679 invoked by uid 111); 27 Apr 2017 20:42:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 16:42:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Apr 2017 16:42:19 -0400
Date:   Thu, 27 Apr 2017 16:42:19 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Stryker <rstryker@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: 30min Script in git 2.7.4 takes 22+ hrs in git 2.9.3
Message-ID: <20170427204218.fywkvvr65ydljb7j@sigill.intra.peff.net>
References: <CA+Up40iusByn-R55=2=2Ae8KH1mkj4hGF_E9dX3vn1vboyMwMw@mail.gmail.com>
 <20170427200956.ssubj74fkxxi6wjk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170427200956.ssubj74fkxxi6wjk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2017 at 04:09:56PM -0400, Jeff King wrote:

> On Thu, Apr 27, 2017 at 12:36:54PM -0400, Robert Stryker wrote:
> 
> > The problem:  the script takes 30 minutes for one environment
> > including git 2.7.4, and generates a repo of about 30mb.   When run by
> > a coworker using git 2.9.3, it takes 22+ hours and generates a 10gb
> > repo.
> > 
> > Clearly something here is very wrong. Either there's a pretty horrible
> > regression or my idea is a pretty bad one ;)
> 
> The large size makes me think that you're getting an auto-gc in the
> middle that is exploding the unreachable objects into loose storage.
> This can happen when objects are ready to be pruned, but Git holds on to
> them for a grace periods (2 weeks by default) as a precaution against
> simultaneous use.
> 
> Try doing:
> 
>   git config gc.auto 0
> 
> in the repositories before the slow step. Or alternatively, try:
> 
>   git config gc.pruneExpire now
> 
> which will continue to do the auto-gc, but throw away unreachable
> objects immediately.
> 
> Or alternatively, we're failing to run gc at all and just getting tons
> of loose objects that need packed. What does running "git gc --auto" say
> if you run it in the slow repository? Does it improve the disk space
> problem?

Fiddling with your script a bit, I have a suspect. Between your two
versions of git, we started disallowing merge of unrelated histories by
default[1]. Which is exactly what your script is doing:

  echo "Merge in the four rewritten projects, with generic commit messages"
  git pull --no-edit webtools.common.fproj     
  git pull --no-edit webtools.common           
  git pull --no-edit webtools.common.tests     
  git pull --no-edit webtools.common.snippets

If you run under "set -e", or just put "|| exit 1" after those, you'll
see that they fail with v2.9.3 and newer.

So what I think is happening is that we never create that shared
history, and then your per-tag work is building further on a nonsense
fake history. That has two implications:

  - as the divergent history in the shared repo gets bigger and bigger,
    the fetches have to do more and more work to try to find a common
    ancestor (but of course they'll never find one, because the two
    histories aren't related)

  - the divergent history racks up tons of unreachable objects, which
    auto-gc won't pack. After a while of the script running, you can see
    that auto-gc fails with "There are too many unreachable loose
    objects" after the pack. Due to the way background gc works these
    days, that blocks further auto-gc from running until the situation
    is resolved. And you just rack up tons of loose objects, which
    explains the disk usage.

Try adding "--allow-unrelated-histories" to your git-pull invocation.

-Peff

[1] See e379fdf34 (merge: refuse to create too cool a merge by default, 2016-03-18)

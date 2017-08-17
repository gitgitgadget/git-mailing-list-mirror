Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68AC6208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 09:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbdHQJ27 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 05:28:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:41506 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751684AbdHQJ24 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 05:28:56 -0400
Received: (qmail 4464 invoked by uid 109); 17 Aug 2017 09:28:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 09:28:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25462 invoked by uid 111); 17 Aug 2017 09:29:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Aug 2017 05:29:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Aug 2017 05:28:54 -0400
Date:   Thu, 17 Aug 2017 05:28:54 -0400
From:   Jeff King <peff@peff.net>
To:     "Carlsson, Magnus" <Magnus.Carlsson@arris.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git fetch with refspec does not include tags?
Message-ID: <20170817092853.hteuzni5lxia4ejf@sigill.intra.peff.net>
References: <1502960406180.9006@arris.com>
 <1502960572292.1402@arris.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1502960572292.1402@arris.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 09:02:52AM +0000, Carlsson, Magnus wrote:

> In the git fetch documentation it states that by default you will
> fetch all tags that point into the history to the branches fetched.
> 
> "By default, any tag that points into the histories being fetched is
> also fetched; the effect is to fetch tags that point  at branches that
> you are interested in. This default behavior can be changed by using
> the --tags or --no-tags options or by configuring
> remote.<name>.tagOpt. By using a refspec that fetches tags explicitly,
> you can fetch tags that do not point into branches  you are interested
> in as well."
> 
> But for me I get tags if I do "git fetch" or "git fetch origin" but if
> I do "git fetch origin master" I don't get tags related to the master
> branch.
> 
> I understand that this might be due to me specifying a refspec and
> then it will only get that exact refspec, but for me it's not that
> clear from the documentation what I should expect. I read it as when I
> fetch something all related tags will come along.

I'll admit that our tag-autofollow behavior has often confused me. So
I'll try to untangle what's happening at least if not the reasoning. :)

I think the problem is not that you have a refspec, but that your
refspec has no destination. Looking at the fetch code, we seem to turn
on autotags only when the destination is a "real" ref and not just the
default FETCH_HEAD. Which sort-of makes sense. If you're doing a one-off
into FETCH_HEAD, you probably don't want to create tags, even if you
have the objects they point to.

But this is further complicated by the opportunistic tracking-ref
updates.  You can see some interesting behavior with a setup like this:

  git init parent
  git -C parent commit --allow-empty -m one &&
  git -C parent tag -m foo mytag

  git init child
  cd child
  git remote add origin ../parent

and then:

  # no tags, we just populate FETCH_HEAD because of the bare URL
  git fetch ../parent

  # this does fetch tags, because we're storing the result according to
  # the configured refspec ("refs/heads/*:refs/remotes/origin/*").
  git fetch origin

  # this doesn't fetch tags, as the main command is "just" populating
  # FETCH_HEAD. But then our logic for "hey, we fetched the ref for
  # refs/remotes/origin/master, so let's update it on the side" kicks
  # in. And we end up updating FETCH_HEAD _and_ the tracking branch, but
  # not the tags. Weird.
  git fetch origin master

  # and this one does fetch tags, because we have a real destination.
  git fetch origin master:foo

So what I'd say is:

  1. Definitely these defaults are under-documented. I couldn't find
     them anywhere in git-fetch(1).

  2. If we continue to follow the "are we storing any refs" rule for the
     default, possibly it should expand to "did we store anything,
     including opportunistic tracking-ref updates".

-Peff

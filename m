Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560D21F404
	for <e@80x24.org>; Sat, 10 Feb 2018 00:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbeBJANU (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 19:13:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:47774 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753300AbeBJANT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 19:13:19 -0500
Received: (qmail 19242 invoked by uid 109); 10 Feb 2018 00:13:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 10 Feb 2018 00:13:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28237 invoked by uid 111); 10 Feb 2018 00:14:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 09 Feb 2018 19:14:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Feb 2018 19:13:17 -0500
Date:   Fri, 9 Feb 2018 19:13:17 -0500
From:   Jeff King <peff@peff.net>
To:     Leo Gaspard <leo@gaspard.io>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Fetch-hooks
Message-ID: <20180210001317.GA26856@sigill.intra.peff.net>
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io>
 <87inb8mn0w.fsf@evledraar.gmail.com>
 <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
 <20180208153040.GA5180@kitenet.net>
 <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
 <87bmgzmbsk.fsf@evledraar.gmail.com>
 <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
 <87po5dbz1a.fsf@evledraar.gmail.com>
 <20180209223011.GA24578@sigill.intra.peff.net>
 <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 10, 2018 at 12:49:31AM +0100, Leo Gaspard wrote:

> > I tend to agree with the direction of thinking you outlined: you're
> > generally better off completing the fetch to a local namespace that
> > tracks the other side completely, and then manipulating the local refs
> > as you see fit (e.g., fetching into refs/quarantine, and then migrating
> > "good" refs over to refs/remotes/origin).
> 
> Hmm... so do I understand it correctly when I say the process you're
> thinking about works like this?
>  * User installs hook for my-remote by running [something]
>  * User runs git fetch
>  * git fetch fetches remote refs/heads/* to local refs/quarantine/* (so
> I guess [something] changes the remote.my-remote.fetch refmap)
>  * When this is done `git fetch` runs a notification-only post-fetch
> hook (that would need to be added)
>  * The post-fetch hook then performs whatever it wants and updates the
> references in refs/remotes/my-remote/*

Yeah, that was roughly my thinking.

> So the changes that are required are:
>  * Adding a notification-only post-fetch hook
>  * For handling tags, there is a need to have a refmap for tags. Maybe
> adding a remote.my-remote.fetchTags refmap, that would be used when
> running with --tags, and having it default to “refs/tags/*:refs/tags/*”
> to keep the current behavior by default?

Yeah, tag-following may be a little tricky, because it usually wants to
write to refs/tags/. One workaround would be to have your config look
like this:

  [remote "origin"]
  fetch = +refs/heads/*:refs/quarantine/origin/heads/*
  fetch = +refs/tags/*:refs/quarantine/origin/tags/*
  tagOpt = --no-tags

That's not exactly the same thing, because it would fetch all tags, not
just those that point to the history on the branches. But in most
repositories and workflows the distinction doesn't matter.

(By the way, the I specifically chose the name "refs/quarantine" instead
of anything in "refs/remotes" because we'd want to make sure that the
"git checkout" DWIM behavior cannot accidentally pull from quarantine).

> The only remaining issue I can think of is: How do we avoid the issue
> of the
> trigger-only-hook-inciting-bad-behavior-by-hook-authors-who-really-want-modification
> raised in the side-thread that Junio wrote in [1]? Maybe just writing
> in the documentation that the hook should use a quarantine-like
> approach if it wants modification would be enough to not have hook
> authors try to modify the ref in the post-fetch hook?

I don't have a silver bullet there. Documenting the "right" way at least
seems like a good first step.

-Peff

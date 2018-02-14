Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96D661F404
	for <e@80x24.org>; Wed, 14 Feb 2018 01:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966375AbeBNBfX (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 20:35:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:51670 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966311AbeBNBfW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 20:35:22 -0500
Received: (qmail 10813 invoked by uid 109); 14 Feb 2018 01:35:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Feb 2018 01:35:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26164 invoked by uid 111); 14 Feb 2018 01:36:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 13 Feb 2018 20:36:06 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Feb 2018 20:35:20 -0500
Date:   Tue, 13 Feb 2018 20:35:20 -0500
From:   Jeff King <peff@peff.net>
To:     Leo Gaspard <leo@gaspard.io>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Fetch-hooks
Message-ID: <20180214013520.GA25188@sigill.intra.peff.net>
References: <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
 <87bmgzmbsk.fsf@evledraar.gmail.com>
 <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
 <87po5dbz1a.fsf@evledraar.gmail.com>
 <20180209223011.GA24578@sigill.intra.peff.net>
 <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io>
 <20180210001317.GA26856@sigill.intra.peff.net>
 <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io>
 <20180210122131.GB21843@sigill.intra.peff.net>
 <5abf8565-1aa1-c101-83a7-90781682bc7a@gaspard.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5abf8565-1aa1-c101-83a7-90781682bc7a@gaspard.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 10, 2018 at 07:36:47PM +0100, Leo Gaspard wrote:

> Hmm... would this also drown the remote.<name>.fetch map? Also, I think
> this behavior could be emulated with fetch and fetchTagsTo, and it would
> look like:
> [remote "my-remote"]
>     fetch = +refs/heads/*:refs/remotes/my-remote/heads/*
>     fetchTagsTo = refs/remotes/my-remote/tags/*
> The remaining issue being to teach the lookup side to look for tags in
> all the remote-tag namespaces (and the fact it's a breaking change).

Right, I think fetching into the right spots is the easy part. Designing
the new lookup rules is the tricky part.

If you're really interested in the gory details, here's a very old
discussion on it:

  https://public-inbox.org/git/AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com/

I think there may have been some more concrete proposals after that, but
that's what I was able to dig up quickly.

> That said, actually I just noticed an issue in the “add a
> remote.<name>.fetch option to fetch to refs/quarantine then have the
> post-fetch hook do the work”: it means if I run `git pull`, then:
>  1. The remote references will be pulled to refs/quarantine/...
>  2. The post-fetch hook will copy the accepted ones to refs/remotes/...
>  3. The `git merge FETCH_HEAD` called by pull will merge FETCH_HEAD into
> local branches... and so merge from refs/quarantine.

Good point. You can't munge FETCH_HEAD by playing with refspecs.

I am starting to come around to the idea that "pre-fetch" might be the
best way to do what you want. Not to rewrite refs, but perhaps to simply
reject them. In the same way that we allow pre-receive to reject pushed
refs (both are, after all, the final check on admitting new history into
the repository, just in opposite directions).

> So, when thinking about it, I'm back to thinking the proper hook
> interface should be the one of the tweak-fetch hook, but its
> implementation should make it not go crazy on remote servers. And so
> that the implementation should do all this refs/quarantine wizardry
> inside git itself.

So does anybody actually want to be able to adjust the refs as they pass
through? It really sounds like you just want to be able to reject or not
reject the fetch. And that rejecting would be the uncommon case, so it's
OK to just abort the whole operation and expect the user to figure it
out.

-Peff

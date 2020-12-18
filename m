Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02498C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 06:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07C62151B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 06:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732675AbgLRGQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 01:16:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:37480 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbgLRGQz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 01:16:55 -0500
Received: (qmail 10436 invoked by uid 109); 18 Dec 2020 06:16:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Dec 2020 06:16:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11825 invoked by uid 111); 18 Dec 2020 06:16:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Dec 2020 01:16:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Dec 2020 01:16:13 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        felipe.contreras@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2 1/3] ls-refs: report unborn targets of symrefs
Message-ID: <X9xJLWdFJfNJTn0p@coredump.intra.peff.net>
References: <X9pQjHrRQQqB6AFI@coredump.intra.peff.net>
 <20201216235443.1674103-1-jonathantanmy@google.com>
 <xmqqzh2dz071.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzh2dz071.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 05:32:50PM -0800, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > Firstly, this allows a staged rollout in load-balancing situations
> > wherein we turn on "allow" for all servers, then "advertise", so that we
> > don't end up with a client that sees the advertisement but then sends
> > the follow-up request to a server that has not received the latest
> > configuration yet.
> 
> If this were the _first_ capability we are adding to the system, the
> above makes quite a lot of sense, but I do not recall any existing
> capability that can be configured this way.  How would one deploy a
> set of servers that gradually start allowing fetching unadvertised
> but reachable commits, for example?  I am not saying that the "I'll
> accept if asked, but I won't actively advertise" is a bad feature; I
> just find it disturbing that only this knob has that feature.

Yeah, that was my thought. It is a real problem, but not one we've dealt
with before in this way (or at all, really). Two recent examples:

  - for fetching, the object-format=sha1 capability is always parroted
    back by v2.28 and higher clients. But there's no config to disable
    the advertisement, so during a partial deployment to a load-balanced
    cluster, a client may say "object-format=sha1" to a server that
    doesn't understand it.

  - for pushing, we added report-status-v2, which is likewise always
    repeated back by any v2.29 and higher client.

At GitHub we recently merged in v2.29, and just hacked report-status-v2
out of the advertisement within the code (leaving it in the "we can read
this but won't advertise it state"). Temporarily modifying the code is
definitely ugly, and I don't mind a cleaner solution, but:

  - it would be nice if this were done in a more consistent way for all
    new capabilities

  - one nice thing about the code change is that after the rollout is
    done, it's safe to make the code unconditional again, which makes
    it simpler to read/reason about.

    This may be oversimplifying it a bit, of course. On one platform, we
    know when the rollout is happening. But if it's something we ship
    upstream, then "rollout" may be on the jump from v2.28 to v2.29, or
    to v2.30, or v2.31, etc. You can never say "rollouts are done, and
    existing server versions know about this feature". So any upstream
    support like config has to stay forever.

So I dunno. My biggest complaint is that the config option defaults to
_off_.  So it's helping load-balanced rollouts, but creating complexity
for everyone else who might want to enable the feature.

(I know there was also an indication that some people might want it off
because they somehow want to have no HEAD at all. I don't find this
particularly compelling, but even if it were, I think we could leave it
the config as an escape hatch for such folks, but still default it to
"on").

-Peff

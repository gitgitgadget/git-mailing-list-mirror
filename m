Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744EAC433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D04964DE7
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 20:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhA2U27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 15:28:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:40802 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233297AbhA2U00 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 15:26:26 -0500
Received: (qmail 3682 invoked by uid 109); 29 Jan 2021 20:25:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 20:25:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8777 invoked by uid 111); 29 Jan 2021 20:25:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jan 2021 15:25:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jan 2021 15:25:37 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 03/10] builtin/pack-objects.c: learn
 '--assume-kept-packs-closed'
Message-ID: <YBRvQdHoslnF0OXr@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <2da42e9ca26c9ef914b8b044047d505f00a27e20.1611098616.git.me@ttaylorr.com>
 <xmqqk0rwtom2.fsf@gitster.c.googlers.com>
 <YBRfvZh86Z8wAnxZ@coredump.intra.peff.net>
 <YBRprCmIX4IrHAi0@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBRprCmIX4IrHAi0@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 03:01:48PM -0500, Taylor Blau wrote:

> On Fri, Jan 29, 2021 at 02:19:25PM -0500, Jeff King wrote:
> > The overall goal here is being able to roll up loose objects and smaller
> > packs without having to pay the cost of a full reachability traversal
> > (which can take several minutes on large repositories). Another
> > very-different direction there is to just enumerate those objects
> > without respect to reachability, stick them in a pack, and then delete
> > the originals. That does imply something like "repack -k", though, and
> > interacts weirdly with letting unreachable objects age out via their
> > mtimes (we'd constantly suck them back into fresh packs).
> 
> As I mentioned in an earlier response to Junio, this was the original
> approach that I took when implementing this, but ultimately decided
> against it because it means that we'll never let unreachable objects age
> out (as you note).

Right. But that's no different than using "-k" most of the time, and
then occasionally doing a more careful repack with short expiration
times and a full reachability check. As you know, this is basically what
we do at GitHub.

So it may be reasonable to go that direction, which is really defining a
totally separate strategy from git-gc's "repack, and occasionally
objects age out". Especially if we find that the
assume-kept-packs-closed route is too risky (i.e., has too many cases
where it's possible to cause corruption if our assumptions isn't met).

I'm not convinced either way at this point, but just thinking out loud
on the options (and trying to give some context to the list).

> I wonder if we need our assumption that the union of kept packs is
> closed under reachability to be specified as an option. If the option is
> passed, then we stop the traversal as soon as we hit an object in the
> frozen packs. If not passed, then we do a full traversal but pass
> --honor-pack-keep to drop out objects in the frozen packs after the
> fact.
> 
> Thoughts?

I'm confused. I thought the whole idea was to pass it as an option (the
user telling Git "I know these packs are supposed to be closed; trust
me")?

> > I think it would want to be "the set of all .keep packs is closed". In a
> > "roll all into one" scenario like above, there is only one .keep pack.
> > But in a geometric progression, that single pack which constitutes your
> > base set could be multiple packs (the last whole "git repack -ad", but
> > then a sequence of roll-ups that came on top of it).
> 
> I don't think having a roll-up strategy of "all-except-one" simplifies
> things. Or, if it does, then I don't understand it. Isn't this the exact
> same thing as a geometric repack which decides to keep only one pack?
> 
> ISTM that you would be susceptible to the same problems in this case,
> too.

I wasn't trying to argue that all-except-one avoids any problems. I was
saying that the example I gave above was an all-into-one, but if you
want to extend the concept to multiple packs, it has to cover the whole
set. I.e., answering Junio's:

  > is it OK for objects in one kept pack to refer to another object in
  > the other kept pack?

with "yes".

-Peff

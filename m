Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAB041F405
	for <e@80x24.org>; Tue, 18 Dec 2018 12:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbeLRMgu (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 07:36:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:44706 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726419AbeLRMgs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 07:36:48 -0500
Received: (qmail 15209 invoked by uid 109); 18 Dec 2018 12:36:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Dec 2018 12:36:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12666 invoked by uid 111); 18 Dec 2018 12:36:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Dec 2018 07:36:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Dec 2018 07:36:46 -0500
Date:   Tue, 18 Dec 2018 07:36:46 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 8/8] tests: mark tests broken under
 GIT_TEST_PROTOCOL_VERSION=2
Message-ID: <20181218123646.GA30471@sigill.intra.peff.net>
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
 <20181213155817.27666-9-avarab@gmail.com>
 <87pnu51kac.fsf@evledraar.gmail.com>
 <20181214101232.GC13465@sigill.intra.peff.net>
 <87o99o1iot.fsf@evledraar.gmail.com>
 <20181217195713.GA10673@sigill.intra.peff.net>
 <20181217231452.GA13835@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181217231452.GA13835@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 17, 2018 at 03:14:52PM -0800, Jonathan Nieder wrote:

> > IMHO those security guarantees there are overrated (due to delta
> > guessing attacks, though things are not quite as bad if the attacker
> > can't actually push to the repo).
> 
> Do you have a proof of concept for delta guessing?  My understanding
> was that without using a broken hash (e.g. uncorrected SHA-1), it is
> not feasible to carry out.

I think we may be talking about two different things. I mean an attack
where you want to know what is in object X, so you ask the server for
object Y and tell it that you already have X. If the sender generates a
delta against X, that tells you something about what's in X.

For a pure read-only server, you're restricted to the Y's that are
already in the repo. So how effective this is depends on what's in X,
and what Y's are available.

For a case where X is in a victim repo you cannot make arbitrary writes
to, but you _can_ make the victim repo aware of other objects (e.g., by
opening a pull request that creates a ref), then you can iteratively
provide many Y's, improving your guess about X in each iteration.

For a case where the victim repo has fully shared storage (GitHub, and
probably other hosts; I'm not sure if it's available yet, but GitLab is
clearly working on shared-storage too), you can probably skip all that
and just push a ref pointing to X with an empty pack (Git just cares
that it has all of the objects afterwards, not that you pushed them).

None of those care about the quality of the hash (they do assume you
know the hash of X already, but then so does fetching by object id).

And no, I've never written a proof-of-concept for that. It would depend
largely on the data you're trying to extract. E.g., if you think X
contains "root:XXXXXX", then you might hope to ask for "root:AXXXXX",
then "root:BXXXXX", etc. You know you've got a hit when the delta gets
smaller. So the complexity for guessing N bytes becomes 256*N, rather
than 256^N.

> > But I agree that people do assume it's the case. I was certainly
> > surprised by the v2 behavior, and I don't remember that aspect being
> > discussed.
> 
> IMHO it's a plain bug (either in implementation or documentation).

Or both. :) The behavior and the documentation seem to agree.

> [...]
> >> I'm inclined to say that in the face of that "SECURITY" section we
> >> should just:
> >>
> >>  * Turn on uploadpack.allowReachableSHA1InWant for v0/v1 by
> >>    default. Make saying uploadpack.allowReachableSHA1InWant=false warn
> >>    with "this won't work, see SECURITY...".
> >>
> >>  * The uploadpack.allowTipSHA1InWant setting will also be turned on by
> >>    default, and will be much faster, since it'll just degrade to
> >>    uploadpack.allowReachableSHA1InWant=true and we won't need any
> >>    reachability check. We'll also warn saying that setting it is
> >>    useless.
> >
> > No real argument from me. I have always thought those security
> > guarantees were BS.
> 
> This would make per-branch ACLs (as implemented both by Gerrit and
> gitolite) an essentially useless feature, so please no.

I think Ævar's argument is that those are providing a false sense of
security now (at least for read permissions).

Let me clarify my position a little.

I won't claim the existing scheme provides _no_ value (especially the
pure read-only case above is less dicey than the others). It's mostly
that the protections are very hand-wavy. I don't trust them _now_, and I
have little faith that other innocent-looking changes to the object
negotiation and the packing code will not significantly weaken them.
There's no security boundary expressed within Git's code, so there's a
very high chance of information leaking accidentally. A trustable system
would have boundaries built in from the ground up.

Enough people seem to believe otherwise (i.e., that the hand-waving
arguments are worth _something_) that I've never pushed to actually
change the default behavior. But if Ævar wants to try to do so, I'm not
going to stand in my way (hence my "no argument from me").

> I would be all for changing the default, but making turning off
> allowReachableSHA1InWant an unsupported deprecated thing is a step too
> far, in my opinion.

Yes, I agree if we were to go down this road, it probably makes sense to
flip the knobs and let them be "unflipped" if the user wants.

> Is there somewhere that we can document these kinds of invariants or
> goals so that we don't have to keep repeating the same discussions?

It's not clear to me that there's consensus on the invariants or goals.
;)

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01D081F405
	for <e@80x24.org>; Mon, 17 Dec 2018 19:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387549AbeLQT5P (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 14:57:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:44066 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732762AbeLQT5P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 14:57:15 -0500
Received: (qmail 17774 invoked by uid 109); 17 Dec 2018 19:57:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 17 Dec 2018 19:57:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6121 invoked by uid 111); 17 Dec 2018 19:56:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 17 Dec 2018 14:56:47 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2018 14:57:13 -0500
Date:   Mon, 17 Dec 2018 14:57:13 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 8/8] tests: mark tests broken under
 GIT_TEST_PROTOCOL_VERSION=2
Message-ID: <20181217195713.GA10673@sigill.intra.peff.net>
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
 <20181213155817.27666-9-avarab@gmail.com>
 <87pnu51kac.fsf@evledraar.gmail.com>
 <20181214101232.GC13465@sigill.intra.peff.net>
 <87o99o1iot.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o99o1iot.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 11:55:30AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > An interesting implication of this at GitHub (and possibly other
> > hosters) is that it exposes objects from shared storage via unexpected
> > repos. If I fork torvalds/linux to peff/linux and push up object X, a v0
> > fetch will (by default) refuse to serve it to me. But v2 will happily
> > hand it over, which may confuse people into thinking that the object is
> > (or at least at some point was) in Linus's repository.
> 
> More importantly this bypasses the security guarantee we've had with the
> default of uploadpack.allowAnySHA1InWant=false.

IMHO those security guarantees there are overrated (due to delta
guessing attacks, though things are not quite as bad if the attacker
can't actually push to the repo).

But I agree that people do assume it's the case. I was certainly
surprised by the v2 behavior, and I don't remember that aspect being
discussed.

(I suspect it was mostly because in the stateless world, the "fetch"
operation requires iterating all of the refs again. That's made even
harder by the fact that "ls-refs" takes arguments now, and might have
only advertised a subset of the refs. How can "fetch" know which ones
were advertised?).

>  a) Subject to the "SECURITY" section of git-fetch, i.e. maybe this
>     doesn't even work in the face of a determined attacker.

Yeah, this is the part I was thinking about above.

>  b) Hosting sites like GitHub, GitLab, Gitweb etc. aren't doing
>     reachability checks when you view /commit/<id>. If I delete my topic
>     branch it'll be viewable until the next GC kicks in (which would
>     also be the case with uploadpack.allowAnySHA1InWant=true).

Actually, we don't ever prune unless a user asks us to (and certainly
users do ask us to after accidentally pushing secret stuff). In GitHub's
case, though, we always tell people to consider anything pushed to a
public repo to be non-secret, even if it was exposed for only a few
seconds. My understanding is that there are literally clients watching
the public feeds and sucking down repo data looking for these kinds of
mistakes.

The /commit/<id> thing has been a frequent topic of discussion within
GitHub over the years, and we have looked at actually doing reachability
checks. They're expensive, though bitmaps help.

> So I wonder how much we need to care about this in practice, but for
> some configurations protocol v2 definitely breaks a security promise
> we've been making, now whether that promise was always BS due to "a)"
> above is another matter.
> 
> I'm inclined to say that in the face of that "SECURITY" section we
> should just:
> 
>  * Turn on uploadpack.allowReachableSHA1InWant for v0/v1 by
>    default. Make saying uploadpack.allowReachableSHA1InWant=false warn
>    with "this won't work, see SECURITY...".
> 
>  * The uploadpack.allowTipSHA1InWant setting will also be turned on by
>    default, and will be much faster, since it'll just degrade to
>    uploadpack.allowReachableSHA1InWant=true and we won't need any
>    reachability check. We'll also warn saying that setting it is
>    useless.

No real argument from me. I have always thought those security
guarantees were BS.

However, I do think that's all orthogonal to the issue I was mentioning,
which is that it looks like repo A wants to serve you object X, even if
that repo never saw the object. That's unique to shared storage schemes,
though.

IMHO this is also a user education issue (it's a question of trust: refs
are the source of trust, and objects don't need to be trusted because
they're immutable). But it's pretty subtle for people who don't know the
inner workings of Git.

-Peff

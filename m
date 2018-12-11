Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC67F20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 13:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbeLKNz0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 08:55:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:38226 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726203AbeLKNz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 08:55:26 -0500
Received: (qmail 22384 invoked by uid 109); 11 Dec 2018 13:55:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Dec 2018 13:55:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5717 invoked by uid 111); 11 Dec 2018 13:54:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Dec 2018 08:54:33 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2018 08:55:01 -0500
Date:   Tue, 11 Dec 2018 08:55:01 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/3] protocol v2 and hidden refs
Message-ID: <20181211135501.GA13731@sigill.intra.peff.net>
References: <20181211104236.GA6899@sigill.intra.peff.net>
 <875zw0nv77.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875zw0nv77.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 12:45:16PM +0100, Ævar Arnfjörð Bjarmason wrote:

> >     I don't know if there's a good solution. I tried running the whole
> >     test suite with v2 as the default. It does find this bug, but it has
> >     a bunch of other problems (notably fetch-pack won't run as v2, but
> >     some other tests I think also depend on v0's reachability rules,
> >     which v2 is documented not to enforce).
> 
> I think a global test mode for it would be a very good idea.

Yeah, but somebody needs to pick through the dozens of false positives
for it to be useful.

> > The patches are:
> >
> >   [1/3]: serve: pass "config context" through to individual commands
> >   [2/3]: parse_hide_refs_config: handle NULL section
> >   [3/3]: upload-pack: support hidden refs with protocol v2
> 
> Does this issue rise to the level of needing a security point-release
> (which I'm discussing here as the details are already public). The
> transfer.hideRefs docs have said:
> 
>     Even if you hide refs, a client may still be able to steal the
>     target objects via the techniques described in the "SECURITY"
>     section of the gitnamespaces(7) man page; it’s best to keep private
>     data in a separate repository.
> 
> So we never promised to hide the objects, but definitely promised to
> hide the ref names. I don't know if anyone uses this in practice for
> secret ref names, but if they do they have a data leak if they enable
> protocol v2.

Yes, that was my line of thinking. You can't really consider such items
secure, though it is unfortunate that this leak makes it way easier to
access them (you can just fetch them, rather than playing
oracle-guessing games with deltas).

At GitHub we keep some internal book-keeping refs, but exposing them to
the user is mostly an annoyance.

One thing to note is that there's no "enable protocol v2". If you're
running a recent enough Git (v2.18+?) on the server, anybody can ask for
these refs.

> More importantly, the docs for receive.hideRefs say. "An attempt to
> update or delete a hidden ref by git push is rejected.". It seems this
> bit was enforced, i.e. this passes before and after your 3/3, but I have
> not dug enough to be 100% satisfied with that.

This part is OK. There is no v2 push protocol yet, so you end up running
the regular v0 receive-pack.

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C26FC11F65
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6762661CEB
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhF2CC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:02:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:35576 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhF2CC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:02:28 -0400
Received: (qmail 17583 invoked by uid 109); 29 Jun 2021 02:00:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Jun 2021 02:00:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22759 invoked by uid 111); 29 Jun 2021 02:00:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Jun 2021 22:00:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Jun 2021 22:00:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Roland Hieber <rhi@pengutronix.de>, git@vger.kernel.org,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH] bisect: allow to run from subdirectories
Message-ID: <YNp+oYKd5SSyxMk9@coredump.intra.peff.net>
References: <20210620213836.10771-1-rhi@pengutronix.de>
 <xmqqy2b3j317.fsf@gitster.g>
 <YNPGb5gvygs++jlv@coredump.intra.peff.net>
 <xmqqtulh31nm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtulh31nm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 06:22:37PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> This does not depend on "do we have T as a directory?" being the
> >> bisection criteria.  The important thing is that the current
> >> directory would appear and disappear as the bisection process makes
> >> you jump around in the history.
> >
> > I think that is a good explanation. But I remain somewhat unconvinced
> > that it is that big a problem in practice.
> 
> It's just the difference in attitude, I would think.  Things like
> "rebase" take a more liberal attitude and most of the time things
> work out OK because removal of a directory is a rare event and
> replacement of a directory with a non-directory is even rarer, but
> when things break there is no provision to help users to know how it
> broke by diagnosing why the revision cannot be checked out, or why
> the directory D the user's shell session is sitting in is now
> orphaned and different from the directory D the user thinks he is in
> because it was removed (while the user's process is in there) and
> then recreated under the same name, or any of the tricky things.
> 
> The ideal endgame would be to allow operating from subdirectory
> *AND* have provisions for helping users when things go wrong because
> the starting subdirectory goes away.  "bisect" works under the more
> conservative philosophy (start strict and forbid operation that we
> know we didn't spend any effort to avoid taking the user into
> dangerous waters---we can allow it later once we make it safer but
> not until then).

Yes, I agree with this second paragraph. Just trying to create a
constructive path forward, I think I'd be comfortable with a patch
series that:

  - confirmed that bisect's behavior when checkout fails produces a
    reasonable error message that the user can act on (either from
    checkout itself, or perhaps extra advice from bisect when the
    checkout fails)

  - detected the case when the prefix we started from goes away as part
    of the checkout, and turned that into an error (rather than
    orphaning the user's cwd and leading to confusing results). This
    _might_ even be something that regular "git checkout" would benefit
    from, too. And I think should not be too expensive to implement (at
    least not after an admittedly moderate amount of thinking on it).

  - only then turn on SUBDIRECTORY_OK.

-Peff

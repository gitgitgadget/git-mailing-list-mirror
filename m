Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF4EC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 09:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0CFA22CA0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 09:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgHEJ2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 05:28:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:48840 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbgHEJ1n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 05:27:43 -0400
Received: (qmail 11462 invoked by uid 109); 5 Aug 2020 09:26:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Aug 2020 09:26:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21226 invoked by uid 111); 5 Aug 2020 09:26:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Aug 2020 05:26:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 Aug 2020 05:26:58 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: racy test failure in tb/upload-pack-filters
Message-ID: <20200805092658.GA1803042@coredump.intra.peff.net>
References: <20200805084240.GA1802257@coredump.intra.peff.net>
 <20200805090641.GR2898@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200805090641.GR2898@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 05, 2020 at 11:06:41AM +0200, SZEDER Gábor wrote:

> > We can fix it by using test_i18ngrep, which just makes this grep a noop
> > in the poison mode.
> 
> I wonder whether changing that die to
> 
>   die("%s: %s", _("remote error"), buffer + 4)
> 
> would be better.

That would definitely work, but it seems sad to have to make our code
uglier. Plus I think it would hurt translations that want to format
differently (e.g., would an RTL language want to swap the order?).

It also wouldn't help other poison uses that could be expecting a "%s"
to be filled.  Another option would be to make our poison code more
realistic by copying placeholders like "%s" into the poison string. That
would fix this problem, and allow some tests to relax a bit (e.g., if
I'm looking for an error message that contains a filename, I _could_
grep for just that filename, which would never actually be translated).

But I think that gets pretty tricky, as we'd have to understand the
whole set of placeholders (e.g., that "%s" is complete after two bytes,
but "%lu" needs three bytes).

Anyway, it seemed like limiting the damage to the tests themselves was
the least bad thing.

By the way, grepping for "remote error:" shows that when we get an error
over sideband 3 we produce the same message but _don't_ translate it.
That seems inconsistent.

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1A7C433FE
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7D66121F
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhIOQkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:40:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:48120 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhIOQkk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 12:40:40 -0400
Received: (qmail 32433 invoked by uid 109); 15 Sep 2021 16:39:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 16:39:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25206 invoked by uid 111); 15 Sep 2021 16:39:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 12:39:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 12:39:18 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 07/11] ls-refs: ignore very long ref-prefix counts
Message-ID: <YUIhtvBWvzTnF2Xw@coredump.intra.peff.net>
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
 <YUE1hz/KKM0XebCP@coredump.intra.peff.net>
 <YUFzhC5Eox8IND4O@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUFzhC5Eox8IND4O@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 12:16:04AM -0400, Taylor Blau wrote:

> > +	/*
> > +	 * If we saw too many prefixes, we must avoid using them at all; as
> > +	 * soon as we have any prefix, they are meant to form a comprehensive
> > +	 * list.
> > +	 */
> > +	if (data.prefixes.nr >= TOO_MANY_PREFIXES)
> > +		strvec_clear(&data.prefixes);
> > +
> 
> Great, I find this version even better than what I suggested where the
> case where the list already has too many prefixes `continue`s through
> the loop before calling strvec_add().
> 
> Just noting aloud, the `>` part of this conditional will never happen
> (since data.prefixes.nr will be at most equal to TOO_MANY_PREFIXES, but
> never larger than it).
> 
> Obviously not wrong, but I figured it'd be worth mentioning in case it
> caught the attention of other reviewers.

Yeah, your analysis is right. Long ago I read some advice (I think from
K&R, either the C book or a related article) that suggested always using
bounding checks like this rather than equality, because they do the
right thing even if the variable ends up with a surprising value.

I can certainly see an argument against it (like that if you're so
worried about it, maybe you ought to detect it and figure out who is
setting the variable to be unexpectedly high). But it seems like a
reasonable defensive measure to me (against an off-by-one mis-analysis,
or against the earlier code changing in the future).

-Peff

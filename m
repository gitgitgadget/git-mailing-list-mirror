Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75370C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C5E123770
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgLJAKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 19:10:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:56340 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgLJAKh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 19:10:37 -0500
Received: (qmail 26583 invoked by uid 109); 10 Dec 2020 00:09:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Dec 2020 00:09:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23035 invoked by uid 111); 10 Dec 2020 00:09:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Dec 2020 19:09:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Dec 2020 19:09:55 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 2/6] config: add new way to pass config via
 `--config-env`
Message-ID: <X9FnU5Jj2XPl8BFk@coredump.intra.peff.net>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
 <766ffe31a6f14c55d1b58a8f53edbb7f731b1b24.1607514692.git.ps@pks.im>
 <X9D23LQv34A5Q5DC@coredump.intra.peff.net>
 <xmqqy2i6zg1j.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2i6zg1j.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 09, 2020 at 04:00:08PM -0800, Junio C Hamano wrote:

> > I think we should also document that <envvar> can't contain an "=" sign.
> > Of course using strrchr() here doesn't help much with just this patch,
> > because we flatten the string before stuffing it into
> > $GIT_CONFIG_PARAMETERS, so the reading side would mis-parse it.
> >
> > But here's a fix for that. I built it on top of your whole series, since
> > you touched some of the related functions, but it could easily be
> > rebased onto just this part.
> 
> Hmph, so 
> 
>  (1) Patrick's 1 & 2 are about adding --config-env,
> 
>  (2) These three patches can come on top to make it more robust to
>      pass key=value with GIT_CONFIG_PARAMETERS (including what is
>      added via the --config-env=name=envvar), and

Yep, exactly.

>  (3) The remainder of Patrick's 6-patch series is to further add the
>      pairs of environment variables to pass keys and values?

More or less. I did use the config_parse_pair() helper from patch 4, and
there's some textual dependency on his patch 5 (but it would be easy to
rebase).

> I am still not sure if we want the last part, but whether we take
> (1) or (3) or neither or both, (2) sounds like a good thing to do.
> And (2) would not shine without (1).  In the traditional use of -c,
> we do not know which = from the end user separates key and value,
> but when (1) places a = to separate the <name> and the value in the
> environment variable, we know where that = is and can quote
> accordingly.

Exactly. Without (1), then (2) is not nearly as exciting. We could also
implement a non-ambiguous version of "-c", like:

  git --config key.with=equals.foo some-value ...

which would also benefit from (2). But I think Patrick's main goal was
to get secret values off the command-line, so he'd want either (1) or
(3) for that.

> But these three patches are done on top of (1) and (3), at least for
> now.

Yes. I'd be happy to rebase them if we're not going to do the
GIT_CONFIG_{KEY,VALUE}_<n> parts.

> The above is my understanding of the state of these patches.  Am I
> getting it right?

Yep.

-Peff

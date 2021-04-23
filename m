Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F1DC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 10:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD5A613C4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 10:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241717AbhDWKGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 06:06:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:33188 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241837AbhDWKGM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 06:06:12 -0400
Received: (qmail 6188 invoked by uid 109); 23 Apr 2021 10:05:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Apr 2021 10:05:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6721 invoked by uid 111); 23 Apr 2021 10:05:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Apr 2021 06:05:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Apr 2021 06:05:34 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Simon Ruderich <simon@ruderich.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v8 2/8] config: add new way to pass config via
 `--config-env`
Message-ID: <YIKb7qoeLtGjgsHr@coredump.intra.peff.net>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610453228.git.ps@pks.im>
 <470396d36f938f0070b8c849a85b1a30949056e3.1610453228.git.ps@pks.im>
 <87o8eeteyz.fsf@evledraar.gmail.com>
 <YHqeh9MeRDADviU0@coredump.intra.peff.net>
 <87y2dd2pdn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y2dd2pdn.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 20, 2021 at 12:59:16PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> It seems to me that having a skip_prefix_opt() or something would be a
> >> good fix for this, i.e. a "maybe trim the last '='" version of
> >> skip_prefix. Then we could just consistently use that.
> >
> > There's a similar situation in the revision parser (which does not use
> > our regular parse-options). There we have a parse_long_opt() helper
> > which does the right thing. We could use that more widely.
> >
> > I also wouldn't be surprised if we could leverage one of the
> > sub-functions of parse-options, but it might turn into a rabbit hole.
> > Converting the whole thing to the usual parse_options() might get
> > awkward, since many of the options operate at time-of-parse, not after
> > we've seen everything (I suspect many of them don't care either way, but
> > you're always risking subtle regressions there).
> 
> So we could use parse_options() and guarantee the existing behavior if
> they were all OPT_CALLBACK?

I _think_ so, but the result might be quite hard to read (the logic
would be scattered all over a bunch of tiny callbacks). But it might not
be too bad. Especially if you figure out which ones actually need the
time-of-parse logic and use more vanilla OPT_* for the others (that's
the rabbit hole I alluded to).

I think things like the "--exec-path" behavior that Patrick mentioned
would still work (I think it's just a stock OPTARG).

-Peff

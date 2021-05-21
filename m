Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B046C433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 09:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE4B6135A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 09:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbhEUJic (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 05:38:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:33190 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235864AbhEUJib (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 05:38:31 -0400
Received: (qmail 2914 invoked by uid 109); 21 May 2021 09:37:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 May 2021 09:37:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7871 invoked by uid 111); 21 May 2021 09:37:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 May 2021 05:37:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 May 2021 05:37:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 00/10] send-email: various optimizations to speed up
 by >2x
Message-ID: <YKd/QkWJtmeUJE8T@coredump.intra.peff.net>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
 <YKYdeom6SgAHqojm@coredump.intra.peff.net>
 <xmqqv97drmge.fsf@gitster.g>
 <875yzcpo52.fsf@evledraar.gmail.com>
 <YKd5xSw1bZbQXaAe@coredump.intra.peff.net>
 <8735ugphge.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735ugphge.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 21, 2021 at 11:24:00AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Using a non-flattened structure would have prevented this (we'd sensibly
> > get undef when trying to access the missing second element of the
> > array). But I do agree the flattened structure is more perl-ish.
> > Probably you'd want to insert an explicit "undef" into the list. The
> > most perl-ish I could come up with is:
> >
> >   my (@kv) = map { my ($k, $v) = split /\n/, $_, 2;
> >                    ($k, $v)
> >                  } split /\0/, $data;
> >
> > I notice that $known_keys then becomes a non-flat representation. You'd
> > either want to turn that back into a zero-length array there, or store
> > the "undef" and handle it appropriately (it can be a synonym for "true",
> > though that is just an optimization at this point).
> >
> > -Peff
> 
> Ah yes, that's indeed a bug. I'd forgetten about the empty value case.
> 
> For what it's worth you can slightly golf that as (split /\n/, $_,
> 2)[0,1], but I think in this case your version is better than that, it's
> more obvious what we're trying to do in always returning the $v.

Heh. Thanks, I almost invited you to golf it because I was curious if we
could continue to do it in one line. I see I didn't need to ask. :)

Yours is clever and I'm glad to be enlightened, but I agree the
two-liner is probably more obvious (perhaps even a comment like
"bool-only values omit the newline and become undef" is worth it).

-Peff

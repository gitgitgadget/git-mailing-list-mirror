Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B1BC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 10:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC65E600D3
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 10:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhGWJfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:35:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:55658 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbhGWJfq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 05:35:46 -0400
Received: (qmail 11147 invoked by uid 109); 23 Jul 2021 10:16:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Jul 2021 10:16:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24074 invoked by uid 111); 23 Jul 2021 10:16:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jul 2021 06:16:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jul 2021 06:16:18 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/5] drop support for ancient curl
Message-ID: <YPqW8lAcwno3j7Fq@coredump.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 22, 2021 at 12:22:11AM +0200, Ævar Arnfjörð Bjarmason wrote:

> This series is a re-roll of patches found in Peff's GitHub repo at
> jk/no-ancient-curl, which were already-rebased versions of those
> patches. His original on-list version had his Signed-off-by, but the
> range-diff is against that branch, hence the addition of
> Signed-off-by in the range-diff.

Heh, OK. It's a little surprising to see random junk pulled out of my
GitHub repo, but in this case I was holding onto them with the intent of
eventually resending after more time passed.

So I'm happy to see these cleaned up and posted. I think what's on that
branch should be good-ish, in the sense that I've been rebasing it
forward as part of my daily routine, and it's part of the build that I
use day-to-day. Though apparently I never applied the CURLOPT_POST301
fix. :-/

I know my S-o-b was on the originals to the list, but just to make
clear: I am fine with using them on the rebased versions you grabbed.

> I then added a couple of patches on top, one is based on my comments
> on the v1 http://lore.kernel.org/git/871sokhoi9.fsf@gmail.com,
> i.e. the CURLAUTH_DIGEST_IE and CURLOPT_USE_SSL flags are also
> version-based, and we can drop support for curls that don't have them.

Seems reasonable.

> I then renamed the ancient CURLOPT_FILE alias to
> CURLOPT_WRITEDATA. Incidentally that's how I remembered to dig up this
> series, i.e. I tried to search for "CURLOPT_FILE" in API documentation
> while reading our HTTP code, but had a hard time finding it, turns out
> we were using a very ancient synonym for the preferred name.

This seemed weirdly familiar. Looks like it was part of a series last
year, but the trickier parts built on top merited a re-roll that never
came:

  https://lore.kernel.org/git/20201013191729.2524700-2-smcallis@google.com/

> Jeff King (3):
>   http: drop support for curl < 7.11.1
>   http: drop support for curl < 7.16.0
>   http: drop support for curl < 7.19.4
> 
> Ævar Arnfjörð Bjarmason (2):
>   http: drop support for curl < 7.19.3 and < 7.16.4 (again)
>   http: rename CURLOPT_FILE to CURLOPT_WRITEDATA

So modulo the commit message tweaks that Junio suggested, this all looks
fine. I actually think my original "#error on too-old curl" is still
reasonable. Yes, people whose distro has backported all of these
features could possibly still use it. But in that case they likely know
what's going on and can rip out the #error. It seems much more likely
to me that it _won't_ work, and they'll get confused by obscure errors
when they try to use an old curl.

But I don't feel too stronlgy about it either way.

-Peff

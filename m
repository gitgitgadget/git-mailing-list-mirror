Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8F2C2D0E2
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 07:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6B0235F7
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 07:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgIXHVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 03:21:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:39058 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbgIXHVw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 03:21:52 -0400
Received: (qmail 1726 invoked by uid 109); 24 Sep 2020 07:21:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Sep 2020 07:21:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24078 invoked by uid 111); 24 Sep 2020 07:21:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Sep 2020 03:21:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Sep 2020 03:21:51 -0400
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 06/13] reftable: (de)serialization for the polymorphic
 record type.
Message-ID: <20200924072151.GC1851751@coredump.intra.peff.net>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <791f69c000556e93bf5fcfc0ec9304833b12565b.1600283416.git.gitgitgadget@gmail.com>
 <xmqqlfh5i7nk.fsf@gitster.c.googlers.com>
 <CAFQ2z_M9uBc+VArOVXg-hwTY8bu-gQQSL9JC6TJ5MuTCtxx=EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_M9uBc+VArOVXg-hwTY8bu-gQQSL9JC6TJ5MuTCtxx=EQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 21, 2020 at 03:13:05PM +0200, Han-Wen Nienhuys wrote:

> The problem is actually triggered by the Git-provided put_be64()
> (which appears unused in the Git source code). The definition
> 
>   #define put_be64(p, v) do { *(uint64_t *)(p) = htonll(v); } while (0)
> 
> is trying to reinterpret a char* as a uint64_t* , which is illegal in
> strict aliasing rules?

Ah, thanks for finding that. I think this resolves the mystery I had
around aliasing warnings with put_be32() in f39ad38410 (fast-export: use
local array to store anonymized oid, 2020-06-25). I got confused because
when I looked at the implementation of put_be32(), I stupidly looked at
the NO_ALIGNED_LOADS fallback code, which indeed does not alias. But the
one we use on x86 does.

I thought this would be OK because C allows aliasing through "char *"
pointers. But I think it may only go the other way. I.e., you can
type-pun a uint64_t as a char, but not the other way around. But then
why doesn't basically every use of put_be32() and put_be64() complain?

> I originally had
> 
> +void put_be64(uint8_t *out, uint64_t v)
> +{
> +       int i = sizeof(uint64_t);
> +        while (i--) {
> +               out[i] = (uint8_t)(v & 0xff);
> +               v >>= 8;
> +       }
> +}
> 
> in my reftable library, which is portable. Is there a reason for the
> magic with htonll and friends?

Presumably it was thought to be faster. This comes originally from the
block-sha1 code in 660231aa97 (block-sha1: support for architectures
with memory alignment restrictions, 2009-08-12). I don't know how it
compares in practice, and especially these days.

Our fallback routines are similar to an unrolled version of what you
wrote above.

-Peff

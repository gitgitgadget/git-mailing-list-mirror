Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8761C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2A5613AA
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhEENuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 09:50:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:45298 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232884AbhEENut (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 09:50:49 -0400
Received: (qmail 18375 invoked by uid 109); 5 May 2021 13:49:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 May 2021 13:49:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9624 invoked by uid 111); 5 May 2021 13:49:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 May 2021 09:49:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 May 2021 09:49:52 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] streaming.c: stop passing around "object_info *" to
 open()
Message-ID: <YJKigIfSXWavM0QN@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
 <patch-4.5-44e79d6cb66-20210505T122816Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-4.5-44e79d6cb66-20210505T122816Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 05, 2021 at 02:33:31PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Change the streaming interface to stop passing around the "struct
> object_info" the open() functions.
> 
> As seen in 7ef2d9a2604 (streaming: read non-delta incrementally from a
> pack, 2011-05-13) which introduced the "st->u.in_pack" assignments
> being changed here only the open_istream_pack_non_delta() path need
> these.
> 
> So let's instead do this when preparing the selected callback in the
> istream_source() function. This might also allow the compiler to
> reduce the lifetime of the "oi" variable, as we've moved it from
> "git_istream()" to "istream_source()".

OK. This blurs the lines a bit between what the generic istream_source()
is responsible for, versus the type-specific helpers. I think that works
a bit against the original design, which was trying to be very abstract
and polymorphic. But that doesn't seem to have bought us much. Just
considering the whole set of streaming code as a module with helper
functions is a bit simpler and more usual for our codebase.

So I'm OK with it unless Junio (as the original author) has strong
objections.

-Peff

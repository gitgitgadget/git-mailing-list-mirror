Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FD8C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C228761355
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbhELXyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:54:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:53038 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234409AbhELXiM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 19:38:12 -0400
Received: (qmail 30757 invoked by uid 109); 12 May 2021 23:37:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 May 2021 23:37:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11033 invoked by uid 111); 12 May 2021 23:37:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 May 2021 19:37:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 May 2021 19:36:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 0/9] send-email: various optimizations to speed up by >2x
Message-ID: <YJxmmyM9/3KBFPTg@coredump.intra.peff.net>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 03:48:16PM +0200, Ævar Arnfjörð Bjarmason wrote:

> As noted in the subject this speeds up git-send-email invocations by
> ~2x or more, and brings the very slow t9001 test from running in ~26s
> on my box to ~12s. It's no longer consistently the slowest test I run.
> 
> This is basically done in two ways: We lazily invoke "git config" to
> get config, before it's very eager, and deferring Perl compilation
> with s/use/require/g.

Splitting my reply, since the other one got deep into test-suite timing
details.

The techniques here look overall pretty reasonable. I think the module
lazy-loading makes the overall code a _little_ uglier, but IMHO the
speedup you're getting is worth it (I was surprised how much of the
improvement comes from that versus avoiding git-config subprocesses).

My only concern is changing the interface of Git::config_regexp() in the
final patch. Do we need to have a config_regexp_with_values() to avoid
breaking third-party users of the module?

-Peff

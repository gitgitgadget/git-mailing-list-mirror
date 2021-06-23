Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BCCC48BC2
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 23:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D555611C9
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 23:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFWXus (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 19:50:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:58900 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhFWXus (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 19:50:48 -0400
Received: (qmail 8369 invoked by uid 109); 23 Jun 2021 23:47:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Jun 2021 23:47:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8097 invoked by uid 111); 23 Jun 2021 23:48:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Jun 2021 19:48:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Jun 2021 19:48:25 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] progress.c tests: fix breakage with COLUMNS != 80
Message-ID: <YNPISWEBxISC30DW@coredump.intra.peff.net>
References: <patch-1.1-cba5d88ca35-20210621T070114Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-cba5d88ca35-20210621T070114Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 09:01:23AM +0200, Ævar Arnfjörð Bjarmason wrote:

> The tests added in 2bb74b53a49 (Test the progress display, 2019-09-16)
> broke under anything except COLUMNS=80, i.e. when running them under
> the "-v" mode under a differently sized terminal.
> 
> Let's set the expected number of COLUMNS at the start of the test to
> fix that bug. It's handy not do do this in test-progress.c itself, in
> case we'd like to test for a different number of COLUMNS, either
> manually or in a future test.

Hmm. So I can easily reproduce the problem here, and your patch fixes
it. But my first thought was: shouldn't test-lib.sh be handling this to
give all of the scripts a uniform environment?

And indeed, we _do_ unset COLUMNS there. So I think the problem isn't
a bad setting of $COLUMNS, but rather that in "-v" mode, the
sub-command's stderr is hooked to our tty, and term_columns() is smart
enough to use TIOCGWINSZ to get the value (at least on some platforms).

Setting $COLUMNS again in the environment fixes it, because we prefer
that value to trying the ioctl.

So I don't think what you have here is wrong (though the commit message
is a little misleading). But it seems like the original intent of our
"unset COLUMNS" in test-lib.sh would best be fulfilled by setting it to
a known value there (like 80), rather than unsetting it.

I admit this a _bit_ of a nitpick (since as far as we know none of the
other scripts care about the terminal width), so I'm OK with this as-is
if you feel strongly the other way.

-Peff

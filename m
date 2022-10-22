Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A8AC433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 20:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJVUfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 16:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJVUfu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 16:35:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0606EF37
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 13:35:49 -0700 (PDT)
Received: (qmail 21012 invoked by uid 109); 22 Oct 2022 20:35:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Oct 2022 20:35:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3477 invoked by uid 111); 22 Oct 2022 20:35:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Oct 2022 16:35:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Oct 2022 16:35:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] repack: use tempfiles for signal cleanup
Message-ID: <Y1RUI8ny2mexxwKm@coredump.intra.peff.net>
References: <Y1M3fVnixJHvKiSg@coredump.intra.peff.net>
 <Y1M3oie5dPrRaOni@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1M3oie5dPrRaOni@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 08:21:54PM -0400, Jeff King wrote:

> +test_expect_success 'clean up .tmp-* packs on error' '
> +	test_must_fail git \
> +		-c repack.cruftwindow=bogus \
> +		repack -ad --cruft &&
> +	find $objdir/pack -name '.tmp-*' >tmpfiles &&
> +	test_must_be_empty tmpfiles
> +'

Ugh, I think this test is racy. I saw a failure via SIGPIPE on OS X in
CI, and running it locally with --stress confirmed. I think the problem
is in our method to trigger pack-objects to fail for the cruft pack. We
pass a bogus command line argument, so pack-objects exits more or less
immediately. But the parent git-repack process is trying to write to its
stdin (to name packs to keep/exclude). So that write may succeed or fail
based on how quickly the child dies.

Some options:

  - find a different way to convince repack to die. The most likely is
    probably corrupting the cruft objects in some way such that
    pack-objects dies, but not until it starts doing real work.

  - mark the test_must_fail with ok=sigpipe. In most case this is a
    band-aid, but here we still test what we want. The .tmp cleanup
    should kick in from a die() or from a signal death, so either is
    sufficient for our purposes.

  - teach git-repack to ignore sigpipe. We don't actually check the
    writes to pack-objects (since they're done by fprintf), but we'd
    notice its failing exit code. And arguably this is improving the
    user experience. Saying "pack-objects died with an error" is more
    useful than a sigpipe.

Thoughts?

-Peff

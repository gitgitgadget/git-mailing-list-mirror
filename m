Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875F6C433FE
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 12:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiKEMwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 08:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKEMw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 08:52:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B59626130
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 05:52:29 -0700 (PDT)
Received: (qmail 24642 invoked by uid 109); 5 Nov 2022 12:52:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 05 Nov 2022 12:52:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7303 invoked by uid 111); 5 Nov 2022 12:52:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 05 Nov 2022 08:52:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 5 Nov 2022 08:52:27 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/3] receive-pack: only use visible refs for
 connectivity check
Message-ID: <Y2Zci0z39Q0/sMHY@coredump.intra.peff.net>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667485737.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1667485737.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2022 at 03:37:25PM +0100, Patrick Steinhardt wrote:

> Overall the performance improvement isn't quite as strong as before:
> we're only 4.5x faster compared to 6.5x in our repo. But I guess that's
> still a good-enough improvement, doubly so that there are no downsides
> for repos anymore that ain't got any hidden refs.

Just a guess, but the extra time is probably spent because "rev-list"
has to iterate over your kajillion refs saying "nope, not this one".

I wonder if there is a way to carve up the ref namespace early, in a
trie-like way, similar to how for_each_fullref_in_prefixes() skips
straight to the interesting part. It's a harder problem, because we are
excluding rather than including entries based on our patterns. But it
seems like you'd be able to notice that we are on "refs/foo/bar", that
all of "refs/foo" is excluded, and jump ahead to the end of the
"refs/foo" section by binary-searching for the end within the
packed-refs file.

And that would speed up both this rev-list, but also the initial
advertisement that receive-pack does, because it's also iterating all of
these saying "nope, it's hidden". And assuming these are all internal
refs you hide from users, upload-pack would benefit, too.

I don't think that should be part of this series, but it may be an
interesting future direction.

-Peff

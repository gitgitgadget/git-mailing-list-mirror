Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17828C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF1EB64D9E
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhBPOzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:55:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:34274 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229827AbhBPOzF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 09:55:05 -0500
Received: (qmail 13517 invoked by uid 109); 16 Feb 2021 14:54:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 14:54:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25041 invoked by uid 111); 16 Feb 2021 14:54:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 09:54:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 09:54:24 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Blake Burkhart <bburky@bburky.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] add open_nofollow() helper
Message-ID: <YCvcoPnDAEWNcv+h@coredump.intra.peff.net>
References: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
 <YCvaRpQs99TBaCrQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCvaRpQs99TBaCrQ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 09:44:23AM -0500, Jeff King wrote:

>   - we can determine whether the path is a symlink with lstat().
> 
>     This is slower (two syscalls instead of one), but that may be
>     acceptable for infrequent uses like looking up .gitattributes files
>     (especially because we can get away with a single syscall for the
>     common case of ENOENT).
> 
>     It's also racy, but should be sufficient for our needs (we are
>     worried about in-tree symlinks that we ourselves would have
>     previously created). We could make it non-racy at the cost of making
>     it even slower, by doing an fstat() on the opened descriptor and
>     comparing the dev/ino fields to the original lstat().
> 
> This patch implements the lstat() option in its slightly-faster racy
> form.

I manually compared the performance of the O_NOFOLLOW and fallback paths
by running:

  git ls-files | git check-attr --stdin -a

on linux.git, which would try to look at quite a few in-tree attribute
files. The slowdown didn't seem measurable (in fact, the fallback seems
about 1% faster even over many trials, but I think it's just noise).
Both take ~50ms.

Which makes sense, because there's only one .gitattributes file, so most
of the lookups are hitting ENOENT on the lstat() and not even calling
open(). If I do:

  find * -type d | sed 's,$,/.gitattributes,' | xargs touch

then the O_NOFOLLOW case takes ~54ms (which makes sense; we're opening a
bunch of extra empty attribute files), and the fallback case goes to
~56ms. So the difference becomes measurable, but I wonder if it's worth
even caring about. That's 2ms on a pathological case. I'd even be
tempted to implement the non-racy version with the extra fstat(). I
don't think we need it, but just as a least-surprise thing.

This is all on Linux, of course. Perhaps other systems with slower
syscalls may be more impacted.

-Peff

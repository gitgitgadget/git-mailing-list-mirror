Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21C0C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 16:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60BB564D79
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 16:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhBPQUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 11:20:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:34428 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230017AbhBPQUF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 11:20:05 -0500
Received: (qmail 13790 invoked by uid 109); 16 Feb 2021 16:19:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 16:19:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26281 invoked by uid 111); 16 Feb 2021 16:19:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 11:19:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 11:19:24 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Blake Burkhart <bburky@bburky.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] add open_nofollow() helper
Message-ID: <YCvwjBm3Jpmi+8Dv@coredump.intra.peff.net>
References: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
 <YCvaRpQs99TBaCrQ@coredump.intra.peff.net>
 <YCvcoPnDAEWNcv+h@coredump.intra.peff.net>
 <YCvoQBhmCeeR9Cup@nand.local>
 <YCvsj2Teym2K06wa@coredump.intra.peff.net>
 <YCvty0WvJycB7WXi@nand.local>
 <YCvuy80k/P8qQ1h7@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCvuy80k/P8qQ1h7@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 11:11:55AM -0500, Taylor Blau wrote:

> On Tue, Feb 16, 2021 at 11:07:39AM -0500, Taylor Blau wrote:
> > On Tue, Feb 16, 2021 at 11:02:23AM -0500, Jeff King wrote:
> > > Can you double-check your initial timings?
> >
> > Aha, I forgot to update the input to the second check-attr tests after
> > putting .gitattributes files everywhere.
> >
> > Rerunning with O_NOFOLLOW, the initial timings look something like
> > 128.8ms and 183.7ms before/after.
> 
> I should add that "before" refers to a clean checkout, and "after"
> refers to the state after running 'find * -type d | ... | xargs touch'.
> Both of those numbers are with the O_NOFOLLOW branch.
> 
> If I repeat the test after applying:
> 
> diff --git a/wrapper.c b/wrapper.c
> index 563ad590df..90f603e749 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -681,7 +681,7 @@ int is_empty_or_missing_file(const char *filename)
> 
>  int open_nofollow(const char *path, int flags)
>  {
> -#ifdef O_NOFOLLOW
> +#if 0
>         return open(path, flags | O_NOFOLLOW);
>  #else
>         struct stat st;
> 
> Then those numbers go from 155.9ms to 197.2ms.

OK, thanks. So to lay out all cases:

             one file | many files
            +--------------------
O_NOFOLLOW  | 128.8ms | 183.7ms
lstat+open  | 155.9ms | 197.2ms

The jump for both from "one" to "many" files for both rows is expected;
there's more work to do. The jump from 183 to 197 in the "many" column
is what I was wanting to measure (how expensive is the fallback code),
and is around the order of magnitude I'd expect (and IMHO probably
acceptable).

But the jump in the "one file" column between the two code paths is
really confusing. Those are making the same number of syscalls. It's
possible that lstat() is way more expensive than open(), but in that
case I'd expect to see a similarly large jump in the "many" column.
Weird.

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CC3C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 19:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJRTku (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 15:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJRTks (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 15:40:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035747CB4B
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 12:40:46 -0700 (PDT)
Received: (qmail 32715 invoked by uid 109); 18 Oct 2022 19:40:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 19:40:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22431 invoked by uid 111); 18 Oct 2022 19:40:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Oct 2022 15:40:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Oct 2022 15:40:45 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: linux-leaks CI failure on master
Message-ID: <Y08BPbWBj7SNluXq@coredump.intra.peff.net>
References: <Y07yeEQu+C7AH7oN@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y07yeEQu+C7AH7oN@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2022 at 02:37:44PM -0400, Taylor Blau wrote:

> After Junio pushed out the tags for v2.38.1 and friends, I noticed that
> our linux-leaks CI job is failing t1300.104 and t1300.109, claiming that
> there is a leak here:
> [...]
>     #14 0x55ba233acb36 in alias_lookup alias.c:35
>     #15 0x55ba232d0748 in handle_alias git.c:346

These are the interesting part of the trace. alias_lookup() returns an
allocated string, and then split_cmdline() fails, so we call die() with:

  fatal: bad alias.split-cmdline-fix string: unclosed quote

So yeah, I think it's probably the same issue as discussed previously:
the compiler presumably puts alias_string into a register, and then
clobbers the register when calling die(), because it knows we're never
coming back.

> I can't reproduce the failure locally with gcc (Debian 10.3.0-15)
> 10.3.0, but Victoria (CC'd) can reproduce the failure with 9.4.0.
> Interestingly, the failure only appears when compiling with `-O2`, but
> not `-O0` or `-O1`.

I can't reproduce on debian unstable using any of gcc 9-12 (but note
gcc-9 here is 9.5.0). But then, I had trouble convincing gcc to find
_actual_ leaks with lsan. Clang is much more reliable for me, but it
turns up only the failure in t1300.135 that I reported earlier.

But given the trace above plus the findings on gcc 9.4.0, I feel pretty
confident saying this is another instance of the same problem.

> I'm not sure if I'm content to treat the 9.4.0 behavior as a compiler
> bug, but definitely running the linux-leaks build with `-O2` is
> suspicious.

It's definitely not a compiler bug. What the optimizer is doing is
perfectly reasonable; it's just that the leak checker interacts badly
with it.

> I suppose we could temporarily mark t1300 as not passing with
> SANITIZE=leak turned on, but I tend to agree with Peff that that feels
> like a hack working around compiler behavior, that will ultimately
> result in us playing whack-a-mole.
> 
> So my preference would be to run the linux-leaks build with `-O0` in its
> CFLAGS, optionally with a newer compiler if one is available for Focal.

Yes, I still think disabling optimizations is the best path forward. Not
just to avoid whack-a-mole, but this is also something we'd eventually
need to confront when the code base really is leak-free.

I don't think there's any need for a newer compiler. While the optimizer
behavior may change between versions, none of what we've seen is any
compiler being _wrong_, just different.

As a lesser change, I suspect that making NORETURN a noop in
leak-checking builds would help in practice, because the compiler
wouldn't realize that die() doesn't return. But it's not foolproof (the
same thing might trigger with a direct exit() call, or one that becomes
direct via inlining). Using -O0 is the more complete fix, and IMHO it's
not important to try to get optimal performance during the leak-checking
test run.

-Peff

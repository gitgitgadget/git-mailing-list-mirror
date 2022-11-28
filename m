Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F87C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 05:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiK1FBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 00:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiK1FBi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 00:01:38 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E354F65E0
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 21:01:36 -0800 (PST)
Received: (qmail 6982 invoked by uid 109); 28 Nov 2022 05:01:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Nov 2022 05:01:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32717 invoked by uid 111); 28 Nov 2022 05:01:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Nov 2022 00:01:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Nov 2022 00:01:35 -0500
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: Re: [PATCH] git-compat-util.h: Fix build without threads
Message-ID: <Y4RAr04vS/TOM5uh@coredump.intra.peff.net>
References: <20221125092339.29433-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221125092339.29433-1-bagasdotme@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 25, 2022 at 04:23:39PM +0700, Bagas Sanjaya wrote:

> From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> 
> Git build with toolchains without threads support is broken (as reported
> by Buildroot autobuilder [1]) since version 2.29.0, which traces back to
> 15b52a44e0 (compat-util: type-check parameters of no-op replacement
> functions, 2020-08-06):
> 
> In file included from cache.h:4,
>                  from blame.c:1:
> git-compat-util.h:1238:20: error: static declaration of 'flockfile' follows non-static declaration
>  static inline void flockfile(FILE *fh)
>                     ^~~~~~~~~
> In file included from git-compat-util.h:168,
>                  from cache.h:4,
>                  from blame.c:1:
> /nvme/rc-buildroot-test/scripts/instance-0/output-1/host/arm-buildroot-linux-uclibcgnueabihf/sysroot/usr/include/stdio.h:806:13: note: previous declaration of 'flockfile' was here

We'll only compile our flockfile wrapper if _POSIX_THREAD_SAFE_FUNCTIONS
isn't set. So this is a platform where flockfile() is declared in a
header, but that flag is not defined.

If flockfile() really is available, I think a better fix here is to
figure out why the posix flag isn't set, or to set it manually, so that
we use the system flockfile(). That would give better performance.

From the filename, I'm assuming it's uclibc. And poking at the uclibc
source, it looks like the flag is sometimes set, but may be unset if
__UCLIBC_HAS_THREADS__ isn't set. And flockfile() is defined regardless.
So it may be correctly telling us that there's no thread support, but
still declares flockfile() anyway. Which is a little weird, but I think
not strictly violating POSIX.

If that's the case, then the patch here seems like the wrong thing.
We'll avoid the extra noop declaration of flockfile() in the header
which is blocking your compilation, but we'll still try to call
flockfile() in config.c. That will try to call the system version that
the headers told us should not be used. How will it behave? Maybe OK,
maybe not, depending on the platform.


All this points to 15b52a44e0 being a bit too loose with its
assumptions. It is assuming that if the posix flag is not defined, we
are free to use those system names. But here's an example where that is
not true. And the only way around it is with a macro, which is what we
had before that commit.

So I think we'd want to revert the flockfile() bits of that commit. And
I'd guess setitimer is in the same boat (the system may declare it, but
for whatever reason somebody may choose not to use it by feeding
NO_SETITIMER to make, at which point the compiler will complain about
the duplicate declaration.

There's more discussion in the original thread:

  https://lore.kernel.org/git/20200807032723.GA15119@coredump.intra.peff.net/

Junio said "we'll cross that bridge when we need to port to such a
system". I guess that time is now. ;)

In theory we should also #undef all of the macros we're replacing, in
case the platform implements them as macros. I'm OK to wait on that
until we see such a system, though (I was mildly surprised that the
compiler didn't also complain about getc_unlocked(), because I believe
that it can be a macro, but it looks like it isn't in uclibc).

-Peff

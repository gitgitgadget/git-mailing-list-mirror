Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E78C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 05:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiK1FE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 00:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiK1FEV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 00:04:21 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD631144C
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 21:04:18 -0800 (PST)
Received: (qmail 7000 invoked by uid 109); 28 Nov 2022 05:04:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Nov 2022 05:04:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32731 invoked by uid 111); 28 Nov 2022 05:04:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Nov 2022 00:04:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Nov 2022 00:04:17 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: Re: [PATCH] git-compat-util.h: Fix build without threads
Message-ID: <Y4RBUa5ILEszSpOu@coredump.intra.peff.net>
References: <20221125092339.29433-1-bagasdotme@gmail.com>
 <221126.86lenymw7p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221126.86lenymw7p.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 26, 2022 at 12:47:27AM +0100, Ævar Arnfjörð Bjarmason wrote:

> On Fri, Nov 25 2022, Bagas Sanjaya wrote:
> 
> > From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> >
> > Git build with toolchains without threads support is broken (as reported
> > by Buildroot autobuilder [1]) since version 2.29.0, which traces back to
> 
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -1470,7 +1470,8 @@ int open_nofollow(const char *path, int flags);
> >  # define SHELL_PATH "/bin/sh"
> >  #endif
> >  
> > -#ifndef _POSIX_THREAD_SAFE_FUNCTIONS
> > +
> > +#if !defined(_POSIX_THREAD_SAFE_FUNCTIONS) && defined(NO_FLOCKFILE)
> 
> Per f43cce23add (git-compat-util: add fallbacks for unlocked stdio,
> 2015-04-16) wouldn't it make more sense to do something like:
> 
> #ifdef NO_FLOCKFILE
> #undef _POSIX_THREAD_SAFE_FUNCTIONS
> #endif

That doesn't work, because the NO_FLOCKFILE is actually overriding the
_lack_ of _POSIX_THREAD_SAFE_FUNCTIONS. So it's kind of confusingly
named. In this patch, NO_FLOCKFILE means "do not define a noop wrapper
flockfile()", which can only work if the system really does define it.

I do think this patch is doing the wrong thing, though. See my other
reply.

-Peff

Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD801C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 02:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918F5206D4
	for <git@archiver.kernel.org>; Tue, 19 May 2020 02:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgESCtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 22:49:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:50508 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726292AbgESCtq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 22:49:46 -0400
Received: (qmail 22772 invoked by uid 109); 19 May 2020 02:49:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 May 2020 02:49:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8616 invoked by uid 111); 19 May 2020 02:49:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2020 22:49:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 May 2020 22:49:45 -0400
From:   Jeff King <peff@peff.net>
To:     "Daniel Richard G." <skunk@iSKUNK.ORG>
Cc:     git@vger.kernel.org
Subject: Re: Minor portability issues + fixes
Message-ID: <20200519024945.GB70483@coredump.intra.peff.net>
References: <7422404e-7fc8-4961-aae4-3f0adb71bb3a@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7422404e-7fc8-4961-aae4-3f0adb71bb3a@www.fastmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 09:15:58PM -0400, Daniel Richard G. wrote:

> I am building Git 2.26.2 on AIX. A few compilation errors arose, but
> they are resolvable with a few minor changes that will improve overall
> portability.
> 
> There were a few errors of this form:
> 
>     sha1-file.c: In function 'mmap_limit_check':
>     sha1-file.c:940:12: error: 'SIZE_MAX' undeclared (first use in this function)
>     sha1-file.c:940:12: note: each undeclared identifier is reported only once for each function it appears in
> 
> SIZE_MAX is defined in stdint.h, and adding that #include fixes this. It
> is likely that this header is being pulled in on other platforms due to
> transitive dependencies, but that does not occur on AIX.

All system defines in Git should be pulled in via git-compat-util.h.
That does include stdint.h, but only if NO_INTTYPES_H is defined
(otherwise we prefer inttypes.h). And POSIX (2004) says:

  The <inttypes.h> header shall include the <stdint.h> header.

But perhaps that is not so on AIX (it wouldn't be the first time we've
seen a platform that does not strictly follow POSIX).

Does building with:

  make NO_INTTYPES_H=YesPlease

work?

If so, then perhaps it should be added to the AIX defines in
config.mak.uname.

> The problem is, in this case, CC_LD_DYNPATH is set to an empty value---
> which is incorrect, in light of how it is used in the Makefile. Here is
> a typical example:
> 
>     ifdef ZLIB_PATH
>             BASIC_CFLAGS += -I$(ZLIB_PATH)/include
>             EXTLIBS += -L$(ZLIB_PATH)/$(lib) $(CC_LD_DYNPATH)$(ZLIB_PATH)/$(lib)
>     endif
>     EXTLIBS += -lz
> 
> Setting that variable to an empty value causes a bare directory to be
> passed to the linker, which of course then errors out. I would suggest
> setting it to "-L" instead.

That would just be redundant with the earlier argument. That might be
the easiest way to turn it into a noop, but we can probably do better
with $(if) or similar, which would allow somebody to build with:

  make CC_LD_DYNPATH=

even without using the autoconf script.

I do wonder, though, if configure.ac could be extended for AIX to
support whatever syntax the system linker uses for setting the run-path.
I understand that you don't care either way about this feature, but this
might be a good opportunity to fix it.

-Peff

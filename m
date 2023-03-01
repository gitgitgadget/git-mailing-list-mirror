Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C727C7EE23
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 19:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjCATwS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 14:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCATwR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 14:52:17 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3DD13D67
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 11:52:16 -0800 (PST)
Received: (qmail 12009 invoked by uid 109); 1 Mar 2023 19:52:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Mar 2023 19:52:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8709 invoked by uid 111); 1 Mar 2023 19:52:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Mar 2023 14:52:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Mar 2023 14:52:15 -0500
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: t3206-range-diff failures on non x86 arches (was: [ANNOUNCE] Git
 v2.40.0-rc1)
Message-ID: <Y/+s7yeWYUYu0SQ+@coredump.intra.peff.net>
References: <xmqqilfknzen.fsf@gitster.g>
 <Y/+paI8WGSmEbv/w@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/+paI8WGSmEbv/w@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 01, 2023 at 02:37:12PM -0500, Todd Zullinger wrote:

> Here's a snipptet from the test summary and a common failure
> from the tests:
> 
> t3206-range-diff.sh                              (Wstat: 256 (exited 1) Tests: 42 Failed: 23)
>   Failed tests:  2-4, 6, 8-19, 21-22, 32-34, 40, 42
> 
> +++ diff -u expect actual
> --- expect	2023-03-01 18:23:20.689515509 +0000
> +++ actual	2023-03-01 18:23:20.679515420 +0000
> @@ -1,4 +1,4 @@
> -1:  4de457d = 1:  35b9b25 s/5/A/
> -2:  fccce22 = 2:  de345ab s/4/A/
> -3:  147e64e = 3:  9af6654 s/11/B/
> -4:  a63e992 = 4:  2901f77 s/12/B/
> +1:  4de457d2c0d218f48d66f45f9b30f3aa62562105 = 1:  35b9b25f76d404d09a23e6c8efa96c3ce19e19aa s/5/A/
> +2:  fccce22f8c95220a7283f047ecc6f042a54ad902 = 2:  de345ab3de2b56a1e208e46197bb77829a6e1f3a s/4/A/
> +3:  147e64ef5365f843f378dcfd60c4b8115146a35a = 3:  9af6654000a6c3235196f874c6fa58c970fcf233 s/11/B/
> +4:  a63e992599e14e34a5664fe3f213fa8ad8977fe1 = 4:  2901f773f3f322646e189b37ffe99a47ad6d456a s/12/B/
> error: last command exited with $?=1
> not ok 2 - simple A..B A..C (unmodified)

So it looks like there's a problem with oid shortening...

> Without bistecting, I'm guessing this is likely to be
> related to this change?
> 
> >  * sscanf(3) used in "git symbolic-ref --short" implementation found
> >    to be not working reliably on macOS in UTF-8 locales.  Rewrite the
> >    code to avoid sscanf() altogether to work it around.
> >    (merge 613bef56b8 jk/shorten-unambiguous-ref-wo-sscanf later to maint).

...but this topic is about ref shortening ("refs/heads/foo" to "foo").
Which doesn't absolve it, but I'm not sure how it would be related.

> If it's not somewhat obvious to others, I can try to dig
> more out of the build output later today.

Seems like 2b15969f61 (range-diff: let '--abbrev' option takes effect,
2023-02-20) is a more likely area to poke at. Given the architecture
dependence, perhaps d9165bef58 (range-diff: avoid compiler warning when
char is unsigned, 2023-02-28) would help?

It's in 'next' but not -rc1.

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1208BC677F1
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 17:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbjAPRhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 12:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbjAPRgo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 12:36:44 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C753F2AA
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 09:13:19 -0800 (PST)
Received: (qmail 15219 invoked by uid 109); 16 Jan 2023 17:13:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Jan 2023 17:13:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31669 invoked by uid 111); 16 Jan 2023 17:13:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Jan 2023 12:13:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Jan 2023 12:13:14 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniel Stenberg <daniel@haxx.se>,
        Patrick Monnerat <patrick@monnerat.net>, git@vger.kernel.org
Subject: Re: [PATCH] ci: do not die on deprecated-declarations warning
Message-ID: <Y8WFqjvMRLqfFT5G@coredump.intra.peff.net>
References: <xmqqv8l9n5fj.fsf@gitster.g>
 <Y8LCsxz8gyTCxFUp@coredump.intra.peff.net>
 <6d826cd9-e447-8df9-83b9-8deb32d6063d@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d826cd9-e447-8df9-83b9-8deb32d6063d@ramsayjones.plus.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2023 at 12:39:39AM +0000, Ramsay Jones wrote:

> > By the way, it seemed odd to me that this failed in just the linux-musl
> > job, and not elsewhere (nor on my development machine, which has curl
> > 7.87.0). It looks like there's a bad interaction within curl between the
> > typecheck and deprecation macros. Here's a minimal reproduction:
> > 
> > -- >8 --
> > cat >foo.c <<-\EOF
> > #include <curl/curl.h>
> > void foo(CURL *c)
> > {
> > 	curl_easy_setopt(c, CURLOPT_PROTOCOLS, 0);
> > }
> > EOF
> > 
> > # this will complain about deprecated CURLOPT_PROTOCOLS
> > gcc -DCURL_DISABLE_TYPECHECK -Wdeprecated-declarations -c foo.c
> > 
> > # this will not
> > gcc -Wdeprecated-declarations -c foo.c
> > -- 8< --
> 
> FYI, I just tried this on cygwin and both gcc invocations above
> complain about deprecated CURLOPT_PROTOCOLS. (On Linux I have
> curl 7.81.0, so I can't test there).

It did work on Linux for me, of course, using 7.87.0. But curiously this
morning it behaved differently!

In the meantime, Debian's libcurl packaging picked up this upstream
patch (and I upgraded):

  https://github.com/curl/curl/commit/e2aed004302e51cfa5b6ce8c8ab65ef92aa83196

and now the deprecation warning happens consistently. So I think on the
curl side there is nothing left to do.

-Peff

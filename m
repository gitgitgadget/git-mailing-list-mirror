Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AC5C3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 14:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjANO4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 09:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjANO4x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 09:56:53 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A99A5B90
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 06:56:52 -0800 (PST)
Received: (qmail 29676 invoked by uid 109); 14 Jan 2023 14:56:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 14 Jan 2023 14:56:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10449 invoked by uid 111); 14 Jan 2023 14:56:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Jan 2023 09:56:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 14 Jan 2023 09:56:51 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Daniel Stenberg <daniel@haxx.se>,
        Patrick Monnerat <patrick@monnerat.net>, git@vger.kernel.org
Subject: Re: [PATCH] ci: do not die on deprecated-declarations warning
Message-ID: <Y8LCsxz8gyTCxFUp@coredump.intra.peff.net>
References: <xmqqv8l9n5fj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8l9n5fj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2023 at 07:47:12PM -0800, Junio C Hamano wrote:

> Like a recent GitHub CI run on linux-musl [1] shows, we seem to be
> getting a bunch of errors of the form:
> 
>   Error: http.c:1002:9: 'CURLOPT_REDIR_PROTOCOLS' is deprecated:
>   since 7.85.0. Use CURLOPT_REDIR_PROTOCOLS_STR
>   [-Werror=deprecated-declarations]

By the way, it seemed odd to me that this failed in just the linux-musl
job, and not elsewhere (nor on my development machine, which has curl
7.87.0). It looks like there's a bad interaction within curl between the
typecheck and deprecation macros. Here's a minimal reproduction:

-- >8 --
cat >foo.c <<-\EOF
#include <curl/curl.h>
void foo(CURL *c)
{
	curl_easy_setopt(c, CURLOPT_PROTOCOLS, 0);
}
EOF

# this will complain about deprecated CURLOPT_PROTOCOLS
gcc -DCURL_DISABLE_TYPECHECK -Wdeprecated-declarations -c foo.c

# this will not
gcc -Wdeprecated-declarations -c foo.c
-- 8< --

I didn't look into why the musl build behaves differently, but
presumably it has an older compiler or something that causes curl to
decide not to trigger the typecheck macros.

Adding relevant curl folks to the cc (the curl list itself is
subscriber-only).

-Peff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD63C3DA78
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 00:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjAPAjt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 19:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjAPAjp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 19:39:45 -0500
Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C5B6A41
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 16:39:43 -0800 (PST)
Received: from [10.0.2.15] ([147.147.167.102])
        by smtp with ESMTPA
        id HDXHpLriYwyIMHDXIpZNaP; Mon, 16 Jan 2023 00:39:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1673829581; bh=lV3RC8OD2JcXmVr5tqroyIxQU7gEHhwDdXTyIx4tnms=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=r+omF6WclMTbRqqL6e/FOSpRCx+y0F61M9vVAEDorrKmzEKy10v+WVmTsRXpU6Ug7
         e7stUddy2aEOKY4Wry4BN16MHaem00zmXILe8F1Gycdb2X94PxczdzmMJmCfq+s00t
         qwUeNujMemdgiDE/E2txgm7ysbNoH43SkVk2AF2Ugm8Rr+Va0xmkljyYHqQIvjUdZv
         ksDomvSXuJ0b1Rnz7Rhi0xzJXVzvUao9NkapKig0COb3Jcc2tYQNSRB/k6Y6cZs+JG
         VBy/kA1OA4zy7sExdbaXOEtTEM9oXToDzdXVLYCqnSWU57nw8MSfioxk4qxRBEPYVT
         zV308DbfbqZHA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=R88QpPdX c=1 sm=1 tr=0 ts=63c49ccd
 a=O4HnXJxpn4bBnFCb4s/IkQ==:117 a=O4HnXJxpn4bBnFCb4s/IkQ==:17
 a=IkcTkHD0fZMA:10 a=Vd9uQxaCwe-hRqQ8iMAA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <6d826cd9-e447-8df9-83b9-8deb32d6063d@ramsayjones.plus.com>
Date:   Mon, 16 Jan 2023 00:39:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ci: do not die on deprecated-declarations warning
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Daniel Stenberg <daniel@haxx.se>,
        Patrick Monnerat <patrick@monnerat.net>, git@vger.kernel.org
References: <xmqqv8l9n5fj.fsf@gitster.g>
 <Y8LCsxz8gyTCxFUp@coredump.intra.peff.net>
Content-Language: en-GB
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Y8LCsxz8gyTCxFUp@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKpwAZDvW/lCgzT3EG85PFBFDdbmfV7nJfCrBqvdYxJYs+IRdYwy1IkDnphf8X30Hq00bis7DE4A9Ltvyo5lK9RI3ufL6VV5BoisACTS5/pIVg8tJMKh
 G5x7x4Lp6a4OqV5OvJJKZGRb/AvhV9UZO+swq6AGe4+/ZjbYAPy8a0iyDABnWvngwC6eKwxKRHamKIJPNw9QGoPHIL3kHg1RkGA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/01/2023 14:56, Jeff King wrote:
> On Fri, Jan 13, 2023 at 07:47:12PM -0800, Junio C Hamano wrote:
> 
>> Like a recent GitHub CI run on linux-musl [1] shows, we seem to be
>> getting a bunch of errors of the form:
>>
>>   Error: http.c:1002:9: 'CURLOPT_REDIR_PROTOCOLS' is deprecated:
>>   since 7.85.0. Use CURLOPT_REDIR_PROTOCOLS_STR
>>   [-Werror=deprecated-declarations]
> 
> By the way, it seemed odd to me that this failed in just the linux-musl
> job, and not elsewhere (nor on my development machine, which has curl
> 7.87.0). It looks like there's a bad interaction within curl between the
> typecheck and deprecation macros. Here's a minimal reproduction:
> 
> -- >8 --
> cat >foo.c <<-\EOF
> #include <curl/curl.h>
> void foo(CURL *c)
> {
> 	curl_easy_setopt(c, CURLOPT_PROTOCOLS, 0);
> }
> EOF
> 
> # this will complain about deprecated CURLOPT_PROTOCOLS
> gcc -DCURL_DISABLE_TYPECHECK -Wdeprecated-declarations -c foo.c
> 
> # this will not
> gcc -Wdeprecated-declarations -c foo.c
> -- 8< --

FYI, I just tried this on cygwin and both gcc invocations above
complain about deprecated CURLOPT_PROTOCOLS. (On Linux I have
curl 7.81.0, so I can't test there).

[cygwin uses newlib, of course].

ATB,
Ramsay Jones


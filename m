Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A31DCE7A8A
	for <git@archiver.kernel.org>; Sun, 24 Sep 2023 03:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjIXDgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 23:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjIXDgj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 23:36:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D4910A
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 20:36:27 -0700 (PDT)
Received: (qmail 17345 invoked by uid 109); 24 Sep 2023 03:36:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 24 Sep 2023 03:36:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32642 invoked by uid 111); 24 Sep 2023 03:36:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 23 Sep 2023 23:36:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 23 Sep 2023 23:36:25 -0400
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Michael Strawbridge <michael.strawbridge@amd.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [REGRESSION] uninitialized value $address in git send-email when
 given multiple recipients separated by commas
Message-ID: <20230924033625.GA1492190@coredump.intra.peff.net>
References: <ZQ1eGzqfyoeeTBUq@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZQ1eGzqfyoeeTBUq@debian.me>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 04:27:55PM +0700, Bagas Sanjaya wrote:

> To reproduce this regression:

I couldn't reproduce the problem here.

I had to modify your instructions slightly:

> 1. Clone git.git repo, then branch off:
> 
>    ```
>    $ git clone https://github.com/git/git.git && cd git
>    $ git checkout -b test
>    ```
> 
> 2. Make two dummy signed-off commits:
> 
>    ```
>    $ echo test > test && git add test && git commit -s -m "test"
>    $ echo "test test" >> test && git commit -a -s -m "test test"
>    ```

This all worked.

> 3. Generate patch series:
> 
>    ```
>    $ mkdir /tmp/test
>    $ git format-patch -o /tmp/test --cover-letter main
>    ```

This should be s/main/master/, since the git.git repo from step 1 does
not have a "main" branch.

> 4. Send the series to dummy address:
> 
>    ```
>    $ git send-email --to="foo <foo@acme.com>,bar <bar@acme.com>" /tmp/test/*.patch
>    ```

This did not produce an error for me. I switched out acme.com for some
addresses I control, and confirmed that the mail was all delivered fine.

Your report also mentions a validation hook, so I tried installing one
like:

	cat >.git/hooks/sendemail-validate <<-\EOF
	#!/bin/sh
	echo >&2 running validate hook
	exit 0
	EOF
	chmod +x .git/hooks/sendemail-validate

and confirmed that the hook runs (three times, as expected). But still
no error. I'm using v2.41.0 to test against.

-Peff

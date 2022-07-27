Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE62C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 19:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbiG0TV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 15:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiG0TVf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 15:21:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF6438C
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 12:18:18 -0700 (PDT)
Received: (qmail 9080 invoked by uid 109); 27 Jul 2022 19:18:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Jul 2022 19:18:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2539 invoked by uid 111); 27 Jul 2022 19:18:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Jul 2022 15:18:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Jul 2022 15:18:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] CI: add SANITIZE=[address|undefined] jobs
Message-ID: <YuGPeHn9wfF6tWA5@coredump.intra.peff.net>
References: <patch-1.1-e48b6853dd5-20220726T110716Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-e48b6853dd5-20220726T110716Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 26, 2022 at 01:09:13PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Per [2] the GitHub fork of git.git runs with these in CI, so it's
> already useful to some forks of this repository.

Yeah, it has been helpful there and I think this is worth doing as part
of our CI. It's a lot of CPU versus running the test suite once on
Linux, but probably not compared to the overall cost of our current CI.

For the GitHub fork, the code-coverage issues you noticed were easy: we
only built one variant, so we could just test with those knobs. ;) But I
tend to agree with your approach here to just test on one platform,
which covers _most_ of the code. It's certainly better than the status
quo, and it strikes a nice balance of CPU versus coverage.

One thing I'd say...

> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index cd1f52692a5..4f59a7aa44c 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -251,6 +251,12 @@ jobs:
>            - jobname: linux-leaks
>              cc: gcc
>              pool: ubuntu-latest
> +          - jobname: SANITIZE=address
> +            cc: gcc
> +            pool: ubuntu-latest
> +          - jobname: SANITIZE=undefined
> +            cc: gcc
> +            pool: ubuntu-latest

There's really no reason to split the "address" and "undefined" builds
into two jobs. We expect them to pass, and if one fails, having the
results split is not likely to give any extra information. So I think
one job with SANITIZE=address,undefined is fine, and reclaims some of
the extra CPU we're spending.

-Peff

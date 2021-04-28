Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5266FC433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 16:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DAC86143A
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 16:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbhD1Q4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 12:56:31 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:37429 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhD1Q4a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 12:56:30 -0400
Received: by mail-ed1-f44.google.com with SMTP id s15so75144533edd.4
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 09:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SUQKhCUsxopc0BIPQp5kwz5KZv48wYA7H1VFSKyQVcs=;
        b=mf7rWYotTNJ3juLuIrBat/bcsV/scmGPdw9HaNXXfMcAZmO/VUC2fNke0LzA9PZHLw
         UVG2y3UPR+b2wDynqjJTauz6xk5Z2mwgnJ/sjjKj4/zGx1qt2xxwwrHMWKrUhvovDghN
         uNLonfla6HTvGXOKZ5bqMGS+Pr3XxbNYb6UWM/MzoudjI/yHE0/5dIWs12Co0SK4hvwt
         fEatA+YFR0rrU74f8CV9rJlynzSlcUVqH041JGxxNFF+zXULc9PhU3bONro1c+eUNHMC
         H/za7DddfI/DB3/vKnGkYggXP482Yeau7B7gtWIqYQ841BpA9SzwNR8fRmhJjcvJOx2H
         xDSw==
X-Gm-Message-State: AOAM53167Hgwk/7HoFuvG24Uzthg5kyT77aijPXT5ARrVA9WRemuU5si
        1XmX3jVSj5pfQWQBC1G52nUcWOx+LG4S/04AeZHkykoi6+4=
X-Google-Smtp-Source: ABdhPJyLnvAG9r3rAqrm3ZRBvhYt2wuFubgAie+Ca2qZ88nNNbJd6Zw7zLD9XMmlXYpgc8GbXjohzoJZVVVsKSKD+ro=
X-Received: by 2002:a05:6402:488:: with SMTP id k8mr12559591edv.233.1619628944504;
 Wed, 28 Apr 2021 09:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210428113805.109528-1-bagasdotme@gmail.com>
In-Reply-To: <20210428113805.109528-1-bagasdotme@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Apr 2021 12:55:33 -0400
Message-ID: <CAPig+cSNWdUmPCQiErm41fzvDFRdegfkExUveYYN61Mrj_X2gQ@mail.gmail.com>
Subject: Re: [PATCH v3] t6030: add test for git bisect skip started with
 --term* arguments
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Trygve Aaberge <trygveaa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 28, 2021 at 7:39 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> Trygve Aaberge reported git bisect breakage when the bisection
> is started with --term* arguments (--term-new and --term-old).
>
> For example, suppose that we have repository with 10 commits, and we
> start the bisection from HEAD to first commit (HEAD~9) with:
>
>   $ git bisect start --term-new=fixed --term-old=unfixed HEAD HEAD~9
>
> The bisection then stopped at HEAD~5 (fifth commit), and we choose
> to skip (git bisect skip). The HEAD should now at HEAD~4 (sixth commit).
> In the breakage, however, the HEAD after skipping stayed at HEAD~5
> (not changed).
>
> The breakage is caused by forgetting to read '.git/BISECT_TERMS' during
> implementation of `'bisect skip' subcommand in C.
>
> Let's add the test to catch the breakage. Now that the corresponding
> fix had been integrated, flip the switch to test_expect_success.

The final sentence about flipping the switch should probably be
dropped since this patch now introduces the new test in its "success"
state.

> Reported-by: Trygve Aaberge <trygveaa@gmail.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>
>  Changes from v2 [1]:
>    * remove double quotes inside test name
>    * double-quote HASH_SKIPPED_FROM and HASH_SKIPPED_TO in the
>      test comparison line
>    * rename test name to be simpler
>    * commit message now includes proper explanation why git bisect skip
>      is currently broken
>    * because the fix to the breakage had just been landed on seen, flip
>      the switch to test_expect_success.

Here in the patch commentary, it does indeed make sense to mention
that you flipped the state from "failure" to "success" between
iterations of the patch.

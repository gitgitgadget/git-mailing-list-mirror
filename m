Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 917561F453
	for <e@80x24.org>; Thu, 25 Apr 2019 22:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfDYWeU (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 18:34:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37282 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfDYWeU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 18:34:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id y5so460733wma.2
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 15:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NP/0O0PHZiv5nn4f67BkdRTOee4UkSev35iXGdaWJ2M=;
        b=LVIBB1dydLUDBJi4BvwbchiAn1Rhz32PpDPL7w54kg2yAf7u88TRKO7xL4gCMHeI8i
         4C1CwpHfSP1Urk8u8USZwxPxwAC03pOMrYivbrD2etKrwduQyAKIpebJvXtd5vU3OM4R
         cI2d5GNzaI5Bosn7BPMscBRPa7uBNksfdNrkNFUjP7cXpWF9ujlgR022lMNfS1kpnDq+
         29wvHx1+XpEym0kVwZfEoYfqGfNzk2jtjdch/We+pkYhOw5FsGzAwhyW3MO0cgXwu3Pb
         aciJ+TNXs+sMPQp01lUwn1vnE8nwpg4ijMPQbIjpJE5YIP+mtFM41ewBNvcdd0aIgbfQ
         2V+g==
X-Gm-Message-State: APjAAAWzjkb2pft4DxHboKClDw8IZXHgVsVD4vhUed082+UDgLTKHIVL
        LyQyLB3lE13IhCDjvjnF8JVy9XMBhHA2aQa6HxA=
X-Google-Smtp-Source: APXvYqyCQIFqUNYsJCh8ph0orU2zaAnxW3yaHh1O+RaR8oz4qzFmpiqp54LcRMLhO0Ah+4L1eV1y/BAqd4wjVBhNSD0=
X-Received: by 2002:a1c:5543:: with SMTP id j64mr5194102wmb.37.1556231658348;
 Thu, 25 Apr 2019 15:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556226502.git.liu.denton@gmail.com> <c0c7171e3d523e5d4a0ac01810378447a38854da.1556226502.git.liu.denton@gmail.com>
In-Reply-To: <c0c7171e3d523e5d4a0ac01810378447a38854da.1556226502.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 25 Apr 2019 18:34:07 -0400
Message-ID: <CAPig+cTdJv9-M+zmp+Jo2bjOrkO3NgsguJ2xM+aXhf38OjjEEw@mail.gmail.com>
Subject: Re: [PATCH 1/3] t2018: cleanup in current test
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 5:10 PM Denton Liu <liu.denton@gmail.com> wrote:
> Before, in t2018, if do_checkout failed to create `branch2`, the next
> test-case would run `git branch -D branch2` but then fail because it was
> expecting `branch2` to exist, even though it doesn't. As a result, an
> early failure could cause a cascading failure of tests.
>
> Make test-case responsible for cleaning up their own branches so that
> future tests can start with a sane environment.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
> @@ -60,38 +60,36 @@ test_expect_success 'setup' '
>  test_expect_success 'checkout -b to a new branch, set to HEAD' '
> +       test_when_finished test_might_fail git branch -D branch2 &&
> +       test_when_finished git checkout branch1 &&

I'm aware that when-finished actions fire in reverse order but the
inherent subtlety of ordering of these two invocations still caught me
off-guard for a moment since they are reverse the order in which one
logically thinks about the actions which need to be performed. I
wonder if it would be easier to digest if written like this:

    test_when_finished '
        git checkout branch1 &&
        test_might_fail git branch -D branch2
    ' &&

(Probably not worth a re-roll.)

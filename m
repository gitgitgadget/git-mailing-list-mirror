Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 866011F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 23:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441800AbfJQXl5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 19:41:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42785 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438582AbfJQXl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 19:41:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id n14so4193163wrw.9
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q6zGV+hryIyus7fG5wdvW1VsyVxqgqvrBliTf3nplAE=;
        b=ImKOFjHkVF6VdIOJHiMwRzqhr2nUcLN5DdRnmm2+bNzNHMLK39fKl7XfqP2kQgYQ/p
         Oh1TJYSNHxMHpPUP+EMCRA3lnNoRJfx1LgBtiMTv0AxaX3k4iXrJYohvnwAKlkOTzIpn
         TKseO4eatUk4Hf2l4dA9yIg81Ul8a5SPXix1ouZYvZU7AdlIRKHLHUecsxKH6KemAcIP
         YyE1k4JzjmDxN6vwN4ogXolLBNyVpTvr3S/a8PWB4OGxmQeuflYC77DerAUYcqPrSXVg
         EetKzHH5nonCXiZiNdqhDR69HEzV+RcaUqw0Ws5UbBp4TSYnQgTaBPmMRx4eQLrN5YU0
         O9Vg==
X-Gm-Message-State: APjAAAVJwOr46vgyTqB5+MpWdd3Hiu927NrR+z2vJOvAMiHspzMJyA0D
        WPsrUtwrDDUen1pgF3cZzqu0P14bf5fh5rkZTPMih/S5
X-Google-Smtp-Source: APXvYqxEEfJvBQaXSgnJ3LZLf8sEE/TSu+axQM0bcWfQYyh4u5qSNreBjJsIsXpeVXGe0DLI2tMWHRCdmAzOkpITfeQ=
X-Received: by 2002:adf:f010:: with SMTP id j16mr5224488wro.317.1571355715197;
 Thu, 17 Oct 2019 16:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571354136.git.liu.denton@gmail.com> <ff05a0a8f7dc91d988e290b7d606e8a64f5daf54.1571354136.git.liu.denton@gmail.com>
In-Reply-To: <ff05a0a8f7dc91d988e290b7d606e8a64f5daf54.1571354136.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 17 Oct 2019 19:41:44 -0400
Message-ID: <CAPig+cRF0taNhmZVu0z+P+Oe3em11Jz33GY8eBZRTGkx3z=TOw@mail.gmail.com>
Subject: Re: [PATCH 08/12] t5520: use test_cmp_rev where possible
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 7:17 PM Denton Liu <liu.denton@gmail.com> wrote:
> In case an invocation of `git rev-list` fails within the subshell, the
> failure will be masked. Remove the subshell and use test_cmp_rev() so
> that failures can be discovered.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> @@ -597,10 +597,10 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
>         test_must_fail git pull &&
> -       test "$COPY" = "$(git rev-parse --verify me/copy)" &&
> +       test_cmp_rev "$COPY" me/copy &&

This transformation doesn't look correct. COPY already holds the
result of a git-rev-parse invocation:

    COPY="$(git rev-parse --verify me/copy)" &&

so passing it to test_cmp_rev() -- which applies its own git-rev-parse
invocation -- doesn't make sense.

>         git checkout HEAD -- file &&
>         git pull &&
> -       test "$COPY" != "$(git rev-parse --verify me/copy)"
> +       test_must_fail test_cmp_rev "$COPY" me/copy

As mentioned in my review of the other patch, this is not a valid use
of test_must_fail().

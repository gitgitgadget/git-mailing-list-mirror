Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0FD01F461
	for <e@80x24.org>; Wed, 28 Aug 2019 21:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfH1VKq (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 17:10:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53320 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1VKq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 17:10:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id 10so1488574wmp.3
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 14:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vN0yWC/SMVlWXlPugILv2WKpc0JRt/5CWhgP0YK06Ek=;
        b=pn/66MaPv7kKPatMDQj1GXh/sFx36d6RsvMLXNBaFpcX3UU7kC85EMnkJyumYT4Lr6
         Dr+6IYU3jWG4bV3xxAIU/v3GATorkIs1yK6GQp9x10E+of8QEU6bmE+hqFz1ANV51wJI
         5VlD/pkQOlMH9crFbaVZI+Y0crCRvaUkEazSBTNNud2Rq2+87kb4Tby61sT8er/knQIX
         yrGXpKMj/3kTXfzd3zzY2KF3TK3ZijEbKyfCtaCiS4Mwo0Nutkl3ikWWraL5ho400tOu
         QUlyJRlUfX85KaU1KeqDADmhcTQ/zwvhVhXKh/BnXdFRkHRYTLDKqRtwPGqrvvhCG+bQ
         UUFQ==
X-Gm-Message-State: APjAAAXdJ5WdSgyPGShjqBpP3/HdkwgsgEm9i8Xw4+e6pwxx6teobgfB
        X5wuM0794VkvGz6s3Z26VhzUeTe/9GzxQaeB/inLWguc
X-Google-Smtp-Source: APXvYqwn5X6XIETuN6oht4tCtXmCUcwNHJrkuok4ODy1tHDSLjUDC7woxj7kEeRjkfiPmahRxoVfPr8tpnsm2xw9Dgs=
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr7266230wma.53.1567026644429;
 Wed, 28 Aug 2019 14:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190828201824.1255-1-jon@jonsimons.org> <20190828201824.1255-2-jon@jonsimons.org>
In-Reply-To: <20190828201824.1255-2-jon@jonsimons.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Aug 2019 17:10:33 -0400
Message-ID: <CAPig+cQeco6-aM+UrJsbj9LXtWSe4hXn0vbrBWwVn00cbDpbzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] list-objects-filter: only parse sparse OID when 'have_git_dir'
To:     Jon Simons <jon@jonsimons.org>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 28, 2019 at 4:27 PM Jon Simons <jon@jonsimons.org> wrote:
> Fix a bug in partial cloning with sparse filters by ensuring to check
> for 'have_git_dir' before attempting to resolve the sparse filter OID.
> [...]
> Signed-off-by: Jon Simons <jon@jonsimons.org>
> ---
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> @@ -241,6 +241,29 @@ test_expect_success 'fetch what is specified on CLI even if already promised' '
> +test_expect_success 'setup src repo for sparse filter' '
> +       git init sparse-src &&
> +       git -C sparse-src config --local uploadpack.allowfilter 1 &&
> +       git -C sparse-src config --local uploadpack.allowanysha1inwant 1 &&
> +       for n in 1 2 3 4
> +       do
> +               test_commit -C sparse-src "this-is-file-$n" file.$n.txt
> +       done &&

The way this is coded, a failure of the test_commit() invocation won't
fail the test overall. You need to do so manually:

    for n in 1 2 3 4
    do
        test_commit -C sparse-src "this-is-file-$n" file.$n.txt || return 1
    done &&

> +       echo "/file.1.txt" >> sparse-src/odd-files &&
> +       echo "/file.3.txt" >> sparse-src/odd-files &&
> +       echo "/file.2.txt" >> sparse-src/even-files &&
> +       echo "/file.4.txt" >> sparse-src/even-files &&

Simpler:

    test_write_lines /file1.txt /file3.txt >sparse-src/odd-files &&
    test_write_lines /file2.txt /file4.txt >sparse-src/even-files &&

> +       echo "/*" >> sparse-src/all-files &&

Style nit: drop whitespace following redirection operator.

And, using >> rather than just > here makes the test more confusing
than it need be; probably best to use >.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF516C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 16:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5ABE61449
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 16:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241789AbhDUQzr convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 21 Apr 2021 12:55:47 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:44858 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241630AbhDUQzq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 12:55:46 -0400
Received: by mail-ej1-f49.google.com with SMTP id r20so14760297ejo.11
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 09:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iX5DhgkcQwpvdKyIHEuh9XgoDOWqzP/P0iH5UjCmSXk=;
        b=gTCmRhsG4Ef9jUAwrHD23fC2sMnABqoCHr2EOCStXBC6JLXsNul4IQxRVealvW5DAe
         IQyojxEnJLBU4qJBV14zJ/QhSsA0RoNqEhTm/H0JhMi3VOjE1M9a/gLUIo2WReyxd8qq
         S2SeY26Fm7iMTvQWdQERSlyGI2W/Trt3oa/3PxLZSseVk0Pl8rpM0Jysl5RJ7jIOnaLP
         kPrFM0oDAz4MGba2DsSYIhnTLqIBSY1X9ijTQEgR4vr1yMCzpYA+VqQLYydxgZQEqQ+q
         xxm20w4BKha8qoAejR/xd0Tcz4Gn513fGhyYm8osMsWR5QAD9GRyg+JFJPLSwW05u15H
         t0mA==
X-Gm-Message-State: AOAM530JeXhmMUBEc4k/Gi9ACX4rd1uTA6iy52ZA+Kan5xRvUf8MqXoD
        JcG1ZFn1xzoKzlAkV9OCxPhdgkZpCC9mxNXolfA9VYEdODL+Aw==
X-Google-Smtp-Source: ABdhPJxpJ+6dmm7Hg12T8ZyZvoMuwU3GGtG+HBnIqAhJc0DHIX7lGCTYSiqojNgK8fQp9XnF4oY8+jpXw3F4/v/npM0=
X-Received: by 2002:a17:907:3a98:: with SMTP id fh24mr34192892ejc.371.1619024112484;
 Wed, 21 Apr 2021 09:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <YIAAzJTG1UitiWyu@danh.dev> <20210421104102.3409-1-congdanhqx@gmail.com>
 <20210421104102.3409-2-congdanhqx@gmail.com>
In-Reply-To: <20210421104102.3409-2-congdanhqx@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 21 Apr 2021 12:55:01 -0400
Message-ID: <CAPig+cSh6VNpWbGPpTqY0rmw7zf9s-kSXSOMYvW94UHOF7t80w@mail.gmail.com>
Subject: Re: [PATCH 2/2] t6402: check exit status of ls-files
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 6:41 AM Đoàn Trần Công Danh
<congdanhqx@gmail.com> wrote:
> We will lose the exit status of "git ls-files" if it's being run in
> anywhere-but-not-final part of a pipe.
>
> Let's send the output of "git ls-files" to a file first,
> and adjust the expected result for "git ls-files -o" since a new
> untracked file will be created as a side effect.
>
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
> diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
> @@ -631,20 +663,33 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
> -               test 5 -eq "$(git ls-files -s | wc -l)" &&
> -               test 3 -eq "$(git ls-files -u | wc -l)" &&
> -               test 1 -eq "$(git ls-files -u one~HEAD | wc -l)" &&
> +               git ls-files -s >output &&
> +               test_line_count = 5 output &&
> +               git ls-files -u >output &&
> +               test_line_count = 3 output &&
> +               git ls-files -u one~HEAD >output &&
> +               test_line_count = 1 output &&

This idiom crops up so frequently in this test script that it almost
begs for the introduction of a helper function rather than applying
the manual transformation repeatedly. For instance, the helper might
be called like this:

    count_ls_files 5 -s &&
    count_ls_files 3 -u &&
    count_ls_files 1 -u one~HEAD &&
    ...

The nice thing about having a helper function is that it can clean up
after itself by not leaving a new file lying around, thus you wouldn't
have to make adjustments to the expected number of untracked files (as
mentioned in the commit message). If this is the sort of thing which
comes up often enough (if there are more such cases beyond the two
scripts you changed in this series), then it might make sense to
promote the helper function to test-lib-functions.sh.

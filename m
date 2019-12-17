Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D110EC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 19:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A878620716
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 19:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfLQTyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:54:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56222 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfLQTyt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 14:54:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so4151558wmj.5
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 11:54:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YjcAi3nh88drtk50C1gnPXqqUC47TYGJGQHIVkNzouI=;
        b=oz1Q9mOW2/cZw0aBs9wxY+hf0ZoZIQ+cAaXCaKYVe9KCRKSz9fX4hD2TRQJhj9VR3N
         loPRnnj/f0n3QAz+v/St5u64wPHNgT74zAfSsg2eFDtEIEoj2yZTMJZsTvaC6gmbNIj7
         K9BZ5uvLtKRbD8hE6ATv0hXSxdpuP8wrF01zRzweHDJC/6A658RQd/fyai/IT1pgVFyL
         +Mz+PsqwrEFVLsJud0OUjPXwZtZwFwsIv2jNZUXjlyS4X2p7DzdN3r4NYKuJKtkUUklR
         ovfnFnbPZcn1XFwpQehQqXhm2dPnuQq7qTUPffNn5VfG0LDRrMeC/GiRQZG3xXLCRC/A
         aSxQ==
X-Gm-Message-State: APjAAAX9C60BDRuXkv7Dt3uqiFHCJzK5qozmobkfRBTWq5DhoYdLH0Lr
        KbpIYBZzR3AyG8nKz+Wb4pSXIxF69XBtvkIhBhMFut/xokc=
X-Google-Smtp-Source: APXvYqyg1Y7AYSeDo2dC4x0/qqnVrjf6un3r0rGlrjEgKHaUFlQlL5e9k0JPmGo2lk5o8S0ZAe0hW1bEB8H7rOHsfOE=
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr7755829wml.55.1576612457682;
 Tue, 17 Dec 2019 11:54:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576583819.git.liu.denton@gmail.com> <cd392a74acb1bc7f3b09f167278afd5959a21fca.1576583819.git.liu.denton@gmail.com>
In-Reply-To: <cd392a74acb1bc7f3b09f167278afd5959a21fca.1576583819.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Dec 2019 14:54:06 -0500
Message-ID: <CAPig+cQiNpgEURfNr91V=j2mk6Y3c28NPgKj9NigU3XFRS=ZbA@mail.gmail.com>
Subject: Re: [PATCH 15/15] t1507: teach full_name() to accept `!` arg
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 17, 2019 at 7:02 AM Denton Liu <liu.denton@gmail.com> wrote:
> Before, we were running `test_must_fail full_name`. However,
> `test_must_fail` should only be used on git commands. Teach full_name()
> to accept `!` as a potential first argument which will prepend
> `test_must_fail` to the enclosed git command. This increases the
> granularity of test_must_fail since it no longer runs on the `cd` as
> well.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
> @@ -29,8 +29,14 @@ test_expect_success 'setup' '
>  full_name () {
> +       fail= &&
> +       if test "x$1" = 'x!'
> +       then
> +               fail=test_must_fail &&
> +               shift
> +       fi &&
>         (cd clone &&
> -        git rev-parse --symbolic-full-name "$@")
> +        $fail git rev-parse --symbolic-full-name "$@")
>  }

Yuck. These days this is entirely unnecessary. My suggestion is to
drop the full_name() function altogether and just invoke git-rev-parse
directly at the (few) call sites, taking advantage of the fact that we
now have -C. So...

> @@ -79,7 +85,7 @@ test_expect_success 'upstream of branch with @ at end' '
>  test_expect_success 'refs/heads/my-side@{upstream} does not resolve to my-side{upstream}' '
> -       test_must_fail full_name refs/heads/my-side@{upstream}
> +       full_name ! refs/heads/my-side@{upstream}
>  '

This just becomes:

    test_must_fail git -C clone rev-parse --symbolic-full-name
refs/heads/my-side@{upstream}

Similarly for the other call sites.

> @@ -91,9 +97,9 @@ test_expect_success 'my-side@{u} resolves to correct commit' '
>  test_expect_success 'not-tracking@{u} fails' '
> -       test_must_fail full_name non-tracking@{u} &&
> +       full_name ! non-tracking@{u} &&
>         (cd clone && git checkout --no-track -b non-tracking) &&
> -       test_must_fail full_name non-tracking@{u}
> +       full_name ! non-tracking@{u}
>  '

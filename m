Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94263C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 01:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7312A61056
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 01:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhJNB7x convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 13 Oct 2021 21:59:53 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:34683 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNB7w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 21:59:52 -0400
Received: by mail-ed1-f51.google.com with SMTP id g10so17990571edj.1
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 18:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XF3ur5DarYR42/2k7b01tcHgycuQ8Z8leaeoqAIYTho=;
        b=TgylN4WOPfLTlK4cXYRJaRs0jcV/eVFky0+UxL9KSisS7ZS/PsZZRJGkdnhCGWeScC
         WxR09tF9ZpYEMdCuWtGCzq7d27wvrDoK5gtG2Xke5gjpumZwuZ8tueL4fOYjGFr+8sn/
         tRwzYHXXV36AyrJXzQUm1nNjmJ3E7/7Y9GXOqWof+w0iEMJSh2SInr+YNBq7OsG3nW7u
         AMNBH/PT6ALhkK4plmCcU0pKY6r5tNFFV8BUovhpcEl+2/MknOGkmwv5dNSmDdU/IU1d
         fXi3lZAK6Cbhc2X0iEKSJYHqlAEWyp+7djFrIiRKYiiXZq0MujM97xn8S04p8gt5TDNg
         uPoA==
X-Gm-Message-State: AOAM530sxvIJCTAdpXmuT6b1aGQnrz+AHVH2KvM80qnRgbaDdZZ0F+H5
        Tns4Z7XVu4IFFpL4dCVsJP/UxduY9YgpGIqmLq8=
X-Google-Smtp-Source: ABdhPJxEgYUJbCtg6Md8L5Hmyc0DywU38/UV7F4i3pX82CDghANUuasTSso+zqs8Gv4+PmmsGR3cdE3tFijXRC/KhEE=
X-Received: by 2002:a17:906:998d:: with SMTP id af13mr425605ejc.568.1634176667485;
 Wed, 13 Oct 2021 18:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <patch-01.20-bea88e382c0-20211013T235900Z-avarab@gmail.com>
In-Reply-To: <patch-01.20-bea88e382c0-20211013T235900Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 13 Oct 2021 21:57:36 -0400
Message-ID: <CAPig+cQ7OqYi3T9GHh36JAsYfyiW8RJsLaztnhcvs2iWjsp9tw@mail.gmail.com>
Subject: Re: [PATCH 01/20] branch tests: test for errno propagating on failing read
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 13, 2021 at 8:07 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Add a test for "git branch" to cover the case where .git/refs is
> symlinked. To check availability, refs_verify_refname_available() will
> run refs_read_raw_ref() on each prefix, leading to a read() from
> .git/refs (which is a directory).
>
> It would probably be more robust to re-issue the lstat() as a normal
> stat(), in which case, we would fall back to the directory case, but
> for now let's just test for the existing behavior as-is. This test
> covers a regression in a commit that only ever made it to "next", see
> [1].
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> @@ -731,6 +731,26 @@ test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for
> +test_expect_success SYMLINKS 'git branch -m with symlinked .git/refs' '
> +       test_when_finished "rm -rf subdir" &&
> +       git init subdir &&
> +
> +       (
> +               cd subdir &&
> +               for d in refs objects packed-refs
> +               do
> +                       rm -rf .git/$d &&
> +                       ln -s ../../.git/$d .git/$d
> +               done
> +       ) &&

Amend the last line of the loop body:

    ln -s ../../.git/$d .git/$d || exit 1

> +       git --git-dir subdir/.git/ branch rename-src &&
> +       git rev-parse rename-src >expect &&
> +       git --git-dir subdir/.git/ branch -m rename-src rename-dest &&
> +       git rev-parse rename-dest >actual &&
> +       test_cmp expect actual &&
> +       git branch -D rename-dest
> +'

Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D787DC433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 02:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA7C20739
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 02:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgFNCwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 22:52:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33731 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgFNCwC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 22:52:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id j198so11630295wmj.0
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 19:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=86aNxzPKw9qNLTCWQr+DF61LEdD0BuXsCVf57fn2r0E=;
        b=QXU7q8mE1pusN8jPL/TQP1qaP0pQS0B1lIezwkmQdogommPqnug5ku+xmv2Be28+Tl
         W7Crb+4ZyerhlpSGRyM+4x+nnHDCG/ntqh7uiXPcHoNC1YuLzB0/tsTxx8JfK/1F6AeO
         8QRFP9Rs1Ss5ytyEuJhjFQvQVaySPmugnEthsSlpAtQQmWmw+oNxsTvHP2/L2x60YHOz
         Vn6oerq/5xYZ+R4LTtduV6e3rkxkqQ8iThoiYm8ZfDa32sG7k55Qsmr1Pq6Nk/oJjsnu
         KeOWgPO+GlCnwNgU7y+DPcRTD453ft2MDPo0qUgKFu24Uy5WE+qoPVUPC102W5Sc4ISx
         eYwQ==
X-Gm-Message-State: AOAM533tmBjG8O63RJfPBdyrCy2dV2uPQSAl2CUO0PhLSHM8vUw7PbOR
        EqfzyMnX6S4Hz1fhGe4v7OaumeT2w9tB5RuUPe4=
X-Google-Smtp-Source: ABdhPJxtUCCYtabCtO3sO+0R97No52McUqTZARxA7LkPqfWIGgLaZUEoKrqnwRrBvn5chUaZ7bsZSMfitpfBl628ddE=
X-Received: by 2002:a1c:dfd7:: with SMTP id w206mr6206021wmg.130.1592103118684;
 Sat, 13 Jun 2020 19:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <d10cb03dd8ce00cb6033c61ff9b9b30bbf5f9c89.1592058281.git.liu.denton@gmail.com>
In-Reply-To: <d10cb03dd8ce00cb6033c61ff9b9b30bbf5f9c89.1592058281.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 13 Jun 2020 22:51:47 -0400
Message-ID: <CAPig+cQ_G+N=mYqO+=7UaAYft27MhZ2_3v8=QzYpDn5hQySp+A@mail.gmail.com>
Subject: Re: [PATCH] checkout: teach --worktree
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 13, 2020 at 10:25 AM Denton Liu <liu.denton@gmail.com> wrote:
> [...]
> Teach `git checkout --worktree`, allowing users to checkout files
> directly into the worktree without affecting the index.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> @@ -264,6 +266,12 @@ When switching branches with `--merge`, staged changes may be lost.
> +-W::
> +--worktree::
> +       When writing contents, only modify files in the worktree. Do not
> +       modify the index. This option is essentially a no-op when used
> +       without a `<tree-ish>`.

Why a no-op rather than actually diagnosing that --worktree makes no
sense in that case and erroring out?

> diff --git a/t/t2028-checkout-worktree.sh b/t/t2028-checkout-worktree.sh
> @@ -0,0 +1,51 @@
> +test_expect_success 'checkout --worktree on a commit' '
> +       test_when_finished "git reset --hard tip" &&
> +       git diff HEAD HEAD~ >expect &&
> +       git checkout --worktree HEAD~ file1 &&
> +       git diff >actual &&
> +       test_cmp expect actual &&
> +       git diff --cached --exit-code &&

Would the intent be clearer if you used 'test_expect_code' here?

    test_expect_code 0 git diff --cached --exit-code &&

Same question for remaining tests.

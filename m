Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBF3D1F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 10:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfKPKfe (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 05:35:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51035 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfKPKfe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 05:35:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id l17so12106245wmh.0
        for <git@vger.kernel.org>; Sat, 16 Nov 2019 02:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EWuAtsYRYjYzv9a28RjaKvTdZHit/vMYAMW8MqOSPs=;
        b=IHaDgIoSd901KwsLVA/RAsfJG3q0+kRZfAX9M4XLFclOfWoNQu2JfJwVff+gwef/qJ
         vFQBpoD1huR4V8RnDQ92C8Dz3oI2jJhvfyVgEiuoNkXovhL9foDRKHnMR/Nv/zBj/Vh7
         p3MfIc6HCcneE3I+V7Wwva6roa7ztHzVNPZb1bfC8w58MH3SSkg5Ij6A6cTwygUb3NtH
         5JXskDFRsKo5KCVj4FWXclQn+aDSO0u5bpwnIZMlLcZAIAUhT1UvVgkBC35f2UuIc41P
         hDDYXdCVpluQkVjGuLnphMmhYkqnzyoMaIFHg5m4i+6pZ5xlaVNO3pRRjo+PqGL1fAcc
         VEFQ==
X-Gm-Message-State: APjAAAWeFj0nSz8nPNjjbOjjYK/QStbSflW0qLaAAKrsgStWmHQlisrK
        MDIORolufZd8zaRpfqWDpcZzM9SMOs9sioN1U1E=
X-Google-Smtp-Source: APXvYqw9zqI3dlNFxbfd1LOiClluHdbbCWqwS00+xHd3rp8b1K65ZFy0j79yNV64cjBIAW1zJUtj7aoQ8tPAdQTrx0A=
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr19610544wma.120.1573900532441;
 Sat, 16 Nov 2019 02:35:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573779465.git.liu.denton@gmail.com> <f6dc7b7a97783d03900eba2e4607b2a38e963256.1573779465.git.liu.denton@gmail.com>
In-Reply-To: <f6dc7b7a97783d03900eba2e4607b2a38e963256.1573779465.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 16 Nov 2019 05:35:21 -0500
Message-ID: <CAPig+cR-CkALYM1m1yaWaOBW+vpZyjDbn9MoZV=q+KXR6_ZCmg@mail.gmail.com>
Subject: Re: [PATCH 15/27] t7501: stop losing return codes of git commands
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 14, 2019 at 8:01 PM Denton Liu <liu.denton@gmail.com> wrote:
> In a pipe, only the return code of the last command is used. Thus, all
> other commands will have their return codes masked. Rewrite pipes so
> that there are no git commands upstream so that we will know if a
> command fails.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
> @@ -285,9 +285,8 @@ test_expect_success 'overriding author from command line' '
>  test_expect_success PERL 'interactive add' '
> -       echo 7 |
> -       git commit --interactive |
> -       grep "What now"
> +       echo 7 | test_must_fail git commit --interactive >out &&
> +       grep "What now" out
>  '

git-commit documentation does not talk about the command's exit code,
so it's not immediately clear why this test should be using
test_must_fail() for the invocation. The implementation of git-commit
is more illuminating, showing that 1 is returned when there are no
changes to commit, and 0 for a successful commit. So, that raises the
question of whether this should be using "test_expect_code 1" rather
than test_must_fail(), however, there is existing precedence which
gives some guidance. In particular, the "nothing to commit" test of
t7501-commit-basic-functionality.sh does use test_must_fail() when
attempting to commit with no changes. It may make sense, therefore, to
mention something about this in the commit message to save future
readers from wondering why the command is "expected to fail".

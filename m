Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BCFC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 00:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B5160524
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 00:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhJVAIV convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 21 Oct 2021 20:08:21 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:35415 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhJVAIV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 20:08:21 -0400
Received: by mail-ed1-f48.google.com with SMTP id w19so86042edd.2
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 17:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fur3mAy0k7poGaM1QShUUYu+yc+Wsel/K042OSfVfuI=;
        b=Gmt8qX1HCJJHN6vYmpSqjgO3YUN5dsQ5yYIEc9MVs4Eheu1aWt2C2otpkjo86teRjg
         jH/7XDgwNRzF5J3eKXMQCHIUQFKnlmvGqLEevbp7lotOHE0gOTTuWmBbMTa5VcyCTKWz
         L3w3cawTKjH6VJ9Cayqo1Qw5jlRhRAMVueWn6//zHUB75tLnIqW/Ij7HtZsuhMM9n6jN
         WBNIw19RyH3e4nbMjBWTiMUwGh54Kv3GR3EJ5RTrD8Ye2FRTjVt8gzQSTvp15AJP4yEv
         OkdIhhTZ3VcbaQgq9908sxtqJE88xAo4hqFeFUzIp0B/icbiA8hwNyX7moO3GYJR0spm
         7lWA==
X-Gm-Message-State: AOAM531YWXOU82N27c31sQWqdVovaWOFwWEUP7pCDyrtWimG96M1WhB2
        Kq+rzoln/2zHd+J1aHasUyizkrH3CUiGZUTGCj8g0xBkGWfYDA==
X-Google-Smtp-Source: ABdhPJyhyVyo64oYDhZK3LVZ8cFCrUZjtdm2ZlftRvu892AzPI/uayWnQFc5ia/PXOcUOqSGWbE1vkd1nRNbrTwi1Vs=
X-Received: by 2002:a05:6402:10da:: with SMTP id p26mr12334028edu.283.1634861163822;
 Thu, 21 Oct 2021 17:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211021222532.463375-1-oystwa@gmail.com> <20211021222532.463375-3-oystwa@gmail.com>
In-Reply-To: <20211021222532.463375-3-oystwa@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 Oct 2021 20:05:53 -0400
Message-ID: <CAPig+cQQurJuKieFcnZ8_10CaJA7vZ2kV=S+AaHVX3nhsVUG-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] status: print stash info with --porcelain=v2 --show-stash
To:     =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 6:25 PM Øystein Walle <oystwa@gmail.com> wrote:
> The v2 porcelain format is very convenient for obtaining a lot of
> information about the current state of the repo, but does not contain
> any info about the stash. git status already accepts --show-stash but
> it's silently ignored when --porcelain=v2 is given.
>
> Let's add a simple line to print the number of stash entries but in a
> format similar in style to the rest of the format.
>
> Signed-off-by: Øystein Walle <oystwa@gmail.com>
> ---
> diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
> @@ -113,6 +113,21 @@ test_expect_success 'after first commit, create unstaged changes' '
> +test_expect_success 'after first commit, stash existing changes' '
> +       cat >expect <<-EOF &&
> +       # branch.oid $H0
> +       # branch.head initial-branch
> +       # stash 2
> +       EOF
> +
> +       test_when_finished "git stash pop && git stash pop" &&

If it's indeed important to clean up the stashes when the test
finishes, then the test_when_finished() invocation should probably be
a bit more robust...

> +       git stash -- file_x &&
> +       git stash &&

... since, as it is now, if an error occurs between these two
git-stash invocations or before them, then there will only be zero or
one stashes, so the double stash-pop by test_when_finished() will
itself errout out. Better, perhaps to do this:

    test_when_finished "git stash pop && git stash pop || :" &&

> +       git status --porcelain=v2 --branch --show-stash --untracked-files=no >actual &&
> +       test_cmp expect actual
> +'

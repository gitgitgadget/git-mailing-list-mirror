Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5101BC433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 15:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhKXPSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:18:53 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:45579 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhKXPSv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 10:18:51 -0500
Received: by mail-ed1-f42.google.com with SMTP id y12so11855237eda.12
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 07:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7EZKuECqTG50x9cRWS/lup7RFbVsWTnYdEg9T84qic=;
        b=FcA0zUPFEgSqaQlEC6bv/mnLkBHJATcHVlaC6yb3r0awvsFFCxoc5NQpjivlyX5qEk
         9WfvWmRiAgJC8XAMXwXXXXcKDYoFyFFSgadN/DUnpCW1UDnqQAzUXBbFVzam9aZdrAvo
         aBurSKA6r5+cSQ1oxtaDTMZDTd0Tt0tXG3vhFyoaBRMR+4X+XZfNaG6g5NBhvbjzzHO4
         G7OVb4lM7p5kY9CfcnxbEpBOQVvPS4VB/2QjkSXij9p3k+WSsygZYAyB1CkcUuDnskdW
         iAPSsCXtuo66j3J7Q0jNxfmpi6N5gmOB3dYWbOiudsZNiV9scVMfIh97Cl9aVHI93sIp
         FTEw==
X-Gm-Message-State: AOAM531fJ1qA36ouA6XeLQlehM5+4DmAg858rRh2cQXLGcnIG68sQa+l
        EjAN5QV1X7rscycKQwRq3x8rGVBxE8/1MESsIAJr9WvFnpQ=
X-Google-Smtp-Source: ABdhPJxEYTcDICXwd1baZ+WHGwt9XaJpjpAhPSIrLMF3ALmYLETmBHhIB/xVCYmTmXimR0rGz9gZbGhEXqw7W7MF0HA=
X-Received: by 2002:a50:d49d:: with SMTP id s29mr26162495edi.55.1637766941080;
 Wed, 24 Nov 2021 07:15:41 -0800 (PST)
MIME-Version: 1.0
References: <20211124145409.8779-1-ematsumiya@suse.de>
In-Reply-To: <20211124145409.8779-1-ematsumiya@suse.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 Nov 2021 10:15:29 -0500
Message-ID: <CAPig+cT0-bu2tcgJrRR+9J86bmGEOOpFZv0JygCp26gieP-2pg@mail.gmail.com>
Subject: Re: [PATCH v3] pager: fix crash when pager program doesn't exist
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 24, 2021 at 9:54 AM Enzo Matsumiya <ematsumiya@suse.de> wrote:
> [...]
> Reproducer:
> $ git config pager.show INVALID_PAGER
> $ git show $VALID_COMMIT
> error: cannot run INVALID_PAGER: No such file or directory
> [1]    3619 segmentation fault (core dumped)  git show $VALID_COMMIT
>
> Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
> ---
> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> @@ -786,4 +786,9 @@ test_expect_success TTY 'git returns SIGPIPE on propagated signals from pager' '
> +test_expect_success TTY 'handle attempt to run an invalid pager' '
> +       test_config pager.show invalid-pager &&
> +       test_terminal git show
> +'

This is a minor observation (so you decide what value it might have),
but the terminology "handle ... invalid pager" in the test title
doesn't convey very much information to some future reader of this
test, and that person will be forced to consult the commit message --
which does a good job of explaining the problem -- to really
understand what this test is checking. If you change the title to, for
instance:

    non-existent pager doesn't cause crash

then the reader will have an easier time understanding what this test
is about. It's true that the reader will still need to consult the
commit message for a detailed picture of the problem, but won't be
left head-scratching, as might be the case with the current test
title.

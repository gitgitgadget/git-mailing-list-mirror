Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D246E75458
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 18:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjJCSBe convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 3 Oct 2023 14:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjJCSB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 14:01:28 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D36D83
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 11:01:25 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7b2ca45d5cfso564680241.1
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 11:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696356084; x=1696960884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pgMSoTlktW1r6i7d3kUHtYOeB4IbENZEHQ8h2EBR3c=;
        b=X4tTWgLmCctHlbGZoYhF9qIADrj3sZWXBUij1ow6/QQLDsY/LFBMIhaEKQ30Qwll0g
         vm1dZHoLo+z0kqfBwt1J0Uyx3QMotXYY45REOn/wPIIdwtUTnejDnAEtgSLNruX/B2xy
         BcLZ7sPelpS/YP6FTkS4gtpoTgoXY86+LXpxuwRlOk+K/yuoP2/U6TBIN/n4K0FMIPP6
         OcFnU0byjj0LjZjz1VJ8hxFWm/XpE1QEZdLD5gfgeBTSDwImgmsCYSVUYITDrWA1PePw
         RVogrpWf1RANRtdwM+a0ENT1T70hwtEySmI+yioRJ5V5baTOYR0W2VMEBqMKvNgz97QL
         k0cQ==
X-Gm-Message-State: AOJu0Yx82v4cjyYW1rofi03k5Mv1slZ476RoVq9C/FIYzpUVHw8k9ZW4
        st9Omdqe390p8DY05KvZUB9e45HsGm28vjLA4eM=
X-Google-Smtp-Source: AGHT+IHeiGSvHADv5qn+R18PmrHJj0I/R60Kg1L+3ktN10XzspPd0TPjACL1bOHYYks+ZLz5qTlxKj+89hQA7ltxQMw=
X-Received: by 2002:a67:ce04:0:b0:44e:d6c3:51d6 with SMTP id
 s4-20020a67ce04000000b0044ed6c351d6mr104919vsl.14.1696356084056; Tue, 03 Oct
 2023 11:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231003174853.1732-1-ach.lumap@gmail.com> <20231003174853.1732-2-ach.lumap@gmail.com>
In-Reply-To: <20231003174853.1732-2-ach.lumap@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Oct 2023 14:01:13 -0400
Message-ID: <CAPig+cSkZ_brRh_ijFRgz3sP9ou5se9-xeRg=C+cV3c3-v3Wtg@mail.gmail.com>
Subject: Re: [PATCH 1/1] t2400: avoid using pipes
To:     ach.lumap@gmail.com
Cc:     git@vger.kernel.org, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 3, 2023 at 1:49 PM <ach.lumap@gmail.com> wrote:
> t2400: avoid using pipes

Pipes themselves are not necessarily problematic, and there are many
places in the test suite where they are legitimately used. Rather...

> The exit code of the preceding command in a pipe is disregarded,
> so it's advisable to refrain from relying on it. Instead, by
> saving the output of a Git command to a file, we gain the
> ability to examine the exit codes of both commands separately.

... as you correctly explain here, we don't want to lose the exit code
from the Git command. Thus, if you want to convey more information to
readers of `git log --oneline` (or other such commands), a better
subject for the patch might be:

    t2400: avoid losing Git exit code

That minor comment aside (which is probably not worth a reroll), the
commit message properly explains why this change is desirable and the
patch itself looks good.

> Signed-off-by: achluma <ach.lumap@gmail.com>
> ---
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> @@ -468,7 +468,8 @@ test_expect_success 'put a worktree under rebase' '
>                 cd under-rebase &&
>                 set_fake_editor &&
>                 FAKE_LINES="edit 1" git rebase -i HEAD^ &&
> -               git worktree list | grep "under-rebase.*detached HEAD"
> +               git worktree list >actual &&

Thanks for following the style guideline and omitting whitespace
between the redirection operator and the destination file.

> +               grep "under-rebase.*detached HEAD" actual
>         )
>  '
>
> @@ -509,7 +510,8 @@ test_expect_success 'checkout a branch under bisect' '
>                 git bisect start &&
>                 git bisect bad &&
>                 git bisect good HEAD~2 &&
> -               git worktree list | grep "under-bisect.*detached HEAD" &&
> +               git worktree list >actual &&
> +               grep "under-bisect.*detached HEAD" actual &&
>                 test_must_fail git worktree add new-bisect under-bisect &&
>                 ! test -d new-bisect
>         )

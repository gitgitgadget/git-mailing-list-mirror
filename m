Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0709C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 05:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiKUFGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 00:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKUFGX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 00:06:23 -0500
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935E418378
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 21:06:22 -0800 (PST)
Received: by mail-pf1-f182.google.com with SMTP id b185so10314660pfb.9
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 21:06:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQm3WZry6k2DNib8aHYNuiCx1peaZYVfVVkNdRO91LE=;
        b=0D2QuuLvSWKao0a6XuB+OxkafKpDWkfCyOGV5b6xZKwCe5qB3FlAptCS/Ogek/K+r5
         4HnEf34HycSZ1mCFpG0pW/Q4o89OGE/HQw+qiY/8Y9tcY6uc9BFU/H7Z1i7sIGylrE+R
         0GqlG2od14skAn/hCqJvkni+MqnuHoqNSAOPG8qRRIgjzhzvaTo+2WV5TYqlHgXY8kXY
         0q9YSr1UCW89773q3sAgeW/Lxz6zdv60vwq4mUt1yVHYD55ZImjFdvsSTgPAmPAoTZMb
         IvsFkfA9AXZy6n0usQUXiaQMv+JnxX94ePOH2jP1TxMqcR0/aIUhu6A8rFUg/OTMYt5B
         wqFQ==
X-Gm-Message-State: ANoB5pnJ7iry0ZIkHwx1HPF9dfYdymrveIXnPDwXt3duHdd3unqC3sNc
        KZfKn1PAfFalvevkfc7FA2GuVr2eq2obi3j1FgJmjTW7B1A=
X-Google-Smtp-Source: AA0mqf7iVRmBs3cm7oaXe0UXkl6u0noNNAI2Ok4p3tq7do6akv54x8tYhnCmJ2m4GjU0N11Si6/Pg+yRfk24FUN1b9s=
X-Received: by 2002:a05:6a00:24c1:b0:56e:a001:8cb0 with SMTP id
 d1-20020a056a0024c100b0056ea0018cb0mr18521918pfv.60.1669007181970; Sun, 20
 Nov 2022 21:06:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com> <pull.1384.v6.git.1668547188070.gitgitgadget@gmail.com>
In-Reply-To: <pull.1384.v6.git.1668547188070.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 Nov 2022 00:06:10 -0500
Message-ID: <CAPig+cRPQ7bmG6+U+oQGGUFiSiHoMMpMk8FDJ7GMJvwCXifa9g@mail.gmail.com>
Subject: Re: [PATCH v6] status: long status advice adapted to recent capabilities
To:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Rudy Rigot <rudy.rigot@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 4:19 PM Rudy Rigot via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Improve the advice displayed when `git status` is slow because
> of excessive numbers of untracked files.  Update the `git status`
> man page to explain the various configuration options.
>
> Signed-off-by: Rudy Rigot <rudy.rigot@gmail.com>
> ---
>     Here is version 6 for this patch.
>
>     Changes since v5:
>
>      * End of sentence for fsmonitor case was changed to "but the results
>        were cached, and subsequent runs may be faster."
>      * Except for that, mostly style and doc fixes.

Thanks, I think v6 addresses all my earlier review comments. Just one
or two notes below...

> +test_expect_success setup '
> +       git checkout -b test &&
> +       cat >.gitignore <<-\EOF &&
> +       /actual
> +       /expected
> +       /out
> +       EOF
> +       git add .gitignore &&
> +       git commit -m "Add .gitignore"
> +'

I suppose I wasn't paying close enough attention earlier, but I see
now that this is creating a branch named "test". If I remove the `git
checkout -b test` line entirely and change "test" to "master" in the
"expected" files, all the tests pass just fine. So, it's not apparent
why you need to create a specially-named branch here rather than
simply accepting the default branch name. The reason I bring this up
is that unnecessary code, whether in tests or elsewhere, can confuse
future readers (and reviewers, such as myself) into wondering if
something subtle is going on which the reader is overlooking. (This is
very much the same sort of concern as when I asked in an earlier
review why the conditions in an `if` got switched around from the way
they were in the original code; such unnecessary changes can confuse
future readers.)

If the answer is that you wanted to avoid the term "master", then an
alternative would have been to override the default branch name at the
top of the script:

    GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

That said, this is minor, and I'm not keen on eating up more of your
time or reviewer time, so I doubt this is worth a reroll.

> +test_expect_success 'when core.untrackedCache and fsmonitor are unset' '
> +       test_might_fail git config --unset-all core.untrackedCache &&
> +       test_might_fail git config --unset-all core.fsmonitor &&

When I suggested the above code, it had slipped my mind that we have a
test_unconfig() function in t/test-lib-functions.sh which does this
more concisely:

    test_unconfig core.untrackedCache &&
    test_unconfig core.fsmonitor &&

But what you have here in v6 is good enough; it's not worth wasting
your time or reviewer time rerolling just to make this change. I
mention it merely for future reference.

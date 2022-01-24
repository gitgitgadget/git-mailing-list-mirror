Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01463C433F5
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 02:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349627AbiAYCAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 21:00:21 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41]:50846 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1848485AbiAXXWf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 18:22:35 -0500
Received: by mail-pj1-f41.google.com with SMTP id o11so704269pjf.0
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 15:22:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RauCMbeJrGv6VsRQE0JqmZbqK10XBe4h/d9a4p7SEbk=;
        b=uPvC9MZiWanRxjRJpu6bup5+D7o0qDIfHA21U4vZrOMZE3Xyw5X4L59Qty1s+Dyl5r
         t6jIyzOS69VwpuH4FyndcJZFLPEm+03fe5a+kdE/ErKCgew4cuzE0ScDw2we3zpvNNLa
         6apteYrAaCyLe9e8MUxICchSuLdtPJGH//BWjMo4NjHYMjb/hnS6MmoQAK9GXvCrHM0S
         0/3ZmYzYKCIbJY9EOSfo4OZnaZxInDPqy8c9+WZDmdDuhrNFaJsfXT4LW/XdBtNtmmRv
         yAVLgcMmwFDMJTc5BDwkw8RI6jGpngFyokC4+WH6h/HrG1kqaBdO3a64hVfpvA18ZPkH
         gKJA==
X-Gm-Message-State: AOAM532lpRY8WJhkocHYG+QpsZaLqH+xe35rMLGWawCRh/WRCCyHvuIw
        rJA4o8V0giae7skEjbYrZwwVXmgnXUpfm19WX39YJt6RPCw=
X-Google-Smtp-Source: ABdhPJyCtRLvUZ8irUjWHNQRQJd5Ks4BezXehYweaWQNj7C2GZl1qKtTANZwKsxfbRuomKQKj3qL/nWz0lYTsZ/zyPk=
X-Received: by 2002:a17:902:9049:b0:14a:ea20:1f21 with SMTP id
 w9-20020a170902904900b0014aea201f21mr16466377plz.35.1643066554060; Mon, 24
 Jan 2022 15:22:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com> <d2ff51bb5dacfe084166de106e9a864c902f0f36.1643050574.git.gitgitgadget@gmail.com>
In-Reply-To: <d2ff51bb5dacfe084166de106e9a864c902f0f36.1643050574.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 24 Jan 2022 18:22:23 -0500
Message-ID: <CAPig+cTk142o5xkN0jHB6y1h=4zYBwhpwdTxG0oO3Ox+xqdgdQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] ci/run-build-and-tests: take a more high-level view
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 24, 2022 at 3:02 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> In the web UI of GitHub workflows, failed runs are presented with the
> job step that failed auto-expanded. In the current setup, this is not
> helpful at all because that shows only the output of `prove`, which says
> which test failed, but not in what way.
>
> What would help understand the reader what went wrong is the verbose
> test output of the failed test.
>
> The logs of the failed runs do contain that verbose test output, but it
> is shown in the _next_ step (which is marked as succeeding, and is
> therefore _not_ auto-expanded). Anyone not intimately familiar with this
> would completely miss the verbose test output, being left mostly
> puzzled with the test failures.
>
> We are about to show the failed test cases' output in the _same_ step,
> so that the user has a much easier time to figure out what was going
> wrong.
>
> But first, we must partially revert the change that tried to improve the
> CI runs by combining the `Makefile` targets to build into a single
> `make` invocation. That might have sounded like a good idea at the time,
> but it does make it rather impossible for the CI script to determine
> whether the _build_ failed, or the _tests_. If the tests were run at
> all, that is.
>
> So let's go back to calling `make` for the build, and call `make test`
> separately so that we can easily detect that _that_ invocation failed,
> and react appropriately.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> @@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
> -export MAKE_TARGETS="all test"
> +run_tests=t
>
>  case "$jobname" in
>  linux-gcc)
> @@ -41,14 +41,18 @@ pedantic)
>         # Don't run the tests; we only care about whether Git can be
>         # built.
>         export DEVOPTS=pedantic
> -       export MAKE_TARGETS=all
> +       run_tests=
>         ;;
>  esac
>
>  # Any new "test" targets should not go after this "make", but should
>  # adjust $MAKE_TARGETS. Otherwise compilation-only targets above will
>  # start running tests.
> -make $MAKE_TARGETS

The comment talking about MAKE_TARGETS seems out of date now that
MAKE_TARGETS has been removed from this script.

> +make
> +if test -n "$run_tests"
> +then
> +       make test
> +fi
>  check_unignored_build_artifacts

This changes behavior, doesn't it? Wth the original "make all test",
if the `all` target failed, then the `test` target would not be
invoked. However, with the revised code, `make test` is invoked even
if `make all` fails. Is that behavior change significant? Do we care
about it?

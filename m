Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF120C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 17:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12D220449
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 17:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbhAERz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 12:55:58 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47]:42209 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbhAERz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 12:55:57 -0500
Received: by mail-ej1-f47.google.com with SMTP id d17so1361045ejy.9
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 09:55:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xP/ai+aD9oBNgZ6hUyeciRL26hoBfs7KZYTGeaBQ0pQ=;
        b=aU7fjDm3wsVsm1MSCQGDdKnw1v0fSiqIRASVaO/CX9G1lhPVrPyo3rWXuPbPUvPaZM
         Rvb7gvFAMRknRoIb3tQtkLxto2MlOYVqsbx7YthI4XlnYgDqr0JxRCQeVd81i1PnF4KI
         0E//E/ajPUFmnzgRozHUdvWLQsFU9ZGdLaXb6SLkcGwm3SY+QLLaadinCzrBONjfPqZI
         wLu64ZP2uGeRKUJ+NS7Bm8Ps0TBjHOZVxjjVHofLHw626rVQr+YC+WDAYTVVUEqqbQpG
         bFhE8gyf+NJ+Ug84HarW2UD6wHKI0KiOwF/BQ4Nc0SWKmdYwy8CutUSeAMuIgHex3f8P
         kdGg==
X-Gm-Message-State: AOAM533ZsqTrNGs6UKIiqqMXTxe63Ll+p/TklrylqSNIvH05u+TqZdLR
        bd/mlS6FDxSkYlwPrhUM849LM5NVqgq4b3TJ7Xw=
X-Google-Smtp-Source: ABdhPJyl4tDYd5erxvMArSqY/68I9buovuGjTY4pSvexLPTd/uZ8+uf3C5uk7vfP1O7oI7AoRFDhvt7gNy/zNOhbpjM=
X-Received: by 2002:a17:906:4348:: with SMTP id z8mr241968ejm.371.1609869315672;
 Tue, 05 Jan 2021 09:55:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.834.git.1609857770445.gitgitgadget@gmail.com>
In-Reply-To: <pull.834.git.1609857770445.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 5 Jan 2021 12:55:04 -0500
Message-ID: <CAPig+cQ4B6s7RzGH=1QhSc_2kKy-Mbp9fyK4VoTntdAfCT4d9A@mail.gmail.com>
Subject: Re: [PATCH] for-each-repo: do nothing on empty config
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 5, 2021 at 9:44 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> 'git for-each-repo --config=X' should return success without calling any
> subcommands when the config key 'X' has no value. The current
> implementation instead segfaults.
> [...]
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
> @@ -51,6 +51,9 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
>         values = repo_config_get_value_multi(the_repository,
>                                              config_key);
> +       if (!values)
> +               return result;

Probably not worth a re-roll, but the above has higher cognitive load than:

    if (!value)
        return 0;

which indicates clearly that the command succeeded, whereas `return
result` makes the reader scan all the code above the conditional to
figure out what values `result` could possibly hold.

> diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
> @@ -27,4 +27,8 @@ test_expect_success 'run based on configured value' '
> +test_expect_success 'do nothing on empty config' '
> +       git for-each-repo --config=bogus.config -- these args would fail
> +'

The `these args would fail` arguments add mystery to the test,
prompting the reader to wonder what exactly is going on: "Fail how?",
"Is it supposed to fail?". It might be less confusing to use something
more direct like `nonexistent` or `does not exist`.

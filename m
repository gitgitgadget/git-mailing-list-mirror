Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F13EB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 04:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjFNE5B convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 14 Jun 2023 00:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjFNE5A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 00:57:00 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BD8122
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 21:56:58 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-62de5392c7bso13254286d6.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 21:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686718617; x=1689310617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rUHmXVEo32inDcwHLyljbdbNzPdqgcyj9aPiIjDFK8=;
        b=gZXK0l0P0sw+GNk3REB/F3meDsaBavR1KGZ55AQBsY0aeQqe59hBiJM2aHXODjCXNS
         LzvcgK/DBB3Gm1HHorfko3i4INPZI52wLXoceY1ZLiomv8TwvktDNLCMq2fuqqEH6I8z
         5K08z0XECLmB2/B0pNGR7UnB1T0H1HaqDesrXo1rZD8kbK6o3ksxIZeFKanHsSEbWFzi
         FQqBmINaPyFwuUDREcVX1SMmFxSPPdGtVz0l0uScdG7riv4EZYf5YUCMGPurVsGswV6J
         dNU5bP/6ZWcRAZzYd6myqGdeLe+OtFpk84ABDLzA1hRi2FY9ourDZjBwDtzcqO+gFG/N
         ZMmA==
X-Gm-Message-State: AC+VfDzbCAObGTw4+KVCaaSC4Lj6StD/ISZ7tD2jpK3BPW8DbFOk6alA
        UTIUmStx5SSr8yc750wtypfjMbE/8dV7hENpiJF526xVAFM=
X-Google-Smtp-Source: ACHHUZ7lqa/48tK2tqRVq6jxJf8yfzfpnGsmgKgTAbG5t3bPaLSCvK7SQEPKk1fBaSc/Gszkij1kByIB1D9j8UFVx9I=
X-Received: by 2002:ad4:594f:0:b0:62d:eb59:7806 with SMTP id
 eo15-20020ad4594f000000b0062deb597806mr10599011qvb.31.1686718617660; Tue, 13
 Jun 2023 21:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230614041626.2979067-2-sokcevic@google.com>
In-Reply-To: <20230614041626.2979067-2-sokcevic@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 14 Jun 2023 00:56:46 -0400
Message-ID: <CAPig+cQiwkwzVNHpBnXEAKo91LCUs-qgxbiZVbmGK1CbPVEQXg@mail.gmail.com>
Subject: Re: [PATCH] diff-lib: honor override_submodule_config flag bit
To:     Josip Sokcevic <sokcevic@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2023 at 12:39 AM Josip Sokcevic <sokcevic@google.com> wrote:
> When `diff.ignoreSubmodules = all` is set and a submodule commit is
> manually staged, `git-commit` should accept it.
>
> `index_differs_from` is called from `prepare_to_commit` with flags set to
> `override_submodule_config = 1`. `index_differs_from` then merges the
> default diff flags and passed flags.
>
> When `diff.ignoreSubmodules` is set to "all", `flags` ends up having
> both `override_submodule_config` and `ignore_submodules` set to 1. This
> results in `git-commit` ignoring staged commits.
>
> This patch restores original `flags.ignore_submodule` if
> `flags.override_submodule_config` is set.
> ---

Thanks for the patch. I'm not a submodule user, so I can't comment on
the functional changes made by the patch, but instead will provide a
few superficial comments to help move your patch along.

Please add a Signed-off-by: before the "---" line above. See
Documentation/SubmittingPatches.

> diff --git a/diff-lib.c b/diff-lib.c
> @@ -669,8 +669,13 @@ int index_differs_from(struct repository *r,
> -       if (flags)
> +       if (flags) {
>                 diff_flags_or(&rev.diffopt.flags, flags);
> +               // Now that flags are merged, honor override_submodule_config
> +               // and ignore_submodules from passed flags.

This project still uses old-style /*...*/ comments; //-style are
avoided. A multi-line comment is formatted like this:

    /*
     * This is a multi-line
     * comment.
     */

> +               if ((*flags).override_submodule_config)
> +                       rev.diffopt.flags.ignore_submodules = (*flags).ignore_submodules;

It would be more idiomatic to use the `->` operator to access members
of `flags`:

    if (flags->override_submodule_config)
        rev.diffopt.flags.ignore_submodules = flags->ignore_submodules;

> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> @@ -1179,4 +1179,32 @@ test_expect_success 'submodule update --recursive skip submodules with strategy=

Nice to see new tests accompanying the code change.

> +add_submodule_commits_and_validate () {
> +       HASH=$(git rev-parse HEAD) &&
> +       git update-index --add --cacheinfo 160000,$HASH,sub &&
> +       git commit -m "create submodule" &&
> +       git ls-tree HEAD >output &&
> +       test_i18ngrep "$HASH" output &&
> +
> +       rm output
> +}

"output" won't get cleaned up if a command earlier in the &&-chain
fails. To ensure that it does get cleaned up regardless of whether the
test succeeds or fails, use test_when_finished() before the file is
created. For instance:

    add_submodule_commits_and_validate () {
        HASH=$(git rev-parse HEAD) &&
        ...
        test_when_finished "rm -f output" &&
        git ls-tree HEAD >output &&
        ...
    }

These days, test_i18ngrep() is deprecated. Just use plain old `grep` instead.

> +
> +
> +test_expect_success 'commit with staged submodule change' '
> +       add_submodule_commits_and_validate
> +'
> +
> +

Separate the tests by a single blank line rather than two.

> +test_expect_success 'commit with staged submodule change with ignoreSubmodules dirty' '
> +       git config diff.ignoreSubmodules dirty &&
> +       add_submodule_commits_and_validate &&
> +       git config --unset diff.ignoreSubmodules
> +'

The same observation as above regarding cleaning up: The `git config
--unset` won't be invoked if a command earlier in the &&-chain fails.
Instead, use test_config() which will ensure cleanup regardless of
whether the test succeeds or fails:

    test_expect_success 'commit ...' '
        test_config diff.ignoreSubmodules dirty &&
        add_submodule_commits_and_validate
    '

> +test_expect_success 'commit with staged submodule change with ignoreSubmodules all' '
> +       git config diff.ignoreSubmodules all &&
> +       add_submodule_commits_and_validate &&
> +       git config --unset diff.ignoreSubmodules
> +'

Likewise.

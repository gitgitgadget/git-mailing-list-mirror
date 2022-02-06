Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F92DC433EF
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 11:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiBFLaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 06:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbiBFLaR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 06:30:17 -0500
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C5FC043182
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 03:30:16 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so226933pjl.2
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 03:30:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzd/XAaPD9GAEXofSUnQb7QBSYXb0hBe65fWjOIbnAM=;
        b=5E/81pDFr9apzzjWd1Q/xeFoGlszENPd25xZB0GX1gV12/DgAace+7dT7353dN5FXD
         T/vlgD9S/HizIrGkylBDdtVtf2W1sa9ElH1AcWJ3VfHRkdl3NHvM1ZWwbyPEZ9O3oydp
         El58gSWD+X9IF4A3p0O95ln/y/34uBJbwDmxvAOHPSTT222mJxkBlazJ2KZyZjfzzjDG
         vEGr7L51smu2y3QrVO7MVmG+JPtby6K7PYEImDho0feizaiKgeZMvYjZfN3391LJv+oD
         VpxdTOkRevFO/g8y5nsILEnrczNpelpEco+GWlBkiQ9raFnuVs58uHzdGfV4+Moc5sT/
         0jOg==
X-Gm-Message-State: AOAM532kVAQsaXw0Ll5KfydGIOBlf5WYEGj6dfNEPjpW/BevdCvFDSb8
        t6oumdmj1F8LCbOgXOZbffIU7OttSTEYTGa+78M=
X-Google-Smtp-Source: ABdhPJxJj1yfDmxLAbvHuEw0T0IH6nWPVQGYU84WUsKuQrIv7E4J2t9xLcRDuOjoXGCcQFDjg8DEcHgiPro95IHLrcs=
X-Received: by 2002:a17:902:da8a:: with SMTP id j10mr1351928plx.145.1644147015519;
 Sun, 06 Feb 2022 03:30:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
 <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com> <85779dfaed39220e18129e823aff9c95ade5985b.1643641259.git.gitgitgadget@gmail.com>
In-Reply-To: <85779dfaed39220e18129e823aff9c95ade5985b.1643641259.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 6 Feb 2022 06:30:04 -0500
Message-ID: <CAPig+cQOieO3cmZv42G_8XRiMwkh4v3cO1AYg5VR9SiPNMwxhw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] worktree: copy sparse-checkout patterns and config
 on add
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 31, 2022 at 10:01 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When adding a new worktree, it is reasonable to expect that we want to
> use the current set of sparse-checkout settings for that new worktree.
> This is particularly important for repositories where the worktree would
> become too large to be useful. This is even more important when using
> partial clone as well, since we want to avoid downloading the missing
> blobs for files that should not be written to the new worktree.
>
> The only way to create such a worktree without this intermediate step of
> expanding the full worktree is to copy the sparse-checkout patterns and
> config settings during 'git worktree add'. Each worktree has its own
> sparse-checkout patterns, and the default behavior when the
> sparse-checkout file is missing is to include all paths at HEAD. Thus,
> we need to have patterns from somewhere, they might as well be the
> current worktree's patterns. These are then modified independently in
> the future.
>
> In addition to the sparse-checkout file, copy the worktree config file
> if worktree config is enabled and the file exists. This will copy over
> any important settings to ensure the new worktree behaves the same as
> the current one. The only exception we must continue to make is that
> core.bare and core.worktree should become unset in the worktree's config
> file.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -335,6 +335,66 @@ static int add_worktree(const char *path, const char *refname,
> +       /*
> +        * If the current worktree has sparse-checkout enabled, then copy
> +        * the sparse-checkout patterns from the current worktree.
> +        */
> +       if (core_apply_sparse_checkout) {
> +               char *from_file = git_pathdup("info/sparse-checkout");
> +               char *to_file = xstrfmt("%s/worktrees/%s/info/sparse-checkout",
> +                                       realpath.buf, name);

I think this is too fragile and may easily be broken by an unrelated
change since `realpath` is a temporary container which gets reused,
thus it holds different paths at different times. For instance, it
first holds the realpath of $GIT_DIR but then later holds the realpath
of $GIT_COMMON_DIR. If someone later comes along and reuses it for
some other path, then the code added by this patch may end up
breaking. To make this robust, you should instead use `sb_repo` which
already has the value "$GIT_DIR/worktrees/<name>":

    char *to_file = xstrfmt(%s/info/sparse-checkout", sb_repo.buf);

> +               if (file_exists(from_file)) {
> +                       if (safe_create_leading_directories(to_file) ||
> +                           copy_file(to_file, from_file, 0666))
> +                               error(_("failed to copy '%s' to '%s'; sparse-checkout may not work correctly"),
> +                                     from_file, to_file);
> +               }
> +
> +               free(from_file);
> +               free(to_file);
> +       }
> +
> +       /*
> +        * If we are using worktree config, then copy all current config
> +        * values from the current worktree into the new one, that way the
> +        * new worktree behaves the same as this one.
> +        */

As an aid for future readers, it might be helpful to extend this
content to explain _why_ the new worktree should behave the same as
the current one. Reproducing the important bits from the commit
message here in the comment could make it more useful.

> +       if (repository_format_worktree_config) {
> +               char *from_file = git_pathdup("config.worktree");
> +               char *to_file = xstrfmt("%s/worktrees/%s/config.worktree",
> +                                       realpath.buf, name);

Same comment about fragility of using `realpath`. Instead:

    char *to_file = xstrfmt("%s/config.worktree", sb_repo.buf);

> +               if (file_exists(from_file)) {
> +                       struct config_set cs = { { 0 }};

s/}}/} }/

> +                       const char *str_value;
> +                       int bool_value;
> +
> +                       if (safe_create_leading_directories(to_file) ||
> +                           copy_file(to_file, from_file, 0666))
> +                               die(_("failed to copy worktree config from '%s' to '%s'"),
> +                                   from_file, to_file);

All the other error conditions handled by this patch use error() but
this one uses die(). Does this one really warrant aborting the `git
worktree add` operation? Perhaps instead just add a label below this
new chunk of code and `goto` the label (or indent this code further
and avoid adding a label).

> +                       git_configset_init(&cs);
> +                       git_configset_add_file(&cs, from_file);
> +
> +                       if (!git_configset_get_bool(&cs, "core.bare", &bool_value) &&
> +                           bool_value &&

Nit: This would be slightly easier to understand if you named this
variable `bare` (as you did in patch [2/5]) rather than `bool_value`.

> +                           git_config_set_multivar_in_file_gently(
> +                                       to_file, "core.bare", NULL, "true", 0))
> +                               error(_("failed to unset 'core.bare' in '%s'"), to_file);
> +                       if (!git_configset_get_value(&cs, "core.worktree", &str_value) &&

In patch [2/5] you used git_configset_get_string_tmp() to retrieve
this setting, but here you're using git_configset_get_value(). Is
there a reason for the inconsistency?

> +                           git_config_set_in_file_gently(to_file,
> +                                                         "core.worktree", NULL))
> +                               error(_("failed to unset 'core.worktree' in '%s'"), to_file);
> +
> +                       git_configset_clear(&cs);
> +               }
> +
> +               free(from_file);
> +               free(to_file);
> +       }
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> @@ -201,6 +201,21 @@ test_expect_success 'add to sparse-checkout' '
> +test_expect_success 'worktree: add copies sparse-checkout patterns' '
> +       cat repo/.git/info/sparse-checkout >old &&
> +       test_when_finished cp old repo/.git/info/sparse-checkout &&
> +       test_when_finished git -C repo worktree remove ../worktree &&
> +       git -C repo sparse-checkout set --no-cone "/*" &&
> +       git -C repo worktree add --quiet ../worktree 2>err &&
> +       test_must_be_empty err &&
> +       new=repo/.git/worktrees/worktree/info/sparse-checkout &&

For robustness, this should be using:

    new=$(git rev-parse --git-path info/sparse-checkout)

to retrieve ".git/worktrees/<id>/info/sparse-checkout" rather than
hard-coding "worktree" for "<id>".

> +       test_path_is_file $new &&
> +       test_cmp repo/.git/info/sparse-checkout $new &&
> +       git -C worktree sparse-checkout set --cone &&
> +       test_cmp_config -C worktree true core.sparseCheckoutCone &&
> +       test_must_fail git -C repo core.sparseCheckoutCone
> +'
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index 37ad79470fb..3fb5b21b943 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -165,8 +165,50 @@ test_expect_success '"add" default branch of a bare repo' '
>         (
>                 git clone --bare . bare2 &&
>                 cd bare2 &&
> -               git worktree add ../there3 main
> -       )
> +               git worktree add ../there3 main &&
> +               cd ../there3 &&
> +               git status
> +       ) &&

Is this some debugging code you forgot to remove or was `git status`
failing due to the bug(s) fixed by this patch series? I'm guessing the
latter since you also use `git status` in more tests below. Anyhow,
it's not very clear what the `git-status` is meant to be testing. An
in-code comment _might_ help. Even better, perhaps, would be to add a
new single-purpose test or a well-named function which explicitly
checks the conditions you want to test (i.e. that git-config doesn't
report core.bare as true or core.worktree as having a value).

> +       cat >expect <<-EOF &&
> +       init.t
> +       EOF
> +       ls there3 >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success '"add" to bare repo with worktree config' '
> +       (
> +               git clone --bare . bare3 &&
> +               cd bare3 &&
> +               git config extensions.worktreeconfig true &&
> +               git config --worktree core.bare true &&
> +               git config --worktree core.worktree "$(pwd)" &&

It's not clear to the casual reader why these nonsensical keys are
being added. An in-code comment explaining the reason (i.e. you expect
the `git worktree add` operation to drop them in the new worktree)
would be beneficial for future readers.

> +               git config --worktree bogus.key value &&
> +               git config --unset core.bare &&

Why is this being unset? (Genuine question. Am I missing something obvious?)

> +               git worktree add ../there4 main &&
> +               cd ../there4 &&
> +               git status &&
> +               git worktree add --detach ../there5 &&
> +               cd ../there5 &&
> +               git status
> +       ) &&

Same comment about the purpose of git-status not being obvious. A
well-named function which checks the specific conditions you're
looking for would be more clear than abstruse invocations of
git-status.

> +       # the worktree has the arbitrary value copied.
> +       test_cmp_config -C there4 value bogus.key &&
> +       test_cmp_config -C there5 value bogus.key &&
> +
> +       # however, core.bare and core.worktree were removed.
> +       test_must_fail git -C there4 config core.bare &&
> +       test_must_fail git -C there4 config core.worktree &&

This is the comment I was looking for above. It's certainly okay to
have it here, but it was confusing above to not understand the reason
those nonsensical keys were being added.

> +       cat >expect <<-EOF &&
> +       init.t
> +       EOF
> +
> +       ls there4 >actual &&
> +       test_cmp expect actual &&
> +       ls there5 >actual &&
> +       test_cmp expect actual
>  '

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48969C433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 22:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242417AbiBOWYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:24:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiBOWYU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 17:24:20 -0500
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924C27085A
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:24:09 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id w20so357584plq.12
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jW0PIpeMAxaBCxT1FtLElG3pwotfZ+SZj3V6IMgJAqw=;
        b=4QxMA+Q1FqsMtijx18xf/gzhT8CbV7OO9BTHV3Ujybj2WHFKwb/FW2zJ7wOMVC+UZ7
         ihXP61W9QtEBm5Noq8C92e/zIdO9dzDK9cq2ocMU8Uup4bACe09z9gCc+GiiDPX/JXLa
         z/CbPEvlksbPNITWAgoI6AxSGXIvff6rmOWIrXfJl+om7WAWXv7DpBqAHy37VVJH/WCT
         mjKDrmZW+MTjWfo3dtm2GMt1HGrOGjMLxbOkW2WvBZRQVsy5jTOsr/MvoeCmVBscQ/eP
         tt1sTLUVC7L0xntaaQ0N2L++9Si8omJclassX28hOXNn9RX+FqmbCMU8bxd8DG1HV1Mn
         kfIQ==
X-Gm-Message-State: AOAM533PTLWDFj4wrHFLO4ZfPR0EqU2nWEw+CBnyklRVTzzq6gE2OF5N
        alSwhnqj/HVIpIg58jMu7Gk9FKAt6nx1h8ASBHFzgORbfC8=
X-Google-Smtp-Source: ABdhPJzjVgYDRy/h2hio1S3eK1Z+eOM6gB4hJ2hfxC8AaOLoj2LsjeyMJ7hrHvZuQWVsKOP2iOlLHif5bP4NgsjqzhI=
X-Received: by 2002:a17:902:a988:: with SMTP id bh8mr1162908plb.35.1644963848986;
 Tue, 15 Feb 2022 14:24:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com> <c51cb3714e7b1d2f8c9370fe87eca9984ff4859f.1644269584.git.gitgitgadget@gmail.com>
In-Reply-To: <c51cb3714e7b1d2f8c9370fe87eca9984ff4859f.1644269584.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 15 Feb 2022 17:23:57 -0500
Message-ID: <CAPig+cS+q-X1KLRp6fV5Lvd80wX8WZ1993OXisQUk2ra_kJ1wA@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] worktree: copy sparse-checkout patterns and config
 on add
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 7, 2022 at 4:33 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When adding a new worktree, it is reasonable to expect that we want to
> use the current set of sparse-checkout settings for that new worktree.
> This is particularly important for repositories where the worktree would
> become too large to be useful. This is even more important when using
> partial clone as well, since we want to avoid downloading the missing
> blobs for files that should not be written to the new worktree.
> [...]
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -335,6 +335,69 @@ static int add_worktree(const char *path, const char *refname,
> +       /*
> +        * If the current worktree has sparse-checkout enabled, then copy
> +        * the sparse-checkout patterns from the current worktree.
> +        */
> +       if (core_apply_sparse_checkout) {
> +               char *from_file = git_pathdup("info/sparse-checkout");
> +               char *to_file = xstrfmt("%s/info/sparse-checkout",
> +                                       sb_repo.buf);
> +
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
> +       if (repository_format_worktree_config) {
> +               char *from_file = git_pathdup("config.worktree");
> +               char *to_file = xstrfmt("%s/config.worktree",
> +                                       sb_repo.buf);
> +
> +               if (file_exists(from_file)) {
> +                       struct config_set cs = { { 0 } };
> +                       const char *core_worktree;
> +                       int bare;
> +
> +                       if (safe_create_leading_directories(to_file) ||
> +                           copy_file(to_file, from_file, 0666)) {
> +                               error(_("failed to copy worktree config from '%s' to '%s'"),
> +                                     from_file, to_file);
> +                               goto worktree_copy_cleanup;
> +                       }
> +
> +                       git_configset_init(&cs);
> +                       git_configset_add_file(&cs, from_file);
> +
> +                       if (!git_configset_get_bool(&cs, "core.bare", &bare) &&
> +                           bare &&
> +                           git_config_set_multivar_in_file_gently(
> +                                       to_file, "core.bare", NULL, "true", 0))
> +                               error(_("failed to unset 'core.bare' in '%s'"), to_file);
> +                       if (!git_configset_get_value(&cs, "core.worktree", &core_worktree) &&
> +                           git_config_set_in_file_gently(to_file,
> +                                                         "core.worktree", NULL))
> +                               error(_("failed to unset 'core.worktree' in '%s'"), to_file);
> +
> +                       git_configset_clear(&cs);
> +               }
> +
> +worktree_copy_cleanup:
> +               free(from_file);
> +               free(to_file);
> +       }

Given that add_worktree() is already overly long, a good future
cleanup would be to move these two new hunks of functionality into
separate functions -- copy_sparsity() and copy_config(), perhaps -- in
builtin/worktree.c. This should be simple enough since (I think) the
only state that needs to be passed to them is `sb_repo`. But such
cleanup needn't hold up this series.

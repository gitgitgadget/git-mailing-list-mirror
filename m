Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB287C43465
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 15:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0EC220866
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 15:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgIUPnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 11:43:35 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:45660 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgIUPnf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 11:43:35 -0400
Received: by mail-ej1-f65.google.com with SMTP id i26so18350471ejb.12
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 08:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRvnqALbCjT1lKYdrpnYqbK8TR+Wc8DPYZujZk7PMiY=;
        b=g2daUT4CfRNgnwWdb2/Rvnyuuyd2TFq83UIJqcF3Zag/baz4lU17ZWuVincq9Ww8cA
         KY311y2UpR14cXztaCYsuIo5lq028gGe+ZnGtU6uhl1lAm97tFsJRgmQz2jCnX+4PrfN
         UnkwkDeXrjV2RUNka2kP1/SU6HTTDPRLBTVKz2Xb1kVuu43N1zD2dfLwMTcbn0uzqcsP
         Y/OBKB2hnzzQXDpvaTcIHu8zk+9dXDg4RjfHeC/OohF27VykQNSPiC7N2OkW7VOqXIu5
         TqIET0SJvLcVBNoGeFfE2nE07XSfrQ9v5lg/T8ycl54Cez9ibz2pBpiuSCihu+vcJtHB
         8NtQ==
X-Gm-Message-State: AOAM533wt5EpIROC995ef50x3tI5MzPN55lZJzU2QQSDfSj0yZDkmsRO
        vE7EbdVOOL/wS4zp44j9GFDl1cyUlaWPzYzJtTg=
X-Google-Smtp-Source: ABdhPJwO9+4jEQXZoEsZYefLcFt84PGrew7Ta1Kz9awkUUYsDJzJwhtq3OFeoQw4wv1c2fQeJgYnaAobfMrQ1I/ZDBY=
X-Received: by 2002:a17:906:552:: with SMTP id k18mr49560eja.482.1600703013355;
 Mon, 21 Sep 2020 08:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.736.git.1600695050.gitgitgadget@gmail.com> <7f851e7c20aafdae5d5ae46ee1083b32ecc82c84.1600695050.git.gitgitgadget@gmail.com>
In-Reply-To: <7f851e7c20aafdae5d5ae46ee1083b32ecc82c84.1600695050.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 Sep 2020 11:43:22 -0400
Message-ID: <CAPig+cQNiB8nw-JwwFweHzeFYcozGA06pPKr=0N9Metp8PBbSQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] commit: add an option the reword HEAD
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 21, 2020 at 9:31 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> +--reword::
> +       Reword the commit message of the tip of the current branch by
> +       replacing it with a new commit. The commit contents will be
> +       unchanged even if there are staged changes. This is equivalent
> +       to specifying `--amend --only --allow-empty` with no paths.
> diff --git a/builtin/commit.c b/builtin/commit.c
> @@ -1152,6 +1153,41 @@ static void finalize_deferred_config(struct wt_status *s)
> +static void validate_reword_options(int argc, struct commit *current_head)
> +{
> +       if (amend)
> +               die(_("cannot combine --reword with --amend"));
> +       if (only)
> +               die(_("cannot combine --reword with --only"));

Nit: It feels a bit odd (though not outright wrong) to disallow
--reword in combination with --amend and --only after the
documentation states that --reword is equivalent to using those
options.

> diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
> @@ -713,4 +713,60 @@ test_expect_success '--dry-run --short' '
> +test_reword_opt () {
> +       test_expect_success C_LOCALE_OUTPUT "--reword incompatible with $1" "
> +               echo 'fatal: cannot combine --reword with $1' >expect &&
> +               test_must_fail git commit --reword $1 2>actual &&
> +               test_cmp expect actual
> +       "
> +}

These error messages are subject to localization, so you'd want to use
test_i18ncmp() here, I think.

Same comment for other new tests.

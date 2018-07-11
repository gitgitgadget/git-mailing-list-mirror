Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1389E1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 18:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387995AbeGKSyw convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 11 Jul 2018 14:54:52 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:40119 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733295AbeGKSyw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 14:54:52 -0400
Received: by mail-yb0-f194.google.com with SMTP id y11-v6so10431047ybm.7
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 11:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GRJd1jB2l51KK8eN00bz9ExySU4hf3u3UowH9Fbak5Q=;
        b=oAjOCrGm1e6lejtxVopWo3caVdLr8VCZlnG3h3FGR+V0Snc5ZID4qoRruVsN+jPgXD
         gUGcIwNv4XgvV2Vjz7EbuybPP6nYuNIn66rRDEk0gadFi4wAMDaROX0SHnEvGI69B3lM
         aB+LzFPPbKCmhXe6UAjS3hbCnjHHBdiqn5dmK8cy464N/DNQI+l5D6U9aFhPUo5Es3o5
         rQZXm5pJITDiRRWPWx60LSSW7S0aO+vGCtQACsQm9dHF44+z/G9d6ovXP6swM3lHbzPj
         XwHDdUmeBa2gqWvnx73zDBGaolZ9eJ+jSOJTo2cTCZbQOjhN978VYj9IJzrlVJIZZJS+
         PG7Q==
X-Gm-Message-State: APt69E25mWtwwp5WKBO/jMoedzOiI1NP23ELlnQyywWNxB7bpr8ZRlUD
        6/Io4GOgsE6HdCZrt2pDTU1CmSXuQeryEg1/sMAB0g==
X-Google-Smtp-Source: AAOMgpfxXH2fFGmbx/P38rIT2tLW/RMkMs3kFV+/mztzBbBeESfno2ZYPEV3EUfz4Gz/XPFmmIuwn1HX/9i2lvBFiDw=
X-Received: by 2002:a25:d38f:: with SMTP id e137-v6mr15617176ybf.287.1531334954417;
 Wed, 11 Jul 2018 11:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.8.git.gitgitgadget@gmail.com> <03d0907ec61f0ea53b59659c84b8a6662e9e7607.1531312689.git.gitgitgadget@gmail.com>
In-Reply-To: <03d0907ec61f0ea53b59659c84b8a6662e9e7607.1531312689.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 11 Jul 2018 14:49:03 -0400
Message-ID: <CAPig+cS1KQseynMCGC_6FZwzB0waJX8+C7CVKNqACzOhjB4uSg@mail.gmail.com>
Subject: Re: [PATCH 2/3] rebase --rebase-merges: add support for octopus merges
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 8:38 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Previously, we introduced the `merge` command for use in todo lists,
> to allow to recreate and modify branch topology.
>
> For ease of implementation, and to make review easier, the initial
> implementation only supported merge commits with exactly two parents.
>
> This patch adds support for octopus merges, making use of the
> just-introduced `-F <file>` option for the `git merge` command: to keep
> things simple, we spawn a new Git command instead of trying to call a
> library function, also opening an easier door to enhance `rebase
> --rebase-merges` to optionally use a merge strategy different from
> `recursive` for regular merges: this feature would use the same code
> path as octopus merges and simply spawn a `git merge`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

A few minor notes below (not a proper review)...

> diff --git a/sequencer.c b/sequencer.c
> @@ -2932,7 +2966,8 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
> -                       strbuf_addf(&buf, "Merge branch '%.*s'",
> +                       strbuf_addf(&buf, "Merge %s '%.*s'",
> +                                   to_merge->next ? "branches" : "branch",

Error messages in this file are already localizable. If this text ever
becomes localizable, then this "sentence lego" could be problematic
for translators.

> @@ -2956,28 +2991,76 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
> +               cmd.git_cmd = 1;
> +               argv_array_push(&cmd.args, "merge");
> +               argv_array_push(&cmd.args, "-s");
> +               argv_array_push(&cmd.args, "octopus");

argv_array_pushl(&cmd.args, "-s", "octopus", NULL);

which would make it clear that these two arguments must remain
together, and prevent someone from coming along and inserting a new
argument between them.

> +               argv_array_push(&cmd.args, "--no-edit");
> +               argv_array_push(&cmd.args, "--no-ff");
> +               argv_array_push(&cmd.args, "--no-log");
> +               argv_array_push(&cmd.args, "--no-stat");
> +               argv_array_push(&cmd.args, "-F");
> +               argv_array_push(&cmd.args, git_path_merge_msg());

Ditto:
argv_array_pushl(&cmd.args, "-L", git_path_merge_msg(), NULL);

> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> @@ -329,4 +329,38 @@ test_expect_success 'labels that are object IDs are rewritten' '
> +test_expect_success 'octopus merges' '
> +       git checkout -b three &&
> +       test_commit before-octopus &&
> +       test_commit three &&
> +       git checkout -b two HEAD^ &&
> +       test_commit two &&
> +       git checkout -b one HEAD^ &&
> +       test_commit one &&
> +       test_tick &&
> +       (GIT_AUTHOR_NAME="Hank" GIT_AUTHOR_EMAIL="hank@sea.world" \
> +        git merge -m "Tüntenfüsch" two three) &&

Unnecessary subshell?

> +       : fast forward if possible &&
> +       before="$(git rev-parse --verify HEAD)" &&
> +       test_tick &&
> +       git rebase -i -r HEAD^^ &&
> +       test_cmp_rev HEAD $before &&
> +
> +       test_tick &&
> +       git rebase -i --force -r HEAD^^ &&
> +       test "Hank" = "$(git show -s --format=%an HEAD)" &&
> +       test "$before" != $(git rev-parse HEAD) &&
> +       test_cmp_graph HEAD^^.. <<-\EOF
> +       *-.   Tüntenfüsch
> +       |\ \
> +       | | * three
> +       | * | two
> +       | |/
> +       * | one
> +       |/
> +       o before-octopus
> +       EOF
> +'

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC94C433E6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 03:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419D4230F9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 03:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbhAGDfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 22:35:08 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:42536 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbhAGDfF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 22:35:05 -0500
Received: by mail-ed1-f49.google.com with SMTP id g24so6348739edw.9
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 19:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9SGoJsn91SOu+Max2d/BQM/eHAG1q5A1tPjdqYdxpO0=;
        b=dtA6vyjvn3/n3pRRIG7X2/twlW7dli44A4ZJW5GjpY6qVcicBIfnCtMHG3tEHjQdyg
         vSARV66qVP8lXexQiltmuPg82Kmylht4VInt+Q3gLoqdOgNdIdfXZ8ZirltSDEFON9qs
         cCYQMh+sLmE9EBFwAu042WhOHA5Zliem9RRnUtySdeZ1paJHiqVMCCdb8YotJyVmLw62
         bFLeAugOE1Yxi9dARbnclHPjs7pWi8YVIAgFtOfqYO5qkGY+3r26qqpaF/VTK+wMe+4U
         qmRJx26TikztwI2J0AuzSSphJUr3/U77fiCCpQb9PzbC1VsdbM7mx8B+QdcLv6GSeYs/
         xtOA==
X-Gm-Message-State: AOAM5329bc3YPrUadA0dCH/YWJ+ZQSlcO2p7px0+4xTjBklg6l+URnT/
        htlvItr+Fc3qPmlm87uv7fGtzjjP+zdYtonfYq3baG6nsg5TPQ==
X-Google-Smtp-Source: ABdhPJxZNtXGSpGkvtxE8A4iF+IAqFP8TT2yOcjISd3EZZFFiaZkdZjPadUJEUtVzQkIHXZgA8riAkqnlqNG9HaNI+k=
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr132015edu.163.1609990461915;
 Wed, 06 Jan 2021 19:34:21 -0800 (PST)
MIME-Version: 1.0
References: <428d16e8-fdb8-a587-6a0b-39c6c50eba99@gmail.com> <20210105110219.99610-1-phillip.wood123@gmail.com>
In-Reply-To: <20210105110219.99610-1-phillip.wood123@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Jan 2021 22:34:10 -0500
Message-ID: <CAPig+cT-9sjmkdWFEcFS=rg9ziV9b6uWNMpQ8BTYP-a258La6Q@mail.gmail.com>
Subject: Re: [PATCH] worktree: add -z option for list subcommand
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 5, 2021 at 6:02 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> Add a -z option to be used in conjunction with --porcelain that gives
> NUL-terminated output. This enables 'worktree list --porcelain' to
> handle worktree paths that contain newlines.

Adding a -z mode makes a lot of sense. This, along with a fix to call
quote_c_style() on paths in normal (not `-z`) porcelain mode, can
easily be done after Rafael's series lands. Or they could be done
before his series, though that might make a lot of extra work for him.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> I found an old patch that added NUL termination. I've rebased it
> but the new test fails as there seems to be another worktree thats
> been added since I wrote this, anyway I thought it might be a useful
> start for adding a `-z` option.

The test failure is fallout from a "bug" in a test added by Rafael's
earlier series[1] which was not caught by the reviewer[2]. In fact,
his current series has a drive-by fix[3] for this bug in patch [6/7].
Applying that fix (or the refinement[4] I suggested in my review)
makes your test work.

[1]: https://lore.kernel.org/git/20201011101152.5291-2-rafaeloliveira.cs@gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cS8hvX4GCsnfLBnQ4Q_AkUad=bw7rjVcaOqSEqcLZvx8w@mail.gmail.com/
[3]: https://lore.kernel.org/git/20210104162128.95281-7-rafaeloliveira.cs@gmail.com/
[4]: https://lore.kernel.org/git/CAPig+cRysXpK0e1xXOuVd+EtkeyTk8FR6MUrL=Bg3W4ve8jdNA@mail.gmail.com/

> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -217,7 +217,13 @@ This can also be set up as the default behaviour by using the
> +-z::
> +       When `--porcelain` is specified with `list` terminate each line with a
> +       NUL rather than a newline. This makes it possible to parse the output
> +       when a worktree path contains a newline character.

If we fix normal-mode porcelain to call quote_c_style(), then we can
drop the last sentence or refine it to say something along the lines
of it being easier to deal with paths with embedded newlines than in
normal porcelain mode.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -640,19 +640,25 @@ static int add(int ac, const char **av, const char *prefix)
> +static void show_worktree_porcelain(struct worktree *wt, int line_terminator)
>  {
> +       printf("worktree %s", wt->path);
> +       fputc(line_terminator, stdout);
> +       if (wt->is_bare) {
> +               printf("bare");
> +               fputc(line_terminator, stdout);
> +       } else {
> +               printf("HEAD %s", oid_to_hex(&wt->head_oid));
> +               fputc(line_terminator, stdout);
> +               if (wt->is_detached) {
> +                       printf("detached");
> +                       fputc(line_terminator, stdout);
> +               } else if (wt->head_ref) {
> +                       printf("branch %s", wt->head_ref);
> +                       fputc(line_terminator, stdout);
> +               }

Perhaps this could all be done a bit more concisely with printf()
alone rather than combining it with fputc(). For instance:

    printf("worktree %s%c", wt->path, line_terminator);

and so on.

> -       printf("\n");
> +       fputc(line_terminator, stdout);

This use of fputc() makes sense.

> @@ -720,15 +726,20 @@ static void pathsort(struct worktree **wt)
>  static int list(int ac, const char **av, const char *prefix)
>  {
> +               OPT_SET_INT('z', NULL, &line_terminator,
> +                           N_("fields are separated with NUL character"), '\0'),

"fields" sounds a little odd. "lines" might make more sense. "records"
might be even better and matches the wording of some other Git
commands accepting `-z`.

> +       else if (!line_terminator && !porcelain)
> +               die(_("'-z' requires '--porcelain'"));

Other error messages in this file don't quote command-line options, so:

    die(_("-z requires --porcelain"));

would be more consistent.

> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> @@ -71,6 +71,28 @@ test_expect_success '"list" all worktrees with locked annotation' '
> +test_expect_success '"list" all worktrees --porcelain -z' '
> +       test_when_finished "rm -rf here _actual actual expect &&
> +                               git worktree prune" &&
> +       printf "worktree %sQHEAD %sQbranch %sQQ" \
> +               "$(git rev-parse --show-toplevel)" \
> +               "$(git rev-parse HEAD)" \
> +               "$(git symbolic-ref HEAD)" >expect &&
> +       git worktree add --detach here master &&
> +       printf "worktree %sQHEAD %sQdetachedQQ" \
> +               "$(git -C here rev-parse --show-toplevel)" \
> +               "$(git rev-parse HEAD)" >>expect &&
> +       git worktree list --porcelain -z >_actual &&
> +       cat _actual | tr "\0" Q >actual &&

Or just use nul_to_q():

    nul_to_q <_actual >actual &&

(And there's no need to `cat` the file.)

> +       test_cmp expect actual
> +'
> +
> +test_expect_success '"list" -z fails without --porcelain' '
> +       test_when_finished "rm -rf here && git worktree prune" &&
> +       git worktree add --detach here master &&
> +       test_must_fail git worktree list -z
> +'

I don't think there's any need for this test to create (and cleanup) a
worktree. So, the entire test could collapse to:

    test_expect_success '"list" -z fails without --porcelain' '
        test_must_fail git worktree list -z
    '

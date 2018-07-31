Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E04D51F597
	for <e@80x24.org>; Tue, 31 Jul 2018 21:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbeGaXV4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 19:21:56 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36796 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732164AbeGaXV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 19:21:56 -0400
Received: by mail-yb0-f194.google.com with SMTP id s1-v6so6745614ybk.3
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 14:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4MnHMRNNRnOVeBIVN3x7Y27o8ptdAGv1kfqHeciNRRk=;
        b=TV7WGXCgB5Y34C4j6qeH2DSLp0zlXjhPB9ioyDBbf6wkA3oqLR6ho060cefrYmK708
         lYcW5fuIAvf90R8ecvg4ctkShOUuXstxc3Ur5Qs0Sussrp+mbrMVKRG5OxHz0dOwyQOB
         aZYpLMklCBMP3togBx0gcJKGYoz6I67XeTauUJ5uPF5IFOSa9pp3IvOcxouZOO7FD1wP
         aWUafUA6NZp5aZXp621TsFb+PeAtIrnhGX/dVfJJx1DGlwiQap3AGHjOg6KGKqXLZOld
         xFFFKuNjrCLhcp8qeRffVUuSnOykMobZ9I8S32XfON++vJlazq4gZVFGdFHeaesVZiLK
         gP3w==
X-Gm-Message-State: AOUpUlHIwOi0CeIH2LObALY7PRFFBVee69z9Ncdq9t0oD1ocB4MvigJp
        Ia5/XJWJc8IX9O3tsujVAoWkgyitMumrwLC6qKBGNg==
X-Google-Smtp-Source: AAOMgpd8g++J2e5fBQOlCLX+7WIGrAyfXro4JokVEmBS0zbmL7c7ua3xspDyHJiAEEwet/BInxeQeqcIvjR+Yrvo0l0=
X-Received: by 2002:a25:488a:: with SMTP id v132-v6mr12615531yba.263.1533073176395;
 Tue, 31 Jul 2018 14:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180731111532.9358-1-phillip.wood@talktalk.net> <20180731111532.9358-3-phillip.wood@talktalk.net>
In-Reply-To: <20180731111532.9358-3-phillip.wood@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 31 Jul 2018 17:39:25 -0400
Message-ID: <CAPig+cR5VHP8muo5_A_9t7OPZam8O_uPb0nd73B15Ye92n+p7Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sequencer: fix quoting in write_author_script
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 7:15 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> Single quotes should be escaped as \' not \\'. Note that this only
> affects authors that contain a single quote and then only external
> scripts that read the author script and users whose git is upgraded from
> the shell version of rebase -i while rebase was stopped. This is because
> the parsing in read_env_script() expected the broken version and for
> some reason sq_dequote() called by read_author_ident() seems to handle
> the broken quoting correctly.

Is the:

    ...for some reason sq_dequote() called by read_author_ident()
    seems to handle the broken quoting correctly.

bit outdated? We know now from patch 2/4 of my series[1] that
read_author_ident() wasn't handling it correctly at all. It was merely
ignoring the return value from sq_dequote() and using whatever broken
value came back from it.

[1]: https://public-inbox.org/git/20180731073331.40007-3-sunshine@sunshineco.com/

> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -664,14 +664,25 @@ static int write_author_script(const char *message)
>  static int read_env_script(struct argv_array *env)
>  {
>         if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
>                 return -1;

This is not a problem introduced by this patch, but since
strbuf_read_file() doesn't guarantee that memory hasn't been allocated
when it returns an error, this is leaking.

> +       /*
> +        * write_author_script() used to fail to terminate the GIT_AUTHOR_DATE
> +        * line with a "'" and also escaped "'" incorrectly as "'\\\\''" rather
> +        * than "'\\''". We check for the terminating "'" on the last line to
> +        * see how "'" has been escaped in case git was upgraded while rebase
> +        * was stopped.
> +        */
> +       sq_bug = script.len && script.buf[script.len - 2] != '\'';

I think you need to be checking 'script.len > 1', not just
'script.len', otherwise you might access memory outside the allocated
buffer.

This is a very "delicate" check, assuming that a hand-edited file
won't end with, say, an extra newline. I wonder if this level of
backward-compatibility is overkill for such an unlikely case.

>         for (p = script.buf; *p; p++)
> -               if (skip_prefix(p, "'\\\\''", (const char **)&p2))
> +               if (sq_bug && skip_prefix(p, "'\\\\''", &p2))
> +                       strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
> +               else if (skip_prefix(p, "'\\''", &p2))
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> @@ -75,6 +75,22 @@ test_expect_success 'rebase --keep-empty' '
> +test_expect_success 'rebase -i writes correct author-script' '
> +       test_when_finished "test_might_fail git rebase --abort" &&
> +       git checkout -b author-with-sq master &&
> +       GIT_AUTHOR_NAME="Auth O$SQ R" git commit --allow-empty -m with-sq &&
> +       set_fake_editor &&
> +       FAKE_LINES="edit 1" git rebase -ki HEAD^ &&

Hmph, -k doesn't seem to be documented in git-rebase.txt. Is it needed here?

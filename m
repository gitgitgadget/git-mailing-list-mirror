Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6F5C433E0
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 07:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE9764E25
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 07:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhAaHew (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 02:34:52 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48]:36494 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhAaHc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 02:32:27 -0500
Received: by mail-ej1-f48.google.com with SMTP id l9so19328625ejx.3
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 23:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sV9OJaheqv9uzcVFfqeAbHmcCKlr2Ns+Y6qfADXh2h8=;
        b=H4nsw4qjFCyug7fi5lAMOJESWCpK2Ed5TIgeI6h05qfEyLgIBE7cUVwzJogdcPe3CF
         0zjYLioMcYU2YedznAh7RptGMcAfgyDj26jxuO3H00AKkuyNWcHwt4KK9MP1nzl5U17o
         E8bZFZ3djZ+0LcmyhlQMr4PDr79Oa53slKJeFTpZIhDAwRCdkQ2k5nZXI4XJigv1vAj2
         Wrf8S9jjTnQBQxb2pWUX70FTfFdyYgjOSK1LsIn5yIIUvBrrCWcsIjTM19CSDozhgcYf
         UB3t6WiJZXXpvdLQUXATGYwBGcjich5OU7z2wnw+dwdOmLPNXdy/7+hq5g7dJMDAvUuw
         +98Q==
X-Gm-Message-State: AOAM530v02QHoy7DkCvsL/jRufttUlM/ES6rSlIcYbBrrMvHCvgzjGN6
        MDqsX8AvQoOL/+e/81P89lTOaIU2J9KPRxN2i8o=
X-Google-Smtp-Source: ABdhPJwkjh+d/0ak17HQvagclYi8ksfcN5x6OM6tHkElPo1AFui1UIFumnrXaSpEQF3/fgs2QheWhM2HeAsGnRniblI=
X-Received: by 2002:a17:906:6d94:: with SMTP id h20mr12522762ejt.231.1612078305289;
 Sat, 30 Jan 2021 23:31:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.854.git.1612021544723.gitgitgadget@gmail.com>
In-Reply-To: <pull.854.git.1612021544723.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 31 Jan 2021 02:31:34 -0500
Message-ID: <CAPig+cQMn6oc4Jh=gb1jNfArXJBYhPRaSzJJvvbvprit6_OC0g@mail.gmail.com>
Subject: Re: [PATCH] status: learn --color for piping colored output
To:     Lance Ward via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Lance Ward <ljward10@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 30, 2021 at 10:51 AM Lance Ward via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Many users like to pipe colored results of git status to other commands
> such as more or less, but by default colors are lost when piping without
> changing the user's git configuration.  Many other commands such as diff,
> show, log and grep have a --color option to easily override this behavior.
> This allows the status command to have a similar --color option providing
> a simpler mechanism for temporarily forcing piped colored output.

Thanks, makes sense.

> Signed-off-by: Lance Ward <ljward10@gmail.com>
> ---
>  builtin/commit.c             |  7 ++++
>  diff.c                       |  5 +++
>  diff.h                       |  1 +
>  t/t7527-status-color-pipe.sh | 69 ++++++++++++++++++++++++++++++++++++

As this is introducing a new --color option to `git status`, it should
be accompanied by an update to Documentation/git-status.txt.

> diff --git a/builtin/commit.c b/builtin/commit.c
> @@ -1410,6 +1412,11 @@ int cmd_status(int argc, const char **argv, const char *prefix)
> +       if (use_color != GIT_COLOR_AUTO) {
> +               s.use_color=use_color;
> +               set_diff_color(use_color);
> +       }
> diff --git a/diff.c b/diff.c
> @@ -261,6 +261,11 @@ void init_diff_ui_defaults(void)
> +void set_diff_color(int use_color)
> +{
> +       diff_use_color_default = use_color;
> +}
> diff --git a/diff.h b/diff.h
> @@ -501,6 +501,7 @@ int parse_long_opt(const char *opt, const char **argv,
> +void set_diff_color(int use_color);

This new API for setting `diff_use_color_default` feels a bit too
quick-and-dirty and assumes that the caller has intimate knowledge
about when it is safe/correct to call the new function. Did you
consider the alternate approach of having wt-status functionality set
the appropriate diff_options.use_color value at the time it drives the
diff machinery? For instance, as a test, I added:

    rev.diffopt.use_color = s->use_color;

to the functions wt-status.c:wt_status_collect_changes_worktree(),
wt_status_collect_changes_index(), and wt_longstatus_print_verbose(),
so that the `use_color` value from the `struct wt_status *` supplied
by commit.c:cmd_status() is automatically applied to the diff options.

(Note that this was just a quick test. I dug through the code just
enough to locate these functions as the likely correct place to set
diff_options.use_color, but didn't spend any time verifying that all
three functions need to be patched like this. I also didn't verify
that my changes won't stomp on --porcelain's explicit disabling of
color, which is something that ought to be checked. There's also some
custom `use_color` handling going on in wt_longstatus_print_verbose()
of which to be aware.)

> diff --git a/t/t7527-status-color-pipe.sh b/t/t7527-status-color-pipe.sh
> @@ -0,0 +1,69 @@
> +# Normal git status does not pipe colors
> +test_expect_success 'git status' '
> +       git status >out &&
> +       test_i18ngrep "original$" out
> +'

None of the text being checked by any of the tests being added by this
file is subject to localization, so use of test_i18ngrep() is
unwarranted. Use plain old `grep` instead here and elsewhere.

> +# Test new color option with never (expect same as above)
> +test_expect_success 'git status --color=never' '
> +       git status --color=never >out &&
> +       test_i18ngrep "original$" out
> +'
> +
> +# Test new color (default is always)
> +test_expect_success 'git status --color' '
> +       git status --color |
> +       test_decode_color >out &&
> +       test_i18ngrep "original<RESET>$" out
> +'

If someone introduces a bug which causes the non-colored tests to
incorrectly emit color codes, then it will be easier to debug the
problem if you also pass the output through test_decode_color() even
for the non-colored tests rather than only for the expect-colored
tests. Thus, I'd recommend calling test_decode_color() in all the
tests, even if you don't expect color to be emitted.

Also, these days, we don't normally place a Git command upstream in a
pipe since its exit code will be lost. Instead, we capture the output
to a file:

    git status --color >raw &&
    test_decode_color <raw >out &&
    ...

> +test_done
> +# Test verbose --color=always
> +test_expect_success 'git status -v --color=always' '
> +       git status -v --color=always |
> +       test_decode_color >out &&
> +       test_i18ngrep "<CYAN>@@ -0,0 +1 @@<RESET>" out &&
> +       test_i18ngrep "GREEN>+<RESET><GREEN>1<RESET>" out
> +'
> +
> +test_done

You have one too many calls to test_done() in this fragment. I think
you only want to keep the final test_done() and remove the one prior
to the last test.

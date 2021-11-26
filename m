Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9742C433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 09:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376450AbhKZJxj convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 26 Nov 2021 04:53:39 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:37637 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376499AbhKZJvi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 04:51:38 -0500
Received: by mail-pj1-f42.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so9546007pjb.2
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 01:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9pRGLU4EZbyVUrOniTAoC7rXYUFhv/NtSVh7r+ivEPw=;
        b=vID6VZZRzrsWOLn36t2Z1JF0SEOOx1zfMfd6Uuoo7RbYHgAO9DsMzx3qaxLcVvJnhz
         gaj5/8pzYUhz9hMGFXZycGD8zphBHYl1Tcwl817b77zo4+zI50ktIDF74RwPNNwIUJq1
         COCX3zJagyhM9v6R8KgBxP+Dmjy6JC59Xknl52mrnGHvkqoyoDHIIbCiuQSfqf1axNnb
         +AWdbYse/fGKv/g8kTMTNDT2sxvVOrsxuM1hxNZU5tn7OHMLh9Khj/SgTebMLN3VzaRm
         2MD4/4sm3ONcjXwSJ/SknVkUlMg59u1phYRZVA36EyhDGaGtZCtq2Fy1HFPE2RA5fUVP
         L6Iw==
X-Gm-Message-State: AOAM531kSNvBWiAjlKK+Lr6xdArYkXbFqZxZFZeo6nzCxMwlwD6/bFP5
        l31FyKhafYGKGFNLoWUsRf8uTjlck2yYoqa0kOI=
X-Google-Smtp-Source: ABdhPJwYMeZp2EPQQbv7S2zEPa9AB4fqjLVTC3+gXXINaJtbJa5W5Yju9lXLqGMccMxWcweCsg00FwEK7Ewm/goRm88=
X-Received: by 2002:a17:90a:b107:: with SMTP id z7mr14371539pjq.104.1637920105931;
 Fri, 26 Nov 2021 01:48:25 -0800 (PST)
MIME-Version: 1.0
References: <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com>
 <cover-v3-0.9-00000000000-20211125T224833Z-avarab@gmail.com> <patch-v3-1.9-1c3f9de33ad-20211125T224833Z-avarab@gmail.com>
In-Reply-To: <patch-v3-1.9-1c3f9de33ad-20211125T224833Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 26 Nov 2021 04:48:15 -0500
Message-ID: <CAPig+cRi6SeuV7k_+9JCcnf79daLZp5B=EyHK-KxC1VGN0B4ig@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] worktree: stop being overly intimate with
 run_command() internals
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Enzo Matsumiya <ematsumiya@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 25, 2021 at 5:52 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
>
> add_worktree() reuses a `child_process` for three run_command()
> invocations, but to do so, it has overly-intimate knowledge of
> run-command.c internals. In particular, it knows that it must reset
> child_process::argv to NULL for each subsequent invocation[*] in order
> for start_command() to latch the newly-populated child_process::args for
> each invocation, even though this behavior is not a part of the
> documented API. Beyond having overly-intimate knowledge of run-command.c
> internals, the reuse of one `child_process` for three run_command()
> invocations smells like an unnecessary micro-optimization. Therefore,
> stop sharing one `child_process` and instead use a new one for each
> run_command() call.

If people feel uncomfortable with the way this patch shadows `cp` in
nested blocks, an alternative would be to call child_process_init(&cp)
to reuse the existing `cp`, similar to the fix[1] applied to pager.c
when reusing a `child_process`. I don't feel strongly about it either
way.

[1]: https://lore.kernel.org/git/20211125000239.2336-1-ematsumiya@suse.de/

> [*] If child_process::argv is not reset to NULL, then subsequent
> run_command() invocations will instead incorrectly access a dangling
> pointer to freed memory which had been allocated by child_process::args
> on the previous run. This is due to the following code in
> start_command():
>
>     if (!cmd->argv)
>         cmd->argv = cmd->args.v;
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/worktree.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index d22ece93e1a..9edd3e2829b 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -355,8 +355,8 @@ static int add_worktree(const char *path, const char *refname,
>                 goto done;
>
>         if (opts->checkout) {
> -               cp.argv = NULL;
> -               strvec_clear(&cp.args);
> +               struct child_process cp = CHILD_PROCESS_INIT;
> +               cp.git_cmd = 1;
>                 strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
>                 if (opts->quiet)
>                         strvec_push(&cp.args, "--quiet");
> @@ -385,12 +385,11 @@ static int add_worktree(const char *path, const char *refname,
>                 const char *hook = find_hook("post-checkout");
>                 if (hook) {
>                         const char *env[] = { "GIT_DIR", "GIT_WORK_TREE", NULL };
> -                       cp.git_cmd = 0;
> +                       struct child_process cp = CHILD_PROCESS_INIT;
>                         cp.no_stdin = 1;
>                         cp.stdout_to_stderr = 1;
>                         cp.dir = path;
>                         cp.env = env;
> -                       cp.argv = NULL;
>                         cp.trace2_hook_name = "post-checkout";
>                         strvec_pushl(&cp.args, absolute_path(hook),
>                                      oid_to_hex(null_oid()),
> --
> 2.34.1.838.g779e9098efb

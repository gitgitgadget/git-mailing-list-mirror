Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D521F404
	for <e@80x24.org>; Thu, 16 Aug 2018 08:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390137AbeHPLkz (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 07:40:55 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33109 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730435AbeHPLky (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 07:40:54 -0400
Received: by mail-qk0-f193.google.com with SMTP id z78-v6so599181qka.0
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 01:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=258dF6iEXDPKUbM/Op+K0nVp6hBjOx8mArs8vdIZU8k=;
        b=Z4Sbn1aZySz9sFisurdkzggx8LpVLSD8KR2wNehLDBL8uPwnmcs7vfPcFSWNIOMIA1
         l/YwDqVfZ6fM5UIry+tklgX4IAavHWM+Nat/xwBbZgzETeqF16Zh4K8SEZWI57FYvae9
         QNLIntaVWn7tr+3UD8nLdSsCYvzeu7LMOEdSRGFvUBvfj+coay4tV5zumrvfreJ/6NOQ
         USVBx/gDEooTXlKssCpnLKEvvqsmps2VD82iwfFKJsPDN4S8qMlOUnCUhbAo6ajqWVKN
         IkF29jvR7YM/sIhoAFHztzebWnpcAXWbFYIoVZEHwpXMuIKC+lXpl1tUmyRRKlj801nY
         odmw==
X-Gm-Message-State: AOUpUlFisisxYyvEEfTWMnfjfpMEAPxTZoZ4/zkHy/O2mS5O0ndoSjbO
        TlI8E4zXGLn0cCewC7IuPKx9qGhizeREObTXLD8VdDF9
X-Google-Smtp-Source: AA+uWPzVESELaHW4mNrZLh+tgLlrvC6fO34pdJGgQkyE8o+q8xd4G3kOnVl70V3/OeHgPhvAojmaNRoGlXhCKb8Lvg0=
X-Received: by 2002:a37:50c3:: with SMTP id e186-v6mr26444295qkb.91.1534409035801;
 Thu, 16 Aug 2018 01:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180815205630.32876-1-gitter.spiros@gmail.com>
In-Reply-To: <20180815205630.32876-1-gitter.spiros@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 16 Aug 2018 04:43:44 -0400
Message-ID: <CAPig+cTSZNtKUXLoR6gqvWT3bD-JgWOF38ZD7i+OocRs4p=GMA@mail.gmail.com>
Subject: Re: [PATCH v2] worktree: add --quiet option
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Karen Arutyunov <karen@codesynthesis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 4:56 PM Elia Pinto <gitter.spiros@gmail.com> wrote:
> Add the '--quiet' option to git worktree,
> as for the other git commands. 'add' is the
> only command affected by it since all other
> commands, except 'list', are currently
> silent by default.

Nit: wrap the commit message at around 70 columns rather than 45 or so.

> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -303,9 +304,13 @@ static int add_worktree(const char *path, const char *refname,
> +       else {
>                 argv_array_pushl(&cp.args, "symbolic-ref", "HEAD",
>                                  symref.buf, NULL);
> +               if (opts->quiet)
> +                       argv_array_push(&cp.args, "--quiet");
> +       }

This constructs the command as "git symbolic-ref HEAD <ref> --quiet".
Although that's not wrong per-se, it does perhaps set an undesirable
precedent. A more standard construction would be:

    argv_array_push(..., "symbolic-ref");
    if (opts->quiet)
        argv_array_push(..., "--quiet");
    argv_array_pushl(..., "HEAD", symref.buf, NULL);

I used "pushl" on the last one to indicate the semantic relationship
between those two arguments.

> +

Nit: the above code is directly related to the code just below, so the
new blank line you add here somewhat (undesirably) divorces the pieces
of code from each other

>         cp.env = child_env.argv;
>         ret = run_command(&cp);
>         if (ret)
> @@ -315,6 +320,8 @@ static int add_worktree(const char *path, const char *refname,
>                 argv_array_pushl(&cp.args, "reset", "--hard", NULL);
> +               if (opts->quiet)
> +                       argv_array_push(&cp.args, "--quiet");

I could also see this one re-written as:

    argv_array_push(...,"reset");
    argv_array_push(...,"--hard");
    if (opts->quiet)
        argv_array_push(...,"--quiet");

now that the command invocation has added another option.

Not at all worth a re-roll.

> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> @@ -252,6 +252,11 @@ test_expect_success 'add -B' '
> +test_expect_success 'add --quiet' '
> +       git worktree add --quiet ../foo master >expected 2>&1 &&
> +       test_must_be_empty expected
> +'

This test is going to create the new worktree directly in Git's t/
directory due to "../foo". Please don't do that. Use a name without
the leading "../".

Also, you should make sure that the worktree doesn't already exist
(wasn't created by an earlier test), otherwise the "git worktree add"
command will fail. So, either choose a distinct worktree name or use
"test_might_fail git worktree remove -f <worktree>" before the "git
worktree add" command.

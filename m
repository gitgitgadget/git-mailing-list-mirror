Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11AD20248
	for <e@80x24.org>; Wed, 17 Apr 2019 08:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbfDQIvW (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 04:51:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33162 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbfDQIvW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 04:51:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so30866288wrp.0
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 01:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ElmfQ4+iwpeDGgYvO34lepG83HbYIfRtDcSufW3knM=;
        b=fDnJkiKHexGx4AzsHv6FcJlCsPaUnuttZm8Ki9JdCnQ5g1rC0TMBSCv3/FS8lPWMYp
         owpgN1v8nJzH+oZGLwGerClZZpxVyhEFmY1b2HvVWqE8aObOV9mZbaPBoTblaVQ0ehQU
         sSgfoiEVnbcDtPMgT+JRmlI/VZCiP4A8q6CKLAqlOBKxyEJ85vSspogHdf1ql+CC9C+R
         5eNlDL8Zwrhsr46v9ukPAbk9UpJ0Ee/nLeN/eAH3a8Xve4H6vOfdJnrGdAkd/qs9PbFS
         2pHc5WjBKX9u+aAuVNbKMUw6ndGWzIAm/leidzuHZh6eOXP/nESAQMoXdrWaIXMl37BX
         cXFA==
X-Gm-Message-State: APjAAAWlrASxXBTD1Mjq+NjtmvQ3fP0oBMI0c6TWyy8fEjluKdgO0beQ
        PRN1xt28Qno1HaOqflxmJRnN6MT4xCJXsS+NG90=
X-Google-Smtp-Source: APXvYqxOwgSK4ltnEdDAFGZ7zLZW1E2xXDZT90H/plCC3KomiwCIq9L3LcVh+b950GgLXxXU/7ipPRoRON3Cj7SUPD0=
X-Received: by 2002:adf:d848:: with SMTP id k8mr8100570wrl.185.1555491080029;
 Wed, 17 Apr 2019 01:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190417040733.22200-1-alexhenrie24@gmail.com>
In-Reply-To: <20190417040733.22200-1-alexhenrie24@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 17 Apr 2019 04:51:08 -0400
Message-ID: <CAPig+cQDU=Nounwiy5CFCfPvnj5eJJXNv+ihgbh2nYYVTYPBCQ@mail.gmail.com>
Subject: Re: [PATCH] Give git-pull a --reset option
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 17, 2019 at 12:07 AM Alex Henrie <alexhenrie24@gmail.com> wrote:
> A common workflow is to make a commit on a local branch, push the branch
> to the remote, check out the remote branch on a second computer, amend
> the commit on the second computer, force-push back to the remote branch,
> and finally submit a pull request. However, if the user switches back to
> the first computer, they must then run the cumbersome command
> `git fetch && git reset --hard origin`. (Actually, at this point Git
> novices often try running `git pull --force`, but it doesn't do what
> they expect.) This patch adds the shortcut `git pull --reset` to serve
> as a complement to `git push --force`.

I didn't know this was a particularly common workflow, although I
admit to working this way myself often enough.

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  Documentation/git-pull.txt |  8 ++++++++
>  builtin/pull.c             | 28 ++++++++++++++++++++++++++++

Perhaps add a test or two to t/t5520-pull.sh covering this new feature.

> diff --git a/builtin/pull.c b/builtin/pull.c
> @@ -860,6 +864,21 @@ static int run_rebase(const struct object_id *curr_head,
> +/**
> + * Runs git-reset, returning its exit status.
> + */
> +static int run_reset(void)
> +{
> +       int ret;
> +       struct argv_array args = ARGV_ARRAY_INIT;

In this codebase, it's typical to have a blank line following the declarations.

> +       argv_array_pushl(&args, "reset", NULL);
> +       argv_array_push(&args, "--hard");
> +       argv_array_push(&args, "FETCH_HEAD");

Not sure why you're using "pushl" for the first and then plain "push"
for the rest. With "pushl", the entire setup can be collapsed to:

    argv_array_pushl(&args, "reset", "--hard", "FETCH_HEAD", NULL);

But, given that this argument list isn't dynamic, you could simplify
further by just declaring:

    const char *argv[] = { "reset", "--hard", "FETCH_HEAD", NULL };

> +       ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
> +       argv_array_clear(&args);

...and do away with the argv_array_clear() altogether.

> +       return ret;
> +}

In fact, taking these suggestions into account, the code collapses to
just two lines, which you could easily inline into the sole caller,
thus you don't need a separate function at all.

> @@ -892,6 +911,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
> +       if (opt_rebase && opt_reset)
> +               die(_("--rebase and --reset are mutually exclusive."));

Modern practice on this project is to not end these messages with a
period, however, as most messages in this file currently end with a
period, this may be okay.

>         if (!opt_rebase && opt_autostash != -1)
>                 die(_("--[no-]autostash option is only valid with --rebase."));

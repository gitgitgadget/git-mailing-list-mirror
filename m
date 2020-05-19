Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEDAC433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 18:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09078206C3
	for <git@archiver.kernel.org>; Tue, 19 May 2020 18:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgESS6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 14:58:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54704 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgESS6L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 14:58:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id h4so319872wmb.4
        for <git@vger.kernel.org>; Tue, 19 May 2020 11:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LIKDnaFpO5JcHKjU5PjNYgkUKc1GDfsZMdb0sGNQPxM=;
        b=DuTtzwNYH5vQ8PCTVnJHNiuie+0FA4rGvDDLucnG4kNnymStFwgO/zrsZ8UzkdbT1w
         3tjdSPa+/FAAU2Zk6B9GXiZMNWcC2xU8yM2qm1+YXDKdyo0wBI05Y783uRMeB1FnhNS6
         KWsr6mc0YBVjbuMr+Kblz6Knk3ejpTmb0AeBBcUQ3cvB29zF1QqISxn05OPk6gniEB3A
         eKx6fqNxTRBl98lPeKRryRdfdGqzpjj50AAK5glo7gAt3gL7Nl+gQPUK+agAdgulZl7k
         W2fUTZZ12QAFf0roMVc8ouBjvgeIMyRHKsXdq6lXlZMVpDVMO7dmuuWPved4KqnRaTVA
         yBTA==
X-Gm-Message-State: AOAM530e1BQwBpDeULkdpngI9No97+BoHrHWyD22/qWT4OIT57Mj9Bq2
        hwCFwyFNySXQv6Gkr/4/2r7oiy8mpK3v0E3mUaM=
X-Google-Smtp-Source: ABdhPJxTJK+gbEGGJ6vpBEOSx4nIMupe6N0zZm6O6WJIKuT3iyyAhJ8H7LjAUeoAzpwe81coRYfCC+DKYYsfBsLABwE=
X-Received: by 2002:a1c:df46:: with SMTP id w67mr828077wmg.130.1589914688482;
 Tue, 19 May 2020 11:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200519182654.33318-1-shouryashukla.oo@gmail.com>
In-Reply-To: <20200519182654.33318-1-shouryashukla.oo@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 19 May 2020 14:57:57 -0400
Message-ID: <CAPig+cSKFBFdNXA52f5f0q3SetA2btmkXeqyHNw-qwJ5ECq5mQ@mail.gmail.com>
Subject: Re: [PATCH v2] submodule: port subcommand 'set-branch' from shell to C
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Doan Tran Cong Danh <congdanhqx@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 19, 2020 at 2:27 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
> Convert submodule subcommand 'set-branch' to a builtin. Port 'set-branch'
> to 'submodule--helper.c' and call the latter via 'git-submodule.sh'.

You can reduce the redundancy by writing this as:

    Convert git-submodule subcommand 'set-branch' to a builtin and
    call it via 'git-submodule.sh'.

> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> @@ -2284,6 +2284,46 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
> +static int module_set_branch(int argc, const char **argv, const char *prefix)
> +{
> +       int quiet = 0, opt_default = 0;
> +       char *opt_branch = NULL;

This can be 'const const *', can't it?

> +       struct option options[] = {
> +               OPT__QUIET(&quiet,
> +                       N_("suppress output for setting default tracking branch of a submodule")),

This is unusually verbose for a _short_ description of the option.
Other commands use simpler descriptions. Perhaps take a hint from the
git-submodule man page:

    N("only print error messages")),

However, the bigger question is: Why is the --quiet option even here?
None of the code in this function ever consults the 'quiet' variable,
so its presence seems pointless.

Looking at the git-submodule documentation, I see that it is already
documented as accepted --quiet, so it may make some sense for you to
accept the option here. However, it might be a good idea either to
have an in-code comment or a blurb in the commit message explaining
that this C rewrite accepts the option for backward-compatibility (and
for future extension), not because it is actually used presently.

> +               OPT_BOOL(0, "default", &opt_default,
> +                       N_("set the default tracking branch to master")),

We can make this and the next short description more precise and
concise like this:

    N_("reset the default tracking branch to master")),

> +               OPT_STRING(0, "branch", &opt_branch, N_("branch"),
> +                       N_("set the default tracking branch to the one specified")),

Then:

    N_("set the default tracking branch")),

> +               OPT_END()
> +       };
> +       const char *const usage[] = {
> +               N_("git submodule--helper set-branch [--quiet] (-d|--default) <path>"),
> +               N_("git submodule--helper set-branch [--quiet] (-b|--branch) <branch> <path>"),
> +               NULL
> +       };
> +
> +       argc = parse_options(argc, argv, prefix, options, usage, 0);
> +
> +       if (!opt_branch && !opt_default)
> +               die(_("at least one of --branch and --default required"));

This wording makes no sense considering that --branch and --default
are mutually exclusive. By writing "at least one of", you're saying
that you can use _more than one_, which is clearly incorrect. Reword
it like this:

    die(_("--branch or --default required"));

> +       if (opt_branch && opt_default)
> +               die(_("--branch and --default do not make sense together"));

A more precise way to say this is:

    die(_("--branch and --default are mutually exclusive"));

> +       if (argc != 1 || !(path = argv[0]))
> +               usage_with_options(usage, options);
> +
> +       config_name = xstrfmt("submodule.%s.branch", path);
> +       config_set_in_gitmodules_file_gently(config_name, opt_branch);

Tracing through the config code, I see that
config_set_in_gitmodules_file_gently() removes the key if 'opt_branch'
is NULL, which mirrors the behavior of the shell code this is
replacing. Good.

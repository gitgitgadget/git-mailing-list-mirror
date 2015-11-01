From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6] checkout: add --progress option
Date: Sun, 1 Nov 2015 16:06:18 -0500
Message-ID: <CAPig+cS1ajnRUiS7JXZ-jvtZV9k0hdnY7+R0nTnQU+kMk_zAqw@mail.gmail.com>
References: <1446409674-17951-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 22:06:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZszpY-0008WE-1i
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 22:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981AbbKAVGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 16:06:20 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33036 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbbKAVGT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 16:06:19 -0500
Received: by vkgy127 with SMTP id y127so75322755vkg.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 13:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zL61v0/PNN9zhV90O012JEOcJneejTWbqEHMYSGEu3A=;
        b=EBIj+EhEgKDhK90K+okwghgBNLxwyi5tKsJfo/G5y8/gQ2DvzOHfTN9129atDBjG45
         e05H8W2Q8sZ3Strf+FasQflnegLdDOdNH8mvofZ4HJUy+bZIsqPE25085BIP7RPOUteO
         2esxUQiFxlTUK3uGcplbav/AVNu5v6QeOgOpMHHQ9Q84GnbToLlXUn+K7NNRLHoCT90v
         7URNndeo6uq/oEoH82MWe59f7iiH2v819FcnpARlki04c8x+A5Hp3LVapSjW4NoQtnDQ
         t3VnUkfe0J4PBQpEL/mcmCIPSPX4UYGJK2ErJMtNfvbh30nlaFR9gD9feyxDrKOzQC9+
         1l5w==
X-Received: by 10.31.52.73 with SMTP id b70mr12889856vka.45.1446411978947;
 Sun, 01 Nov 2015 13:06:18 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Sun, 1 Nov 2015 13:06:18 -0800 (PST)
In-Reply-To: <1446409674-17951-1-git-send-email-eantoranz@gmail.com>
X-Google-Sender-Auth: sOzIKZzNxEA-xHfKlQR_NnvgP3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280668>

On Sun, Nov 1, 2015 at 3:27 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> Under normal circumstances, and like other git commands,
> git checkout will write progress info to stderr if
> attached to a terminal. This option allows progress
> to be forced even if not using a terminal. Also,
> progress can be skipped if using option --no-progress.
>
> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> @@ -107,6 +107,12 @@ OPTIONS
>  --quiet::
>         Quiet, suppress feedback messages.
>
> +--[no-]progress::
> +       Progress status is reported on the standard error stream
> +       by default when it is attached to a terminal, unless --quiet
> +       is specified. This flag enables progress reporting even if not
> +       attached to a terminal, regardless of -q.

The mix of -q and --quiet is inconsistent and potentially confusing. I
suspect that your intention was to hint that they are equivalent,
however, the reader who is not familiar with -q as an alias of --quiet
may now be forced to look up both options, rather than just one, only
to discover that they are the same, thus potentially requiring extra
effort. It probably would be better to consistently use --quiet.

Also, quoting with backticks is recommended: `--quite`

The rest of the patch looks good.

>  -f::
>  --force::
>         When switching branches, proceed even if the index or the
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> @@ -37,6 +37,7 @@ struct checkout_opts {
>         int overwrite_ignore;
>         int ignore_skipworktree;
>         int ignore_other_worktrees;
> +       int show_progress;
>
>         const char *new_branch;
>         const char *new_branch_force;
> @@ -417,7 +418,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
>         opts.reset = 1;
>         opts.merge = 1;
>         opts.fn = oneway_merge;
> -       opts.verbose_update = !o->quiet && isatty(2);
> +       opts.verbose_update = o->show_progress;
>         opts.src_index = &the_index;
>         opts.dst_index = &the_index;
>         parse_tree(tree);
> @@ -501,7 +502,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
>                 topts.update = 1;
>                 topts.merge = 1;
>                 topts.gently = opts->merge && old->commit;
> -               topts.verbose_update = !opts->quiet && isatty(2);
> +               topts.verbose_update = opts->show_progress;
>                 topts.fn = twoway_merge;
>                 if (opts->overwrite_ignore) {
>                         topts.dir = xcalloc(1, sizeof(*topts.dir));
> @@ -1156,6 +1157,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>                                 N_("second guess 'git checkout <no-such-branch>'")),
>                 OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
>                          N_("do not check if another worktree is holding the given ref")),
> +               OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
>                 OPT_END(),
>         };
>
> @@ -1163,6 +1165,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>         memset(&new, 0, sizeof(new));
>         opts.overwrite_ignore = 1;
>         opts.prefix = prefix;
> +       opts.show_progress = -1;
>
>         gitmodules_config();
>         git_config(git_checkout_config, &opts);
> @@ -1172,6 +1175,13 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>         argc = parse_options(argc, argv, prefix, options, checkout_usage,
>                              PARSE_OPT_KEEP_DASHDASH);
>
> +       if (opts.show_progress < 0) {
> +               if (opts.quiet)
> +                       opts.show_progress = 0;
> +               else
> +                       opts.show_progress = isatty(2);
> +       }
> +
>         if (conflict_style) {
>                 opts.merge = 1; /* implied */
>                 git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
> --
> 2.6.1

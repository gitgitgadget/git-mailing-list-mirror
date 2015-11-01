From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] checkout: add --progress option
Date: Sat, 31 Oct 2015 20:45:46 -0400
Message-ID: <CAPig+cQ+-k_eAm+EMEHqAyQ1P-AjNXQwmyPKqm=fD3vZ1chTLA@mail.gmail.com>
References: <1446168186-4730-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cTvRs_O8uY9_SrZZCf95Lraon8knkQUDgm0Lke3pve01A@mail.gmail.com>
	<xmqqh9l8kxa3.fsf@gitster.mtv.corp.google.com>
	<20151030193151.GB5336@sigill.intra.peff.net>
	<xmqq4mh8kv0e.fsf@gitster.mtv.corp.google.com>
	<CAOc6etYiqH8bvnCD_9hedzDW6fhknXLGesM6dX7S9DBB_r-9zA@mail.gmail.com>
	<CAOc6etYCzBYpf+7p8p3=zQun7bYXYVc-codoUf5Abcq+hAz8cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 01:46:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsgmu-0007rC-KP
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 01:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbbKAApt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 20:45:49 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35433 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbbKAAps (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 20:45:48 -0400
Received: by vkfw189 with SMTP id w189so67364192vkf.2
        for <git@vger.kernel.org>; Sat, 31 Oct 2015 17:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qmaUUc3oCIxzQAUI3zqbThk9JUtpXI/btCS4/A5YtgA=;
        b=ZDCJ4Pl6Qz3kXSCToEH2IBQT7aeaaS33KwbGXYMDk+6IhL88U+UzaPnEthN7t7gp4B
         6pNo9r4W5nIGzUgasdrj9OGSKDzLJLHlG9g0RPLNQ5lynOfzgjO3fm5pSxkcXEXcJWfV
         8R6EYcwU/08Mv4KdScbiJ34B9P5/dhvPErLShn+uDW46dra+SDcfYk0vboMIHIYDeqdB
         JAf7KKaDnJyQOtXdB3LxCggvpSO/D3cVY0SeiuZu3I5CY+QicTilRwU7IothDCc0IVwA
         qOPVJGs6jHj+Ejfzr9M5gU8GDx2J8N6Zj2pifeNt2c1gE6mZ4Jkf+uNLIJzO7R7iODR3
         3Vfw==
X-Received: by 10.31.163.85 with SMTP id m82mr9381911vke.19.1446338746934;
 Sat, 31 Oct 2015 17:45:46 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Sat, 31 Oct 2015 17:45:46 -0700 (PDT)
In-Reply-To: <CAOc6etYCzBYpf+7p8p3=zQun7bYXYVc-codoUf5Abcq+hAz8cA@mail.gmail.com>
X-Google-Sender-Auth: FUTeVJAJCzMnCVBJhY5-KWdK2nU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280603>

On Fri, Oct 30, 2015 at 10:11 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> Ok.... this is like the previous patch (on top of my patch) but does
> post_processing right after parse_options and so there's no need for
> the function I had introduced before. Hope it can get your blessings
> so I can send-email the _second_ patch for this feature (following the
> one that has already being merged into pu, right?).

Patches in 'next' are pretty much set in stone, and those in 'master'
definitely are, but 'pu' is volatile, so just send the entire patch
revised, tagged v2 (or v3, etc.), rather than sending a patch to fix
what is in 'pu', and Junio will replace the previous version with the
new one.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index e28c36b..9e78835 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -27,8 +27,6 @@ static const char * const checkout_usage[] = {
>        NULL,
> };
>
> -static int option_progress = -1;
> -
> struct checkout_opts {
>        int patch_mode;
>        int quiet;
> @@ -39,6 +37,7 @@ struct checkout_opts {
>        int overwrite_ignore;
>        int ignore_skipworktree;
>        int ignore_other_worktrees;
> +       int show_progress;
>
>        const char *new_branch;
>        const char *new_branch_force;
> @@ -419,19 +418,7 @@ static int reset_tree(struct tree *tree, const
> struct checkout_opts *o,
>        opts.reset = 1;
>        opts.merge = 1;
>        opts.fn = oneway_merge;
> -       /**
> -        * Rules to display progress:
> -        * -q is selected
> -        *      no verbiage
> -        * -q is _not_ selected and --no-progress _is_ selected,
> -        *      progress will be skipped
> -        * -q is _not_ selected and --progress _is_ selected,
> -        *      progress will be printed to stderr
> -        * -q is _not_ selected and --progress is 'undefined'
> -        *      progress will be printed to stderr _if_ working on a terminal
> -        */
> -       opts.verbose_update = !o->quiet && (option_progress > 0 ||
> -                                          (option_progress < 0 && isatty(2)));
> +       opts.verbose_update = o->show_progress;
>        opts.src_index = &the_index;
>        opts.dst_index = &the_index;
>        parse_tree(tree);
> @@ -515,7 +502,7 @@ static int merge_working_tree(const struct
> checkout_opts *opts,
>                topts.update = 1;
>                topts.merge = 1;
>                topts.gently = opts->merge && old->commit;
> -               topts.verbose_update = !opts->quiet && isatty(2);
> +               topts.verbose_update = opts->show_progress;
>                topts.fn = twoway_merge;
>                if (opts->overwrite_ignore) {
>                        topts.dir = xcalloc(1, sizeof(*topts.dir));
> @@ -1170,7 +1157,7 @@ int cmd_checkout(int argc, const char **argv,
> const char *prefix)
>                                N_("second guess 'git checkout
> <no-such-branch>'")),
>                OPT_BOOL(0, "ignore-other-worktrees",
> &opts.ignore_other_worktrees,
>                         N_("do not check if another worktree is
> holding the given ref")),
> -               OPT_BOOL(0, "progress", &option_progress, N_("force
> progress reporting")),
> +               OPT_BOOL(0, "progress", &opts.show_progress, N_("force
> progress reporting")),
>                OPT_END(),
>        };
>
> @@ -1178,6 +1165,7 @@ int cmd_checkout(int argc, const char **argv,
> const char *prefix)
>        memset(&new, 0, sizeof(new));
>        opts.overwrite_ignore = 1;
>        opts.prefix = prefix;
> +       opts.show_progress = -1;
>
>        gitmodules_config();
>        git_config(git_checkout_config, &opts);
> @@ -1187,6 +1175,16 @@ int cmd_checkout(int argc, const char **argv,
> const char *prefix)
>        argc = parse_options(argc, argv, prefix, options, checkout_usage,
>                             PARSE_OPT_KEEP_DASHDASH);
>
> +       /*
> +        * Final processing of show_progress
> +        * Any of these 3 conditions will make progress output be skipped:
> +        * - selected --quiet
> +        * - selected --no-progress
> +        * - didn't select --progress and not working on a terminal
> +        */
> +       opts.show_progress = !opts.quiet && opts.show_progress &&
> +                            (opts.show_progress >= 0 || isatty(2));
> +
>        if (conflict_style) {
>                opts.merge = 1; /* implied */
>                git_xmerge_config("merge.conflictstyle", conflict_style, NULL);

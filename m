Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	BULK_RE_SUSP_NTLD,FROM_SUSPICIOUS_NTLD,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 447E21F461
	for <e@80x24.org>; Sun, 12 May 2019 13:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfELNVW (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 May 2019 09:21:22 -0400
Received: from git.icu ([163.172.180.134]:53534 "EHLO git.icu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfELNVV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 May 2019 09:21:21 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
        by git.icu (Postfix) with ESMTPSA id 12C8E220922
        for <git@vger.kernel.org>; Sun, 12 May 2019 13:21:20 +0000 (UTC)
Received: by mail-vs1-f47.google.com with SMTP id j184so6390554vsd.11
        for <git@vger.kernel.org>; Sun, 12 May 2019 06:21:20 -0700 (PDT)
X-Gm-Message-State: APjAAAWUHuuIfI47nf+GpPf4JzzCKGgaKSay/3PeIcPaeVd+dhtasA1P
        W/Gekdqnv2HymRlpma8NcjepknCRBcWfXxhz+Nk=
X-Google-Smtp-Source: APXvYqwsziBUqgh2R+2hLhvNh7yTSrWEinY0i+Kb+yxWsNUZ/L2zpXzjzhbQGjZ4v/PYm1LFbl3jzcW0Ng/U/iDRDwY=
X-Received: by 2002:a67:302:: with SMTP id 2mr10310418vsd.91.1557667279189;
 Sun, 12 May 2019 06:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <CA+49okrda1=dV=rN23oFg7LQmRp+idkDDDxFQ9R5jhGJFHKpEg@mail.gmail.com>
 <20190423030648.GA6344@sigill.intra.peff.net> <xmqqftq95qr6.fsf@gitster-ct.c.googlers.com>
 <20190423035537.GB7753@sigill.intra.peff.net>
In-Reply-To: <20190423035537.GB7753@sigill.intra.peff.net>
From:   Shawn Landden <shawn@git.icu>
Date:   Sun, 12 May 2019 08:21:07 -0500
X-Gmail-Original-Message-ID: <CA+49okqSu1VYgrc__1SjYFvs1mhGHqQXhHrMFApRSzk_UNkjJw@mail.gmail.com>
Message-ID: <CA+49okqSu1VYgrc__1SjYFvs1mhGHqQXhHrMFApRSzk_UNkjJw@mail.gmail.com>
Subject: Re: allow a differn't diff.context config for git format-patch
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 10:55 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Apr 23, 2019 at 12:45:17PM +0900, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > > ... I don't think it would be
> > > too big a problem for format-patch to learn some options to configure
> > > its diffs. We already have some options in format.* for various things.
> >
> > I am not sure; diff.context is rather special in that the variable
> > behind it belongs to the diff layer and is set via diff_config that
> > is called by diff_ui_config that in turn is called by log_config
> > which is called by format_config.
> >
> > If we want to say "format.context" trumps "diff.config", then a new
> > internal variable to receive the value of the variable must be
> > invented and after the config gets read, cmd_format_patch() needs to
> > do something silly like this:
> >
> >                 git_config(git_format_config, NULL);
> >         +     if (format_context != -1)
> >         +             diff_default_context = format_context;
> >                 repo_init_revisions(the_repository, &rev, prefix);
> >
> > committing layering violation by exposing diff_default_context
> > variable.
>
> After init_revisions(), we'll have called diff_setup(), which puts
> diff_context_default into revs->diffopt. So we still have to do the "if
> we have a format-specific value, then override..." conditional. But we
> can do it without touching the hidden variable:
>
>
>
Looks like this fell into the cracks. You guys know the code much
better than me, but do I have to write a patch to make this happen?
> diff --git a/builtin/log.c b/builtin/log.c
> index 57869267d8..0de2ee0905 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1613,14 +1613,16 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>         repo_init_revisions(the_repository, &rev, prefix);
>         rev.commit_format = CMIT_FMT_EMAIL;
>         rev.expand_tabs_in_log_default = 0;
>         rev.verbose_header = 1;
>         rev.diff = 1;
>         rev.max_parents = 1;
>         rev.diffopt.flags.recursive = 1;
> +       if (format_context != -1)
> +               rev.diffopt.context = format_context;
>         rev.subject_prefix = fmt_patch_subject_prefix;
>         memset(&s_r_opt, 0, sizeof(s_r_opt));
>         s_r_opt.def = "HEAD";
>         s_r_opt.revarg_opt = REVARG_COMMITTISH;
>
>         if (default_attach) {
>                 rev.mime_boundary = default_attach;
>
> -Peff

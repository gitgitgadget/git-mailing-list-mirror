Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E2FC433F5
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 11:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243046AbiBELYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Feb 2022 06:24:09 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:39661 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbiBELYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Feb 2022 06:24:09 -0500
Received: by mail-pj1-f42.google.com with SMTP id v13-20020a17090ac90d00b001b87bc106bdso1534687pjt.4
        for <git@vger.kernel.org>; Sat, 05 Feb 2022 03:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQsxsqlsTqJ7qlRQBQQWLptB6jkcjyPo0MCLHVWi5bs=;
        b=w1DsBV/kkhUdauNFO54FqlZvGfg9Wb+sq5fAFbWvp8wPJVE61Mpm835bglBDJ/MKdd
         4TXd/KyLq4TSo1ExDzf0eJQukitlGh0PoPdW9AoHcVAWekDEgfjtdeBxZCV2jY3U53fX
         IosNspaPY6gatwcT7OtiWUyroFyp8VGSTdiBrCOotODr8/ubELaCcvG1szCBNUGV2yFR
         64ZzByYFytswn8fRQZtisZ2xFiujeGqtFM6eN8OXjxoMlEZav0GGyhu2yWgrMhWCnC/s
         jIKXslgWS6QbYmxOm5Xr0jgmaFsBEN2ZOZ9N9980/ippwlXJiX9ZgobtumbEmIv9dx44
         qtng==
X-Gm-Message-State: AOAM532avCvIQQ3pMsM4to+ZmZuH6q9VjG4+HJ6rfMR5HIXjOIxHNGp8
        DGsYBttj07M2NlPVKglDG2DT6iGFkW6IrOlyt286rKaKC0M=
X-Google-Smtp-Source: ABdhPJxPBj1JRp22E739whEtnu08hA4+E50YZZ+qZ47T7kn2WOUAdT4Ic+Uc62FtV7LzPYvNTTFOKi7WLzmKSWkSTMQ=
X-Received: by 2002:a17:903:249:: with SMTP id j9mr7692682plh.145.1644060248716;
 Sat, 05 Feb 2022 03:24:08 -0800 (PST)
MIME-Version: 1.0
References: <CAPig+cQVNdmHQnhORqh2XtJSMhcOymR99pmKTWOAyhoQ10khSw@mail.gmail.com>
 <20220127200341.333996-1-newren@gmail.com>
In-Reply-To: <20220127200341.333996-1-newren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 5 Feb 2022 06:23:57 -0500
Message-ID: <CAPig+cSi8_90=-Fvt_fq=VtOW_HzifNhrk1gaa6F1GrEonng+Q@mail.gmail.com>
Subject: Re: [Bug] Rebase from worktree subdir is broken (was Re: [PATCH v5
 07/11] rebase: do not attempt to remove startup_info->original_cwd)
To:     Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Glen Choo <chooglen@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 27, 2022 at 3:03 PM Elijah Newren <newren@gmail.com> wrote:
> On Wed, Jan 26, 2022 at 9:53 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > As far as I know, there is no reason to set GIT_DIR and GIT_WORK_TREE,
> > in general, when in a linked worktree since each worktree has its own
> > .git file ("gitfile") which tells Git commands where the repository is
> > and signals that that directory itself (which contains the .git file)
> > is indeed a Git worktree.
>
> Oh, interesting.  Not setting GIT_DIR either does sound a bit better.
>
> ...though after digging for a while, it turns out to be a bit more
> involved than I thought.  Although the below patch passes our current
> testsuite and fixes the reported bug, I'm worried I've missed some cases
> not tested by the testsuite.
>
> Not sure if we want to pursue this, drop it, or something else.  Thoughts?

It's an enticing idea, though I have no deep knowledge about all the
possible interactions which may be impacted by such a change. Duy had
a deep understanding of how all this worked, and probably Peff, as
well, but they aren't around to offer opinions.

set_git_dir() has been setting the GIT_DIR environment variable ever
since it (the function) was introduced by d7ac12b25d (Add
set_git_dir() function, 2007-08-01). Unfortunately, the commit message
doesn't explain why it does so.

More below...

> -- >8 --
> Subject: [RFC/POC PATCH] setup: do not pre-emptively set GIT_DIR based on discovery
>
> Some comments on the various code changes:
>    * clone/push/fetch related:
>      * there are *many* subprocesses involved in fetch/push and friends,
>        and they typically need to know the GIT_DIR they are operating on
>      * this involves: fetch-patch.c, connected.c, bundle.c, clone.c,
>        transport-helper.c, receive-pack.c, upload-pack.c
>      * this accounts for the majority of this patch
>      * much of this work could be avoided by having enter_repo() call
>        xsetenv(GIT_DIR_ENVIRONMENT, ".", 1) just after its set_git_dir()
>        call, but I don't know if that'd be considered a half measure

It does feel a bit like a bandaid to insert new code at these
locations to set GIT_DIR manually. It's not clear to readers why
GIT_DIR is needed for these specific cases, nor what the impact is
when it is not set. Thus, one wonders if such a blanket approach is
indeed required or if a more narrow and directed fix can be applied,
such as calling subprograms with an explicit --git-dir= rather than
setting GIT_DIR with its potentially more broad and
difficult-to-reason-about impact.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/builtin/clone.c b/builtin/clone.c
> @@ -836,13 +836,18 @@ static void dissociate_from_references(void)
>  {
> +       struct strvec env = STRVEC_INIT;
> +       strvec_pushf(&env, GIT_DIR_ENVIRONMENT "=%s", the_repository->gitdir);

Minor inconsistency: all the other similar changes in this patch use
"%s=%s" and then pass in GIT_DIR_ENVIRONMENT to be interpolated by
`%s`.

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> @@ -930,12 +930,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
> -                               const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
> +                               const char *gitdir = the_repository->gitdir;
>                                 if (arg[2] == 'g') {    /* --git-dir */
> -                                       if (gitdir) {
> +                                       if (strcmp(gitdir, ".git")) {
> @@ -945,9 +945,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
> -                                       if (!gitdir && !prefix)
> -                                               gitdir = ".git";
> -                                       if (gitdir) {
> +                                       if (strcmp(gitdir, ".git") || !prefix) {

The meaning here becomes more obscure with this change applied. In the
original code, it was obvious enough that non-NULL `gitdir` meant that
the GIT_DIR environment variable had a value, but
`strcmp(gitdir,".git")` probably doesn't convey much to readers of
this code? Assigning the result of the strcmp() to a well-named
variable could go a long way toward making the meaning clearer. Or, an
in-code comment might be warranted.

> diff --git a/environment.c b/environment.c
> @@ -327,7 +327,6 @@ char *get_graft_file(struct repository *r)
>  static void set_git_dir_1(const char *path)
>  {
> -       xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
>         setup_git_env(path);
>  }

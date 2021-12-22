Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C7EC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 00:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbhLVApP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 19:45:15 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:35403 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhLVApO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 19:45:14 -0500
Received: by mail-pg1-f176.google.com with SMTP id v25so548160pge.2
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 16:45:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhkItSIzakhREKzYfx7TiAqoSnp46bgnhN4aj9mHRoo=;
        b=l4VZe4jsG+0aF1Q61xt52/Ey/FpVOTmsbgsmBqPdMr3Ormcc29zkaN1HFP4iq/tht8
         IG+2Txx/zZNKfj6KssmZvTUyt4mic5sQeYPF5CHg7D1D0b6yKeoPvAmy2ondrI/UX4Z0
         aRE3/y2WhdJqpbt2cHH5uAWno+liA/be8+PUo6/GtZdwfnI7J6XxOcKBVY1WEJnt0Jjf
         raJU3Zqssqp2/k+RD7nz3dtaXwX+rmIaT43A7wkwuemY6CV7oaT4MctCPSPVDWv2sWoN
         u6LaVQACX7Qp84IsN39i3O0yWw68udZ5uTWtf+AW1CSPc4IbDQRlt0hB0UuZ12cllO5r
         35lQ==
X-Gm-Message-State: AOAM532riWM6wWSh1D9nHr3EXhx1/zTwWc3MKYDErI3FBqy1DvMEqTYW
        2hj5B6OE8efXnkXIYpODw0h19cJsg6f0i6KPU6c=
X-Google-Smtp-Source: ABdhPJwki1tcLMFn/6GpJhO8qtsBofQAUAmag1Ec99kGV6xfm1HZVD7W7530U06/rBWyt6bt6iFtfeNhWEDBq9I3v70=
X-Received: by 2002:a05:6a00:230b:b0:4ae:d8b2:dc0c with SMTP id
 h11-20020a056a00230b00b004aed8b2dc0cmr626958pfh.67.1640133914215; Tue, 21 Dec
 2021 16:45:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com> <ed8e2a7b19d236642b3b8d3a49d017d29753db56.1640114048.git.gitgitgadget@gmail.com>
In-Reply-To: <ed8e2a7b19d236642b3b8d3a49d017d29753db56.1640114048.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 21 Dec 2021 19:45:03 -0500
Message-ID: <CAPig+cQrJ9yWjkc8VMu=uyx_qtrXdL3cNnxLVafoxOo6e-r9kw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] worktree: add upgrade_to_worktree_config()
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 21, 2021 at 2:14 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Some features, such as the sparse-checkout builtin, require using the
> worktree config extension. It might seem simple to upgrade the
> repository format and add extensions.worktreeConfig, and that is what
> happens in the sparse-checkout builtin.
>
> Transitioning from one config file to multiple has some strange
> side-effects. In particular, if the base repository is bare and the
> worktree is not, Git knows to treat the worktree as non-bare as a
> special case when not using worktree config. Once worktree config is
> enabled, Git stops that special case since the core.bare setting could
> apply at the worktree config level. This opens the door for bare
> worktrees.

It would be a good idea to drop the final sentence since there is no
such thing as a bare worktree (either conceptually or practically),
and end the first sentence at "case": i.e. "... stops that special
case."

> To help resolve this transition, create upgrade_to_worktree_config() to
> navigate the intricacies of this operation. In particular, we need to
> look for core.bare=true within the base config file and move that
> setting into the core repository's config.worktree file.
>
> To gain access to the core repository's config and config.worktree file,
> we reference a repository struct's 'commondir' member. If the repository
> was a submodule instead of a worktree, then this still applies
> correctly.

I'm not sure how much this commit message is going to help someone who
did not participate in the discussion which led to this patch series.
I think the entire commit message could be written more concisely like
this:

    worktree: add helper to upgrade repository to per-worktree config

    Changing a repository to use per-worktree configuration is a
    somewhat involved manual process, as described in the
    `git-worktree` documentation, but it's easy to get wrong if the
    steps are not followed precisely, which could lead to odd
    anomalies such as Git thinking that a worktree is "bare" (which
    conceptually makes no sense). Therefore, add a utility function to
    automate the process of switching to per-worktree configuration
    for modules which require such configuration. (In the future, it
    may make sense to also expose this convenience as a `git-worktree`
    command to automate the process for end-users, as well.)

    To upgrade the repository to per-worktree configuration, it performs
    these steps:

    * enable `extensions.worktreeConfig` in .git/config

    * relocate `core.bare` from .git/config to .git/config.worktree
      (if key exists)

    * relocate `core.worktree` from .git/config to
      .git/config.worktree (if key exists)

    It also upgrades the repository format to 1 if necessary since
    that is a prerequisite of using `extensions`.

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/worktree.c b/worktree.c
> @@ -830,3 +831,49 @@ int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath,
> +int upgrade_to_worktree_config(struct repository *r)
> +{
> +       int res;
> +       int bare = 0;
> +       struct config_set cs = { 0 };

This function is doing a lot of unnecessary work if per-worktree
configuration is already enabled. The very first thing it should be
doing is checking whether or not it actually needs to do that work,
and short-circuit if it doesn't. I would think that simply checking
whether `extensions.worktreeConfig` is true and returning early if it
is would be sufficient.

> +       char *base_config_file = xstrfmt("%s/config", r->commondir);

If we look at path.c:strbuf_worktree_gitdir(), we see that this should
be using `r->gitdir`, not `r->commondir`.

> +       char *base_worktree_file = xstrfmt("%s/config.worktree", r->commondir);

Per path.c:strbuf_worktree_gitdir(), this use of `r->commondir` is
correct. Good.

Can we use more meaningful variable names? It's not at all clear what
"base" means in this context (I don't think it has any analog in Git
terminology). Perhaps name these `shared_config` and `repo_config`,
respectively.

> +       git_configset_init(&cs);
> +       git_configset_add_file(&cs, base_config_file);
> +
> +       /*
> +        * If the base repository is bare, then we need to move core.bare=true
> +        * out of the base config file and into the base repository's
> +        * config.worktree file.
> +        */

Here, too, it's not clear what "base" means. I think you want to say
that it needs to "move `core.bare` from the shared config to the
repo-specific config".

> +       if (!git_configset_get_bool(&cs, "core.bare", &bare) && bare) {
> +               if ((res = git_config_set_in_file_gently(base_worktree_file,
> +                                                       "core.bare", "true"))) {
> +                       error(_("unable to set core.bare=true in '%s'"), base_worktree_file);
> +                       goto cleanup;
> +               }
> +
> +               if ((res = git_config_set_in_file_gently(base_config_file,
> +                                                       "core.bare", NULL))) {
> +                       error(_("unable to unset core.bare=true in '%s'"), base_config_file);
> +                       goto cleanup;
> +               }
> +       }

This seems unnecessarily complicated and overly specific, thus
potentially confusing. The requirements laid out in git-worktree.txt
say only to move the configuration key from .git/config to
.git/config.worktree; it doesn't add any qualifiers about the value
being "true". And, indeed, we should not care about the value; it's
immaterial to this operation. Instead, we should just treat it
opaquely and relocate the key and value from .git/config (if it
exists) to .git/config.worktree without interpretation.

The error messages are too specific, as well, by mentioning "true".
They could instead be:

    unable to set `core.bare` in '%s'

and

    unable to remove `core.bare` from '%s'

However, there is a much more _severe_ problem with this
implementation: it is incomplete. As documented in git-worktree.txt
(and mentioned several times during this discussion), this utility
function _must_ relocate both `core.bare` _and_ `core.worktree` (if
they exist) from .git/config to .git/config.worktree. This
implementation neglects to relocate `core.worktree`, which can leave
things in quite a broken state (just as neglecting to relocate
`core.bare` can).

> +       if (upgrade_repository_format(r, 1) < 0) {
> +               res = error(_("unable to upgrade repository format to enable worktreeConfig"));
> +               goto cleanup;
> +       }
> +       if ((res = git_config_set_gently("extensions.worktreeConfig", "true"))) {
> +               error(_("failed to set extensions.worktreeConfig setting"));
> +               goto cleanup;
> +       }

The order in which this function performs its operations can leave the
repository in a broken state if any of the steps fails. For instance,
if setting `extensions.worktreeConfig=true` fails _after_ you've
relocated `core.bare` (and `core.worktree`) to .git/config.worktree,
then those configuration values will no longer be "active" since the
config system won't consult .git/config.worktree without
`extensions.worktreeConfig` enabled.

To be resilient against this sort of problem, you should perform the
operations in this order:

(1) upgrade repository format to 1
(2) enable `extensions.worktreeConfig`
(3) relocate `core.bare` and `core.worktree`

> +cleanup:
> +       git_configset_clear(&cs);
> +       free(base_config_file);
> +       free(base_worktree_file);
> +       trace2_printf("returning %d", res);

Is this leftover debugging or intentional?

> +       return res;
> +}
> diff --git a/worktree.h b/worktree.h
> @@ -182,4 +182,16 @@ void strbuf_worktree_ref(const struct worktree *wt,
> +/**
> + * Upgrade the config of the current repository and its base (if different
> + * from this repository) to use worktree-config. This might adjust config
> + * in both repositories, including:

Here, too, it's not clear what "base" means. Moreover, this seems to
be talking about multiple repositories, but we're only dealing with a
single repository and zero or more worktrees, so it's not clear what
this is trying to say.

> + * 1. Upgrading the repository format version to 1.
> + * 2. Adding extensions.worktreeConfig to the base config file.
> + * 3. Moving core.bare=true from the base config file to the base
> + *    repository's config.worktree file.

As mentioned above, it's unnecessary and perhaps confusing to focus
only on "true" here; we should be treating the value opaquely.

Also, if you're talking about the specific config settings which this
relocates, then `core.worktree` should be mentioned too, not just
`core.bare`.

> + */
> +int upgrade_to_worktree_config(struct repository *r);

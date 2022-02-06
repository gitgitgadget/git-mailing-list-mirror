Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497E3C433EF
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 09:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiBFJcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 04:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiBFJcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 04:32:16 -0500
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCD9C061355
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 01:32:15 -0800 (PST)
Received: by mail-pf1-f175.google.com with SMTP id i186so9130184pfe.0
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 01:32:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmKrA3BE6EkFWlwIhcefW7hft55vDUr2q68T65MDSCw=;
        b=qQmBf3sy9T55qScSNPTQE9brIozv9Qc/xNlURdTLlFljAJSvoLJflBtvUiOLqbdVKJ
         b8/9CnGoQuvTN3YoxAfPlzQAIn+OGndkBHFR1P5ldESJfE4PngIM95jMqs5yiRjgy6fn
         GEy2UCIMyLP3Rxb9ympd7B2ImmsYCj8RuD9Q7falpfTsq7yyhhTG6tXtw+dyJIjMppsh
         TpOTXyf/HMkjHfsFi9pJ3lEweV8EmtgX3FcqBDC/AjlSb/AszYQRaVXIVj4Frlg5Nwbp
         GoJ6pG676aE0NGfUUApE7gwD5GanozDmrYGjv9dL+40aejqymbzJawO2IF5yH6h4Wr4F
         JbMw==
X-Gm-Message-State: AOAM530TwnfUaEjEEUbLk6W9LB7cL9TgkIzlPWXel4xGFqiDGJHA8H5s
        sRBl+7qyxr9PJitSPfqPQjKs6iYQ4Xtv6QGN740=
X-Google-Smtp-Source: ABdhPJyv28CSGr8N8Qo+oZAnb3FEMNom65G1fDyB1fRtKjbxhhI/zh/lv79+P9+K0HMlVUx2xo8yQsPFiSFFH0jPJP4=
X-Received: by 2002:a62:2745:: with SMTP id n66mr10860603pfn.15.1644139934547;
 Sun, 06 Feb 2022 01:32:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
 <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com> <2a2c350112e647510c5f7c81e831661948cfb68d.1643641259.git.gitgitgadget@gmail.com>
In-Reply-To: <2a2c350112e647510c5f7c81e831661948cfb68d.1643641259.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 6 Feb 2022 04:32:03 -0500
Message-ID: <CAPig+cQiZS5-ScE1Fedm194=dHXCNhGdphJf-BV2uagO+X+wng@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] worktree: create init_worktree_config()
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 31, 2022 at 10:01 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> Create a helper method, init_worktree_config(), that will be used in a
> later change to fix this behavior within 'git sparse-checkout set'. The
> method is carefully documented in worktree.h.
> [...]
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/worktree.c b/worktree.c
> @@ -826,3 +827,72 @@ int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath,
> +int init_worktree_config(struct repository *r)
> +{
> +       int res = 0;
> +       int bare = 0;
> +       struct config_set cs = { { 0 } };
> +       const char *core_worktree;
> +       char *common_config_file = xstrfmt("%s/config", r->commondir);
> +       char *main_worktree_file = xstrfmt("%s/config.worktree", r->commondir);
> +
> +       /*
> +        * If the extension is already enabled, then we can skip the
> +        * upgrade process.
> +        */
> +       if (repository_format_worktree_config)
> +               return 0;
> +       if ((res = git_config_set_gently("extensions.worktreeConfig", "true")))
> +               return error(_("failed to set extensions.worktreeConfig setting"));

These two early returns are leaking `common_config_file` and
`main_worktree_file` which have already been allocated by xstrfmt().

> +
> +       git_configset_init(&cs);
> +       git_configset_add_file(&cs, common_config_file);
> +
> +       /*
> +        * If core.bare is true in the common config file, then we need to
> +        * move it to the base worktree's config file or it will break all
> +        * worktrees. If it is false, then leave it in place because it
> +        * _could_ be negating a global core.bare=true.
> +        */

The terminology "base worktree", which is not otherwise in the
project's lexicon, seems to be a leftover from earlier versions of
this series. Perhaps it could say instead "the repository-specific
configuration in $GIT_COMMON_DIR/worktree.config" or something?

> +       if (!git_configset_get_bool(&cs, "core.bare", &bare) && bare) {
> +               if ((res = move_config_setting("core.bare", "true",
> +                                              common_config_file,
> +                                              main_worktree_file)))
> +                       goto cleanup;
> +       }
> +       /*
> +        * If core.worktree is set, then the base worktree is located
> +        * somewhere different than the parent of the common Git dir.
> +        * Relocate that value to avoid breaking all worktrees with this
> +        * upgrade to worktree config.
> +        */

s/base worktree/main worktree/

> +       if (!git_configset_get_string_tmp(&cs, "core.worktree", &core_worktree)) {
> +               if ((res = move_config_setting("core.worktree", core_worktree,
> +                                              common_config_file,
> +                                              main_worktree_file)))
> +                       goto cleanup;
> +       }
> +
> +       /*
> +        * Ensure that we use worktree config for the remaining lifetime
> +        * of the current process.
> +        */
> +       repository_format_worktree_config = 1;
> +
> +cleanup:
> +       git_configset_clear(&cs);
> +       free(common_config_file);
> +       free(main_worktree_file);
> +       return res;
> +}

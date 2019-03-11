Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71D5020248
	for <e@80x24.org>; Mon, 11 Mar 2019 06:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfCKGTO (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 02:19:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38698 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfCKGTN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 02:19:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so3655289wrm.5
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 23:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TwL8i86ustQZlKoGAcYgvdNTn9aMVSISo/MiXYeN8ac=;
        b=PLpgev+rEMeb4kKVhhgIUmPnsazVSC9ctARJ1Ww1L67x4uUo4EtKeTMktCmPuVxov1
         SRlPKVXS7zaS4i9oERwaD0/6Y1kBe+UDo0yqm6tAbMc1okUOusNc94MDa40iCpiMe6mx
         6TBpJTYlx6ECNYfrchw3EiC2On2FmWl/H0eumL3KcIzM2asH2PB5/x6vuTa7pmqHCsG9
         XGU2azvX8JcbLA2S10XfE6m6A1f8Hq2IVuRRR1ktpiFvv+pWasnJDbh7dY/58qTKpHTN
         QEmUK8be9x8fXI8a/31QFg1SGVJ51wRRoSmLlj5laMboE+xYSLTM+CLrNVybVj8RxPgX
         hpjA==
X-Gm-Message-State: APjAAAXSFIC2vVlMfRPGacdXqXbqWNQ92F1A3/tb+cPfuAzMYDHBcZFF
        N5B/u3UnK+hu2ShZjSun3WpLMD6hJlrFopF5hAxQl0Mz
X-Google-Smtp-Source: APXvYqwjwmpBQA2QekpI1UjpGZLRWRRzvTJFVRWKdb3+Yg1attqYZCT/AVkNxW7fxL3K4DoEngRVUyS/73adFMGP/+Y=
X-Received: by 2002:adf:d84c:: with SMTP id k12mr10100152wrl.58.1552285151489;
 Sun, 10 Mar 2019 23:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1548219737.git.liu.denton@gmail.com> <cover.1552275703.git.liu.denton@gmail.com>
 <ced1df0fc76c97c9896b6cbb5b4154532461716d.1552275703.git.liu.denton@gmail.com>
In-Reply-To: <ced1df0fc76c97c9896b6cbb5b4154532461716d.1552275703.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Mar 2019 02:19:00 -0400
Message-ID: <CAPig+cQGvmi-237s1Leb1NpOMA0683PkCG4HBCKn_+x5YDHnCQ@mail.gmail.com>
Subject: Re: [PATCH v7 7/8] sequencer.c: define get_config_from_cleanup
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 10, 2019 at 11:42 PM Denton Liu <liu.denton@gmail.com> wrote:
> Define a function which allows us to get the string configuration value
> of a enum commit_msg_cleanup_mode. This is done by refactoring
> get_cleanup_mode such that it uses a lookup table to find the mappings
> between string and enum and then using the same LUT in reverse to define
> get_config_from_cleanup.

Aside from a missing 'static', the comments below are mostly style
suggestions to make the new code less noisy. The basic idea is to
reduce the "wordiness" of the code so that the eye can glide over it
more easily, thus allowing the reader to grasp its meaning "at a
glance", without necessarily having to read it attentively. You may or
may not consider the suggestions actionable.

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -160,6 +160,22 @@ static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
> +struct cleanup_config_mapping {
> +    const char *config_value;
> +    enum commit_msg_cleanup_mode editor_cleanup;
> +    enum commit_msg_cleanup_mode no_editor_cleanup;
> +};

These members are already inside a struct named
"cleanup_config_mapping", so we can drop some of the wordiness from
the member names. For instance:

    config --or-- value --or-- val
    editor
    no_editor

> +/* note that we assume that cleanup_config_mapping[0] contains the default settings */
> +struct cleanup_config_mapping cleanup_config_mappings[] = {
> +       { "default", COMMIT_MSG_CLEANUP_ALL, COMMIT_MSG_CLEANUP_SPACE },
> +       { "verbatim", COMMIT_MSG_CLEANUP_NONE, COMMIT_MSG_CLEANUP_NONE },
> +       { "whitespace", COMMIT_MSG_CLEANUP_SPACE, COMMIT_MSG_CLEANUP_SPACE },
> +       { "strip", COMMIT_MSG_CLEANUP_ALL, COMMIT_MSG_CLEANUP_ALL },
> +       { "scissors", COMMIT_MSG_CLEANUP_SCISSORS, COMMIT_MSG_CLEANUP_SPACE },
> +       { NULL, 0, 0 }
> +};

This table should be 'static'.

> @@ -504,26 +520,42 @@ static int fast_forward_to(struct repository *r,
>  enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
>         int use_editor, int die_on_error)
>  {
> +       struct cleanup_config_mapping *default_mapping = &cleanup_config_mappings[0];
> +       struct cleanup_config_mapping *current_mapping;

We can shorten these two variable names to "def" and "p",
respectively, without losing clarity; there are only two variables in
the function, so it's not difficult to remember what they are. More
importantly, the rest of the code becomes considerably shorter,
allowing the eye to glide over it while easily taking in its meaning
rather than having to spend time actively reading it.

> +       if (!cleanup_arg) {
> +               return use_editor ? default_mapping->editor_cleanup :
> +                                   default_mapping->no_editor_cleanup;
> +       }
> +
> +       for (current_mapping = cleanup_config_mappings; current_mapping->config_value; current_mapping++) {
> +               if (!strcmp(cleanup_arg, current_mapping->config_value)) {
> +                       return use_editor ? current_mapping->editor_cleanup :
> +                                           current_mapping->no_editor_cleanup;
> +               }
> +       }

For instance, with the shorter names, the above loop (while also
dropping unnecessary braces) becomes:

    for (p = cleanup_config_mappings; p->val; p++)
        if (!strcmp(cleanup_arg, p->val))
            return use_editor ? p->editor : p->no_editor;

> +       if (!die_on_error) {
>                 warning(_("Invalid cleanup mode %s, falling back to default"), cleanup_arg);
> -               return use_editor ? COMMIT_MSG_CLEANUP_ALL :
> -                                   COMMIT_MSG_CLEANUP_SPACE;
> +               return use_editor ? default_mapping->editor_cleanup :
> +                                   default_mapping->no_editor_cleanup;
>         } else
>                 die(_("Invalid cleanup mode %s"), cleanup_arg);
>  }

Same comments apply to other new code introduced by this patch.

> +const char *get_config_from_cleanup(enum commit_msg_cleanup_mode cleanup_mode)
> +{
> +       struct cleanup_config_mapping *current_mapping;
> +
> +       for (current_mapping = &cleanup_config_mappings[1]; current_mapping->config_value; current_mapping++) {
> +               if (cleanup_mode == current_mapping->editor_cleanup) {
> +                       return current_mapping->config_value;
> +               }
> +       }
> +
> +       BUG(_("invalid cleanup_mode provided"));

Don't localize BUG() messages; they are intended only for developer
eyes, not end-users. So:

    BUG("invalid cleanup_mode provided");

> +}
> diff --git a/sequencer.h b/sequencer.h
> @@ -118,6 +118,7 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
>  enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
>         int use_editor, int die_on_error);
> +const char *get_config_from_cleanup(enum commit_msg_cleanup_mode cleanup_mode);

A more intuitive name might be describe_cleanup_mode().

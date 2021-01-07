Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073E9C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 05:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C96BD225AC
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 05:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbhAGFKM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 00:10:12 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:35243 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbhAGFKL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 00:10:11 -0500
Received: by mail-ej1-f53.google.com with SMTP id q22so8127515eja.2
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 21:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hacK8OzUBjI5DO7s2Hxsd1anqPe+fUw40HcXNejrPQc=;
        b=Wl3FWgF7y0YfFiWr323eJREUzWjN6PWk1GbFO7MEndnsC5GBOz+yXvVeicXEZEXLKs
         98YP7WXVeOSYYPvdEOtMyRjxDW+o8blRH9TH6+uEJ8lUqNxvBvrsz2kfuW8bW6JmYSVJ
         ZwV46OWxPmivtpz+ggQ16VOyZXf/LoHoulAjMtA5Set2zZGm28uCPh2hngnjkH6pg71b
         DGRANi7pOyAICqodm0byRjpLwVLKcii8UNnVSyivSTQbs6nJN5AxLJMWQLPbgYFwcanb
         Ud4VRVXYJEVwqSIQ/jrJ/RpKwywaAaK0KLxof2TyIoaI+WK5IwIA5fad0uXpDzajTyiP
         OPhw==
X-Gm-Message-State: AOAM533WhwINCJG5Zf9WourW356ZDRb7PK4rMpNzzCGyXY1VWksGfjfK
        LtCozXx6szOBoiCckiJDC2+eOjFsZk4ul2RsThk=
X-Google-Smtp-Source: ABdhPJzbcR7E51Tj4XIhzQ94DUOM6T1fqlozo6A1Dy47vuJRcK/z5r3ZM5TIPNHJOC2A1oY6fr8KSckGcCCAp2WUcos=
X-Received: by 2002:a17:906:d0c1:: with SMTP id bq1mr4961180ejb.202.1609996169477;
 Wed, 06 Jan 2021 21:09:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
 <pull.830.v2.git.1609821783.gitgitgadget@gmail.com> <2b171a142b36b114d5ff526073fe3fd9517a4d32.1609821783.git.gitgitgadget@gmail.com>
In-Reply-To: <2b171a142b36b114d5ff526073fe3fd9517a4d32.1609821783.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 7 Jan 2021 00:09:18 -0500
Message-ID: <CAPig+cTfHsd7WMvcX1_433WVOG+y4FceUACBx_4UfnjJTgVY6g@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] update-index: remove static globals from callbacks
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 4, 2021 at 11:43 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> In order to remove index compatibility macros cleanly, we relied upon
> static globals 'repo' and 'istate' to be pointers to the_repository and
> the_index, respectively. We remove these static globals inside the
> option parsing callbacks, which are the final uses in update-index.
>
> The callbacks cannot change their method signature, so we must use the
> value member of 'struct option', assigned in the array of option macros.
> There are several callback methods that require at least one of 'repo'
> and 'istate', but they use a variety of different data types for the
> callback value.
>
> Unify these callback methods to use a consistent 'struct callback_data'
> that contains 'repo' and 'istate', ready to use. This takes the place of
> the previous 'struct refresh_params' which served only to group the
> 'flags' and 'has_errors' ints. We also collect other one-off settings,
> but only those that require access to the index or repository in their
> operation.

Makes sense. The patch itself is necessarily a bit noisy, but there's
nothing particularly complicated in that noise.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> @@ -784,19 +784,21 @@ static int do_reupdate(struct repository *repo,
> -struct refresh_params {
> +struct callback_data {
> +       struct repository *repo;
> +       struct index_state *istate;
> +
>         unsigned int flags;
> -       int *has_errors;
> +       unsigned int has_errors;
> +       unsigned nul_term_line;
> +       unsigned read_from_stdin;
>  };

The only mildly unexpected thing here is that `has_errors` is now a
simple value rather than a pointer to a value, but you handle that
easily enough by always accessing `has_error` directly from the
structure, even within the function in which `has_error` used to be a
local variable. Fine.

> @@ -818,7 +820,7 @@ static int really_refresh_callback(const struct option *opt,
>  static int chmod_callback(const struct option *opt,
> -                               const char *arg, int unset)
> +                         const char *arg, int unset)
> @@ -829,11 +831,12 @@ static int chmod_callback(const struct option *opt,
>  static int resolve_undo_clear_callback(const struct option *opt,
> -                               const char *arg, int unset)
> +                                      const char *arg, int unset)

A couple drive-by indentation fixes. Okay.

> @@ -1098,8 +1103,13 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
> -       istate = repo->index;
> +       cd.repo = repo;
> +       cd.istate = istate = repo->index;

Will there ever be a case in which `cd.istate` will be different from
`cd.repo->index`? If not, then we could get by with having only
`cd.repo`; callers requiring access to `istate` can fetch it from
`cd.repo`. If, on the other hand, `cd.istate` can be different from
`cd.repo->istate` -- or if that might become a possibility in the
future -- then having `cd.istate` makes sense. Not a big deal, though.
Just generally curious about it.

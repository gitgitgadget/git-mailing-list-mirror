Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DFAC77B7C
	for <git@archiver.kernel.org>; Wed, 24 May 2023 18:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjEXStN convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 24 May 2023 14:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbjEXStG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 14:49:06 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8359DE7E
        for <git@vger.kernel.org>; Wed, 24 May 2023 11:48:52 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-62381fe42b3so600936d6.0
        for <git@vger.kernel.org>; Wed, 24 May 2023 11:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684954131; x=1687546131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WB2eoEiAXJMPjCAY1eibc6E7FJNG5BkeZfvrbv5ez4=;
        b=Bq1yzSsCS4+nL3ZXmwmXG77dl8tWLmxim/WNp8N+pjFkGT9CbrJt+w7WWyf0bems2C
         fuJ1iikJB041mUwEagQ9kAA0O7jsdfluwrHCHUyosWcY7vjiyWskNmg7fELL/GiyNUur
         uviUtdjaB37Endolld+AKq+A37yF6OSLtqi6fJ3/el7T6W/WkLIcCvhc2SuL7rpmW5Cd
         H22b6/aWaewgULqssrEPT8qQFHquJGSwZo0pEJm6g6EAcnJ9/iqpzDf2GpwI5Ym3NcPM
         o3LoRlIKh7KU6vjHzKrDN13Nwz1t5nN++0fGh38MB7UbJcqxdWgwKW8AmdLZAlcsPAFt
         89mA==
X-Gm-Message-State: AC+VfDzpu4BS6Au1fWf0ucG9sp3XveUftb7LWeKwmGrkhod46RXfH/F3
        RfGG6wZIeUvIHP0oNNRhDuxf1iQoqSlo+oPufdc=
X-Google-Smtp-Source: ACHHUZ6LCKy6SJ+fOYbFVxzKKaQpmkZ/9lR52oigNQMkr5Q/jgQcppK12Rreq5adiUDdqpI63tGBAw+S8IJZvPEIvss=
X-Received: by 2002:ad4:5768:0:b0:625:aa1a:937f with SMTP id
 r8-20020ad45768000000b00625aa1a937fmr3280290qvx.59.1684954131360; Wed, 24 May
 2023 11:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <f7a8de14fe255286e62fc46d0a3083189f46bcc6.1684944140.git.me@ttaylorr.com>
 <bc204f450a80f7e6379b3a8564fc54637a266e7e.1684945504.git.me@ttaylorr.com>
In-Reply-To: <bc204f450a80f7e6379b3a8564fc54637a266e7e.1684945504.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 May 2023 14:48:40 -0400
Message-ID: <CAPig+cT4c4f8DtNJOmNJKRYVX0HNz9fSgkF9hAbzaCXV0ozydg@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/submodule--helper.c: handle missing submodule URLs
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Tribo Dar <3bodar@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2023 at 12:40 PM Taylor Blau <me@ttaylorr.com> wrote:
> In e0a862fdaf (submodule helper: convert relative URL to absolute URL if
> needed, 2018-10-16), `prepare_to_clone_next_submodule()` lost the
> ability to handle URL-less submodules, due to a change from:
>
>     if (repo_get_config_string_const(the_repostiory, sb.buf, &url))
>         url = sub->url;
>
> to
>
>     if (repo_get_config_string_const(the_repostiory, sb.buf, &url)) {
>         if (starts_with_dot_slash(sub->url) ||
>             starts_with_dot_dot_slash(sub->url)) {
>                 /* ... */
>             }
>     }
>
> , which will segfault when `sub->url` is NULL, since both
> `starts_with_dot_slash()` does not guard its arguments as non-NULL.
>
> Guard the checks to both of the above functions by first whether

s/first/first checking/

> `sub->url` is non-NULL. There is no need to check whether `sub` itself
> is NULL, since we already perform this check earlier in
> `prepare_to_clone_next_submodule()`.
>
> By adding a NULL-ness check on `sub->url`, we'll fall into the 'else'
> branch, setting `url` to `sub->url` (which is NULL). Before attempting
> to invoke `git submodule--helper clone`, check whether `url` is NULL,
> and die() if it is.
>
> Reported-by: Tribo Dar <3bodar@gmail.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> @@ -2024,14 +2024,17 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
> -               if (starts_with_dot_slash(sub->url) ||
> -                   starts_with_dot_dot_slash(sub->url)) {
> +               if (sub->url && (starts_with_dot_slash(sub->url) ||
> +                                starts_with_dot_dot_slash(sub->url))) {
>                         url = resolve_relative_url(sub->url, NULL, 0);
>                         need_free_url = 1;
>                 } else
>                         url = sub->url;
>         }
>
> +       if (!url)
> +               die(_("cannot clone submodule '%s' without a URL"), sub->name);

Good. The first version of this patch was more difficult to reason
about due to its "error-at-a-distance" approach. This version is much
cleaner and obvious.

> @@ -2065,11 +2068,11 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>                 strvec_pushf(&child->args, "--filter=%s",
>                              expand_list_objects_filter_spec(suc->update_data->filter_options));
> +       strvec_pushl(&child->args, "--url", url, NULL);
>         if (suc->update_data->require_init)
>                 strvec_push(&child->args, "--require-init");
>         strvec_pushl(&child->args, "--path", sub->path, NULL);
>         strvec_pushl(&child->args, "--name", sub->name, NULL);
> -       strvec_pushl(&child->args, "--url", url, NULL);

This change is unnecessary now, isn't it? Or is there something
nonobvious going on here?

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE7641F404
	for <e@80x24.org>; Wed, 12 Sep 2018 12:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeILRTW (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 13:19:22 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46895 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbeILRTV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 13:19:21 -0400
Received: by mail-qk1-f196.google.com with SMTP id j7-v6so922491qkd.13
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 05:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGuVP4i+RD3yWQtz+qTPhI/hnF6lowHEeh0l1t/R5AM=;
        b=RBDm+6RGwn0u2tMWwE+seX/zpa2INmPwG+GzIEr0pRVSiztSuZiN2VlwSNkzEeyoWj
         YKA5LDsoPwX7KhGYVJlk65tP0vGYaN8cXUgiHMn4CTDPxUVU3rijrFXh9WzH6w7MkU+T
         Wd8Pu9LdVjkgLLpKTe2i4/icLVuTT4lrFYzu58pL35kpKQRAqpNPnPsmGwqEbWdsqvOT
         5Itlq7Pgbw2ypNQ39GBGinytWj0QgMLOmCwHIsKLBMGvp9gK52An/2ALnh8YOwbXq/SU
         TKicBfYMD3vIVahdpusX2nqI80R3RiUNHb1TsWyHKLmBw60Zslm/J59TMAlGk4wLbUyw
         sqrw==
X-Gm-Message-State: APzg51Cdy4QqNmVJHeDagd+xugZHrNI62UkPNR+EVX9Yg08LyTvFdQdn
        dfyik97hadxNTLMK5OmYUWBrlDZNgzNE4kuWUJQ=
X-Google-Smtp-Source: ANB0VdbV6htJxB2NwSlMWgsdZHGvwFXkSb6xFeUJ7uYKL4dmEfMNCAMdVan7io4lsBsrQ1lYYNHzImZuoN4WkHfRql0=
X-Received: by 2002:a37:48e:: with SMTP id 136-v6mr1137078qke.26.1536754505782;
 Wed, 12 Sep 2018 05:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180912101029.28052-1-phillip.wood@talktalk.net> <20180912101029.28052-4-phillip.wood@talktalk.net>
In-Reply-To: <20180912101029.28052-4-phillip.wood@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 12 Sep 2018 08:14:54 -0400
Message-ID: <CAPig+cRvUr26GZyW6ecYhpwABueBqaEfZH1+JjLaqZo8+RTD6Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] sequencer: use read_author_script()
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 12, 2018 at 6:11 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> Use the new function to read the author script, updating
> read_env_script() and read_author_ident(). This means we now have a
> single code path that reads the author script and uses sq_dequote() to
> dequote it. This fixes potential problems with user edited scripts
> as read_env_script() which did not track quotes properly.
> [...]
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -723,54 +723,35 @@ int read_author_script(const char *path, char **name, char **email, char **date,
>  static int read_env_script(struct argv_array *env)
>  {
> +       strbuf_addstr(&script, "GIT_AUTHOR_NAME=");
> +       strbuf_addstr(&script, name);
> +       argv_array_push(env, script.buf);
> +       strbuf_reset(&script);
> +       strbuf_addstr(&script, "GIT_AUTHOR_EMAIL=");
> +       strbuf_addstr(&script, email);
> +       argv_array_push(env, script.buf);
> +       strbuf_reset(&script);
> +       strbuf_addstr(&script, "GIT_AUTHOR_DATE=");
> +       strbuf_addstr(&script, date);
> +       argv_array_push(env, script.buf);
> +       strbuf_release(&script);

I haven't read this series closely yet, but this caught my eye while
scanning it quickly. The above noisy code can all be collapsed to the
simpler:

    argv_array_pushf(env, "GIT_AUTHOR_NAME=%s", name);
    argv_array_pushf(env, "GIT_AUTHOR_EMAIL =%s", email);
    argv_array_pushf(env, "GIT_AUTHOR_DATE =%s", date);

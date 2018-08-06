Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C234208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 18:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbeHFVJH (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 17:09:07 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43020 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729861AbeHFVJH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 17:09:07 -0400
Received: by mail-yw1-f67.google.com with SMTP id l189-v6so3995540ywb.10
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 11:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T86J7LzfTmbAD5Hr43v1eG9VLYd975DMIMMb8B5pvQ4=;
        b=PrZwi8yzxQIDKqvTEh8YtJseXFnzs8IchqQT2ATQ/PB37+406e+Aq5lNOTz1ZmdMRu
         +1b+ofzPhMzVz1jQgGpGxsR6rda+mcrTeK9xXkwLzMRgTXZIMzoncVOqlh2B0zHY/hEG
         9gv0VzqegNc0rana/AUf5wMGvk/VgLa9Tj6hnmhuXFur4Pcxj3U5FySGaMZeokHRirfq
         k4aakMUt9Kp7nzETu2mxNnjxo97HFpRfZMEkMONEY0QduXEMbJlH06/O79B8Pc50HJVn
         YSRhRJRb8v+GpzAyRPEKTibWgzVw2x/9tuzSH8hlnOEmRmO1+fuQ2LMc6sARbxEcYFXp
         erJA==
X-Gm-Message-State: AOUpUlEoptlmWb08wjtSKd4/+C4aHoMd+/i1dRjix4TwRSkZ7GVrtFmw
        /cuZO6dq/gBYpm2hT3W6w+oEloQJKXKvRhqceHM=
X-Google-Smtp-Source: AA+uWPwkQP70tEmOaHvQ5WoXU9hcTWjN93UlSkpirsJDSIfaYNNvs6eVc22co46dwM0So444xrF8ep89+uZtDeuqMJU=
X-Received: by 2002:a81:ae61:: with SMTP id g33-v6mr1486607ywk.74.1533581920447;
 Mon, 06 Aug 2018 11:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180806174459.199589-1-hanwen@google.com> <20180806174459.199589-2-hanwen@google.com>
In-Reply-To: <20180806174459.199589-2-hanwen@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 6 Aug 2018 14:58:28 -0400
Message-ID: <CAPig+cScb_7s4a_ZSVCsr+nBxAHGHZVMZOtnrOgbhZUi96-VFA@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] sideband: highlight keywords in remote sideband output
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrn@google.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 6, 2018 at 1:45 PM Han-Wen Nienhuys <hanwen@google.com> wrote:
> The colorization is controlled with the config setting "color.remote".
> [...]
> Helped-by: Duy Nguyen <pclouds@gmail.com>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -1263,6 +1263,18 @@ color.push::
> +color.remote::
> +       If set, keywords at the start of the line are highlighted. The
> +       keywords are "error", "warning", "hint" and "success", and are
> +       matched case-insensitively. Maybe set to `always`, `false` (or

s/Maybe/May be/

> +       `never`) or `auto` (or `true`). If unset, then the value of
> +       `color.ui` is used (`auto` by default).
> diff --git a/sideband.c b/sideband.c
> +static void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
> +{
> +       if (!want_color_stderr(use_sideband_colors())) {
> +               strbuf_add(dest, src, n);
> +               fprintf(stderr, "added: '%s'\n", dest->buf);

Debugging gunk?

> +               return;
> +       }
> @@ -96,6 +204,7 @@ int recv_sideband(const char *me, int in_stream, int out)
>         if (outbuf.len) {
> +               fprintf(stderr, "last bit '%s'\n", outbuf.buf);

Debugging gunk?

>                 strbuf_addch(&outbuf, '\n');
>                 xwrite(2, outbuf.buf, outbuf.len);
>         }

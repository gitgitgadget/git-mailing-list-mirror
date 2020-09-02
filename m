Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B532C433E6
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 07:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A7C2084C
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 07:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgIBHan (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:30:43 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:43402 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgIBHam (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 03:30:42 -0400
Received: by mail-ej1-f68.google.com with SMTP id m22so5182889eje.10
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 00:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZxdTjtZR8p+ii7DyfGSoCJdYRuB0zUC724s1MCCfzs=;
        b=jG73E121QIyjrz/8deW3zUuXcgSV27/obOz4w6UPDyujwekhSJ/Q96gabNaVNJwuy5
         pMww/nzJbgGhb8hKgxTRZF3wfKOjjbw5W5C6ZxuRM0nVFmprEhd61Zxb7lgAx0CsEZHQ
         4RxiEej5TcPddoMncgwBkZP6mM85S8Mb0Q/v4N+RbFjTCRYHxFEzJe3DvILpZZMKguD2
         29PHLC/FR81fccIanmpoybbQzEXBeXVcDvswr0tGdwHzaVCBiBXs3SNwxAhRjOnGuRhM
         XAFDbNMfoGViRpLMvofsgdtK3j/ZTQJ1pYEOZa7ENRobOOnax5IppKPeyCHLif3TpOfZ
         vCBw==
X-Gm-Message-State: AOAM531gboJgM+w8xCa76SuD26zZXYEEFx4W145NkttuvHWFu7jPgcAC
        4WdMVUqSH5q53n4XsFMt3+qvHZ1a4g/YeOl3g8g=
X-Google-Smtp-Source: ABdhPJw5ZTaIUlyZBhIsGgebXH/0XrufbfvqauLs9JaNcTSqrM03FcojkUptIdhJUG8YS5ijU7EbDTneH6vpIAnffwI=
X-Received: by 2002:a17:906:454a:: with SMTP id s10mr4970868ejq.138.1599031840358;
 Wed, 02 Sep 2020 00:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599026986.git.matheus.bernardino@usp.br> <56535b0e36e94dc73aa570f4f3c0466305c6432f.1599026986.git.matheus.bernardino@usp.br>
In-Reply-To: <56535b0e36e94dc73aa570f4f3c0466305c6432f.1599026986.git.matheus.bernardino@usp.br>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 2 Sep 2020 03:30:29 -0400
Message-ID: <CAPig+cSZFOXuLBKBLrNkZ=dTmQUrp-QiUb7wYGoza-YmEFiM9A@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] t/helper/test-config: unify exit labels
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 2, 2020 at 2:18 AM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
> test-config's main function has three different exit labels, all of
> which have to perform the same cleanup code before returning. Unify the
> labels in preparation for the next patch which will increase the cleanup
> section.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> @@ -69,16 +69,19 @@ static int early_config_cb(const char *var, const char *value, void *vdata)
> +#define TC_VALUE_NOT_FOUND 1
> +#define TC_CONFIG_FILE_ERROR 2
> +
>  int cmd__config(int argc, const char **argv)
>  {
> +       int i, val, ret = 0;
>
>         if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
>                 read_early_config(early_config_cb, (void *)argv[2]);
> -               return 0;
> +               return ret;
>         }

This one change feels both fragile and increases cognitive load, thus
does not seem desirable. It feels fragile because someone could come
along and insert code above this conditional which assigns some value
other than 0 to 'ret' (not realizing that this conditional wants to
return 0), thus breaking it. It increases cognitive load because it
forces the reader to scan all the code leading up to this point to
determine what value this conditional really wants to return.

Nevertheless, this is a minor objection, not necessarily worth a re-roll.

> @@ -94,10 +97,9 @@ int cmd__config(int argc, const char **argv)
>                         printf("Value not found for \"%s\"\n", argv[2]);
> -                       goto exit1;
> +                       ret = TC_VALUE_NOT_FOUND;

This sort of change, on the other hand, does not increase cognitive
load because it's quite obvious what return value this conditional
wants to return (because it's assigning it explicitly).

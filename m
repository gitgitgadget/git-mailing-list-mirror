Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EB5C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 04:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5455020771
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 04:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgHNEmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 00:42:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36537 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgHNEmc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 00:42:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so6850500wmi.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 21:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=maE8Na76y13+q/eSdfOMW9lPrp2BCGX+Yf4vqp0GYmo=;
        b=CWedQyAYWieSi6rytMYXqwJdtgWBBse7Zx6oU4Li66vWe7x2UuTh8H12WmVbFYuc9G
         wCR3FNUXoPwDOKExOuSwCFD2siT0sX59QByIZ7aUZvExGrqUMEdkH7Hgn4ERZ/OtLX+X
         JE1qADur8BJI5Tm9l0Wcs3zO96wrNVcmaztnUWVDylCinI8XIx94bwRx+obWYIGrRfEt
         0yIxO6NxlpVwtlBJNX6IQQpE8fjIJ+x0xbp4wCJPqZP5bJ9tA325x/lEAkuK00fmlybV
         058vqUj6tyt7/q8/Efg7VAPCvjBYf3CD09/SrTwuPfjc7WddudYzzOb+EZUso+QgY96z
         DRoA==
X-Gm-Message-State: AOAM5324at3wWU75EIU9eV6QLRpTUFEYPISEPloQY2Q3a6v3wEdS2YVG
        e9G7BFwes1/Gfs1JX71tC48WoOpYh8bau/Uq8bI=
X-Google-Smtp-Source: ABdhPJxyBD+8deKDscwUDWVeMIaE8+VNOLKAioBPd5ZMhgM/u6VVuVHSLTvbWjOwOtgvF7hVudTLRL+RUo6HXvvcZJs=
X-Received: by 2002:a1c:39d4:: with SMTP id g203mr764863wma.107.1597380150014;
 Thu, 13 Aug 2020 21:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.830.git.git.1597374135.gitgitgadget@gmail.com> <eae8b2923f7834f3b1d030f6eb4dc093b94da91b.1597374135.git.gitgitgadget@gmail.com>
In-Reply-To: <eae8b2923f7834f3b1d030f6eb4dc093b94da91b.1597374135.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 14 Aug 2020 00:42:19 -0400
Message-ID: <CAPig+cQamHAUc9gV=pRAVYfxJKCwiMj=y6nqoN8w2kg6CtOT9Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] mem-pool: add convenience functions for xstrdup and xstrndup
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 11:02 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> fast-import had a special mem_pool_xstrdup() convenience function that I
> want to be able to use from the new merge algorithm I am writing.  Move
> it from fast-import to mem-pool, and also add a mem_pool_xstrndup()
> while at it that I also want to use.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/mem-pool.c b/mem-pool.c
> @@ -102,6 +102,29 @@ void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_t size)
> +char *mem_pool_xstrdup(struct mem_pool *pool, const char *str)
> +{
> +       size_t len = strlen(str) + 1;
> +       char *ret = mem_pool_alloc(pool, len);
> +
> +       if (!ret)
> +               die("Out of memory, mem_pool_xstrdup failed");

Nit: Not worth a re-roll, but I was wondering if it would make sense
to allow these to be localized (and follow current convention of not
capitalizing):

    die(_("mem_pool_xstrdup: out of memory"));

> +       return memcpy(ret, str, len);
> +}
> +
> +char *mem_pool_xstrndup(struct mem_pool *pool, const char *str, size_t len)
> +{
> +       size_t minlen = strnlen(str, len);
> +       char *ret = mem_pool_alloc(pool, minlen+1);
> +
> +       if (!ret)
> +               die("Out of memory, mem_pool_xstrndup failed");

Ditto.

> +
> +       ret[minlen] = '\0';
> +       return memcpy(ret, str, minlen);
> +}

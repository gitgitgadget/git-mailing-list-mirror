Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53497C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 22:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BA060E95
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 22:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhGWV1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:27:21 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:42904 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhGWV1U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 17:27:20 -0400
Received: by mail-ej1-f45.google.com with SMTP id e19so5677046ejs.9
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 15:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vAjeEF0nFwy69efSXEEugGkQc5/P3nRW1vPw8tjB2MM=;
        b=omi7a6ecQ+Nl7bl2KCN4iYh15txJBk8mYKkLnvnSMPHie2Ouj5sSV5rAS/nH+z8Ay3
         i6T6LS+pZ/OR7m277rjBcI5H0oEJmS9297b9bkks6OQGgKJ0uu/ofCAppGL+lppCvwww
         LB4YGyQv2HIrNfUgSByNsNkKy1gYJUxAHbsfvMfTNpokfwiG1dXaiuVU2gGWqM3SH06g
         JvP/vmWrYwz/AthQtGwocJuTUvAJ8zFX4ttzM2DmDrtqEuXF8Hqysss1TFMGiwm7UMTF
         A7U4Qt/amYUmj1RGu8/r/bDipiLn8paPLEXAyAYP56Bkg3Z8KuJKKiTJuost2h+heZ54
         uVdw==
X-Gm-Message-State: AOAM532P4c57+TIGWcQnl8BmgAETL9zw0NJgFhOjF0+ml8oQhNLkJe5L
        htjHUePfKtR3L+BQz1qg1Bf72oVY7sxiNVlonTM=
X-Google-Smtp-Source: ABdhPJxW38CwTZLHovnrucFJCyYAp2lDEAVEnyhXnXadQ7kNc6ROIaurBsbpeLLelIyZgO43ECgkUpkbVrvRIebESb4=
X-Received: by 2002:a17:906:f9c5:: with SMTP id lj5mr6621277ejb.482.1627078072774;
 Fri, 23 Jul 2021 15:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.990.git.1627044897.gitgitgadget@gmail.com> <e30b8c8fea110b2475d00a4b37eb62a4883999c4.1627044897.git.gitgitgadget@gmail.com>
In-Reply-To: <e30b8c8fea110b2475d00a4b37eb62a4883999c4.1627044897.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 23 Jul 2021 18:07:41 -0400
Message-ID: <CAPig+cQD28hPV30B2Oih=LUDmJGWKTFXmZGE65YYhqAeH0FVvQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] merge-ort: add pool_alloc, pool_calloc, and
 pool_strndup wrappers
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 8:55 AM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> We need functions which will either call
>     xmalloc, xcalloc, xstrndup
> or
>     mem_pool_alloc, mem_pool_calloc, mem_pool_strndup
> depending on whether we have a non-NULL memory pool.  Add these
> functions; the next commit will make use of these.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

Patch [2/7] feels somewhat incomplete without the utility functions
introduced by this patch (and, indeed, when reading [2/7], I was
wondering how you were going to deal with the potential NULL pointer).
From a review standpoint, I could easily see [2/7] and [3/7] presented
as a single patch, but it's not worth a re-roll.

> diff --git a/merge-ort.c b/merge-ort.c
> @@ -683,6 +683,30 @@ static void path_msg(struct merge_options *opt,
> +MAYBE_UNUSED
> +static void *pool_calloc(struct mem_pool *pool, size_t count, size_t size)
> +{
> +       if (!pool)
> +               return xcalloc(count, size);
> +       return mem_pool_calloc(pool, count, size);
> +}
> +
> +MAYBE_UNUSED
> +static void *pool_alloc(struct mem_pool *pool, size_t size)
> +{
> +       if (!pool)
> +               return xmalloc(size);
> +       return mem_pool_alloc(pool, size);
> +}
> +
> +MAYBE_UNUSED
> +static void *pool_strndup(struct mem_pool *pool, const char *str, size_t len)
> +{
> +       if (!pool)
> +               return xstrndup(str, len);
> +       return mem_pool_strndup(pool, str, len);
> +}
> +

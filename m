Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD62F1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 14:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeJOWUG (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 18:20:06 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43648 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbeJOWUG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 18:20:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id q41-v6so21637297qtq.10
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 07:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P79pidIOfL/DuAnEgy51NN+BsD4W4osjkjdjFnM7Cgo=;
        b=G/72coyhfT8hj+4JcwVuxQhIsLTy9aGpK3Y8nAdXxqf02wU8wDIY9CQ8afFD/LBvdt
         4awVK0k+EiN7i+PGGNoZaJYNMGdUpe6CAsizOyZ3NdxPFcADUcsy2oJrWm10pYlYwh7m
         ZN3sSDFzNwHQ+dlOO2qU1p+rHWNd76N9m+xSyuwqvN7svhppNIP4NGGA3m5Y54gU/GDG
         1SedPOmQaX8Hw2C5+OcsWYJQmx337BWAcjR0wZTtt0VAOQ8RYdlxLe1AX9kJwYamXJEq
         KZj2p1kuaLGSPtPDBHqW6CGm8wCqulgmGk7hH9LAJ79S2sQq7OZzcmVqcWcnwC0NYHtH
         Ufxw==
X-Gm-Message-State: ABuFfoj+IJXB86K7gp5RLjbiVIQMRlb5LtcWYYw0KvWOOEzjg76pmiE3
        nmE14v8pDQmM2i9ShJjYG59L9eVK5lt3QrrBpvA=
X-Google-Smtp-Source: ACcGV621OKhn/jon2fMW14CF6We7JKBrFShfnp6NgraUb8O/VO1uJLt+1OFffTDeaBhwpGXi7SkgflhPG05ovELWwx4=
X-Received: by 2002:ac8:592:: with SMTP id a18-v6mr16688300qth.184.1539614073287;
 Mon, 15 Oct 2018 07:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.45.git.gitgitgadget@gmail.com> <11025b1639785577924b2020fb20d076308e9c69.1539596822.git.gitgitgadget@gmail.com>
In-Reply-To: <11025b1639785577924b2020fb20d076308e9c69.1539596822.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 15 Oct 2018 10:34:22 -0400
Message-ID: <CAPig+cRbOOrC5_jCnR2ohMZWoYXfNqvWtj3m_JTpudJhV1mQng@mail.gmail.com>
Subject: Re: [PATCH 2/3] getpwuid(mingw): provide a better default for the
 user name
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 5:47 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> We do have the excellent GetUserInfoEx() function to obtain more
> detailed information of the current user (if the user is part of a
> Windows domain); Let's use it.
> [...]
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/compat/mingw.c b/compat/mingw.c
> @@ -1798,6 +1799,33 @@ int mingw_getpagesize(void)
> +static char *get_extended_user_info(enum EXTENDED_NAME_FORMAT type)
> +{
> +       DECLARE_PROC_ADDR(secur32.dll, BOOL, GetUserNameExW,
> +               enum EXTENDED_NAME_FORMAT, LPCWSTR, PULONG);
> +       static wchar_t wbuffer[1024];

Does this need to be static? It's not being returned to the caller.

> +       len = ARRAY_SIZE(wbuffer);
> +       if (GetUserNameExW(type, wbuffer, &len)) {
> +               char *converted = xmalloc((len *= 3));
> +               if (xwcstoutf(converted, wbuffer, len) >= 0)
> +                       return converted;
> +               free(converted);
> +       }

If xwcstoutf() fails, 'converted' is freed; otherwise, the allocated
'converted' is stored in the caller's statically held 'passwd' struct.
Okay.

> +       return NULL;
> +}

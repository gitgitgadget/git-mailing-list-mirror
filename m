Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 034601F453
	for <e@80x24.org>; Mon, 15 Oct 2018 14:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJOWLe (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 18:11:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36080 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbeJOWLe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 18:11:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id a85-v6so11919653qkg.3
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 07:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1jJQ9XOzJym9AQdt3dd0i4kYZgaXYuoDu0/TasObak=;
        b=KR/wOBdGMqr8ZuhahR6jMoYw5zjNjYTr5hbX/DNM8PnsuVxSgs4JaPZDKrHL4WDcWm
         aXlCovQhfe2X+LhrtypWIUyAZQRf4CrKtqEd3GtJRIKt4ex04oQrmdU50jrCERpqyF4o
         evvjjvb5F2+dqZoWAaDYLsWeCNmjFxofS6d1KJPt+/kIaQtDnTA2xc/cXSM5FXB5B02u
         kPno2QItwX2TW06D2eMPIzuQez4iMvToVIDX5UjIulkI1t6uileiSOaxYcJV4BohVq5X
         NBTxmYMrFhG4YIwc1wvE5uX0wKArqYrglDJrzq4pJIQ2DaRjw6MyAbc1iRQSJ6VLwYkp
         /d4g==
X-Gm-Message-State: ABuFfogehsDOI/76JsJz+eXjC0j+lLsOVYIw7X3qEPCX+lRSz6uPvslX
        lwCOxvMJDJb4mn8//N2GLlfLy6dtevnEgPSm/Yg=
X-Google-Smtp-Source: ACcGV615LUupEYx/CDvRYM93iI+aBtph2w7pHzGvuro0a/vjkreWUAAApFt+1yAX/h4Zz5gwKSQO1Z64Y5+ANVS7Ezs=
X-Received: by 2002:a37:7641:: with SMTP id r62-v6mr16267743qkc.314.1539613563576;
 Mon, 15 Oct 2018 07:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.45.git.gitgitgadget@gmail.com> <63373dd91d0be324273ab34ff49d630453954173.1539596822.git.gitgitgadget@gmail.com>
In-Reply-To: <63373dd91d0be324273ab34ff49d630453954173.1539596822.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 15 Oct 2018 10:25:52 -0400
Message-ID: <CAPig+cS3Bz3uaxWv23bQEXB7Ok=Q+V07mGc-Fysg-WU3DKKagA@mail.gmail.com>
Subject: Re: [PATCH 1/3] getpwuid(mingw): initialize the structure only once
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
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/compat/mingw.c b/compat/mingw.c
> @@ -1800,16 +1800,27 @@ int mingw_getpagesize(void)
>  struct passwd *getpwuid(int uid)
>  {
> +       static unsigned initialized;
>         static char user_name[100];
> -       static struct passwd p;
> +       static struct passwd *p;
>
> +       if (initialized)
> +               return p;
> +
> +       len = sizeof(user_name);
> +       if (!GetUserName(user_name, &len)) {
> +               initialized = 1;
>                 return NULL;
> +       }

If GetUserName() fails, that failure is recorded (as "initialized=1"
and 'p' is still NULL), so subsequent invocations just return NULL
without doing any more work. Makes sense.

> +       p = xmalloc(sizeof(*p));
> +       p->pw_name = user_name;
> +       p->pw_gecos = "unknown";
> +       p->pw_dir = NULL;
> +
> +       initialized = 1;
> +       return p;
>  }

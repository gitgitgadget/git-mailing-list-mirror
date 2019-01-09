Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D4681F803
	for <e@80x24.org>; Wed,  9 Jan 2019 23:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfAIXLK (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 18:11:10 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33935 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfAIXLK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 18:11:10 -0500
Received: by mail-qk1-f196.google.com with SMTP id q8so5495117qke.1
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 15:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xrztkiiu4vSp3xeS0Nh3QmkdPI+ZsPnsNb1MXsRDwLU=;
        b=A6BSF6GhpioOCXebbGKG8UA9IFytjRpptPmLsJT/fp3UfiboA55pYTyOChINmIUKVG
         TBzO3+fAamoRk/dnAiWuyvdywf/0TztLsTAO2zPL+Bxq9c4pKPqc70kiGM73Fj+FvP81
         b/mJ8pJWByKawvEVsgxrW/BN/AuxOZhinJT4X3F/OnXlwTscHyNTay83/Hg3ULM8LC5r
         XZOHYUe2sUwue9QgIRFr0HBK16w3r2fwGjOcDEPTjiG2k1GHQ8RzW5X6UBxfbnq5ND3z
         46AoepMARiPB4db2AWEKyvQpWrRzFaOdag3v+LwNvp+DFIMJGhjvglIU/gXIDvnuGlSB
         /yVw==
X-Gm-Message-State: AJcUukfSeaKrDAjxeiDdL+N/nT2QlhB5T7sOk2EuSHsnUHMnAUAvyaPw
        +z2mXLG3qfsOQk7LF1AcYHeliHFmLP8Yts68jmgGAQ4b
X-Google-Smtp-Source: ALg8bN7R8Lqy5J+fORHN97ohXazksb9JulyRoHL3U//Z2l0SX4Vgg9b/0D0ovjP0h+WZd/Xnh9x4KQcZSqx9cRq1XiU=
X-Received: by 2002:a37:a44e:: with SMTP id n75mr7391724qke.26.1547075469326;
 Wed, 09 Jan 2019 15:11:09 -0800 (PST)
MIME-Version: 1.0
References: <20190109221007.21624-1-kgybels@infogroep.be>
In-Reply-To: <20190109221007.21624-1-kgybels@infogroep.be>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 9 Jan 2019 18:10:58 -0500
Message-ID: <CAPig+cQKnEWb+co_NJ0UyZbXZrvx2KsbS_ZugdyjjYZcz8tjvw@mail.gmail.com>
Subject: Re: [PATCH] diff: ensure correct lifetime of external_diff_cmd
To:     Kim Gybels <kgybels@infogroep.be>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Karsten Blees <blees@dcon.de>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 9, 2019 at 5:19 PM Kim Gybels <kgybels@infogroep.be> wrote:
> According to getenv(3)'s notes:
> [...]
> Since strings returned by getenv() are allowed to change on subsequent
> calls to getenv(), make sure to duplicate when caching external_diff_cmd
> from environment.
> [...]
> Signed-off-by: Kim Gybels <kgybels@infogroep.be>
> ---
> diff --git a/diff.c b/diff.c
> @@ -492,6 +492,9 @@ static const char *external_diff(void)
>         external_diff_cmd = getenv("GIT_EXTERNAL_DIFF");
>         if (!external_diff_cmd)
>                 external_diff_cmd = external_diff_cmd_cfg;
> +       else
> +               external_diff_cmd = xstrdup(external_diff_cmd);

Make sense.

Not shown in the context is that 'external_diff_cmd' is static, so
this is not (in the traditional sense) leaking the dup'd string.

I do find that the logic is obscured by doing the xstrdup() in the
'else' arm; it would be easier to grok if the condition was reversed
and xstrdup() done in the 'then' arm.

However, you might also consider using xstrdup_or_null(), like this:

    external_diff_cmd = xstrdup_or_null(getenv(...));
    if (!external_diff_cmd)
        ...as before...

>         done_preparing = 1;
>         return external_diff_cmd;
>  }

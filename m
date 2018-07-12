Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFB0B1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 22:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbeGLXIQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 19:08:16 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33880 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387532AbeGLXIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 19:08:16 -0400
Received: by mail-yw0-f194.google.com with SMTP id j68-v6so11086325ywg.1
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 15:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQEfRP/AiMfVn5DqU7gnSOVz0Vot2XPuGEbuCc40G7Y=;
        b=WrULPfXAX84ytB1qq5sW/vv3G3HCnzSEjUXPWikbVE2VEp+3wNqjVG6eE8LLl+Kct7
         6nMSH5fdTRKAILVTk9phgbkuZdhGgxf35E8d4jFlH8HWPfZ9rHxCfAkAscj/UbAeuRqX
         w4mLS2DOgbSC0rlTYLw6XGashMiRVNPEXfw4CRpmzBLJYTQqapWm4Ohh2eX+sY/UABGP
         Letn9ddU6ldz5rbkJPQncBbIxlNTt0ozQNRHX4a+kRpxJKaXYDMjOEfA/R5EkM6Paty4
         b3BjX7Id3i+AL6Lw4QVTw/Nu+Ybq/CxwAz1ea8pEQ7Bf9iweCXJFW5Qs4O89aMpfWZyi
         QY/g==
X-Gm-Message-State: AOUpUlFjPxhx89vwA1V/xQr7Da57OtvK4v4a9EWqLt2Yp1RywJJ9jeVg
        h2lcLeFVYi4pHvZf0f1s7TZs2U+fbENYGo96zU0=
X-Google-Smtp-Source: AAOMgpepwYXKYIi8qjSkEzkFqDU4FoJfJWXvAAiQbzqclegoJuqwctQQBWt2WGy6ssaS8VstcQfw2or40HnSTJFmHHQ=
X-Received: by 2002:a81:7bd4:: with SMTP id w203-v6mr2168731ywc.70.1531436193237;
 Thu, 12 Jul 2018 15:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com> <20180712193940.21065-5-dstolee@microsoft.com>
In-Reply-To: <20180712193940.21065-5-dstolee@microsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 12 Jul 2018 18:56:22 -0400
Message-ID: <CAPig+cTU--KrGcv4C_CwBZEuec4dgm_tJqL=CFWKT6vxxR016w@mail.gmail.com>
Subject: Re: [PATCH v4 04/23] multi-pack-index: add 'write' verb
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 12, 2018 at 3:40 PM Derrick Stolee <stolee@gmail.com> wrote:
> In anticipation of writing multi-pack-indexes, add a skeleton
> 'git multi-pack-index write' subcommand and send the options to a
> write_midx_file() method. Also create a skeleton test script that
> tests the 'write' subcommand.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> @@ -30,5 +31,17 @@ int cmd_multi_pack_index(int argc, const char **argv,
> +       if (argc == 0)
> +               goto usage;
> +
> +       if (!strcmp(argv[0], "write")) {
> +               if (argc > 1)
> +                       goto usage;
> +
> +               return write_midx_file(opts.object_dir);
> +       }
> +
> +usage:
> +       usage_with_options(builtin_multi_pack_index_usage,
> +                          builtin_multi_pack_index_options);
>  }

I realize that some other commands may work this way, but merely
showing 'usage' is fairly user-hostile. What would be much more
helpful would be to explain to the user what the problem is; for
instance, "no action specified" and "'write' takes no arguments", or
something. That way the user knows exactly what corrective action to
take rather than having to try to guess based upon 'usage'. Showing
'usage' after the actual error message may or may not make sense
(though, I prefer not doing so since noisy 'usage' tends to swamp the
actual error message, making it easy to miss).

I wouldn't want to see a re-roll just for this, especially for such a
long series. Perhaps such a change can be done as a follow-up patch by
someone at some point.

By the way, if you ever need to add options or arguments to "write" or
"verify", you might want to model it after how it's done in
builtin/worktree.c, in which each subcommand is responsible for its
own argument processing, rather than handling subcommand arguments
here in the top-level function.

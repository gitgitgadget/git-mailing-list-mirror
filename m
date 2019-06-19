Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D967D1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 04:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbfFSELB (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 00:11:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45305 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfFSELB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 00:11:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so1663302wre.12
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 21:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8VnayS3zqF5QX15uXEonxNMp/oLC5n4OML2XUlBq3Aw=;
        b=YqUAT9w/ZcW8spMnohYn10crS53rY4FsnjfA63r4jqy5Az0laXuWtO+hzG/nV2E26k
         h1WVFtHuyPIsR7W6K7ONKCm8UbhXISeSOCTcDzQoquRVeI0ZqHyuVlA/QT4xf9j6DG2U
         P0TnNl4yWsRWqGvICC6r7SkGUUaomglqPiN4Dufj9C8nJdW5X+Zm5JpUqyfxvXMee4kN
         LqWCHJ32c+Y6iT2u9+FnmXtuSWRX6+Cg8By6/yAND5S+PSNDF2xRGrJFhL5D50d5XvNJ
         VyA3FMA/texKJsY47pN7SPyeuXVVcBtWzRaiAmZElNQ6wWTTGOLkwg7TPty8xEJ/APc4
         uaFg==
X-Gm-Message-State: APjAAAXuNCEv1VpXP17LmiF9h2t4CSLacnVKN8N1yeajr1RhJsHhmUTs
        KrDseksULY+Mbw6v570AQt7+pryG8MmubJBZFPUpTg==
X-Google-Smtp-Source: APXvYqz7e8e7ojAfLuong2MTXi3TLVe07YHcZ1LS57y8xHKeNfz7TqmLqC7B/IwY9j8t9s1nClrEOJbluRyp+sGghRY=
X-Received: by 2002:adf:f84f:: with SMTP id d15mr83556636wrq.53.1560917458813;
 Tue, 18 Jun 2019 21:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.149.git.gitgitgadget@gmail.com> <1491ea4140518d76d4619fa2da7ec20250da1404.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <1491ea4140518d76d4619fa2da7ec20250da1404.1560860634.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 19 Jun 2019 00:10:47 -0400
Message-ID: <CAPig+cRW+1dEUe1=7=5G-HziJOA2UpYVKsnMdBpkpcU6D8O95A@mail.gmail.com>
Subject: Re: [PATCH 15/17] msvc: do not pretend to support all signals
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 18, 2019 at 8:24 AM Jeff Hostetler via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> This special-cases various signals that are not supported on Windows,
> such as SIGPIPE. These cause the UCRT to throw asserts (at least in
> debug mode).
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/compat/mingw.c b/compat/mingw.c
> @@ -2119,8 +2119,34 @@ int mingw_raise(int sig)
> +#if defined(_MSC_VER)
> +               /*
> +                * <signal.h> in the CRT defines 8 signals as being
> +                * supported on the platform.  Anything else causes
> +                * an "Invalid signal or error" (which in DEBUG builds
> +                * causes the Abort/Retry/Ignore dialog).  We by-pass
> +                * the CRT for things we already know will fail.
> +                */
> +               /*case SIGINT:*/
> +       case SIGILL:

Why is SIGINT commented out?

And, the comment block seems over-indented.

> +       case SIGFPE:
> +       case SIGSEGV:
> +       case SIGTERM:
> +       case SIGBREAK:
> +       case SIGABRT:
> +       case SIGABRT_COMPAT:
> +               return raise(sig);
> +       default:
> +               errno = EINVAL;
> +               return -1;

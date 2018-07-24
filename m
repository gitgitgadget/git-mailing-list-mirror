Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 086631F597
	for <e@80x24.org>; Tue, 24 Jul 2018 17:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbeGXSk5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 14:40:57 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:32890 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388382AbeGXSk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 14:40:56 -0400
Received: by mail-yw0-f195.google.com with SMTP id c135-v6so1836862ywa.0
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 10:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j+TeA46hX0TA1Bjr8DvgLTS4DNiFuWr6Bxn9Krr0WFQ=;
        b=Yk11BKAEwEkLx3g4DKOJWoKrfNUOREG75R3F4uMB/0Ray427hPKjhQtlJp4x2W6X0v
         UDE+ebYVsTWRAb5JyqxI/7gJdeQ04n1S2G0qtzq8if8VM9XLtmG+EZTVrawbtGO7Jkbl
         eP3BIeIOuFy9GHBFC+6VmzlDjETQhR3uK0SBWMsX2JwwvzN+XmRD8r//iP+N1FJtPVqz
         NqYbcWDEXRrTJ8VppcKWia+L4fk/Di8M8II4bLyy88psrJmlZeBGwFWi5qiRdLU7Ta1t
         sLfJIQpa6BInB1teELNGfNCaT9gXAQqUqESU8oY2e8SGgNIujcQ/L1uQy0QxH6WUdHVz
         1V7g==
X-Gm-Message-State: AOUpUlEdASjO6Fe2OCPXI8HDj0UmTDQbzIQCVnZeTDdyrAOVGUch9dNr
        ebS0JazXgoXZa9QwoE4otXFzjD4/DK5u8Ahr6Gk=
X-Google-Smtp-Source: AAOMgpcjV4MpycqNpkHObxgs3aY/2dDyZPPJ2CU7I0HtzowQtkvnxry587ZykQjaWdgZ2MZVNiu27O/AHPbRpuwMFU4=
X-Received: by 2002:a81:1001:: with SMTP id 1-v6mr9497549ywq.120.1532453603910;
 Tue, 24 Jul 2018 10:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180724144249.2857-1-git@jeffhostetler.com>
In-Reply-To: <20180724144249.2857-1-git@jeffhostetler.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 24 Jul 2018 13:33:13 -0400
Message-ID: <CAPig+cSzJQS9PnHgEbyUpOAQGQgWJuwZDP7nsgBMECzy2C3wkQ@mail.gmail.com>
Subject: Re: [PATCH v1] msvc: fix non-standard escape sequence in source
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 10:43 AM <git@jeffhostetler.com> wrote:
> Replace non-standard "\e" escape sequence with "\x1B".
>
> In commit 7a17918c34f4e83982456ffe22d880c3cda5384f a trace message with
> several "\e" escape sequences was added.  This causes a compiler warning
> under MSVC.

Wrong commit. That code was actually introduced by 541d059cd9
(convert: add tracing for 'working-tree-encoding' attribute,
2018-04-15).

> diff --git a/convert.c b/convert.c
> @@ -335,7 +335,7 @@ static void trace_encoding(const char *context, const char *path,
>         strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
>         for (i = 0; i < len && buf; ++i) {
>                 strbuf_addf(
> -                       &trace,"| \e[2m%2i:\e[0m %2x \e[2m%c\e[0m%c",
> +                       &trace,"| \x1B[2m%2i:\x1B[0m %2x \x1B[2m%c\x1B[0m%c",

In this codebase, ESC is always spelled as octal \033 rather than hex \x1b.

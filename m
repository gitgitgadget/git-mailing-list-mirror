Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB7BD1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 08:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeKTSxr (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 13:53:47 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38911 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbeKTSxr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 13:53:47 -0500
Received: by mail-qk1-f193.google.com with SMTP id d19so1536641qkg.5
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 00:25:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fn4ghD6jLDE2SZf5Pd9LICnANJxaTlccXYMQtvoPKt0=;
        b=A1GaTdqR4aLcMxN3SfVYaHuvIOoqbOJFa8gwedPsSs69AZ9i4VmGaJEJ44Kifc4mlf
         dya8rum05zbdN9vnOPl+65fnBUs315cNg85JYAE3B39cKEerxQkdefsMN7k40VRfZRS0
         UA4T8PiaEoE59MpwYGgwcGeOdR1THEy0qRO7Tj8zBIL1wjsDHog0kNIkjW5wpHxQPb7Q
         /gH4fpM35tVs6ZPdUUVKFMi1D0KJfE7cjimEyk26/Wy4haho1AwNgWiVf9CGXh/5OOn4
         J603sDPYDBvblXxCsrtF0e7KWd5vfPqCzMsPLzh7SwaNyYqkvy4TkWFMfmQTdeR4kxd0
         jqDA==
X-Gm-Message-State: AA+aEWaj0f0sch47gl/j63czHTzp/veNstyiC562uWh/hN8ZH/RKCsh7
        QBzRd2Xqrvh7v5oTgTAlA06TjpZO2wYnHNK3pOg=
X-Google-Smtp-Source: AFSGD/Xvc5j831ARr2D4ogK4wzuErpLemFBQIZjbaIuLeTl8v+X8mYTv29h818byZfUh9WgsuBMeXH9u/0X7OJuUbD8=
X-Received: by 2002:a0c:86c1:: with SMTP id 1mr990579qvg.6.1542702353722; Tue,
 20 Nov 2018 00:25:53 -0800 (PST)
MIME-Version: 1.0
References: <20181104152232.20671-1-anders@0x63.nu> <20181118114427.1397-1-anders@0x63.nu>
 <20181118114427.1397-6-anders@0x63.nu>
In-Reply-To: <20181118114427.1397-6-anders@0x63.nu>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Nov 2018 03:25:42 -0500
Message-ID: <CAPig+cRhnEO7suiCB4j_7c3NdRHWkPjY8mp0jU76KdOoM_hhPQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] pretty: add support for separator option in %(trailers)
To:     anders@0x63.nu
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 18, 2018 at 6:45 AM Anders Waldenborg <anders@0x63.nu> wrote:
> By default trailer lines are terminated by linebreaks ('\n'). By
> specifying the new 'separator' option they will instead be separated by
> user provided string and have separator semantics rather than terminator
> semantics. The separator string can contain the literal formatting codes
> %n and %xNN allowing it to be things that are otherwise hard to type as
> %x00, or comma and end-parenthesis which would break parsing.
>
> Signed-off-by: Anders Waldenborg <anders@0x63.nu>
> ---
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> @@ -218,9 +218,16 @@ endif::git-rev-list[]
> +  ** 'separator=<SEP>': specifying an alternative separator than the
> +     default line feed character. SEP may can contain the literal
> +     formatting codes %n and %xNN allowing it to contain characters
> +     that are hard to type such as %x00, or comma and end-parenthesis
> +     which would break parsing. If option is given multiple times only
> +     the last one is used.

It's not clear from this documentation what constitutes a valid <SEP>.
Is it restricted to a single character? Can it be an arbitrary string?
If a string, does it need to be quoted? Does it support backslash
escaping?

Although I was able to guess that %xNN allowed hex input of a 7- or
8-bit value, I found myself wondering what I was supposed to replace
'n' with in "%n". I didn't fathom that "%n" was meant to be typed
literally to specify a newline character.

> +  ** Examples: `%(trailers:only,unfold,separator=%x00)` unfolds and
> +     shows all trailer lines separated by NUL character,
> +     `%(trailers:key=Reviewed-by,unfold)` unfolds and shows trailer
> +     lines with key `Reviewed-by`.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22E2C64E90
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 03:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A8C206CB
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 03:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgLADQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 22:16:29 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:37637 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgLADQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 22:16:29 -0500
Received: by mail-ej1-f67.google.com with SMTP id f9so954043ejw.4
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 19:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BMru7+uZqFMD4ma8rdW6HlTF8BRk1cuWQEOqv1Lfd4=;
        b=CU0QJA+71QS20dtCEw+Ai6n+wESsgU4HTa6iM8yG0/0ap1q4uagCseZcK60jkSy0Nz
         zfON0kUGfjqoxmzQpxyDB0Z/RLtO6H7QH7lhrBKxsmpXQ/8BENzSTM7hBfddza5eRX/7
         jhvfAk3ghjSAY1PlpVtZsUEUg/LhWAHh71W5kVzLqLH3PPB0YJirMmsyAfv9WZmtEyRA
         Cfs32jqYBPX2BlFGzeukbtMwxcjlhdpvawvHQHtFDqMgfCj87UOBZWG3kkkz5JOHWQJG
         90/It55ZtMCj4vCpT5eju+6dAnnhD7BLqTB6RDG5cMAPhHKohXHy1Ov65IvfBZvvE4sL
         9+Sg==
X-Gm-Message-State: AOAM531YBjS++OpRTtFxeliFO5EgLdAsdg6mqdQYSYfxDre6jmWZ1+N5
        hBi4N9/cRjrBTsCvetyAiAeN9UV+Jv2ir2c6QQ1750VqaiM=
X-Google-Smtp-Source: ABdhPJzOGKGy36JRdxLcLRp4V/LVz+88PIIuoi5Bsuf4dNRZpjF6+YKfUWTFwfs9/UkuohPKpGNt8X+P5jvyW8jbTGM=
X-Received: by 2002:a17:906:614:: with SMTP id s20mr1047838ejb.202.1606792548067;
 Mon, 30 Nov 2020 19:15:48 -0800 (PST)
MIME-Version: 1.0
References: <27fc158339c91f56210f00dae9015da1d6c781ec.1606777520.git.me@ttaylorr.com>
 <73eb4965807ea2fdf94f815a8f8a2b036296ecca.1606782566.git.me@ttaylorr.com> <X8WqFynk23yWT6E3@coredump.intra.peff.net>
In-Reply-To: <X8WqFynk23yWT6E3@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Nov 2020 22:15:37 -0500
Message-ID: <CAPig+cT=gMEuKkbJefT9yxWWB5VC1fj6T+ofjn_saEEeEeU_MA@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/bugreport.c: use thread-safe localtime_r()
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 30, 2020 at 9:30 PM Jeff King <peff@peff.net> wrote:
> We might also want to do this on top:
>
> -- >8 --
> Subject: [PATCH] banned.h: mark non-reentrant gmtime, etc as banned
>
> The traditional gmtime(), localtime(), ctime(), and asctime() functions
> return pointers to shared storage. This means they're not thread-safe,
> and they also run the risk of somebody holding onto the result across
> multiple calls (where each call invalidates the previous result).
>
> All callers should be using gmtime_r() or localtime_r() instead.
>
> The ctime_r() and asctime_r() functions are OK in that respect, but have
> no check that the buffer we pass in is long enough (the manpage says it
> "should have room for at least 26 bytes"). Since this is such an
> easy-to-get-wrong interface, and since we have the much safer stftime()
> as well as its more conveinent strbuf_addftime() wrapper, let's likewise
> ban both of those.

s/conveinent/convenient/

I forgot all about banned.h. This patch does seem worthwhile to take.

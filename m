Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6123FC77B61
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 17:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDGRYK convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 7 Apr 2023 13:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDGRYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 13:24:09 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C796900C
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 10:24:08 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id x17so19122059qtv.7
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 10:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680888247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kOhXLIMnf+YiaXVG2QVu9oQrTGuyPgjM+hmDuPTBuc=;
        b=DXeXQHJB+OVLHC/zhamSVOdeg5fCcCJHd6UxwVGUp2iYbjXayRA5j1qobU6AiC5vYm
         BJakIHELSyw3tPdUI9jMUszz/bq5Wnjod1eg5mA1RGN+XJx+MRrLN1jlHOuX7gbqjkzB
         mboNNRIhWYOITWRIOB6ZJlUqyoANdEGK091hUIKrxUNr4SWbTzRLofpq0+VtP7LbJ1Rt
         9qWlfRbn/WVr3lRsVSm5qdWXIcNvj39498cEHJsCQ+s6M1JLxBRxghw9se60ZPLj58Hd
         V0Q87dBTSOpGiTxxpzvOKxWv3D4OG+h753qOn5WxLR5vbr/thT+rTyhvumQzGDADJeW3
         PzHg==
X-Gm-Message-State: AAQBX9ePHXy0TZuMnemosdn5li03aw1BqF7ixnCJFH8fOW1M7CE8Sdwd
        qkFHshWjB1s9e3DU/WiFPt+ou0AXnq0IUDFvmSY=
X-Google-Smtp-Source: AKy350ZdJVccp2a6KrRTAUzKCrAVZrrq/ZnwULWGLWIjYvR+Is7axB1mWakoQk9JrYmRf2zoIS2GeAPGSuye5Z+SX8w=
X-Received: by 2002:a05:622a:1811:b0:3d7:9d03:75af with SMTP id
 t17-20020a05622a181100b003d79d0375afmr972517qtc.12.1680888247406; Fri, 07 Apr
 2023 10:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAPig+cSNmws2b7f7aRA2C56kvQYG3w_g+KhYdqhtmf+XhtAMhQ@mail.gmail.com>
 <b45bf46f-580a-870c-5293-10ecdf2e56d3@aueb.gr> <b8b3777b-ee6e-d90e-3365-5cb9c9d129fe@web.de>
 <c4728fac-bea9-3794-077e-c978d99f46bf@web.de> <xmqq5yad7wv3.fsf@gitster.g>
 <bc6e89c9-d886-c519-85b3-fbc3f4eb5528@web.de> <7327ac06-d5da-ec53-543e-78e7729e78bb@web.de>
In-Reply-To: <7327ac06-d5da-ec53-543e-78e7729e78bb@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Apr 2023 13:23:56 -0400
Message-ID: <CAPig+cSmtc3pgdv5+3y1KhLymhjzLY2JsOqN2S__pXb4jGNHpA@mail.gmail.com>
Subject: Re: [PATCH] userdiff: support regexec(3) with multi-byte support
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Diomidis Spinellis <dds@aueb.gr>,
        demerphq <demerphq@gmail.com>,
        Mario Grgic <mario_grgic@hotmail.com>,
        "D. Ben Knoble" <ben.knoble@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 6, 2023 at 4:19 PM René Scharfe <l.s.r@web.de> wrote:
> Since 1819ad327b (grep: fix multibyte regex handling under macOS,
> 2022-08-26) we use the system library for all regular expression
> matching on macOS, not just for git grep.  It supports multi-byte
> strings and rejects invalid multi-byte characters.
>
> This broke all built-in userdiff word regexes in UTF-8 locales because
> they all include such invalid bytes in expressions that are intended to
> match multi-byte characters without explicit support for that from the
> regex engine.
>
> "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" is added to all built-in word
> regexes to match a single non-space or multi-byte character.  The \xNN
> characters are invalid if interpreted as UTF-8 because they have their
> high bit set, which indicates they are part of a multi-byte character,
> but they are surrounded by single-byte characters.
>
> Replace that expression with "|[^[:space:]]" if the regex engine
> supports multi-byte matching, as there is no need to have an explicit
> range for multi-byte characters then.  Check for that capability at
> runtime, because it depends on the locale and thus on environment
> variables.  Construct the full replacement expression at build time
> and just switch it in if necessary to avoid string manipulation and
> allocations at runtime.
>
> Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
> Reported-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: René Scharfe <l.s.r@web.de>

Thank you, René! This patch resolves the problem I was experiencing[1].

I'm happy to have --color-words working again.

[1]: https://lore.kernel.org/git/CAPig+cSNmws2b7f7aRA2C56kvQYG3w_g+KhYdqhtmf+XhtAMhQ@mail.gmail.com/

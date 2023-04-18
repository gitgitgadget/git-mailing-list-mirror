Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAD6C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 21:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjDRVZP convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 18 Apr 2023 17:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjDRVZM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 17:25:12 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420F8A27B
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 14:25:10 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id a15so7912063qvn.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 14:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681853109; x=1684445109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoImwnjdgzQvJq92ZkAVKqH0DV3UyJxbUKPIJlr/jDg=;
        b=IOuzartK1fJGAGkcjAZRCnRnR9ko8MfzaJmJuX7XSp1re9qpUEsm1K8R/56XYKv/fN
         tqQex0KSXvKrn5xpXn/82IZlh98QPeb/0/VwxjX5NO0WUk9iNdgecLZ7dH/OFt3Sd37n
         uKmbhxtSyMP1Ao0kqpNQK593JroMEdv3BHilQdLp/LHVYHjZvy2kmbWJ7b064WBXnhXt
         virSUCgJrxUjOJRmqh8tS6eE56WBBKOQe6pI1a3TxG3q/1MNmyZ6LRH6WTDKWY/3aOER
         DN3UUxygS4y8wY1nXoqwtKq8asWgLHlnHMS25QJlWwp7D8FBUfWQkARWI5o2dk0QbzvX
         mUpw==
X-Gm-Message-State: AAQBX9cM2GV1vvMr1DR2drp67L7M8o/KSjoiHMWsy9iku0Hde34sW11V
        UPWEu2zsosED1K69kRVM1Sm0CAHbNBJAt75G0n8=
X-Google-Smtp-Source: AKy350YiMp5UJIM809KYIWBSZHbIOpMR0in6vH1q1iW94VqxoG0xJAQ/W3IVeT2dcG0Oz1Q/iTHKopEptpGVP2wnD14=
X-Received: by 2002:a05:6214:409:b0:5c1:59b9:40b4 with SMTP id
 z9-20020a056214040900b005c159b940b4mr28911515qvx.48.1681853109174; Tue, 18
 Apr 2023 14:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu>
 <20230416054735.3386065-1-newren@gmail.com> <xmqq5y9uo4kj.fsf@gitster.g>
 <CABPp-BEmzofRAmgoz7Wam-6btCYCTy4CiVnTOtr9aQdjS6TB7w@mail.gmail.com> <xmqqwn28c3dh.fsf@gitster.g>
In-Reply-To: <xmqqwn28c3dh.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 18 Apr 2023 17:24:58 -0400
Message-ID: <CAPig+cTTTNO9e3X5u8irHjGHmY5t3GA1_zrvYmfhETn312XJcQ@mail.gmail.com>
Subject: Re: [PATCH/RFD] fix connection via git protocol
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, Michael J Gruber <git@grubix.eu>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 5:06 PM Junio C Hamano <gitster@pobox.com> wrote:
> From: Elijah Newren <newren@gmail.com>
> Subject: [PATCH] protocol.h: move definition of DEFAULT_GIT_PORT from cache.h
>
> Michael J Gruber noticed that connection via the git:// protocol no
> longer worked after a recent header clean-up.

A link to Michael's email might be useful for future readers of this
commit message.

    Michale J Gruber noticed[1] that connection...

    [1]: https://lore.kernel.org/git/5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu/

> This was caused by
> funny interaction of few gotchas.  First, a necessary definition
>
>         #define DEFAULT_GIT_PORT 9418
>
> was made invisible to a place where
>
>         const char *port = STR(DEFAULT_GIT_PORT);
>
> was expecting to turn the integer into "9418" with a clever STR()
> macro, and ended up stringifying it to
>
>         const char *port = "DEFAULT_GIT_PORT";
>
> without giving any chance to compilers to notice such a mistake.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Perhaps an additional tailer would be appropriate?

    Reported-by: Michael J Gruber <git@grubix.eu>

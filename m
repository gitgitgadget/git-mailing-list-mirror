Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88E0C74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 20:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCQUI5 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 17 Mar 2023 16:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCQUI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 16:08:56 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D563A149A1
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 13:08:54 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id z11so3812603pfh.4
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 13:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679083734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQUfvYaNEB6uyJ3cszRoQgKccyUmaEyg2lmR42n/Fto=;
        b=PfHM/zdWcXdPpCONNchOHEQv97v0C6eZ1DxmrHL5uqhTfGO/7ck/C37lLUnE3Jbb0F
         ek5s/pfOtAuSoRV9na0bgmXH2BBW6/+yO+1rvfPqfRoKEhXcVf9mi1m8fVO7dRJ/Y41n
         mAxr1HAgXaPwtYN7ZNuB2qAOxfQ4KAa2wt70FHJKqz85uYbVakO4A1EtnZmK4fuaNsME
         CqBtMqXoqbAVc+JDwd6HzUZH8+SQoZX+EUdARI/NQmCV/ULeiO1jxRbadF3CtF2IRAB5
         TBf0XGapKLZTyyv+Rsw9n8tXnEvPoZyoMUAaUWwY/rh7l2Ew5k8yf9xygx1U1xGGmoC9
         ZrXw==
X-Gm-Message-State: AO0yUKUy/Ps/mEwKH+xlkNDtpxDso0nK0FQFcGp84h57sCJldWpxCAKv
        rrMKGVq0uNGJclDFms0zsD4NT8dEvlUMLTyjgaM=
X-Google-Smtp-Source: AK7set+6ov70e85z1aFBo7F1l6KhkrhaE1HFPS7bJ6hZS98O7uXrgvZrDPKDXoDFH+9QtFC12UFhkcyjHNuhGuWnsko=
X-Received: by 2002:a05:6a00:1410:b0:606:a4bd:8dde with SMTP id
 l16-20020a056a00141000b00606a4bd8ddemr3137865pfu.4.1679083734307; Fri, 17 Mar
 2023 13:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <ZBS77VYL9ZrxKtCN@coredump.intra.peff.net> <ZBS8illla36MVppa@coredump.intra.peff.net>
In-Reply-To: <ZBS8illla36MVppa@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 Mar 2023 16:08:43 -0400
Message-ID: <CAPig+cQ9MNjEFHA07CM+c+qfTzNm99D=npLPD9qY079kkCzH6g@mail.gmail.com>
Subject: Re: [PATCH 1/4] mailmap: drop debugging code
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2023 at 3:16 PM Jeff King <peff@peff.net> wrote:
> There's some debugging code in mailmap.c which is only compiled if you
> manually tweak the source to set DEBUG_MAILMAP. When it's not set, the
> fallback noop uses static inline functions; we couldn't use macros here
> because one of the functions is variadic (and variadic macros were
> forbidden back then, but aren't now). As a result, this triggers
> a -Wunused-parameter warning.
>
> We have a few options here:
>
>   1. Leave it be. Just mark it as UNUSED, or switch to a variadic macro.
>
>   2. Assume the debugging code is useful, compile it always, and trigger
>      it with a run-time flag (e.g., with a trace key). This is pretty
>      easy to do, and carries a pretty small runtime cost.
>
>   3. Assume the debugging is not very useful, and just rip it out. This
>      matches what we did with a similar case in 69c5f17f11 (attr: drop
>      DEBUG_ATTR code, 2022-10-06).
>
> The debugging flag has been mentioned only three times on the list.
> Once, when it was added in 2009:
>
>   https://lore.kernel.org/git/cover.1234102794.git.marius@trolltech.com/
>
> In 2013, when somebody fixed some compilation errors in the conditional
> code (presumably because they used it while making other changes):
>
>   https://lore.kernel.org/git/1373871253-96480-1-git-send-email-sunshine@sunshineco.com/
>
> And finally it seemed to have been useful to somebody in 2021:
>
>   https://lore.kernel.org/git/87eejswql6.fsf@evledraar.gmail.com/

Nit: s/2021/2020/

> So it's not totally without value. On the other hand, it's not likely to
> be useful to non-developers (and certainly isn't if you have to
> recompile). And using a debugger or adding your own inspection code is
> likely to be as useful. So I've just dropped the code entirely here.
>
> Note that we do still have to mark a few parameters unused in callback
> functions which are passed to string_list_clear_func(). Those get an
> extra pointer with the string being cleared, which we previously fed to
> the debugging code.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I'm cc-ing folks from those earlier threads. If somebody really wants to
> salvage it, I can prepare a patch converting it to a trace variable
> instead, but absent any outcry, I'd go with this approach.

As one of the mentioned anonymous "sombody"s, I have no objection.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A941FC47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 22:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 837CA610A1
	for <git@archiver.kernel.org>; Sun, 30 May 2021 22:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhE3WQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 18:16:09 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:34522 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhE3WQI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 18:16:08 -0400
Received: by mail-ej1-f46.google.com with SMTP id g8so5269222ejx.1
        for <git@vger.kernel.org>; Sun, 30 May 2021 15:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Td4BfPsqMqZWSFSQQkCocH6Kt4f/IieSuskAGSGzqME=;
        b=t8YESQQFogpNEawU7X1RjcXoFn5mNTYSSIeUQxBK8/wJPUWkFFCyrzJs8IeLjO65ss
         GKRgOzqrg+8V81wm9C8IG9CunP/rQ4sFcRvMp7KtoKAY7FI0/t8CMOI0CyFnVHspTuEG
         IFQBXUmaH3Ar4sp1s0gSc3bLofmQjtoasr7NslEVnQPg9oicAPDytZqvBUH0QcD0twjt
         hV4Dz/Wus49qH/FsIWfAF1E1MIFO9jnVOW0pqjMpbpFrTcgeg891x1y4tMr/EWMLMPJ/
         DJGF3K+RjUDb9x+sf6JPdyeGQffrC1EEKn85rhHtpNNqd/itraf59WbgDiLf6y4+gBa8
         KhGQ==
X-Gm-Message-State: AOAM532z/ROxif12/A+BalrmmY0EGkHOtMYacVOB4Rm7NfpPUlsiI92e
        4JKBRTGD8YZ5gjSAeYBa+d574omcgPVafHqi7F4=
X-Google-Smtp-Source: ABdhPJyBEOmVsbDOsCjQUc2Qhd0Dsd0qymEXKMvRCOaQ5MOV0EVPl4sUSMbSukEarDeBPPMMx2pNrquiLNj302bBYJk=
X-Received: by 2002:a17:907:1c13:: with SMTP id nc19mr3856691ejc.168.1622412867872;
 Sun, 30 May 2021 15:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.964.git.1622410962551.gitgitgadget@gmail.com>
In-Reply-To: <pull.964.git.1622410962551.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 30 May 2021 18:14:17 -0400
Message-ID: <CAPig+cQdfadxF-AJAFtOv2XTjoLKQ1DqCfvDm-mtqPSj6eMrcA@mail.gmail.com>
Subject: Re: [PATCH] refactor of git_setup_gettext method
To:     Dima Kov via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Dima Kov <dima.kovol@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 30, 2021 at 5:43 PM Dima Kov via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Use one "free" call at the end of the function,
> instead of being dependent on the execution flow.
>
> Signed-off-by: Dima Kov <dima.kovol@gmail.com>
> ---
>     Hi. My first PR fot Git repository. I went over the code and saw that
>     maybe this part can be more clearer. Thanks.

Thanks for taking the time to submit a patch to the project. Your
change looks "obviously correct", however...

> diff --git a/gettext.c b/gettext.c
> @@ -109,17 +109,14 @@ void git_setup_gettext(void)
> -       if (!is_directory(podir)) {
> -               free(p);
> -               return;
> +       if (is_directory(podir)) {
> +               bindtextdomain("git", podir);
> +               setlocale(LC_MESSAGES, "");
> +               setlocale(LC_TIME, "");
> +               init_gettext_charset("git");
> +               textdomain("git");
>         }
>
> -       bindtextdomain("git", podir);
> -       setlocale(LC_MESSAGES, "");
> -       setlocale(LC_TIME, "");
> -       init_gettext_charset("git");
> -       textdomain("git");
> -
>         free(p);

... "clearness" is subjective, and it turns out that this project
generally prefers the code the way it was before this patch, and you
will find a lot of similar code throughout the project. In particular,
we like to get the simple cases and the error cases out of the way
early so that we don't have to think about them again for the
remainder of the function. Doing it this way eases cognitive load. (A
minor side benefit is that it also saves one or more levels of
indentation.)

An alternative which is also crops up somewhat often in this project
is to use `goto`, like this:

    if (!is_directory(podir))
        goto done;
    bindtextdomain(...);
    ...
    done:
    free(p);

However, `goto` is most often used when there is a lot of cleanup to
do or the cleanup is intricate. This specific case doesn't qualify as
either, so the code is probably fine as-is.

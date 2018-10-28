Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1548B1F453
	for <e@80x24.org>; Sun, 28 Oct 2018 19:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeJ2DrA convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 28 Oct 2018 23:47:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42301 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJ2DrA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 23:47:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id z20-v6so6848262qti.9
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 12:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fhXFuhyk+M3+k8mHgFqUBjLfy9DpXVuAQN3hLeFggno=;
        b=O9d5WXOUjwzhJP2UaThB4oJVrfXE/lQy4fGBvXSuDvZcWU0E2Ot6GXmTQNmV+ZGdcd
         WAWONy+ggVuc26GjZ/E2hY++XSX+EEkb3AGwq6/fVf1Tb//Rv/e/u1CF4l+zdR/UWMMr
         5TaRH5aCFUyTC6CwZ2bz5e/ZrSVolPJWL/BluFLNGT6KwDoQbwpCvkeCER0XvM5uVpB/
         qROpskcEL52Mo104652Gy05r9mTTW0nPDlRSLGwmNw8WDm96o+8SWsCM4DipK1riCsdZ
         p6UGlTuvLTmaU0VFLLc49i1vcqHyKgxUEjG27FFs5GgqSnYiAfp9G7DgPCL11CANOexn
         yrHw==
X-Gm-Message-State: AGRZ1gKt5ijV7MJJSy6cA6e5x09pGfNrwVfh0TrIaDnHJMuiCLsUwS5m
        9Ho95mjx79oVYI9gON7Or6no9SUfShjHOMrbsVA=
X-Google-Smtp-Source: AJdET5d3IujmVu20ZO36zMZBxTHq+LeNx0AjPV0gWAEhKJsZmdbrr+yFylFqaq9olgxv4WX3PMmNTo518ljCJCKwUKA=
X-Received: by 2002:ac8:592:: with SMTP id a18-v6mr10714868qth.184.1540753287964;
 Sun, 28 Oct 2018 12:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181028153145.25734-1-martin.agren@gmail.com>
In-Reply-To: <20181028153145.25734-1-martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 28 Oct 2018 15:01:16 -0400
Message-ID: <CAPig+cR28OBA0rwy=X6XU0cjstAguvUiLU9Zxjvg2X7=UsB5qw@mail.gmail.com>
Subject: Re: [PATCH] sequencer: clarify intention to break out of loop
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 28, 2018 at 11:32 AM Martin Ågren <martin.agren@gmail.com> wrote:
> [...]
> Let's be explicit about breaking out of the loop. This helps the
> compiler grok our intention. As a bonus, it might make it (even) more
> obvious to human readers that the loop stops at the first space.

This did come up in review[1,2]. I had a hard time understanding the
loop because it looked idiomatic but wasn't (and we have preconceived
notions about behavior of things which look idiomatic).

[1]: https://public-inbox.org/git/CAPig+cQbG2s-LrAo9+7C7=dXifbWFJ3SzuNa-QePHDk7egK=jg@mail.gmail.com/
[2]: https://public-inbox.org/git/CAPig+cRjU6niXpT2FrDWZ0x1HmGf1ojVZj3uk2qXEGe-S7i_HQ@mail.gmail.com/

> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -2849,10 +2849,14 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
>                 /* Determine the length of the label */
> +               for (i = 0; i < len; i++) {
> +                       if (isspace(name[i])) {
>                                 len = i;
> +                               break;
> +                       }
> +               }
>                 strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);

At least for me, this would be more idiomatic if it was coded like this:

    for (i = 0; i < len; i++)
        if (isspace(name[i]))
            break;
    strbuf_addf(..., i, name);

or, perhaps (less concise):

    for (i = 0; i < len; i++)
        if (isspace(name[i]))
            break;
    len = i;
    strbuf_addf(..., len, name);

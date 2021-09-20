Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5679DC433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 06:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3903F61052
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 06:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhITGHq convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 20 Sep 2021 02:07:46 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:39661 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbhITGHk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 02:07:40 -0400
Received: by mail-ed1-f43.google.com with SMTP id h17so56850363edj.6
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 23:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9fpxwc2GON4cEF0woWYXfPsrjX6UAjpVc5jZnAphAe0=;
        b=ob3Nr9N9bZq1wvs/udZsyUlwCvUDLn+Aje8bNA18KqnMp26Jopdg0vwXkAVPLdShh9
         AB/B4Le5UyxbTdijria35cMdECFF5fTxvyOa2J4Xbfx+uOEesNikXC6V9RF4qo3cOTVV
         vzHKAsbs/CYP2xP7bIrOib12yYCSqpFuXjNojjUHbfTPnyniPR0/wiexTl15wNG1Jr/9
         HGScVw4y4G0lNfQChKZjO9XlO6Q51zomAvzqLRQLQgBLW9/Q6IcsBVDg6b1HFtXOIScW
         TEHE8Szi4wpCOoX4tK5nDlN2l+O/R8BvjMlFrbjba0NAu19j2mMB3Wm365Yro6vnZf4d
         j3nw==
X-Gm-Message-State: AOAM530ZsdAQm29MzE+R2bO1LHG2wnE5mO6C44KiDkm9JulebGngAsHT
        aE+GZkYbmlKvvUcNSLmDoDIA/BFuldMc2S4habo=
X-Google-Smtp-Source: ABdhPJyRFx7m8wzuQdvlFHo8+6W1uz6BFazQE3XdhP7hgeHhl96VHJKj6PdqDrvs36t2CL4SZYIi+QgW7HhG+sgHsdo=
X-Received: by 2002:a17:906:15cf:: with SMTP id l15mr26565603ejd.568.1632117972610;
 Sun, 19 Sep 2021 23:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
 <6d54bc264e2f9ce519f32c0673167a00bab55573.1631972978.git.gitgitgadget@gmail.com>
 <YUZG0D5ayEWd7MLP@carlos-mbp.lan> <87o88obkb1.fsf@evledraar.gmail.com> <YUes7yxKHKW7cXcl@carlos-mbp.lan>
In-Reply-To: <YUes7yxKHKW7cXcl@carlos-mbp.lan>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Sep 2021 02:06:01 -0400
Message-ID: <CAPig+cT-ajKsoj19ChPnkNByf-6P-vX=SG0NmgYt8CXyNH8y-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] log: UNLEAK rev to silence a large number of leaks
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 19, 2021 at 5:34 PM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> Subject: [PATCH] revision: remove dup() of name in add_rev_cmdline()
>
> df835d3a0c (add_rev_cmdline(): make a copy of the name argument,
> 2013-05-25) adds it, probably introducing a leak.
>
> All names we will ever get will either come from the commandline
> or be pointers to a static buffer in hex.c, so it is safe not to
> xstrdup and clean them up (just like the struct object *item).

I haven't been following this thread closely, but the mention of the
static buffer in hex.c invalidates the premise of this patch, as far
as I can tell. The "static buffer" is actually a ring of four buffers
which oid_to_hex() uses, one after another, into which it formats an
OID as hex. This allows a caller to format up to -- and only up to --
four OIDs without worrying about allocating its own memory for the hex
result. Beyond four, the caller can't use oid_to_hex() without doing
some sort of memory management itself, whether that be duplicating the
result of oid_to_hex() or by allocating its own buffers and calling
oid_to_hex_r() instead.

In this particular case, one of the callers of add_rev_cmdline() is
add_rev_cmdline_list(), which does this:

    while (commit_list) {
        ...
        add_rev_cmdline(..., oid_to_hex(...), ...);
        ...
    }

which may call add_rev_cmdline() any number of times, quite possibly
more than four.

Therefore (if I'm reading this correctly), it is absolutely correct
for add_rev_cmdline() to be duplicating that string to ensure that the
hexified OID value remains valid, and incorrect for this patch to be
removing the call to xstrdup().

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> diff --git a/revision.c b/revision.c
> @@ -1481,7 +1480,7 @@ static void add_rev_cmdline(struct rev_info *revs,
>         info->rev[nr].item = item;
> -       info->rev[nr].name = xstrdup(name);
> +       info->rev[nr].name = name;
>         info->rev[nr].whence = whence;
> @@ -1490,10 +1489,6 @@ static void add_rev_cmdline(struct rev_info *revs,
>  static void clear_rev_cmdline(struct rev_info *revs)
>  {
>         struct rev_cmdline_info *info = &revs->cmdline;
> -       size_t i, nr = info->nr;
> -
> -       for (i = 0; i < nr; i++)
> -               free(info->rev[i].name);
>
>         FREE_AND_NULL(info->rev);

Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF5CC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB38207CD
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHUVNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:13:23 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:46097 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgHUVNW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:13:22 -0400
Received: by mail-ej1-f68.google.com with SMTP id d11so3836688ejt.13
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K3Weu1dRZJwB0hFlzqhhC02tsw0/L2r+KzwdN7ID1wg=;
        b=tBKHI9nNY/0N1PLoZkCKWThYueuSplLfAC+lF2dY7xs4W7XDaG4mGnPgnmwxAOS2z3
         nriYpqqBsRasYVQkc/hoERDn+xkk5EVUdkdhz8z0ACjEseX7pTPKr6DLZVxXd+8p/igd
         O9B/EEJ+emdMs49yLfHf66Zpz+8MaYGRq64N+T6KjW/8pni84yuY7r6y5E5RC+Om8cAW
         xVLgSZv8Gx3ADg+LPVMpqfarE5mlvMSnLGeVRSWff6BGVa6GFoCRRi9m5ZkxLteJ/dZJ
         vnPUmHOCYxZTYL+kND2WzCrIRcVbOjQpYqrisOn3RxC0tOyIcWPqlHvf2ultXiTTKnB1
         X9/A==
X-Gm-Message-State: AOAM531SggP3n0iYCJk1jYo8ir77NDY+x+Vln2x+WPK1snHH3U2bZwTB
        BS8XvElfXNtGuI8CS8WgoOpGR5V7U4apoGCFSxI=
X-Google-Smtp-Source: ABdhPJwjcTNZpCRO8IWj9iljyZHMxcrGU5yOI/sn9a3DLLPx78aa3X3CbrIOw8fFAPNUN2srPbIhHBdrV5xtMD9BzGw=
X-Received: by 2002:a17:906:a18e:: with SMTP id s14mr4763456ejy.168.1598044400485;
 Fri, 21 Aug 2020 14:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.707.v2.git.1598004663.gitgitgadget@gmail.com>
 <pull.707.v3.git.1598043976.gitgitgadget@gmail.com> <659b9835dcd0b38ac3972eb19c08c3bf26dccc80.1598043976.git.gitgitgadget@gmail.com>
In-Reply-To: <659b9835dcd0b38ac3972eb19c08c3bf26dccc80.1598043976.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Aug 2020 17:13:09 -0400
Message-ID: <CAPig+cSxjRoBE9FNqBW_xSkct6F23HmVSPhta_b4YD+MJERcTA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ref-filter: 'contents:trailers' show error if `:`
 is missing
To:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 5:06 PM Hariom Verma via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The 'contents' atom does not show any error if used with 'trailers'
> atom and colon is missing before trailers arguments.
>
> e.g %(contents:trailersonly) works, while it shouldn't.
>
> It is definitely not an expected behavior.
>
> Let's fix this bug.
>
> Acked-by: Eric Sunshine <sunshine@sunshineco.com>

I didn't "ack" this patch. If you think some sort of attribution with
my name is warranted, then a "Helped-by:" would be more appropriate.

> Signed-off-by: Hariom Verma <hariom18599@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -345,9 +345,11 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
> -       else if (skip_prefix(arg, "trailers", &arg)) {
> -               skip_prefix(arg, ":", &arg);
> -               if (trailers_atom_parser(format, atom, *arg ? arg : NULL, err))
> +       else if (!strcmp(arg, "trailers")) {
> +               if (trailers_atom_parser(format, atom, NULL, err))
> +                       return -1;
> +       } else if (skip_prefix(arg, "trailers:", &arg)) {
> +               if (trailers_atom_parser(format, atom, arg, err))
>                         return -1;

This looks better and easier to reason about (but I may be biased in
thinking so).

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> @@ -823,6 +823,14 @@ test_expect_success '%(trailers) rejects unknown trailers arguments' '
> +test_expect_success 'if arguments, %(contents:trailers) shows error if semicolon is missing' '

This still needs a s/semicolon/colon/ (mentioned in my previous review).

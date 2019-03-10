Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7C9920248
	for <e@80x24.org>; Sun, 10 Mar 2019 02:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCJCCO convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 9 Mar 2019 21:02:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39636 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfCJCCO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 21:02:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id l12so1352549wrp.6
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 18:02:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pMYfwBU6kqoxo/8obZC4p9F/3V9rEG5kWeg0GNXHKdM=;
        b=ZIp1DplZFRIHL77efoBH/ZYzllHTalFf/jYdwsoj7CbTvcf8h4yNUXAjqhTOlALIs3
         plul9b3AtlF2c3h5m3TEVBgT1xMbhaPc+aVi+cLCNGnjGCK0jOPe/sa4NfdOPhX2yKIZ
         Rm/JoHs0z1Jtzcu0si0g8KSMTeBCc7DtIzLnUWMSe53+85GfAVbEHLliH1vzLknlFuHz
         nj01HAxDQ9BMZ72LW3Fp2w0gqqaNPJ5XS82j9OvRDuIZqQHsh9h08STqvaHTXhozSafr
         AW1Hm6/MDGMpp0Kd9EpG38DL4b7Y87i8onJ3YVZD+aTcTaORr+gzkIZmxSPimAoKzaws
         v0WQ==
X-Gm-Message-State: APjAAAWgvsSrH4a0ANuERLhbnBBJz+82K7Kgr1x/E4pRS7+oUFTOO1ML
        ZY44U3Sbkw3YUCThthlD7zl02riE3J3qErlCD+c=
X-Google-Smtp-Source: APXvYqwy1TU+kzhraQoe4Jv4eHxtOJu0kSR11IDHFvgn8M0ONueUhv+QCiVYnoL9L2y6DBQ28v3yt5At103kzX/3xSk=
X-Received: by 2002:adf:dc10:: with SMTP id t16mr16281015wri.40.1552183332357;
 Sat, 09 Mar 2019 18:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20190305120834.7284-1-pclouds@gmail.com> <20190308092834.12549-1-pclouds@gmail.com>
 <20190308092834.12549-2-pclouds@gmail.com>
In-Reply-To: <20190308092834.12549-2-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 9 Mar 2019 21:02:02 -0500
Message-ID: <CAPig+cQYDuKrRwf9GrGZUTnH=BgSyp8Rmh7ON1p+0qOrHxpe3Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] worktree add: sanitize worktree names
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Yagamy Light <hi-angel@yandex.ru>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 8, 2019 at 4:28 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> Worktree names are based on $(basename $GIT_WORK_TREE). They aren't
> significant until 3a3b9d8cde (refs: new ref types to make per-worktree
> refs visible to all worktrees - 2018-10-21), where worktree name could
> be part of a refname and must follow refname rules.
>
> Update 'worktree add' code to remove special characters to follow
> these rules. In the future the user will be able to specify the
> worktree name by themselves if they're not happy with this dumb
> character substitution.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/refs.c b/refs.c
> @@ -72,30 +72,57 @@ static unsigned char refname_disposition[256] = {
> +static int check_refname_component(const char *refname, int *flags,
> +                                  struct strbuf *sanitized)
>  {
>         for (cp = refname; ; cp++) {
>                 unsigned char disp = refname_disposition[ch];
> +               if (sanitized && disp != 1)
> +                       strbuf_addch(sanitized, ch);
> +
>                 switch (disp) {
>                 case 1:
>                         goto out;
>                 case 2:
> +                       if (last == '.') { /* Refname contains "..". */
> +                               if (sanitized)
> +                                       sanitized->len--; /* collapse ".." to single "." */

I think this needs to be:

    strbuf_setlen(sanitized, sanitized->len - 1);

to ensure that NUL-terminator ends up in the correct place if this "."
is the very last character in 'refname'. (Otherwise, the NUL will
remain after the second ".", thus ".." won't be collapsed to "." at
all.)

> +                               else
> +                                       return -1;
> +                       }
>                         break;

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022EFC54E94
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 02:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjAZCef (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 21:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjAZCee (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 21:34:34 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4724561D51
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 18:34:33 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g13so1014281lfv.7
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 18:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0DLnTvkHehTK5UkFxUnBh6Ts+vaIGZkO52eARf6L5s=;
        b=RypM/bbc244ahmoiyoyJjmhQ6g1Dddi7IjV5nHDYxVoHlSfjqnz+mU7qorLYekI9Yj
         p3yZReWQwC2Kpi72h6UFzLqScy0c80ELZsIB0rCsIp9yUpjhFwH5OfV0DBjgMoRgceLd
         MOB+R8LcxMExnAaFs19q8bIA0rbUwqo6nwx7odfQE2seP7pgK38+4sCmlYy3nkuurWwn
         cxOb25Shbv4PvGi96T8KzT0fD8eRG7D5z9UHXDH2E/3WMUYaibvuR8PD1gZhjUMfN0FF
         BELRFJRwOcqF5cBGsamo19aDzxxJW+NorLg3EdzAu230NlxxAednQcleO97W0p2961yH
         U43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0DLnTvkHehTK5UkFxUnBh6Ts+vaIGZkO52eARf6L5s=;
        b=58GH3hXB6bp43PYJ0fufBp4qgH3Q6rd+Ssl987GQHalf63pRAvoG4T84DO90KUe1rY
         X0ZtvFiXO4ODLI2UYr5NG3YHpYHyxhio15KiBpoSsfbkbrNbGyux2mHxdDfLDMNfpVoM
         +oc9SJtRzQ8kcKu63FX1gcOhgYjRidcAqySEmoU5U9xu2OWSRYsiHYENFL97nv6Dn1L4
         OQpEfLVLX6ZDsZ0QMOVB7EenR8np3q/b8zn3rEN5S289kw2SGyUaExfQHljrjxtiofuc
         mnVAJb5Dh+N139dh0FPn8XoHuBjo0RWMq5mk2N805fUIdRaHVxTD/ICtFUVWnreWCNj9
         VY9w==
X-Gm-Message-State: AFqh2kpcOIkKr1Pthn4/GK+cUyEMGkv0rqIxXDXID/zkdzOI5rcArS7c
        rftiaGVA7yZ42GlL/RjxS2WuvG08820Nw45z9FY=
X-Google-Smtp-Source: AMrXdXuhjsjCYOcfhhm+ONvFuJZMGzAdxkiS58gbGrubJ2BEY7HJOk9B59pPQMRmX5y1o5CeWOh/23by7llbYGOMk3c=
X-Received: by 2002:a05:6512:4014:b0:4cc:548b:35f9 with SMTP id
 br20-20020a056512401400b004cc548b35f9mr2728977lfb.192.1674700471435; Wed, 25
 Jan 2023 18:34:31 -0800 (PST)
MIME-Version: 1.0
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
 <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <patch-v5-17.19-6a8f4a567aa-20230118T120334Z-avarab@gmail.com>
In-Reply-To: <patch-v5-17.19-6a8f4a567aa-20230118T120334Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Jan 2023 18:33:00 -0800
Message-ID: <CABPp-BFtR81jdjnEMKMaFnD71hdmCfgoQMSRuAEk8oMb3_AYFw@mail.gmail.com>
Subject: Re: [PATCH v5 17/19] grep API: plug memory leaks by freeing "header_list"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had the same reaction to this patch that Rene did on v1.  The commit
message of the previous patch should probably be reworked so as to not
mislead.

On Wed, Jan 18, 2023 at 5:15 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> When the "header_list" struct member was added in [1] it wasn't made
> to free the list using loop added for the adjacent "pattern_list"
> member, see [2] for when we started freeing it.
>
> This makes e.g. this command leak-free when run on git.git:
>
>         ./git -P log -1 --color=3Dalways --author=3DA origin/master
>
> 1. 80235ba79ef ("log --author=3Dme --grep=3Dit" should find intersection,
>    not union, 2010-01-17)
> 2. b48fb5b6a95 (grep: free expressions and patterns when done.,
>    2006-09-27)

That paragraph is really hard to parse for me.  Maybe change the above
to something like

"""
When the "header_list" struct member was added in [1], freeing this
field was neglected.  Fix that now, so that commands like

    ./git -P log -1 --color=3Dalways --author=3DA origin/master

will run leak-free.

1. 80235ba79ef ("log --author=3Dme --grep=3Dit" should find intersection,
    not union, 2010-01-17)
"""

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  grep.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/grep.c b/grep.c
> index a4450df4559..c908535e0d8 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -795,6 +795,7 @@ static void free_grep_pat(struct grep_pat *pattern)
>  void free_grep_patterns(struct grep_opt *opt)
>  {
>         free_grep_pat(opt->pattern_list);
> +       free_grep_pat(opt->header_list);
>
>         if (opt->pattern_expression)
>                 free_pattern_expr(opt->pattern_expression);
> --
> 2.39.0.1225.g30a3d88132d

Actual code change looks good.

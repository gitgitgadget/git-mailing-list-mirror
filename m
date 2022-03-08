Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C43EC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 01:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiCIBOI convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 8 Mar 2022 20:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiCIBNu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 20:13:50 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8056162029
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 17:01:46 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id p8so827871qvg.12
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 17:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zKBRRyZxMW/JaskPtiXPWWF2pz8Pp8T99jkXPshi8eY=;
        b=5lFbGJH7ScdIereJUTJ+EwIw7xtVk+8U3XryZp5pXg8lIQROUmO4VQpLEJTRXASO5M
         YRi//vUJHMJurD2jGqpa+agdfqs9HXaD/EKQky+hM0gqfDnzgRc6C8s8CDpPIB23f3Ua
         FDgTzbewQDM8R1zf7/HnoboTZ+9yCtXw4GuzQDcRC0zYT11xCrE50SQ/Luv/nOlfy6Rw
         HzCBRrA0Z1xFYEborUVbDBnAmV1Iv5JV2TtB74ym/GrDqg+brDoIKd+0ZDV32KoDG4zc
         K84GRE7uSaFnCTeaZXYKmZh5FLtgxmHkbsKej4kUI22f0NPov13HN6cfE+c1CddOWf58
         EYRg==
X-Gm-Message-State: AOAM533HULFVrXYTBtR7Dt3VdcdOKcyz0a3XWnY0bpXXTRyyP9HS7ir5
        E1HlafJQdvPGzHzsEiBtsJVvFvVI7VuzAdzOLh9myMODQ4w4pg==
X-Google-Smtp-Source: ABdhPJzBCvrP2Y9nckIR8XV/miw6LHanRz8tmeVB6oPxmrGBnA3jZ8tZbV029gWKJBeW25Ro/7aHBZhyOEcqa60qXcY=
X-Received: by 2002:a17:902:c215:b0:14f:f1c2:9fe3 with SMTP id
 21-20020a170902c21500b0014ff1c29fe3mr20052832pll.145.1646783894307; Tue, 08
 Mar 2022 15:58:14 -0800 (PST)
MIME-Version: 1.0
References: <20220304133702.26706-1-gitter.spiros@gmail.com>
 <20220308113305.39395-1-carenas@gmail.com> <CAPig+cSNgQ7SEYk9M=L7z0G=hteTdupKS6sHJL8T7zEp=zkLEA@mail.gmail.com>
In-Reply-To: <CAPig+cSNgQ7SEYk9M=L7z0G=hteTdupKS6sHJL8T7zEp=zkLEA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 8 Mar 2022 18:58:03 -0500
Message-ID: <CAPig+cT3TNFBMesYvYoncawfBdLqKL971SoP_J7F9FgnL10Eqw@mail.gmail.com>
Subject: Re: [PATCH] test-lib.sh: use awk instead of expr for a POSIX non
 integer check
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Elia Pinto <gitter.spiros@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 8, 2022 at 6:55 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Mar 8, 2022 at 6:44 PM Carlo Marcelo Arenas Belón
> <carenas@gmail.com> wrote:
> > Restrict the glibc version to a single version number and compare it
> > arithmetically against the base glibc version to avoid accidentally
> > matching against "2.3" and better supporting versions like "2.34.9000"
> >
> > Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> > ---
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > @@ -518,9 +518,9 @@ else
> > -               if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
> > -                  _GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
> > -                  expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null
> > +               local _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null)
> > +               if echo "$_GLIBC_VERSION" | cut -d. -f1-2 |
> > +                       awk '{ if ($2 - 2.34 < 0) exit 1 }'
>
> No need for `cut` since `awk` can accomplish the same by itself.
>
>     if echo "$_GLIBC_VERSION" | awk '/^glibc / { if ($2 - 2.34 < 0) exit 1 }'
>
> should work, I would think.

Nevermind, I forgot you want to better support "2.34.9000" matches.
Though, awk should still be able to do so on its own, one would
expect, but not too important.

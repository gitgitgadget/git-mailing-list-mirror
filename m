Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F66AC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 23:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiCKXJx convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 11 Mar 2022 18:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiCKXHw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 18:07:52 -0500
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343E0181B16
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 15:06:47 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id w4so8821674ply.13
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 15:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wDUTBOIh02UnROvody3ZL99CNvaHKPa2n/jo+UjkhbM=;
        b=CKTc2rBZpfPxXiul1qWn7/KH6K92FjolTWWduAkJQteQgfCs2r7tXdZkJZ1GUXL13t
         GR8G/2mD25eIrT7cdHlaJH/ZqPbVCwhaN2Oovk6i0LD49U3Vgbgb8n3PmUQ/OSWxHYRO
         gikfCP+D69e3c465BkcIjjEHVlqgeo9LMK6MYIXC8+AVQ1i6hGBSXrynlux7P+W+ooI9
         AjbwfARidGaE+oOd2fswb1Wo/YSbArm4Yhouxx+l0l8MauaWIQO7qA4nCg48zwLkvfKM
         P5sIiwNqdGZiz4OnDp7qsypVsGoUIHb61obudKKYbB3tA/xvdQKDzRydLfFhRjUsZ811
         qb0Q==
X-Gm-Message-State: AOAM532tGrctZQKSpKd1oneVrWriX3e0hmTUgoXJkJokaP9N4QR8YHn/
        J18laoeKdlfyLZxuPOZQmch0jz8BfdnN5+V0VgjJsm9aSrk=
X-Google-Smtp-Source: ABdhPJyphMTQfbYzbu5F8+OpDEnbUh8Fr5fhUU1bPBQg3mlGuSGSClF1aAoB2vnTTpcwQjkK3eAoztIkZ/wcSFDrYcA=
X-Received: by 2002:a17:903:2287:b0:151:dab2:aacc with SMTP id
 b7-20020a170903228700b00151dab2aaccmr13045313plh.64.1647040006568; Fri, 11
 Mar 2022 15:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20220304133702.26706-1-gitter.spiros@gmail.com>
 <20220308113305.39395-1-carenas@gmail.com> <CAPig+cSNgQ7SEYk9M=L7z0G=hteTdupKS6sHJL8T7zEp=zkLEA@mail.gmail.com>
 <CAPig+cT3TNFBMesYvYoncawfBdLqKL971SoP_J7F9FgnL10Eqw@mail.gmail.com>
 <CAPig+cSUTaPRvALJyJ8AxNB4wMFLyaWBOa8f+_8K6quPbxTT5A@mail.gmail.com>
 <xmqqv8wnm30q.fsf@gitster.g> <220309.86pmmulw77.gmgdl@evledraar.gmail.com>
In-Reply-To: <220309.86pmmulw77.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 11 Mar 2022 18:06:35 -0500
Message-ID: <CAPig+cQNeTAvWHm2GUGc2i=FKF2V6Gqkmmsw4kDOTzrSYEbgxA@mail.gmail.com>
Subject: Re: [PATCH] test-lib.sh: use awk instead of expr for a POSIX non
 integer check
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elia Pinto <gitter.spiros@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 9, 2022 at 3:14 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Wed, Mar 09 2022, Junio C Hamano wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> >> This seems to work, though it's getting a bit verbose:
> >>
> >>     awk '/^glibc / { split($2,v,"."); if (sprintf("%s.%s", v[1], v[2])
> >> - 2.34 < 0) exit 1 }'
> >
> > In general it is a good discipline to question a pipeline that
> > preprocesses input fed to a script written in a language with full
> > programming power like awk and perl (and to lessor extent, sed) to
> > see if we can come up with a simpler solution without pipeline
> > helping to solve what these languages are invented to solve, and I
> > very much appreciate your exploration ;-)
>
> I agree :) But the first language we've got here is C. Rather than
> fiddle around with getconf, awk/sed etc. why not just the rather
> trivial:
>
>         +#include "test-tool.h"
>         +#include "cache.h"
>         +
>         +int cmd__glibc_config(int argc, const char **argv)
>         +{
>         +#ifdef __GNU_LIBRARY__
>         +       printf("%d\n%d\n", __GLIBC__, __GLIBC_MINOR__);
>         +       return 0;
>         +#else
>         +       return 1;
>         +#endif
>         +}

It feels overkill to add this just for this one case which is
otherwise done easily enough with existing shell tools.

That said, perhaps I'm missing something, but I don't see how this
solution helps us get away from the need for `expr`, `awk`, or `perl`
since one of those languages would be needed to perform the arithmetic
comparison (checking if glibc is >= 2.34).

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51360C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 10:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349322AbiAKKl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 05:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiAKKlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 05:41:25 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28F4C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 02:41:24 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o12so54768851lfk.1
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 02:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KrZW2jL8CpSROEIXOvIOJsZOQdZRE/q5s04Kh1ptcwY=;
        b=dEWGgCcn+VCj7bL5GIGeiHTMXCqiIat5wNLIH8qZ/mtgfGr8T4uyzqFlg4lXnqzq8J
         U3GJfJOeT8G9DhFZTTECMR3ldobnTfVXkNao892ugnJRrjPzQhNRMpWjG4DbRTGWA4ek
         OEVwvs539nWSwaCgR12sX5BDUk1k6y0XUbwcPpfN5F+9BKjImJsnJlqvg5yahFOhwV27
         51TlDFLrmqrguffKlBhFPR9NQs2UywWwWmshy3WWyFeQVePuLnbhdlMxbWBjtNnkLIbB
         +y6HKcSM7pOZP126GpHnpPzaEeXbLVTZmmDNvGqMLRU3rXzDXMpfH3K94QP4TgPgOrdy
         bdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KrZW2jL8CpSROEIXOvIOJsZOQdZRE/q5s04Kh1ptcwY=;
        b=nfiFLyo4rSq9OzPuyVfG1yRistsw5DCguE++P9DIC3KvKTmiX/D86GtSYA4lyVQfLD
         YRR8gd6PwhI8MkLtsQZ/NojvjqTPk/TUK5XZFeLJEbZOsusCqWLZ2BI3aIqIFNizrq53
         F/4yAWHtDCCxCted330p6naNysPlsHMtP22HqYAbSW0GuxDK99ozLIi9gjvNpYn28jFu
         4Abr+aZ3UDSITY8dcDsRRNFutUENgMkFQauEIeC/VWdx5qqd8pbShrPNAABxJbnQ4/Zq
         ngla8s16nS/N46o9ip96WmEJc8N5lH+aJN3qBR1rGDD8TlyfCTEqyPRlV6Vn4Vr5kLxQ
         7POA==
X-Gm-Message-State: AOAM531U3rkiwQssciepF8TsU9UBgN+p3pZ+N33su2kUtJVn51n+BpIG
        8PWIKc/uIT7jvz0Uwmc7Jfznf6YcXQabu9er+t3PHrbufLXVCeom
X-Google-Smtp-Source: ABdhPJyRT62Ku/kRU5AJVksh1BvuhqwRoubd29Y3mh/SGAByDrIeMxml3j2A91Y+ZhVuSy3sj9+qvJxNltLLJDG9wmQ=
X-Received: by 2002:a05:6512:3f20:: with SMTP id y32mr2958037lfa.401.1641897683071;
 Tue, 11 Jan 2022 02:41:23 -0800 (PST)
MIME-Version: 1.0
References: <20211217112629.12334-1-chiyutianyi@gmail.com> <20220108085419.79682-2-chiyutianyi@gmail.com>
 <8f9dd345-56c4-9a20-151b-e0e6d1a5b3fa@web.de>
In-Reply-To: <8f9dd345-56c4-9a20-151b-e0e6d1a5b3fa@web.de>
From:   Han Xin <chiyutianyi@gmail.com>
Date:   Tue, 11 Jan 2022 18:41:11 +0800
Message-ID: <CAO0brD17MC4THrGVNq70ey+vP-9-W28kZD4y8Fn1mVqyEbEbKA@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] unpack-objects: low memory footprint for
 get_data() in dry_run mode
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 8, 2022 at 8:28 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
>  Am 08.01.22 um 09:54 schrieb Han Xin:
> > From: Han Xin <hanxin.hx@alibaba-inc.com>
> >
> > +assert_no_loose () {
> > +     glob=3Ddest.git/objects/?? &&
> > +     echo "$glob" >expect &&
> > +     eval "echo $glob" >actual &&
> > +     test_cmp expect actual
> > +}
> > +
> > +assert_no_pack () {
> > +     rmdir dest.git/objects/pack
>
> I would expect a function whose name starts with "assert" to have no
> side effects.  It doesn't matter here, because it's called only at the
> very end, but that might change.  You can use test_dir_is_empty instead
> of rmdir.
>

*nod*
I think it would be better to rename "assert_no_loose()" to "test_no_loose(=
)".
I will remove "assert_no_pack()" and use "test_dir_is_empty()" instead.

Thanks
-Han Xin

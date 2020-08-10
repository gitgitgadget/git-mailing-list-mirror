Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4E7C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4E720748
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHJWNd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:13:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53935 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgHJWNc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 18:13:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id g8so879508wmk.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDs2QxG9EdH/vbbdatVr8e1jAeVft0EnOErSKt2/vAU=;
        b=FsXh46VVKzkWU764luTAUB4R+0/uMrMr7izNOZxdTkCjmTvcIMaJpg3jB1JEP1ToUx
         Oa6OyOEJ/W40UWuU/f8/rEVU/CP+31ArEJI1CSd/jtVhyopJkjtF7cWVX1AlZ09hH47r
         IZUmf9NzyPTLa+ChJwOMrLLcsW5SwqadkZebD0bkpTIj7iYciCIocSgvpEiTNgLz+TIQ
         gXVZ5rrRnGGCnBrt7JVykUNPhUDvaCtzZIxtXqWsfGjbjtvf2eGDa1OEtv6fDuWtR6LO
         WAS6j1YM0g/cfswEZzoOqTwntl/JdChdGtxXzShlXVCVfziF82k7QA0b2EfANM7Nh4UA
         JrvQ==
X-Gm-Message-State: AOAM53009ecQVTJPdbHBUPNAIY9m8qQN7iZYjNUmyu5U0RkyavIixkOr
        wFidSJBey8jWEYFOvW8Hw9ufAAUD0AbYoQ1fv0A=
X-Google-Smtp-Source: ABdhPJywBW1SZL+Zd5me8o5LKOLjymFitceae1E9F/hV1LpApokRWf3YP87BCiE68ATYGQWRrmCPXDG1uPqOlrgbiPg=
X-Received: by 2002:a1c:7405:: with SMTP id p5mr1124609wmc.130.1597097610434;
 Mon, 10 Aug 2020 15:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200808075323.36041-1-ray@ameretat.dev> <20200810085343.43717-1-ray@ameretat.dev>
 <CAPig+cSn_wrBuMKzoUZ720Hy-Y9RuPpJtmZ1mr--cnyAP866-Q@mail.gmail.com>
 <CAPig+cQCMG3Dx99LWTOAe8wZ2ocdikQAzdDS=-APfYE9HVn+=A@mail.gmail.com> <xmqqk0y6b1b0.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0y6b1b0.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 10 Aug 2020 18:13:19 -0400
Message-ID: <CAPig+cSUdRE2=PQhAHXTjJc10meAMSC6FqJ+LEjZYQA4shGURA@mail.gmail.com>
Subject: Re: [PATCH] t4069: test diff behavior with i-t-a paths
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Raymond E. Pasco" <ray@ameretat.dev>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 10, 2020 at 6:09 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > This can be improved by taking advantage of the OID_REGEX variable
> > defined by the test suite for matching an OID. So something like this
> > would be even better:
> >
> >     cat >expect <<-\EOF &&
> >     diff --git a/test-file b/test-file
> >     index OID..OID 100644
> >     --- a/test-file
> >     +++ b/test-file
> >     EOF
> >     cat blueprint >test-file &&
> >     git diff --ita-visible-in-index -- test-file >raw &&
> >     sed "s/$OID_REGEX/OID/g" raw >actual &&
> >     test_cmp expect actual
>
> OID_REGEX is [0-9a-f]{40} while what is used here is [0-9a-f]{1,}.
> Unless --full-index is in use, they mean different things, no?

You're right, of course. The regex in the original example I gave was
too loose, matching even single hex letters in words like "index" and
"test-file", so I wanted to tighten it up, but I botched it with
OID_REGEX. Anyhow, I hope my examples convey the general idea (which
needs a bit of tweaking from what I showed).

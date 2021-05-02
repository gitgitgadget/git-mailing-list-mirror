Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39418C433B4
	for <git@archiver.kernel.org>; Sun,  2 May 2021 06:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1052B6135A
	for <git@archiver.kernel.org>; Sun,  2 May 2021 06:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhEBGuV convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 2 May 2021 02:50:21 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:34456 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhEBGuU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 02:50:20 -0400
Received: by mail-ed1-f48.google.com with SMTP id i3so2756481edt.1
        for <git@vger.kernel.org>; Sat, 01 May 2021 23:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=khBKbs1fOHpGkNa+4R+wlaTUw9ewCA/IDyDpOi4AKK8=;
        b=av24plG1i8hmEYUN9ZJNNmatRT5m7Esba0ennybtnRUJWRYrfnnjxynvJI28xND+//
         j8eh6MlRdB71i9cfAZGe/dHXuQavzIGETlvbJym4boexOrOzQpenCt8Gs1zJ+7ixWSAT
         V91QSogExI2ExO15tUsxgmXTVfgel2Kaz5rzj8NMO/XaQBFVHTkxxm9DqjSCR0X+NmoE
         9JC722s/nGMPt2i2AOXsu32ENkabnMO8dinzvENq87nB7Y5Nl5SXqJNmEWcfByn8E/CX
         3CS8NbRfDHdBCtKjoepgtL4u5OTIX1BneazfKalVhQp8C4S6WH13KB5QcBPEmh/NHKoL
         iLyw==
X-Gm-Message-State: AOAM532Yq31BrmjnWsyX1nZ6TpzP32DCTNMis6V3qgLwF3GIMVYfEKDx
        qPSVKftBRV0QTAyA9EPKZYAafbA2wroK5brJtLoHSnHJ2QI=
X-Google-Smtp-Source: ABdhPJy0/sIsPbajbxx6WIjdusZjFptBVqj9oQMlxl+pyfrXMX1je1oxcciNQ8Fjj2OV9TFtEZA4br5wFN4qfA6Kt28=
X-Received: by 2002:a05:6402:145:: with SMTP id s5mr13989376edu.221.1619938167624;
 Sat, 01 May 2021 23:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210501145220.2082670-1-lenaic@lhuard.fr> <81e77586-8e9a-44b8-bee6-94ecf1b60d12@gmail.com>
In-Reply-To: <81e77586-8e9a-44b8-bee6-94ecf1b60d12@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 2 May 2021 02:49:16 -0400
Message-ID: <CAPig+cSwFwUbeyUZxs5mZ4GpFRqQ51C9xA1uD=VHQB==jkKj0Q@mail.gmail.com>
Subject: Re: [PATCH] maintenance: use systemd timers on Linux
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 2, 2021 at 1:28 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> On 01/05/21 21.52, Lénaïc Huard wrote:
> > The existing mechanism for scheduling background maintenance is done
> > through cron. On Linux systems managed by systemd, systemd provides an
> > alternative to schedule recurring tasks: systemd timers.
> >
> > The main motivations to implement systemd timers in addition to cron
> > are:
> > * cron is optional and Linux systems running systemd might not have it
> >    installed.
>
> Supposed that I have Linux box with systemd and classical cron. Should
> systemd timers be preferred over cron?

The implementation in this patch unconditionally prefers `systemd`
over `cron`. Whether that's a good idea is subject to question (as
both brian and I mentioned in our reviews).

> Nevertheless, because we are dealing with external dependency (systemd), it
> should makes sense to enforce this dependency requirement when user choose to use
> systemd timers so that users on non-systemd boxes (such as Gentoo with OpenRC)
> don't see errors that forcing them to use systemd.

If you scan through the patch itself, you will find that it is careful
to choose the appropriate scheduler and not to spit out errors when
one or the other scheduler is unavailable.

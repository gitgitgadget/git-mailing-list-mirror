Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B4CC433E0
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 17:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BE82067B
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 17:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgFGRQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 13:16:39 -0400
Received: from mx2.freebsd.org ([96.47.72.81]:35906 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgFGRQi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 13:16:38 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 30D8A872D5
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 17:16:38 +0000 (UTC)
        (envelope-from kevans@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 49g32Y7080z4Hmf
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 17:16:37 +0000 (UTC)
        (envelope-from kevans@freebsd.org)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client CN "smtp.gmail.com", Issuer "GTS CA 1O1" (verified OK))
        (Authenticated sender: kevans)
        by smtp.freebsd.org (Postfix) with ESMTPSA id E482412C32
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 17:16:37 +0000 (UTC)
        (envelope-from kevans@freebsd.org)
Received: by mail-qv1-f52.google.com with SMTP id dp10so7256276qvb.10
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 10:16:37 -0700 (PDT)
X-Gm-Message-State: AOAM533w+ZufFMv+O0f23IW+9nAMKCmoCJC/701vd0qCqx4IHmRlr01w
        t748LsJBlzbgl+l0/BIZo/W8wk9JALtMi6on7ig=
X-Google-Smtp-Source: ABdhPJzmJMYtcMX2+b5Fpn0b/la9b4fGGyCkbm6SB4vp0TD85Pmu3GJGEjtlzXcQDV+jXSE1Ks/sqcdbdKJ+GujmFzs=
X-Received: by 2002:a0c:ba22:: with SMTP id w34mr18791239qvf.129.1591550197580;
 Sun, 07 Jun 2020 10:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <CACNAnaG19QD1PbVS93nFm3XY70CZCrRosmVq-_3j+puAKSPj9Q@mail.gmail.com>
 <xmqqd06an6wf.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqd06an6wf.fsf@gitster.c.googlers.com>
From:   Kyle Evans <kevans@freebsd.org>
Date:   Sun, 7 Jun 2020 12:16:26 -0500
X-Gmail-Original-Message-ID: <CACNAnaHBPeg1SMMGUdErKnn12bGo8t3O7LU6Yktw40B7bKfBGA@mail.gmail.com>
Message-ID: <CACNAnaHBPeg1SMMGUdErKnn12bGo8t3O7LU6Yktw40B7bKfBGA@mail.gmail.com>
Subject: Re: fread reading directories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 7, 2020 at 12:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Kyle Evans <kevans@freebsd.org> writes:
>
> > I was looking at FREAD_READS_DIRECTORIES to measure some performance
> > differences, then stumbled upon [0] that dropped fread() from the
> > autoconf test that causes git to use its git_fopen shim [1] even on
> > Linux.
>
> I thought we saw this mentioned recently?  I do not recall if
> any concrete improvement came out of it.
>

Ah, this is my bad. =-( I had searched the archives (I'm not typically
subscribed to this list) and noticed the related patch for GNU/Hurd,
but completely missed that a more active discussion had taken place
within that thread. I have now read that, and have no further
questions.

Thanks!

Kyle Evans

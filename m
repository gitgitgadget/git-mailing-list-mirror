Return-Path: <SRS0=HVLo=IF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EE4C433DB
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 20:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839C765172
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 20:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhCGUxA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 7 Mar 2021 15:53:00 -0500
Received: from mail-ej1-f51.google.com ([209.85.218.51]:45295 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhCGUwf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Mar 2021 15:52:35 -0500
Received: by mail-ej1-f51.google.com with SMTP id mm21so16098889ejb.12
        for <git@vger.kernel.org>; Sun, 07 Mar 2021 12:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jqItIPqs4bX4z2SztwUzCEhd/lYtFoA43Xp6rfkTYtI=;
        b=kDoXF1Ko3r9UsJXT7cs+gx8wIPaoV+92G2FgMB92bLxC4FfbAa/Sf+XbKOMbN6KfEj
         h3nW4FF9BO+ZA4hoUTv2dcy/ruXExCem2/Six7u93oIVWrzesfleA5c4mATmHfeq7EDX
         0fqS6pgRjlXcE6PN4jZCfHz+ofhdCblm1O80/x9e/iFam4Syf4GE1QitLBkDkb667T7e
         b6tYYhBjnc2Odm9+P//ApkkvwmCMXLXqroBya1GlNFRRTthrOnV1mkPnmioRocUCYszm
         2pVqbCmwonwWchO6/Y7xV0oL1a/Eyu33FkS6OlM2Yur2CCNIAWNAFXjFqEBy7LB4vHLg
         NAmQ==
X-Gm-Message-State: AOAM531xDjJej5ijkQUPtC1hM1094tSuiPKDi9sSKRn/TfYlfWAVxmx1
        TrefRMMJXNB2uafVnuS6glbGRlNpERTsWfmtULA=
X-Google-Smtp-Source: ABdhPJxYHLms3aQ1ZPM6EQHXyDdmEEIAwJpK4kqubDWQwfSGuLckSZyeq6DNLtH7/323rhZxQUZEEJ8btG38/WDxu8E=
X-Received: by 2002:a17:906:68c5:: with SMTP id y5mr12199610ejr.371.1615150354789;
 Sun, 07 Mar 2021 12:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20210211015353.28680-2-avarab@gmail.com> <20210307132905.14212-1-avarab@gmail.com>
 <xmqqy2ey7kzx.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2ey7kzx.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 7 Mar 2021 15:52:24 -0500
Message-ID: <CAPig+cRnAFaHWGFqNes9SVXDeW=zgV4ONvY9=RTKcyJ+CnZO8Q@mail.gmail.com>
Subject: Re: [PATCH] mktag tests: fix broken "&&" chain
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 7, 2021 at 3:43 PM Junio C Hamano <gitster@pobox.com> wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> > -                     test_must_fail git mktag --no-strict <tag.sig 2>message.no-strict &&xb
> > +                     test_must_fail git mktag --no-strict <tag.sig 2>message.no-strict &&
> >                       grep '$2' message.no-strict
>
> I do not think the chainlint check is designed to deal with helper
> functions, but I wonder why nobody noticed a runtime failure.  Is
> this an unused/dead codepath?

The `git mktag` invocation would still have produced the expected
stderr output regardless of what happens later (by "later", I mean the
failing invocation of the non-existent `xb` command), which means that
the subsequent `grep` will find what it's looking for, making the
function succeed as expected.

Someone looking at the verbose output might have had a chance of
spotting the "xp: not found" error message, but there likely wasn't
any reason to scan the verbose output since the test succeeded.

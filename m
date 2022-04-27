Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE10AC433FE
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 11:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiD0LDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 07:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiD0LDS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 07:03:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF8E25B26A
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 03:43:04 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id k23so2568195ejd.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 03:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=/HeQEknZee01ztH058VLzycfRJnuY0uLOmGcsLQcxkg=;
        b=ghb70/FWreHoSKNrlB+nQKhc6Q/6hFaen7F4R24kJT6H22f1NAT8EmO0Yq1mFPUVHg
         jqCfHoXN4xb6b0DLMG4I2ts/maGpVhO9v72obbkV+upi1Dt1PzcywNrvuuDdxoli+0a4
         gcOQZyy9Z3+DR7N+x4vEBP24PGBqbufvgAJ5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/HeQEknZee01ztH058VLzycfRJnuY0uLOmGcsLQcxkg=;
        b=CYJ8eBuNRRtl0yEsAu/S1p2lkpADMu8nYCYz9h+FRmpaOlc8texCmln1/SEF01QROx
         AwPw7u10kY8BP4naZSo91FI0diHStqbeWawDDWTDiIAmRjsFHv9Nf/UQSW6DcIDixe72
         DEwaYsiZvu9oBN0yVO37JJfa0zYXnZZxjRaOymrS+34LlQfDkqwhNtyZasz7JMZ2VogY
         dJ2DqXDMXBUC56OKqoor1waACJLYE7KYjtF4zrU0c7HRGX9vkjOdQelkC8exGjVmhQCM
         QOMnoq5kBXugO7mNpu0iKTQ0zPEBPmtOpDQQg+EHTHC+nU3+BE1AWqpbChAhBtOMj5KK
         cdRg==
X-Gm-Message-State: AOAM530eCTef3bcd3RMq/4bYLko7Hc7nUEElK+efDfLYfLn+Rm+Vlt+Q
        xJMo+nbJldk8AfXk33CyzqPM9HeGZwWmPFuFf02fDcmfeDvYnZrbBd8=
X-Google-Smtp-Source: ABdhPJyp8ZwQGuqfgbQ0+EdpGhAkOhSonilWkmGm2WMoGQ4GDrJEjD4TKwlPz4G0yNAaCFQo1cmEUsMvqk0tGfTV1C0=
X-Received: by 2002:a17:907:96a5:b0:6f3:a0c0:c565 with SMTP id
 hd37-20020a17090796a500b006f3a0c0c565mr11929961ejc.540.1651056183366; Wed, 27
 Apr 2022 03:43:03 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 27 Apr 2022 12:42:51 +0200
Message-ID: <CAPMMpoj1pF=FfRg6Rgz6bP2mZaQhApL7QQx9=2U7i4AE4zsJ1w@mail.gmail.com>
Subject: Git stash create with untracked files?
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I'm just checking in case I'm missing something: Is there any way to
tell "git stash create" to include untracked files?

Someone recently brought up a situation where they'd like to take a
working directory state (incl untracked but not-ignored files), and
reproduce it in another working directory on another machine; "git
stash create" seems to be ideal for this purpose, save for the
(apparent) lack of arguments support.

If this is not possible today and we wanted to better support this
usecase, what would be a sensible way to do it? I can see three
possible directions:

1) Change the "create" subcommand to treat specific options as options
rather than the stash message (and make it understand -u /
--include-untracked)

2) Create a new subcommand like "create" that actually supported
relevant options (--include-untracked, --staged, maybe also
pathspecs), without changing the contract of "create"

3) Add an option to the "save" subcommand, asking it to actually leave
the working tree untouched (like create does) - and then expect the
user of this usecase to "drop".


It's possible to just use the existing "push" and then immediately
"pop", but the resulting temporary changes to the working tree could
make things like IDEs go into an unhappy indexing frenzy, depending on
the amount of local change.

I realize there's the "make stashes refs" work ongoing that's related
to this, but I don't think I've seen anything there that directly
addresses this "make my local changes be available over there
*without* touching my working tree" requirement.

Thanks,
Tao

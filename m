Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A156C55193
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 16:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7ED20704
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 16:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbgDWQR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:17:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55011 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgDWQR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 12:17:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id h2so7039223wmb.4
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 09:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DfHWFTPN0km+rt9meqaPOTRLKS6/QhZSYPzpbmzsphw=;
        b=UMXb7KkybmNhoSNlpBM1ccZ2aPLSldZDYGCOL2ekxqfoJ8nK3IyaVy58KhvCiBicyh
         4FRDRfZHoTAGUSrLAJgtb+hNJMaVZocFI7jIl79xtBAFttnBD0JJ6r1+iBJ7QnCdEAWu
         nGDIjaVNSWB1B/YalU1VXdVOaaq7yAMBRs6Dzf1u7je22AhPpbmf75SAjsWoYXx6tHxh
         OT89N8B9sBWCuHr3ykXGPQmggCf8S395FVw/IcFbhvzb0+VHvRleoYgkWQ8mqxhNrgPq
         hA4sgFbMLm2l6XKSoiKlFG/wfGWzzPgPBsra/aqpsMw+TiwZ7gnaP1Xh3WKwXeOUpBk/
         ePmA==
X-Gm-Message-State: AGi0PuYsdlTVh/zr6jV66RHt/HjK3986CqL2FzFep9CqwTk3rlrumz2w
        QZgnxooNBlmQev8A/5Vo9S9YgF83BeCqrqpU9u4=
X-Google-Smtp-Source: APiQypI7wH16RUym41vkvnwDZHWX6msOWg92LtIe8zyfgRZkRX1Ox3WAGTPLN07+RQhPF8dzcXruxrkSEnjjH4rDeMo=
X-Received: by 2002:a7b:c213:: with SMTP id x19mr4844040wmi.53.1587658645068;
 Thu, 23 Apr 2020 09:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.616.git.1587628367528.gitgitgadget@gmail.com>
In-Reply-To: <pull.616.git.1587628367528.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 23 Apr 2020 12:17:14 -0400
Message-ID: <CAPig+cSDQe7YDke=fyfdeSZOimcR5jj3FFk=Q4iOk6uiHsT-Zw@mail.gmail.com>
Subject: Re: [PATCH] macos: do let the build find the gettext headers/libraries/msgfmt
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 23, 2020 at 3:54 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Apparently a recent Homebrew update now installs `gettext` into a
> subdirectory under /usr/local/, requiring the CFLAGS/LDFLAGS to list
> explicit directories _even_ when asking to force-link the `gettext`
> package.
>
> Likewise, the `msgfmt` tool is no longer in the `PATH`.

Interesting. I wonder if this is indeed a recent Homebrew change or if
something changed elsewhere in the environment. I ask because...

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/config.mak.uname b/config.mak.uname
> @@ -133,8 +133,11 @@ ifeq ($(uname_S),Darwin)
> -       BASIC_CFLAGS += -I/usr/local/include
> -       BASIC_LDFLAGS += -L/usr/local/lib
> +       BASIC_CFLAGS += -I/usr/local/include -I/usr/local/opt/gettext/include
> +       BASIC_LDFLAGS += -L/usr/local/lib -L/usr/local/opt/gettext/lib
> +       ifeq ($(shell test -x /usr/local/opt/gettext/bin/msgfmt && echo y),y)
> +               MSGFMT = /usr/local/opt/gettext/bin/msgfmt
> +       endif

... I've needed these assignments in my local config.mak file ever
since I switched over to Homebrew from Macports (which installed
everything under top-level /opt) years ago.

I'm slightly leery of seeing these applied globally on Mac OS in
config.mak.uname since various package managers on Mac OS install
packages in wildly different locations, and these settings might cause
the wrong version of a package to be picked up if a user has a
preferred version installed elsewhere.

Would it be an alternative for the CI/PR build process to just create
a local customized config.mak rather than patching the
globally-applied config.mak.uname like this?

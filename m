Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5C7C433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 03:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5791223E8
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 03:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgLWDvq convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 22 Dec 2020 22:51:46 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:35831 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgLWDvp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 22:51:45 -0500
Received: by mail-ed1-f44.google.com with SMTP id u19so14940713edx.2
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 19:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3y5fLN308ZSKJgwJJjqCH9mal2h3/cddwnORtZfhR34=;
        b=tupX2bMmD+LNI/SRUs7DE/+yb89Ak3LB8UCPaHXbm9A9ZXmRDyCx+wbiUV2Vi16ZN8
         nSQpLfq4x7ZYBcf2oFEc6ElyhmKmXOSPEwGKhq2a4LMCaR+8QS40jJyfqXQOkI5XjrqI
         dZgHKDLS7gBYPdVfGO0M6drSO3xNd0InDqoio7C9rG1RW0bdhFAeJFNIKxx5ijX0hO6s
         mRtTsCk+k/iWexqEhZ3pS2cWAIfS/A1Tyqyym0WheoKOmqH82pzYDZ9i19aybEGwDNEg
         GQqbVzzJlEjDdcvBmM0wCJ5B7yU2GgoW7kLDEe2aVBd0iydEaIo5zKaon+hkpA0icQas
         W00g==
X-Gm-Message-State: AOAM530i6hpJmvDBjV2Lc++OjHdPOkdHpy9d+AFwYgvUwx/yzsIdcOD+
        pOXuAYcWSdT3x9ch1RF5i3o8unRLL1pkhwhJr7s=
X-Google-Smtp-Source: ABdhPJymUDv7nR58TGLO2qXFcU0ZPaR2j+B4qkNjg4tgL/R1k74m2pdjzMu2izY+RuhhiSlT4rDlAJTV90JFPjy5tuI=
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr23212256edu.163.1608695463493;
 Tue, 22 Dec 2020 19:51:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608585497.git.martin.agren@gmail.com> <689d3150e9822eeccac0e1d07c2ba26dac47b4c9.1608585497.git.martin.agren@gmail.com>
 <xmqqsg7xfoj9.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsg7xfoj9.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Dec 2020 22:50:52 -0500
Message-ID: <CAPig+cRmatC0Q22XBBx-ouzNSn5uiarTes1tSehGZuBWucSt1g@mail.gmail.com>
Subject: Re: [PATCH 2/3] gc: fix handling of crontab magic markers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 22, 2020 at 5:47 PM Junio C Hamano <gitster@pobox.com> wrote:
> Martin Ågren <martin.agren@gmail.com> writes:
> > +test_expect_success 'stop preserves surrounding schedule' '
> > +     echo "Crucial information!" >>cron.txt &&
> > +     GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
>
> 31345d55 (maintenance: extract platform-specific scheduling,
> 2020-11-24) in ds/maintenance-part-4 needs to adjust this
> exported variable for the tests to pass in 'seen'
>
> Is it just the matter of replacing it with
>         GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab ..."
> or is there more to it?

Yes, renaming GIT_TEST_CRONTAB to GIT_TEST_MAINT_SCHEDULER and
prepending "crontab:" to the value should be sufficient (per the
proposal by [1] and realization by [2]).

[1]: https://lore.kernel.org/git/X6+iJNYEbpQjHCb0@flurp.local/
[2]: https://lore.kernel.org/git/4807342b0019be29bb369ed3403a485f0ce9c15d.1605647598.git.gitgitgadget@gmail.com/

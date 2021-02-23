Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD3BC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 05:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D99A464E27
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 05:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhBWFDy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 00:03:54 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47]:46186 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhBWFDx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 00:03:53 -0500
Received: by mail-ej1-f47.google.com with SMTP id r17so6274307ejy.13
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 21:03:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCzNiO3Vr3pxiastKWMEa9uV36R7pgOa+BbMaT9+M7Q=;
        b=MnaghMnguYhXvtulgOx1FKFWfE+wZF0AxlyXE6roaok/bytgvH+ROyOHiLW5vRuFVL
         gcBA5QcAG2FPgUuK9spADh921yJNYLbfsYfCON5t/TGs4JerlmPJxBC+rZfc7jc9xCxz
         r1Nzd9Uevl37ot8s30pBcxb96x6AY53OCRlb6jTQsG7Vpb3vInXgH07mUOINrpJPZ1sH
         eHBJnnObQH7MCxAzsDCV7dMLg7RXYZyF0G5HWxWe679zImVDe/gbdBrXLONxXjFC2pU0
         KyiwBMsqMBkAatJzY9bZJStDG3PJn6v47vareO+lPTwCp6Em2Y8U+Mqiqm/Hl6UBRTBs
         c3Cg==
X-Gm-Message-State: AOAM533ETxe11+/PUOQOzBnPEhAf7hWdkGzLMAlaFeS5aYp5m85YDsK/
        q9UZO2lUob62i0Qq6ZZPKsH+91mQvTEUmIIkbQpcz6lL3lg=
X-Google-Smtp-Source: ABdhPJwe4/2C2bQ9+wCiK6DOhOTSL+P1ROBFcKD5vyFpxOBStGoRS5VtNx7ElZg7UIjnpw2ssSP1IyqShm1zeyt4HK4=
X-Received: by 2002:a17:906:ae14:: with SMTP id le20mr18273976ejb.231.1614056591481;
 Mon, 22 Feb 2021 21:03:11 -0800 (PST)
MIME-Version: 1.0
References: <CABXAcUzRhkeQhVtwtx-NBR0hbkoo=aCTwN464Dsj8680GPMDxw@mail.gmail.com>
In-Reply-To: <CABXAcUzRhkeQhVtwtx-NBR0hbkoo=aCTwN464Dsj8680GPMDxw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Feb 2021 00:03:00 -0500
Message-ID: <CAPig+cSvYLMtML5ya4GR30-nfNNt19okLjchkkdhdzAEB19H4g@mail.gmail.com>
Subject: Re: 'git maintenance' won't work on bare repos
To:     Clement Moyroud <clement.moyroud@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 22, 2021 at 9:02 PM Clement Moyroud
<clement.moyroud@gmail.com> wrote:
> So the proper solution is to do it from the bare clone itself.
> However, 'git maintenance register' silently fails (with an 0 exit
> code). There are two tell-tale signs:
> 1. 'git config --global --get maintenance.repo' returns '.'
> 2. There are no Crontab entries inserted.

I can confirm that problem 1 is a bug. However, I am unable to
reproduce problem 2.

Note that the crontab entry won't be created until you run `git
maintenance start`. Is it possible that you are forgetting that step?
(Be aware that `git maintenance start` will show a misleading "no
crontab for <user>" message if you don't already have a crontab file,
but the crontab entry will be created nevertheless, as evidenced by
`crontab -l`.)

> To reproduce:
> git init --bare test-me
> git -C test-me maintenance register
> git config --global --get maintenance.repo

I have a patch which fixes the problem with the bare repo path being
incorrectly registered as ".", but I still need to create a regression
test for it.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4F2C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 20:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiKVU6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 15:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiKVU6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 15:58:16 -0500
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1641FF94
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 12:58:07 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id 136so15115616pga.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 12:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHRqoE5o7yAzq5p88pXdJMXUU5SQFiOerMvXp4ChWAw=;
        b=k1f3Y8ihYZISFxWE1ccQ2mXBRlT/IHvTd4SMM52+Cfwr2Z2KlRWxcrT/rU3/qXORdg
         aNcwdnXNeBeR6Y/XcmRfq86zzVre5MFVol3ilCLpY+UhNuwKYDwxj+FDLvIyVhtEA+xD
         5l5j026/VaMW8R9XC1IPYXZ41hMSGy6+x+EEPsVM8Q4eVU5Z96I4nLu+kQLAbEAlsJwW
         4BNrccVkPVlxX+Eu7zjwgdFq5tDfQQu+1hc/gXX1FTO8+eQctSXLEQcbFfQS+vVw7FnE
         t1AThrGoieIpu54J1K5lNFhu+mmJ0xrzThiceKLReJYRi5mZk2axOZJMWGboTYVw4CSk
         9DsQ==
X-Gm-Message-State: ANoB5pmVbgQgKTYSAnHSEPzHFAaYmHdL8dz/Q2xWDPT1l8ZHywzTdy4G
        QlrbN2PWcZrBHF/ymxZa4yVOHUKYJ4RAy6MuW4c=
X-Google-Smtp-Source: AA0mqf4LclQsr0ikp5VlQPIzrgn74o/Z+vOjds2hHpr9+zZV87aLNNUIDoraXVXVditfschsKcoQF9yf6V6brTBsBGc=
X-Received: by 2002:a63:f048:0:b0:477:5e23:f9d1 with SMTP id
 s8-20020a63f048000000b004775e23f9d1mr4662036pgj.268.1669150686691; Tue, 22
 Nov 2022 12:58:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1385.git.git.1669148861635.gitgitgadget@gmail.com>
In-Reply-To: <pull.1385.git.git.1669148861635.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Nov 2022 15:57:55 -0500
Message-ID: <CAPig+cQ6_7wf6C280Rqi7mcTCiQp-n5GiLWTPazfcUcGFeZi0g@mail.gmail.com>
Subject: Re: [PATCH] chainlint.pl: fix /proc/cpuinfo regexp
To:     Andreas Hasenack via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Andreas Hasenack <andreas.hasenack@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 3:29 PM Andreas Hasenack via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> git commit 29fb2ec384a867ca577335a12f4b45c184e7b642 introduced a
> function that gets the number of cores from /proc/cpuinfo on some
> systems, notably linux.

Thanks for diagnosing this problem and quickly submitting a patch.

I forgot to mention earlier that we typically cite other commits like this:

    29fb2ec384 (chainlint.pl: validate test scripts in parallel, 2022-09-01)

which you can generate automatically with:

    git log --pretty=reference -1 29fb2ec384

> The regexp it uses (^processor\s*:) fails to match the desired lines in
> the s390x architecture, where they look like this:
>
> processor 0: version = FF, identification = 148F67, machine = 2964
>
> As a result, on s390x that function returns 0 as the number of cores,
> and the chainlint.pl script exits without doing anything.

Makes sense. Well explained.

A separate problem is that chainlint.pl doesn't fall back to a
sensible non-zero value if ncores() returns 0 (or some other nonsense
value). That is, of course, outside the scope of the well-focused
problem fix which this standalone patch addresses. I may end up
submitting a fix separately to make it fall back sensibly.

> Signed-off-by: Andreas Hasenack <andreas.hasenack@canonical.com>
> ---
> diff --git a/t/chainlint.pl b/t/chainlint.pl
> @@ -656,7 +656,7 @@ sub ncores {
>         # Windows
>         return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROCESSORS});
>         # Linux / MSYS2 / Cygwin / WSL
> -       do { local @ARGV='/proc/cpuinfo'; return scalar(grep(/^processor\s*:/, <>)); } if -r '/proc/cpuinfo';
> +       do { local @ARGV='/proc/cpuinfo'; return scalar(grep(/^processor[\s\d]*:/, <>)); } if -r '/proc/cpuinfo';
>         # macOS & BSD
>         return qx/sysctl -n hw.ncpu/ if $^O =~ /(?:^darwin$|bsd)/;
>         return 1;

As mentioned elsewhere[1], this code may eventually be dropped
altogether, but this fix is good to have in the meantime. Thanks.

[1]: https://lore.kernel.org/git/CAPig+cQrXb-YUSzmfgJ2PRoiOP3goVACRCrX9C39kf3oDH+BHg@mail.gmail.com/

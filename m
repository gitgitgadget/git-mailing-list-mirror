Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4466BC433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 05:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA926109F
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 05:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhKCFMr convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 3 Nov 2021 01:12:47 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:38464 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhKCFMo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 01:12:44 -0400
Received: by mail-ed1-f49.google.com with SMTP id r4so4964833edi.5
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 22:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iiialm1dIQ/5UaPKYfDqo1EhZm+Xz8akF9sd7Bdn3Co=;
        b=EjgPFz4mR9GmcB2tDKlIbsRxM5gqIsI4LqkYGEn6fw62hcm1CVWDvf9Z5R4lKKyOXJ
         mqNKx9gMS6kMvnkqAN4YFImfulMb9WNmevKCkzpVMpIjGNj1o+eJTCw+2Yh8x3t0zD7d
         bIX30XBmPKRna3N58ue/uxMj8usfr4Xa1kmvq8Nyw7v0+hKXH+Leqkej4XiCzKKXf4Fk
         Ck0A/L97YmSOYkznMfqLnNWjSV2Xd7Bt//Z3rBDkNFZ+AKwmhP+by3xTqmYiBglONTGj
         e2aeHSV/w47ysWagS+yvNZSJOKkC2vn0cVlziBxjVGULMjezG2CyqjBqkkgXnrWxfmjX
         nOCA==
X-Gm-Message-State: AOAM530cjUcI2BUUYVUBo3o4LqEB3b4qrk0NRuWzEevjm3DAEff/KxxZ
        cX7Cjt/0T5ag/pbgqLQ5HZJuB/D8EOm3TCpx6nOchXwa
X-Google-Smtp-Source: ABdhPJyABySbetF/ONNoKAhk7swtOte4t3AF1pSNnwQL+BSDqPWh8kr0N1kpZ+7CqwVK22WpGZN1fsDlykDu+RYiJVs=
X-Received: by 2002:a17:906:128d:: with SMTP id k13mr51613048ejb.517.1635916207726;
 Tue, 02 Nov 2021 22:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <211026.8635oo11jk.gmgdl@evledraar.gmail.com> <patch-1.1-90172a8ddcc-20211102T142351Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-90172a8ddcc-20211102T142351Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 3 Nov 2021 01:09:56 -0400
Message-ID: <CAPig+cRxW2A8rzJfna7KOc5fu46qr+Y7VLzSi0377SpCG-mVbA@mail.gmail.com>
Subject: Re: [PATCH] maintenance tests: fix systemd v2.34.0-rc* test regression
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 2, 2021 at 10:25 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Fix tests added in b681b191f92 (maintenance: add support for systemd
> timers on Linux, 2021-09-04) to run successfully no systems where

s/no/on/

> systemd-analyze is installed, but on which there's a discrepancy
> between a FILE argument of "/lib/systemd/system/basic.target" and
> "systemd/user/git-maintenance@.service" succeeding.
>
> There was an attempt to work around previous breakage in these tests
> in 670e5973992 (maintenance: fix test t7900-maintenance.sh,
> 2021-09-27), as noted in my [1] that commit is wrong about its
> assumption that we can use "/lib/systemd/system/basic.target" as a
> canary.argument.
>
> To fix this let's adjust this test to test what it really should be
> testing: If we've got systemd-analyze reporting anything useful, we
> should use it to check the syntax of our just-generated
> "systemd/user/git-maintenance@.service" file.
>
> Even on systems where this previously succeeded we weren't effectively
> doing that, because "systemd-analyze" will pass various syntax errors
> by and exit with a status code of 0, e.g. if the "[Unit]" section is
> replaced with a nonsensical "[HlaghUnfUnf]" section.
>
> To do that ignore whatever exit code we get from "systemd-analyze
> verify", and filter its stderr output to extract the sorts of lines it
> emits no note syntax warnings and errors. We need to filter out

s/no/on/


> "Failed to load", which would be emitted e.g. on the
> gcc135.fsffrance.org test box[1].
>
> We also need to pipe this output to FD's 5 & 6, to avoid mixing up the
> trace output with our own output under "-x".
>
> 1. https://lore.kernel.org/git/211026.8635oo11jk.gmgdl@evledraar.gmail.com/
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBB9C6FA83
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 00:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiIMAaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 20:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiIMAaS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 20:30:18 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616E02CCBA
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 17:30:14 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id p69so8622191yba.0
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 17:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=AYHovLzFuRStHvzIbxBoWQYKHOvxxvntIINgi7F3Hvw=;
        b=rjicHld4qwH8xZGpO4Zoml4leSH+Ni7c6XtbiqToWe/SEmjeeAKmK2j/D0OY2l1q1g
         JBHONxUolbWrIspyb6kaOs3XgnNjvAsqJRyjeCDixkdvrfERYj66oK76fmKuTpUr1XL0
         QLJZ45Tifccll7jzRIhoTqqoVt/dSGWf5LdmRppLBKW4JBFRhvmnmVJqyvMfPQwqxjzk
         oe+9jvYn/uMASM2jd4fmfVHIsfaW6fZa34QmeA49IdrgFvBHSNFbanu1zqL0tG+/0CgM
         sGJuoFbDE0iMdZ5EyKB2MXw+x7Vb8dkhwnJWvMHpoZk+JYVhHPiG5URkD751lPgsG5xI
         fajA==
X-Gm-Message-State: ACgBeo183NtRZLX1Krd7uegYM4/4nJj/VJto4ObxTFzGBUzr8ImM1Sgh
        Kt11VKeAlpWhhRXnVD4mOOybmjdO9rfqzYdwTPY22/yt6tQHVg==
X-Google-Smtp-Source: AA6agR4GxsJqfshR32T8gkKe5KU8Fjz+mUv+A7wkFz4k62sl5IRSG4CuMO3t/PHgLCRuK7zOVTHfbPp8IWWhcqkb/PQ=
X-Received: by 2002:a25:ef46:0:b0:6ae:c52c:7b9 with SMTP id
 w6-20020a25ef46000000b006aec52c07b9mr9416545ybm.54.1663029012864; Mon, 12 Sep
 2022 17:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com> <Yx/LpUglpjY5ZNas@coredump.intra.peff.net>
In-Reply-To: <Yx/LpUglpjY5ZNas@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Sep 2022 20:30:02 -0400
Message-ID: <CAPig+cRTatQRS2MyOTfmz56UKqtz_x_Gk6j=rnYR-jTkM-CDdQ@mail.gmail.com>
Subject: Re: [PATCH] chainlint: colorize problem annotations and test delimiters
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2022 at 8:15 PM Jeff King <peff@peff.net> wrote:
> On Mon, Sep 12, 2022 at 11:04:48PM +0000, Eric Sunshine via GitGitGadget wrote:
> > +my @NOCOLORS = (bold => '', reset => '', blue => '', green => '', red => '');
> > +my %COLORS = ();
> > +sub get_colors {
> > +     return \%COLORS if %COLORS;
> > +     if (exists($ENV{NO_COLOR}) ||
> > +         system("tput sgr0 >/dev/null 2>&1") != 0 ||
> > +         system("tput bold >/dev/null 2>&1") != 0 ||
> > +         system("tput setaf 1 >/dev/null 2>&1") != 0) {
> > +             %COLORS = @NOCOLORS;
> > +             return \%COLORS;
> > +     }
> > +     %COLORS = (bold  => `tput bold`,
> > +                reset => `tput sgr0`,
> > +                blue  => `tput setaf 4`,
> > +                green => `tput setaf 2`,
> > +                red   => `tput setaf 1`);
> > +     chomp(%COLORS);
> > +     return \%COLORS;
> > +}
>
> This is a lot of new processes. Should be OK in the run-once-for-all-tests
> mode. It does make me wonder how much time regular test-lib.sh spends
> doing these tput checks for every script (at least it's not every
> snippet!).

This is indeed a lot of new processes, but this color interrogation is
done lazily, only if a problem is detected, so it should be zero-cost
in the (hopefully) normal case of a lint-clean script.

I had the exact same thought about the cost being paid by test-lib.sh
making all those `tput` invocations.

> It feels like we could build a color.sh snippet once and then include it
> in each script. But maybe that is dumb, since you could in theory build
> in one terminal and then run in another. Unlikely, but it shows that
> file dependencies are a mismatch. I guess a better match would be
> stuffing it into the environment before starting all of the tests.

That might be worth considering at some point.

> I ran this on my pre-fixup state where I had a half-dozen linter checks.
> It's _so_ much more readable. Thanks for working on it.

Good to hear.

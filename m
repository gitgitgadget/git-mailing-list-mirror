Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23973C433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 02:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E91610A3
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 02:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhILC7B convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 11 Sep 2021 22:59:01 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:47050 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhILC7B (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 22:59:01 -0400
Received: by mail-ej1-f50.google.com with SMTP id kt8so12775652ejb.13
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 19:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R2NXsWioqB8tLiAIs6tq3DiKFnVQ2cGuTi93tIWDGgA=;
        b=zRBq+TvpH1b9R/wojRGMOMdUf357jXes84nTaz4ct87VNNyn/u+0rsXdrYEMCBi9+t
         1vxp0kUyRJKHLeTRRLquchCLlAtpwZV4b4kFu8yoq9YRqFmlKryyJF9bTJPmJREFg1Y2
         d7OwASud1tifbwrTyoMuy2uij3w9tb1QVuDucetUAzSnlJ5hUR24NZhWfC2yR/etOMio
         bhQJMJO9QjSJp+0AaEM0Tc4deHF+pg0APyxzTIJHofEI8pzt9Thve5w5RAdH5a/OKl+m
         AhW9fCA/nTYMlL4LIRTPYKBQwopqGdHVAie1qQ9MFYkRaD9YfDUdXtTR0em9rYCBVHct
         EdqQ==
X-Gm-Message-State: AOAM533W9KcIb+zlEDsfG3ZJ/DgRxLXR5H/1fwYZG6HQ1dpWb0NS26sn
        hsF0LVKEUo8f6tFusz8z1Rg3CZYermODblHCmA4=
X-Google-Smtp-Source: ABdhPJw8TC2/H1AfTu6KV/oLgNV5lkH2Pi3o90D4aJd2tnYu3R+1WrRM9sGxrGyZ2GAn/vbl6Xr1KXwHeiAhjY0OBko=
X-Received: by 2002:a17:906:4691:: with SMTP id a17mr5387669ejr.36.1631415466987;
 Sat, 11 Sep 2021 19:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email>
 <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com> <patch-v2-5.7-be85a0565ef-20210912T001420Z-avarab@gmail.com>
In-Reply-To: <patch-v2-5.7-be85a0565ef-20210912T001420Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 11 Sep 2021 22:57:36 -0400
Message-ID: <CAPig+cTWjqCiW=M37sf41F7-M0U=fJdTgtM_YqdPTqS53rFHHg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] rebase: don't have loop over "struct strvec"
 depend on signed "nr"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 8:16 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> As in the preceding commit, prepare for the "nr" member of "struct
> strvec" changing from an "int" to a "size_t".
>
> Let's change this code added in f57696802c3 (rebase: really just
> passthru the `git am` options, 2018-11-14) so that it won't cause a
> bug if the "i" variable here is updated to be a "size_t" instead of an
> "int".
>
> The reason it would be buggy is because this for-loop relied on
> "counting down" from nr-1 to 0, we'll then decrement the variable one
> last time, so a value of -1 indicates that we've visited all
> elements. Since we're looking for a needle in the haystack having
> looked at all the hay means that the needle isn't there.

s/haystack/&,/

> Let's replace this with simpler code that loops overthe "struct
> strvec" and checks the current needle is "-q", if it isn't and we're
> doing a merge we die, otherwise we do a "REBASE_APPLY".

s/overthe/over the/

Nit: comma-splice[1] at `"-q",`; replace comma with semicolon or period.

[1]: https://lore.kernel.org/git/CAPx1GvfFPWvJsj+uJV7RZrv1rgEpio=pk6rKF2UrjHebVY=LPA@mail.gmail.com/

> We've been able to simplify this code since 8295ed690bf (rebase: make
> the backend configurable via config setting, 2020-02-15) when we
> stopped using this for anything except this one check, so let's do
> that and move the check into the loop itself.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

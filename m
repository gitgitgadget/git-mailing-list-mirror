Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0B4C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAB064EA1
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhBBDVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 22:21:25 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:37061 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhBBDVY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 22:21:24 -0500
Received: by mail-ej1-f42.google.com with SMTP id kg20so27704970ejc.4
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 19:21:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5mbAOhKSc6nPlWsMZB/CpXZfVViP+ZIvI7fjmKYvWE0=;
        b=X7xGsbRMx+vTKoNjDBVcy1RUUGckMft7MKKHHPMGuOwoMnG0yzz/9CkOa7gH+nK1B6
         qOJV9iBdcSntqj5OSA5K4CDEw+PjnYCBbzoj7HmsW9GAZS0Ew72KTArXiMPf2BPQ2QXB
         WHphZ+lLJzaYh3l78hds1cYtQpgeFKQZ0faVrXuUHrwNVrKfYO18zPBsmlgOJVXcyyTG
         RsRFDAyHrul6y2dGPFU+EcayYL/+rIj8YC6Mjqu44kIh5Op8+e5ZXpPzEhKH1MT6gH0P
         jWfmqC8oUpzParXRK4GodRq049DRERFRgtq74WFTRze17pjumW7f2+Grxntdvy5NriKm
         IJeg==
X-Gm-Message-State: AOAM533JoVk+gf3C3RWE3yL4xh+SZ7aV2cc/tadfg26pZ83r0BuEC0Pc
        yBGugPMCQ2jQNL8FkekviyXPm5jjLp3Fz3HwosM=
X-Google-Smtp-Source: ABdhPJwVrzEqVAYngptwzqVnWOWlC3vwZqjKfrEdNsn22EkFidtXypqgb0+U7t10UM5AIoIzCaQillsVumTvzHpu4CI=
X-Received: by 2002:a17:906:6d94:: with SMTP id h20mr21332788ejt.231.1612236042509;
 Mon, 01 Feb 2021 19:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20210124170405.30583-1-charvi077@gmail.com> <20210129182050.26143-1-charvi077@gmail.com>
 <20210129182050.26143-9-charvi077@gmail.com>
In-Reply-To: <20210129182050.26143-9-charvi077@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 1 Feb 2021 22:20:31 -0500
Message-ID: <CAPig+cTyK_OPixAnJQc_cO4vHzA++hfyfGEA7uZBK3ukCWD0PA@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] rebase -i: teach --autosquash to work with amend!
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 1:25 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> If the commit subject starts with "amend!" then rearrange it like a
> "fixup!" commit and replace `pick` command with `fixup -C` command,
> which is used to fixup up the content if any and replaces the original
> commit message with amend! commit's message.
>
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
>  sequencer.c                     | 23 ++++++++++++++++-------
>  t/t3437-rebase-fixup-options.sh | 12 ++++++++++++
>  2 files changed, 28 insertions(+), 7 deletions(-)

Is this new behavior of recognizing "amend!" in the subject documented
anywhere? I checked the documentation patch [9/9] but didn't see any
mention of it.

> diff --git a/sequencer.c b/sequencer.c
> @@ -5662,6 +5662,12 @@ static int subject2item_cmp(const void *fndata,
> +static inline int skip_fixup_amend_squash(const char *subject, const char **p) {
> +       return skip_prefix(subject, "fixup! ", p) ||
> +              skip_prefix(subject, "amend! ", p) ||
> +              skip_prefix(subject, "squash! ", p);
> +}

While the function name skip_fixup_amend_squash() may be accurate, it
won't scale well. What happens when additional fixup-like prefixes are
added in the future? Does the function name get extended to name them,
as well? How about choosing a more generic, yet still meaningful,
function name which doesn't suffer from this scaling problem. Perhaps
skip_fixupish() or fix_squashlike() or something.

Also, making this function `inline` seems like a case of premature optimization.

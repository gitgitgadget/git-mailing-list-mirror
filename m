Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B30C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07BA2067D
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 17:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIRRG3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 13:06:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39086 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIRRG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 13:06:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id e22so6780077edq.6
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 10:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WQM3ZAfi3RHfXlHwd+QdFE2D62X1a8UCCSR6DUGMvLk=;
        b=rNSjXwLPlS8kNKkqc9juKxm7GpSvYS7flWsVwCfApOiEyJpE11VrgaFDPfYPFlY5B9
         W9k0AkWPM6/zr5huowCl549msAXqglfg9wLKEwOv86K1vBK+7i2sFCu0YBbMnb2bgBJr
         g/8XcM82OfmV+FQDG1M8amMQpiSZOlLt65QifrEzRA4YjGD7sF0fSM7KYYQXPm9LGbhC
         16wTlH6k4F5fl1MHSnwzKeN3HcZY+TbUyz84mlrFGVUF6ANx9lPch24vXGluv5/+R0D3
         ewUnf0/WKB5YmIEPU4/80VaXMBfvqIgMGdgLe1Mj8Y2ppB/rWjYhyp+dAOZYh1t2z1lk
         9Ffw==
X-Gm-Message-State: AOAM532cnkbj1VdwLtmZC3fwe2sN9dE8QVuuZBSS+mChLwXJtVGbrZf+
        QbagJrD7e4AtvcfP+WHKaL4sWjVXTcsoPRc8CHRLKWhZ
X-Google-Smtp-Source: ABdhPJyGVGq5PrptqW6KvUDfcE09YbrptvB2/gx7DngxQjC7FhIH9Uiu/39GTZuQuZnzv1IhlcLpIDzEdLv6kFmddR4=
X-Received: by 2002:a50:eb0a:: with SMTP id y10mr25300450edp.89.1600448786313;
 Fri, 18 Sep 2020 10:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600427894.git.liu.denton@gmail.com> <9d6c2951ab0a2c2e92353c238b008538fe6a6327.1600427894.git.liu.denton@gmail.com>
In-Reply-To: <9d6c2951ab0a2c2e92353c238b008538fe6a6327.1600427894.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 18 Sep 2020 13:06:13 -0400
Message-ID: <CAPig+cRKrgOhu3bH=TjdWnPaDfKmcM0OcL2ajktc-itGyyi1Ww@mail.gmail.com>
Subject: Re: [PATCH 3/4] hooks--pre-push.sample: use hash-agnostic null OID
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 7:19 AM Denton Liu <liu.denton@gmail.com> wrote:
> The pre-push sample hook has the null OID hardcoded as 40 zeros.
> However, with the introduction of SHA-256 support, this assumption no
> longer holds true. Replace the hardcoded $z40 with a call to
> `git rev-parse --null-oid` so the sample hook becomes hash-agnostic.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
> @@ -22,16 +22,16 @@
> +null_oid="$(git rev-parse --null-oid)"
>
>  while read local_ref local_sha remote_ref remote_sha
>  do
> -       if [ "$local_sha" = $z40 ]
> +       if [ "$local_sha" = "$null_oid" ]

Seeing this made me wonder if, rather than introducing a --null-oid
option (or --zero-oid per Taylor's suggestion), it would make more
sense to answer the question more directly. For instance:

    if test rev-parse --is-null-oid "$local_sha"
    then
        ...

Or, if following Taylor's suggestion, you would add --is-zero-oid,
--is-empty-blob, --is-empty-tree.

On the other hand, as this is used in a loop, being able to ask for
the null (or zero) OID just once before the loop does make sense, so
maybe the --is-*-oid forms are less practical.

By the way, if you're cleaning up the sample scripts to make them
hash-agnostic, then it would also make sense to s/sha/oid/.

Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDEAC433DF
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E461206D8
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgGZXeg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 19:34:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42449 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGZXeg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 19:34:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so10106643wrx.9
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 16:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V4nyf6U/+a2ykI/AUbBREsDzYreHfAN5Drt7CKKv2AE=;
        b=TC/rtHfOxP5qsZ8yNkIi9Go4IZtF+B9BEg6G8XraSgJSLL7Z2fNmZP3IqAn1ttwRtB
         Cwtr5ObZQhUl6LNpDNGTcw8UnyUOJrdkFK6bA72IFgVIrQHtCdcqXDNFVVPE+yWWP+XC
         ypquEXQV8V7o+ezy8o3wM93+IQuBeieIW8e1sLEdkzF73IKUlRtJXPCm/VjVMsffaILB
         fGzVphRaTrOHzwDA/+b0g9EKqDqSk/XDAqf4/OEwZXYK1dd6B7WHVDd6SXtyUaFwUsNC
         EStUu8tm1Uleb2Zzlx1A1XwlrGAVRjNKChLZJea3x4RW4cIN/tO0vSLMwXGIOAMq1FLv
         bFEw==
X-Gm-Message-State: AOAM5332cBOAEmJNMgUtT9jafa/hKNgAdZAQWCqgaXQrsTJ7YeDzivm5
        nirjrrG+r0fL36L5V6fRUmdvy4T1+03HeU/hXNXNONMv
X-Google-Smtp-Source: ABdhPJyQMkHVqqcJjJfNfrg1qzsJPfsDCUCl5bHRnF3dpBRHZAtABtdDELlZ5iCM4WKtxujbwXs9vLaACZq+qdI2B2U=
X-Received: by 2002:adf:ec45:: with SMTP id w5mr18077838wrn.415.1595806474639;
 Sun, 26 Jul 2020 16:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200726195424.626969-1-sandals@crustytoothpaste.net> <20200726195424.626969-33-sandals@crustytoothpaste.net>
In-Reply-To: <20200726195424.626969-33-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Jul 2020 19:34:23 -0400
Message-ID: <CAPig+cSaqwwtOitm3_3kF+q9TaputNAnz78qBb-7PfrZcqUDVg@mail.gmail.com>
Subject: Re: [PATCH v4 32/39] setup: add support for reading extensions.objectformat
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 26, 2020 at 3:56 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> The transition plan specifies extensions.objectFormat as the indication
> that we're using a given hash in a certain repo.  Read this as one of
> the extensions we support.  If the user has specified an invalid value,
> fail.
>
> Ensure that we reject the extension if the repository format version is
> 0.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/setup.c b/setup.c
> @@ -470,7 +470,16 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
> +               else if (!strcmp(ext, "objectformat")) {
> +                       int format;
> +
> +                       if (!value)
> +                               return config_error_nonbool(var);
> +                       format = hash_algo_by_name(value);
> +                       if (format == GIT_HASH_UNKNOWN)
> +                               return error("invalid value for 'extensions.objectformat'");

Not necessarily worth a re-roll, but this error message could be more
helpful by providing additional context:

    return error("invalid value for extensions.objectFormat: %s", value);

Notice I also capitalized "Format" since this is a user-facing message.

Also, should this message be localizable _(...)?

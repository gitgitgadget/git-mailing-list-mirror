Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781C0C433E0
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C9A20786
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgGZXAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 19:00:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46835 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgGZXAT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 19:00:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id r12so12990595wrj.13
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 16:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFIYEP4Vit6lXEwu8NxitUunPVvN7UyFZdnb27ejUok=;
        b=aZ19d7+68lAlHf1+K89lKoe7dCE3jfKemtgXqBXeFkcr8WJZl6vEgkXXC5wyWJETeQ
         mbhOMY/4+z5LNe0TDEwZoCulNL+e8OXsKTcjAYkJc1Q1tcV6c+PiWWRtNdX7n45zRpa5
         5p5q/Zhs/IEKtrEfJq+uvOjPgPo2h5WnMDb34M2uFYmRdUI0hjdtoIFUvoCCiHmNVr2g
         638dKoxoN5K+/bFWUwCkLwLY+PXtr1etmyq8BdSXjjJXQP/bthpcDz94Doff9AjwR3Xj
         NZ1Pq8X5/X/MEt3/NBsNgGcDTxp2kfdRHhwj3oT7SWVlBXNp36HUseiphY3H7gMd3KnW
         jH8g==
X-Gm-Message-State: AOAM530Jj5b0XoS6iH061jnkGmHUx0t3tW5n3kskqp0lGt0oAY/d76QR
        G8G+eeKTP1awQITwbK3HoR9LQ7Toj2r7AQOpG96XMwPs
X-Google-Smtp-Source: ABdhPJzxjA34qSFBwHMmJFs4ObwtNFw3NPUErTd3dNxtIyulSVV8Z9QgJVHl3tuegUzIGgEfI9Fc6LZJlCDGD7i2T/Q=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr18927089wrs.226.1595804417527;
 Sun, 26 Jul 2020 16:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200726195424.626969-1-sandals@crustytoothpaste.net> <20200726195424.626969-21-sandals@crustytoothpaste.net>
In-Reply-To: <20200726195424.626969-21-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Jul 2020 19:00:06 -0400
Message-ID: <CAPig+cTwj7PXk3Uejf=UznfFSNTCbGWLtKE2PesbvMZ-c+VDgQ@mail.gmail.com>
Subject: Re: [PATCH v4 20/39] t8011: make hash size independent
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 26, 2020 at 3:55 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Allow lines which start with either a 40- or 64-character hex object ID,
> to allow for both SHA-1 and SHA-256.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t8011-blame-split-file.sh b/t/t8011-blame-split-file.sh
> @@ -54,7 +54,7 @@ test_expect_success 'setup simulated porcelain' '
>         while (<>) {
> -               if (/^[0-9a-f]{40} /) {
> +               if (/^[0-9a-f]{40,64} /) {

Although this helps the current cases of SHA-1 and SHA-256, it doesn't
necessarily help people experimenting with other hash algorithms. I
wonder if it makes sense to loosen it a bit to simply look for
something that is likely to be an OID. Perhaps like this:

    if (/^[0-9a-f]{40,} /) {

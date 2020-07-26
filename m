Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D266C433E3
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 22:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197EC2053B
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 22:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgGZWuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 18:50:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45875 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgGZWuK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 18:50:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id z18so9456865wrm.12
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 15:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUAnkUNX4gWSYrZ0jkztOQOxrcuQadDZygV8C7Abcv0=;
        b=C2XZdogKd54rNel8XJ/h1evxgZRCKuKwmXn3nILP2zRU6XL25g4o5nUFeOYWLELO/3
         rBPhoSpX/4DUjY/5oMdAWfC/XEbMox5fxTkniL5ql2sTRKPaSYIaAdOQLwiylBMItoDk
         zVDbWrC9AOIZwXfERs1JEnKyughPq0IZ8VGcxFcT5+7QwR1duJ1MoZKo1MqGEiwQPzhE
         JWxZ9ssDOaedCGv/Brn7SAbIWNPuCS+OoaaH5MxOv/jUopXyDUtzIbsfSnK1mqa4wrw4
         G9lVU5OtlHui/DrxyljfCQwSOWI+n1V61bU3vnJlm894h9vmgCPN8aU23OtTkr1uPupv
         N8fQ==
X-Gm-Message-State: AOAM531SGPUWWlMTbMRdsRHPcNf88UMWwJaCNQ3BCeKhbKeGskI6OIvw
        ART+AYmcGZZLzdzlBiGp5fbylebt0yN9k8AwNnQgAUC0
X-Google-Smtp-Source: ABdhPJxXZlX4CGfwfzx3bdNBazVDu8VbLDYK68QlRO9JS1k3CiKrw0AHVLH/S5j3x8OT89tx3RRX/LblQLujVV6x2FU=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr18904060wrs.226.1595803809068;
 Sun, 26 Jul 2020 15:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200726195424.626969-1-sandals@crustytoothpaste.net> <20200726195424.626969-19-sandals@crustytoothpaste.net>
In-Reply-To: <20200726195424.626969-19-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Jul 2020 18:49:58 -0400
Message-ID: <CAPig+cT27QQgQcq87DErR07h-p_w2q-EqDPNhGJC54=hutMPhg@mail.gmail.com>
Subject: Re: [PATCH v4 18/39] t8002: make hash size independent
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 26, 2020 at 3:55 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Compute the length of an object ID instead of of hard-coding 40-based

s/of of /of/

> values.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> @@ -6,6 +6,10 @@ test_description='git blame'
> +test_expect_success 'setup' '
> +       test_oid_init
> +'
> +
> @@ -105,17 +109,18 @@ test_expect_success 'blame --abbrev=<n> works' '
>  test_expect_success 'blame -l aligns regular and boundary commits' '
> +       hexsz=$(test_oid hexsz) &&
> +       check_abbrev $hexsz         -l HEAD &&
> +       check_abbrev $((hexsz - 1)) -l ^HEAD
>  '
> +test_expect_success 'blame --abbrev with full length behaves like -l' '
> +       check_abbrev $hexsz         --abbrev=$hexsz HEAD &&
> +       check_abbrev $((hexsz - 1)) --abbrev=$hexsz ^HEAD
>  '

Rather than assigning 'hexsz' in the first test which needs the value
and then re-using the value in subsequent tests, how about assigning
'hexsz' in the new "setup" test? This will make it easier to run
individual tests while skipping others.

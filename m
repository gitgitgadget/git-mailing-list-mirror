Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB6B1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 04:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932115AbeGFE60 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 00:58:26 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:43573 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754035AbeGFE6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 00:58:25 -0400
Received: by mail-yw0-f196.google.com with SMTP id l189-v6so3754887ywb.10
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 21:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wsm6F6Nqlc3sb8Bt954TfD+U3SMllfO+7vdWrmsbXWs=;
        b=sW5FwD0MsT3ziEyD+DVU8nq2zMkIFikfW2GDEIF1YZukodly/kbe3H3/N95sGhsoyh
         moz8dcugZXsAKgnRuQkPBTjkmere+hYt5qZpf0GESbKR8K6igZQr8cAJRCmfM6bfxJQh
         ku2G/VARzZsQcRzNaAOWy4HBmu2ZntdmwGdNc/LjEgIUmgPFXHsHVSpGAX5zDs1t0i/T
         VvQ3z2VegFWRQQ92PWseoIu+UNflk7zS5ve13QAIm4bJVQpcwzMi4YMQrPwOlIHzn4PV
         VokZMxDxREW4BN5Zh/cERZuTb4yKDqlgF7WU58QkMC8bO8jn0W9ptHwEDOpaX2q7g7cQ
         DgAA==
X-Gm-Message-State: APt69E0RlIij4lQrki83C0NEjNaMRh7+5WNutxLN1PeBK69Iph2wi1gU
        XM0dnkn3vQhUyZego+mLmRlXDhpx7yRXurObGnM=
X-Google-Smtp-Source: AAOMgpd0gqtkWB9U4ZaW2vqSy50HQyMwKd4dvD4wDTRcCFhD+wIEAzuxuQ+QcaCe93CRZRGQhY3/2VGI+bUxXxS0lbo=
X-Received: by 2002:a81:7bd4:: with SMTP id w203-v6mr4228263ywc.70.1530853104654;
 Thu, 05 Jul 2018 21:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180625143434.89044-1-dstolee@microsoft.com> <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-12-dstolee@microsoft.com>
In-Reply-To: <20180706005321.124643-12-dstolee@microsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Jul 2018 00:58:13 -0400
Message-ID: <CAPig+cQ2cz8H9qYn09g1o-ZAVQc98Z=hD9R0c7pfha257BsX3w@mail.gmail.com>
Subject: Re: [PATCH v3 11/24] midx: read pack names into array
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 5, 2018 at 8:54 PM Derrick Stolee <stolee@gmail.com> wrote:
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> @@ -8,8 +8,13 @@ midx_read_expect () {
>         cat >expect <<-EOF

Broken &&-chain.

>         header: 4d494458 1 1 $NUM_PACKS
>         chunks: pack_names
> -       object_dir: .
> +       packs:
>         EOF
> +       if [ $NUM_PACKS -ge 1 ]

On this project, use 'test' rather than '['.

> +       then
> +               ls pack/ | grep idx | sort >> expect
> +       fi

Broken &&-chain.

> +       printf "object_dir: .\n" >>expect &&

All this code building up 'expect' could be in a {...} block to make
it clearer and less noisy:

    {
        cat <<-EOF &&
        ...
        EOF
        if test $NUM_PACKS -ge 1
        then
            ls -1 pack/ | ...
        fi &&
        printf "..."
    } >expect &&

And, some pointless bike-shedding while here: perhaps dashes instead
of underlines? "pack-names", "object-dir"

>         test-tool read-midx . >actual &&
>         test_cmp expect actual
>  }

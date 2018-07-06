Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7702F1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 04:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753968AbeGFETX (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 00:19:23 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33276 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753963AbeGFETW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 00:19:22 -0400
Received: by mail-yb0-f193.google.com with SMTP id e84-v6so4078267ybb.0
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 21:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ecsCoDLUIk7+ehMT/5Bedi6uBHUKHltdAFRl7lffD8=;
        b=ICae5LumRxHTRvA3nQT4gKyGiyrKeTCs14A+Cc2vWFmSX9fSDCtRHXLg9zWLJFWatX
         bexICHLTLPfJaE9O6t/pfTWMsW2CWoF2EQldIiAdgbrc8+Szu6lHDgf3RZd7c7Vjb8By
         7Y9F9km06gWwTg0lmVxKD4KpoXr5+TmZE5Avk7bjNt93mBijedoaK6xJxsjaBJzOaAkS
         TIpfhrEF4sXQtZAYGNl3xPSvXRrtbxY8+79QcOTmXOrZSksEER53Ei4u0G6FAbCzUzmx
         UMhMTTZ8e4bx9KKqHHCfDOY6OuFfC78woDhcD4UUbfesjMVqez6jxkenza93hunkeBA/
         9slQ==
X-Gm-Message-State: APt69E3VHyiPSxBmi3zdUYQHSQj7FLIUVmyTwn8FJL/o8netK1R0kpeS
        wDv+pTrJHsGIKVkTCUXPNDmuGDZMnvrIPXBkLas=
X-Google-Smtp-Source: AAOMgpfK30SBqdDo4uAFWKsSERuo1rpdMniq6dZ/3j8AO8IhRD34TOwFXPu3vHQA+eqybzGFWuGZ2Q7EYNqQlEw6Yjo=
X-Received: by 2002:a25:8b04:: with SMTP id i4-v6mr4490185ybl.12.1530850761911;
 Thu, 05 Jul 2018 21:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180625143434.89044-1-dstolee@microsoft.com> <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-7-dstolee@microsoft.com>
In-Reply-To: <20180706005321.124643-7-dstolee@microsoft.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Jul 2018 00:19:10 -0400
Message-ID: <CAPig+cSntb3=YTBm67+4T1FgLCi585CnUuN__DE2mdo4y2n98A@mail.gmail.com>
Subject: Re: [PATCH v3 06/24] multi-pack-index: load into memory
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

On Thu, Jul 5, 2018 at 8:53 PM Derrick Stolee <stolee@gmail.com> wrote:
> Create a new multi_pack_index struct for loading multi-pack-indexes into
> memory. Create a test-tool builtin for reading basic information about
> that multi-pack-index to verify the correct data is written.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
> @@ -0,0 +1,34 @@
> +/*
> + * test-mktemp.c: code to exercise the creation of temporary files
> + */

Meh. Copy/paste botch.

> +static int read_midx_file(const char *object_dir)
> +{
> +       struct multi_pack_index *m = load_multi_pack_index(object_dir);
> +
> +       if (!m)
> +               return 0;

Should this 'return 0' be a die() or BUG() or something?

> +       printf("header: %08x %d %d %d\n",
> +              m->signature,
> +              m->version,
> +              m->num_chunks,
> +              m->num_packs);
> +
> +       printf("object_dir: %s\n", m->object_dir);
> +
> +       return 0;
> +}
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> @@ -3,9 +3,19 @@
> +midx_read_expect () {
> +       cat >expect <<-EOF

I guess you're planning on interpolating some variables here in a
later patch, which is why you used -EOF rather than -\EOF?

> +       header: 4d494458 1 0 0
> +       object_dir: .
> +       EOF
> +       test-tool read-midx . >actual &&
> +       test_cmp expect actual
> +}
> +
>  test_expect_success 'write midx with no packs' '
>         git multi-pack-index --object-dir=. write &&
> -       test_path_is_file pack/multi-pack-index
> +       test_path_is_file pack/multi-pack-index &&
> +       midx_read_expect
>  '

Kind of a do-nothing change. I wonder if this step would better be
delayed until a later patch. (Not necessarily a big deal.)

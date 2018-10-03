Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B1B71F453
	for <e@80x24.org>; Wed,  3 Oct 2018 07:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeJCOdn convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 3 Oct 2018 10:33:43 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42862 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeJCOdn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 10:33:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id g20-v6so2842244qke.9
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 00:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EbBa4H9LpNOKqtEV0qcME0UkCKe5dXyw0AGM+NfTymo=;
        b=uRkgEJF7XQ49woDhuMSvjw/qIfFitfjuMPyaVMMSWVCEScggBBxfp2MCzLovbhRymV
         Le+7jJxyW1PvP5V7CGw75l5WGpcmdc3DP9EKDZh0ioeXpGKskcJYFHdnOTVLW0DYPxDr
         c6NMIzEldLnXmvubezQU/hkMKYlJXAoI8KEpsLg6wzKgK/MPOkxuUvR1AxWAwAWz5rRc
         qrXLR2J5AEhni0iB0WfowhGQHoQkmw/dojwuMAOecSZpRvdZJDj1ahJ1PrsFVU0EbZAN
         wtHqwqRoO04Mdl4Dm5koX1SUTf/u8/thG10TKb1bPurP6yxGjQ+VFY/r7AF7vRobvHmv
         xlGg==
X-Gm-Message-State: ABuFfogwig2FpFufvBjpk5ecxweIRN+T01db63uGp8SWh8FjHtzliZWI
        Dp/lOVAraOZ/Lvlstu9JLzVgwUGJgpm+myEugh1vtOXH
X-Google-Smtp-Source: ACcGV60QtrczzmQhhzjnRYWtd+WuYxHCtSzRiWICYPs1n1P6pGy7SpaSVqOfzdCwfmWqeSu6cLA0n84eWmuY5SvBKd0=
X-Received: by 2002:a37:ef08:: with SMTP id j8-v6mr203830qkk.26.1538552789445;
 Wed, 03 Oct 2018 00:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180929153005.10599-1-pclouds@gmail.com> <20181002160658.15891-1-pclouds@gmail.com>
 <20181002160658.15891-2-pclouds@gmail.com>
In-Reply-To: <20181002160658.15891-2-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 3 Oct 2018 03:46:19 -0400
Message-ID: <CAPig+cRTty2BBs_udpYxHESBMx_y0NTM0gdkgX=z3EbEhvJDdg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] t1300: extract and use test_cmp_config()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 2, 2018 at 12:07 PM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> In many config-related tests it's common to check if a config variable
> has expected value and we want to print the differences when the test
> fails. Doing it the normal way is three lines of shell code. Let's add
> a function do to all this (and a little more).
> [...]
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -747,6 +747,29 @@ test_cmp() {
> +test_cmp_config() {
> +       local GD

If you re-roll, maybe make this part of the &&-chain to protect
against someone coming along and inserting code above this line
without realizing that the &&-chain is broken.

> +       if test "$1" = "-C"
> +       then
> +               shift &&
> +               GD="-C $1" &&
> +               shift
> +       fi &&
> +       printf "%s\n" "$1" >expect.config &&
> +       shift &&
> +       git $GD config "$@" >actual.config &&
> +       test_cmp expect.config actual.config
> +}

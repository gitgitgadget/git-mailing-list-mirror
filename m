Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95049C433F5
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 17:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiB0RxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 12:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiB0RxN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 12:53:13 -0500
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D152240AE
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 09:52:34 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4K6B1D6n6qz5tlD;
        Sun, 27 Feb 2022 18:52:32 +0100 (CET)
Message-ID: <7e09ee3e-9ac6-e2ff-c6a4-3dd03303b576@kdbg.org>
Date:   Sun, 27 Feb 2022 18:52:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 2/2] t0030-t0050: avoid pipes with Git on LHS
Content-Language: en-US
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     me@ttaylorr.com, avarab@gmail.com, git@vger.kernel.org
References: <220224.86o82wab31.gmgdl@evledraar.gmail.com>
 <20220227122453.25278-1-shivam828787@gmail.com>
 <20220227122453.25278-3-shivam828787@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20220227122453.25278-3-shivam828787@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.02.22 um 13:24 schrieb Shubham Mishra:
>  test_expect_success \
>      'text plus spaces without newline at end should not show spaces' '
> -    ! (printf "$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (printf "$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (printf "$ttt$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (printf "$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (printf "$ttt$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (printf "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
> +    printf "$ttt$sss" | git stripspace >tmp &&
> +    ! grep "  " tmp >/dev/null &&
> +    printf "$ttt$ttt$sss" | git stripspace &&
> +    ! grep "  " tmp >/dev/null &&
> +    printf "$ttt$ttt$ttt$sss" | git stripspace &&
> +    ! grep "  " tmp >/dev/null &&
> +    printf "$ttt$sss$sss" | git stripspace &&
> +    ! grep "  " tmp >/dev/null &&
> +    printf "$ttt$ttt$sss$sss" | git stripspace &&
> +    ! grep "  " tmp >/dev/null &&
> +    printf "$ttt$sss$sss$sss" | git stripspace &&
> +    ! grep "  " tmp >/dev/null
>  '

You forgot to redirect all but the first `git stripspace`.

>  
>  test_expect_success \
> @@ -282,12 +292,18 @@ test_expect_success \
>  
>  test_expect_success \
>      'text plus spaces at end should not show spaces' '
> -    ! (echo "$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (echo "$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (echo "$ttt$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (echo "$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (echo "$ttt$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
> -    ! (echo "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
> +    echo "$ttt$sss" | git stripspace >tmp &&
> +    ! grep "  " tmp >/dev/null &&
> +    echo "$ttt$ttt$sss" | git stripspace >tmp &&
> +    ! grep "  " tmp>/dev/null &&
> +    echo "$ttt$ttt$ttt$sss" &&
> +    ! grep "  " tmp >/dev/null &&
> +    echo "$ttt$sss$sss" | git stripspace >tmp &&
> +    ! grep "  " tmp >/dev/null &&
> +    echo "$ttt$ttt$sss$sss" | git stripspace >tmp &&
> +    ! grep "  " tmp >/dev/null &&
> +    echo "$ttt$sss$sss$sss" | git stripspace >tmp &&
> +    ! grep "  " tmp >/dev/null
>  '

A superficial glance at the visual pattern formed by the new lines
reveals immediately that there is something foul. And indeed, one of the
rewritten cases misses `| git stripspace >tmp`.

-- Hannes

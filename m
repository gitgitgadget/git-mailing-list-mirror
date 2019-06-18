Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C7A81F462
	for <e@80x24.org>; Tue, 18 Jun 2019 23:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfFRXMo (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 19:12:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34430 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfFRXMn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 19:12:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so3318527wmd.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 16:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6my/xfiCQf/ywmyPGsqnVW7Vf854uvO2h2RKpygBoPE=;
        b=qI3ysie55mR5dS4WE1kcsb9BF51IFAk/pUrBn3KqoWRWot8+ZCV+8lq9CBK1mpB/Zl
         NvBZT/WoqnWoOEFoxHK4dFIc6DFLPnDj5a0ELgkoxPOAYYnNfaWM6ljibljgaMdI+Aah
         l/bhotfFysiXLioSJwyDpaWGUkEpiTxdMA4AlLtKN+a9Aw/Crtc4SySRrp/IfN8l8zro
         c76d3dksVIhrkz7g8fxdYqiK5DIvVLSp+/LqV9t1t1ut696cfpdpds7GD1f199KNUQwc
         Zu2SfFrqrRUhmin5/9Nl52j8qnCu5mJE3xvIVObo1qkXIbexJr/zNUhDRRp9UdP7ig4v
         suKQ==
X-Gm-Message-State: APjAAAWG/MWoV157BoYPvwhex9XhRbrjYAOHhTB5htX4AaommsUOPcBc
        jVA4vQVLRwAL7GImSGEI7OnM46eprzOJxE2RlPY=
X-Google-Smtp-Source: APXvYqwotVHU0BVR0ZxXtNHMf/rEBXKem9fFS1pT2mUSWWrdPByO8HCDDNSIq0QSil/3CgWIT8ii5nsmyTNytyuyWCo=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr5417001wmf.101.1560899561682;
 Tue, 18 Jun 2019 16:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.149.git.gitgitgadget@gmail.com> <d551cdeafbf2953ba340aa16554fbd5ac6194a6e.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <d551cdeafbf2953ba340aa16554fbd5ac6194a6e.1560860634.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 18 Jun 2019 19:12:30 -0400
Message-ID: <CAPig+cQaoRBnH0JrUwXTo1hSwjrZ1vJHewjCAkKPeCrRwo=P2w@mail.gmail.com>
Subject: Re: [PATCH 02/17] t0001 (mingw): do not expect a specific order of stdout/stderr
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 18, 2019 at 8:24 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When redirecting stdout/stderr to the same file, we cannot guarantee
> that stdout will come first.
>
> In fact, in this test case, it seems that an MSVC build always prints
> stderr first.
>
> In any case, this test case does not want to verify the *order* but
> the *presence* of both outputs, so let's relax the test a little.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> @@ -474,7 +474,8 @@ test_expect_success MINGW 'redirect std handles' '
>         printf ".git\nfatal: Needed a single revision\n" >expect &&
> -       test_cmp expect output.txt
> +       sort <output.txt >output.sorted &&
> +       test_cmp expect output.sorted

It was quite surprising to see this sorting only 'output' but not
'expect'. I see now that 'output' is already "sorted" (in that sense),
but it feels fragile. More robust would be to sort 'expect' as well:

    printf ".git\nfatal: Needed a single revision\n" | sort >expect &&

This would protect against the next person who modifies the 'printf'
testing on Unix and Windows/gcc and thinking all is well even though
the change might make the test fail for an MSVC build.

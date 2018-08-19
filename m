Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FFC61F954
	for <e@80x24.org>; Sun, 19 Aug 2018 20:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbeHSXXM (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 19:23:12 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33910 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeHSXXM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 19:23:12 -0400
Received: by mail-qk0-f194.google.com with SMTP id d15-v6so2040328qkc.1
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 13:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EyqAH67d/DwFAOv0O1KNAnAfJ9jKDeiWuS7cajq6OYM=;
        b=mh7vxfUjClakz8LmGIOcb14B+1Ft5nKnkjZJ5Y3VZOS3ULG3YKsT8qnShIyTzi+LPi
         PNBFqgEd2jO2kFdPKxNbxgJQTvTZzauUz+yFp2l7V9ZiFKsNplraHwbL3VEcanwWQITx
         JKxQ01l6YVUp9eu+Z3SoBvhOc8l3ll5cShMgrPeEuqitQJ1xyZ7IDcNaRfIpjpz+DmKJ
         5zSrRTiat7VWPL5jVioVYyNREa9xCOhUDYNMmq7rBgbLTyemXZfPyapW/IEtL7k/BilP
         abXxDMX4psZXgk5lAC7yv2JaXEgSVoSMJA8BKAhOdS5Y1b8cH2Lrndz7ms+gKkZfK4fp
         YYIw==
X-Gm-Message-State: AOUpUlHAVhaF70sqK+G5MUQ9gzOJdVFYBnt9I4uxTxgbuyoYetAzDuMa
        Ppsf6sJcO50Y0SZwyNjGfdnj17jj7qzlvnmT7SZCXg==
X-Google-Smtp-Source: AA+uWPxFyiI3DUXKwAt1Ib7SSRPBtD2nk9wXGXU5yzs5xsyFn8H6JD8aoOrXS7KW4Xi//WtqOZ1Ac7dzlSYPHuemBIk=
X-Received: by 2002:a37:4951:: with SMTP id w78-v6mr39161134qka.2.1534709432075;
 Sun, 19 Aug 2018 13:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180819175351.449973-1-sandals@crustytoothpaste.net> <20180819175351.449973-6-sandals@crustytoothpaste.net>
In-Reply-To: <20180819175351.449973-6-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Aug 2018 16:10:21 -0400
Message-ID: <CAPig+cS6Z+U-Z26m-eW-JX5D29ONSb_Zzur2fvWGb_ZMbmF4UQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] t0027: make hash size independent
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 19, 2018 at 1:54 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> We transform various object IDs into all-zero object IDs for comparison.
> Adjust the length as well so that this works for all hash algorithms.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> @@ -15,8 +15,9 @@ compare_ws_file () {
> -       tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$exp" &&
> +       tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$exp+" &&

My immediate thought upon reading this was whether "+" is valid in
Windows filenames. Apparently, it is, but perhaps (if you re-roll) it
would make sense to use a character less likely to cause brain
hiccups; for instance, "exp0'.

>         tr '\015\000abcdef0123456789' QN00000000000000000 <"$3" >"$act" &&
> +       sed -e "s/0000+/$ZERO_OID/" "$exp+" >"$exp" &&

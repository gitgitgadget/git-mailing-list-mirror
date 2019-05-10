Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF2C51F45F
	for <e@80x24.org>; Fri, 10 May 2019 07:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfEJHuo convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 10 May 2019 03:50:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44529 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbfEJHuo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 03:50:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so6517557wrs.11
        for <git@vger.kernel.org>; Fri, 10 May 2019 00:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cx2y8RfBACNZLeUVAGU3BRnHptr/YX07PE6v1uM8zxY=;
        b=Qwh1RXWb3QcKJR2XIJ0wokVH6fbclGYJFz4JPC2I03hSPNARKWFdz3+ErNi5jwNisp
         2sCI7Zy1q7aA/QEwhqDZtJzxGQii6Dqc5BUL0xbj4ZepmhMAyQidcWFC/aIOo6N2Po1Y
         xInqV8z3Pl1dtGmESFIFj3i5b/BiXzOWWbEvVCjHJZvVwagccXY10HraiQjXeDGsomeu
         vRrWEe5rAhudKIY31pZGDWfsrQHNu9iUfKk3IcWRgWJ5GguWpubevxySlsq/X6WjJdxB
         pA+9LnxDKCq+vJq+X7UtvZt1mlUua6NHfWw5fhRQmGpYbZDJd+ANatm8GOKoZCfkIX1F
         dO+Q==
X-Gm-Message-State: APjAAAU0/U7cAsFSGiT1yq3grGZpYMINBSsrknjlIGwAw7rKA9wlTYXK
        I2GILS43aMpMQ8gbADGU+XqtYvMbuUgr1EV/7H8=
X-Google-Smtp-Source: APXvYqyG5A1P/RfdG6UeKL1p9xp7ifn07sEyg8dLAxHlrcxfyzUV//Ddk0f4yeo1hAvXwts7v592/fyOWz1tHoxIvhU=
X-Received: by 2002:adf:f74f:: with SMTP id z15mr6343949wrp.282.1557474642738;
 Fri, 10 May 2019 00:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190510065848.27606-1-carenas@gmail.com>
In-Reply-To: <20190510065848.27606-1-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 10 May 2019 03:50:32 -0400
Message-ID: <CAPig+cSY4SKXcppM6UYpeJ3z+PrUwiJ=whCmHQv4e_3CUZSwoQ@mail.gmail.com>
Subject: Re: [PATCH] http-push: workaround for format overflow warning in gcc
 >= 9
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>, nickh@reactrix.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 10, 2019 at 2:59 AM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> In function 'finish_request',
>     inlined from 'process_response' at http-push.c:248:2:
> http-push.c:587:4: warning: '%s' directive argument is null [-Wformat-overflow=]
>   587 |    fprintf(stderr, "Unable to get pack file %s\n%s",
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   588 |     request->url, curl_errorstr);
>       |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ---

Missing sign-off.

> diff --git a/http-push.c b/http-push.c
> @@ -585,7 +585,8 @@ static void finish_request(struct transfer_request *request)
>                 int fail = 1;
>                 if (request->curl_result != CURLE_OK) {
>                         fprintf(stderr, "Unable to get pack file %s\n%s",
> -                               request->url, curl_errorstr);
> +                               request->url ? request->url : "",
> +                               curl_errorstr);
>                 } else {

If I'm reading the code correctly, the conditional and "true" branch
of the ternary expression are dead code since 'request->url' will
unconditionally be NULL due to the:

    /* URL is reused for MOVE after PUT */
    if (request->state != RUN_PUT) {
        FREE_AND_NULL(request->url);
    }

earlier in the function. If you want to present a meaningful error
message here, I could imagine squirreling-away the URL so it can be
used in the error message, or re-working the code so that
FREE_AND_NULL(request->url) is only done when and if needed.

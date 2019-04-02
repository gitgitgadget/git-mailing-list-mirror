Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C97920248
	for <e@80x24.org>; Tue,  2 Apr 2019 05:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfDBFp3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 2 Apr 2019 01:45:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52832 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfDBFp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 01:45:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id a184so1853650wma.2
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 22:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HVV8y/6seGJfCmNhfYXWLjj4pG39JXhR26GOVbu+26A=;
        b=CvbD2/t4cYa3nk9QG81Vx8s35su6oREIBpodRjJAOVHJuXFKOFgnj4c0AAkhG4rCMk
         aD+NdmBbXIli9YR6X6mhxkvmqRA0tpSDeBOMU5Vj10iJ5LtXxfl1M2V3dDKLEyCTsqXq
         ojfHX2YbAvOciVCr17wA820WsifMZnt+ijBmwUa0baBYlRpXIevT1ul4kgrT4PsIP8u0
         pRQ2+yDUVxl7CCEXtAe9YRMsCC020Oqxf/7w9igpfsrGbukLKqGj6gFvhI52B4kfE+tU
         /BOuE5t4lZStakIJFknYTC3x5ahnnhVFzp/Fo85YQ74ZvCyKtcVjv+PjaqlXK9tfOSCX
         HquA==
X-Gm-Message-State: APjAAAUxEAeDiPtq4r+vJQPrHhvKpkPzrBNZWYgTdASkmpKITuJj/m0S
        jzmBR7N8OBIWzTB7ZWLX9rgq2KnJC0hT8fatkaM=
X-Google-Smtp-Source: APXvYqxOFBSSRvva5sh4sX/5BA2rmcYdoLMvKCtcYY9HRG0vtlR9pTqNZGxvZT5AY+14Hs6T2ZMdiicUAqyTYtzXv7U=
X-Received: by 2002:a7b:c446:: with SMTP id l6mr2254179wmi.80.1554183927125;
 Mon, 01 Apr 2019 22:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190325103844.26749-1-szeder.dev@gmail.com> <20190401115217.3423-1-szeder.dev@gmail.com>
 <20190401115217.3423-3-szeder.dev@gmail.com>
In-Reply-To: <20190401115217.3423-3-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 2 Apr 2019 01:45:15 -0400
Message-ID: <CAPig+cRMBmfG1YDeP9t9eLZdqMqthfxp6nviQYGr7qNEA2U54Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] progress: assemble percentage and counters in a
 strbuf before printing
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 1, 2019 at 7:52 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> [...]
> To prepare for those changes assemble the changing parts in a separate
> strbuf kept in 'struct progress' before printing.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
> diff --git a/progress.c b/progress.c
> @@ -80,36 +81,42 @@ static int is_foreground_fd(int fd)
>  static void display(struct progress *progress, uint64_t n, const char *done)
>  {
>         if (progress->total) {
>                 if (percent != progress->last_percent || progress_update) {
>                         [...]
> -                       progress_update = 0;
> -                       return;
>                 }
> +       if (show_update) {
>                 [...]
>                 progress_update = 0;
> -               return;
>         }

Removal of these two 'returns' is unrelated to the change made by this
patch and should have been done by 1/4.

>         return;

Likewise, this final 'return' doesn't need to be here and should go away in 1/4.

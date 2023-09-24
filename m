Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81C9CE7A88
	for <git@archiver.kernel.org>; Sun, 24 Sep 2023 06:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjIXGwj convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 24 Sep 2023 02:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIXGwi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2023 02:52:38 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AAFCE
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 23:52:31 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-65afd8af8bbso6055896d6.3
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 23:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695538351; x=1696143151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTk1awe3n63wnSHwrn/WafLBTW3QDgiSIWooXfDXkhw=;
        b=f7hPRVeCwwK2pYcGGGAZLYdvDY7eeZ4wE79MSNsNVeuF2aBjOp2649BFLgMBpLWfCT
         jh7vw7CfNIps0HA+TgDofvAiaCj+JM/c3EaYgEbi1jrZJvOpPTD0Rn/WhJulKx37LOHG
         UXNLzu6ITNadANz9ZlyI7TVUcC3QPFFnWwjUOWnMOIquE5xfbmEE2hih9U3HEbkNIndW
         M14C3Z+n34wBWhKYQxXVNUTPwZwQStTRpjdAhlvslGGozyl3fEemX1S9DR6QghuqgkA2
         0eBvIQgBaunPUHad1MQWPW6LG8FfsSyzcUbN8KetlTBaLXxeCHGz7NLY52qZU7M0aF12
         eNaw==
X-Gm-Message-State: AOJu0YxtMCcnkZuKO7EGWX5vMcqu3lciEAHIEr2fkPsOFezWIuKrQ9Mt
        9hsWoSzzH7W09y37bIkkdYxiicK+LOmKcVTUMP8=
X-Google-Smtp-Source: AGHT+IEA2za/iglDjCepnfUBMGM6qMjGz/5Qkj80HnliPUEu95SXGADBNY+vbvkZFwtvDuwV+ojGsGXMdTVmqEZICfM=
X-Received: by 2002:a0c:b391:0:b0:656:49a3:21a7 with SMTP id
 t17-20020a0cb391000000b0065649a321a7mr3295690qve.16.1695538350831; Sat, 23
 Sep 2023 23:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy1h2f5dv.fsf@gitster.g> <20230923152201.14741-4-worldhello.net@gmail.com>
In-Reply-To: <20230923152201.14741-4-worldhello.net@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 24 Sep 2023 02:52:19 -0400
Message-ID: <CAPig+cTRByz10ySknTxPB2yVJf5Snz29LNRq5MtPk2MF3nMziQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] archive: support remote archive from stateless transport
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 23, 2023 at 11:22 AM Jiang Xin <worldhello.net@gmail.com> wrote:
> Even though we can establish a stateless connection, we still cannot
> archive the remote repository using a stateless HTTP protocol. Try the
> following steps to make it work.
> [...]
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
> diff --git a/http-backend.c b/http-backend.c
> @@ -639,10 +640,19 @@ static void check_content_type(struct strbuf *hdr, const char *accepted_type)
> -       const char *argv[] = {NULL, "--stateless-rpc", ".", NULL};
> +       const char *argv[4];
>
> +       if (!strcmp(service_name, "git-upload-archive")) {
> +               argv[1] = ".";
> +               argv[2] = NULL;
> +       } else {
> +               argv[1] = "--stateless-rpc";
> +               argv[2] = ".";
> +               argv[3] = NULL;
> +       }

It may not be worth a reroll, but since you're touching this code
anyhow, these days we'd use `strvec` for this:

    struct strvec argv = STRVEC_INIT;
    if (strcmp(service_name, "git-upload-archive"))
        strvec_push(&argv, "--stateless-rpc");
    strvec_push(&argv, ".");

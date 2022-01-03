Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68432C433EF
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 17:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbiACRRS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 12:17:18 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:34710 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiACRRR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 12:17:17 -0500
Received: by mail-pg1-f182.google.com with SMTP id g22so30569833pgn.1
        for <git@vger.kernel.org>; Mon, 03 Jan 2022 09:17:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VTa5DF3WeYWbsO66BQDvxgcQA56O/QP8+TucDSU9ZY=;
        b=cZXs2o4w00BdAYtAphmXKzy4W8/ncCJ2/zExK3LmklbrG0jvJmozXyflwhl8NgIyuV
         /yTiTuel8tAydwu0xKH/99W7g8wn0NVlHAShB+Iu/eIgef7jLdNf9UuJuXbAjGS7HFCx
         8LoDgdKURePVioWXvYyVWbwIy1P2gyj2pfCf+rABc1jvjepMSvau9qiLJUQYvsIV3WEx
         5ZrT9vAga5GA++ybuA6RndUgm0mqkpDNRphFVx/mFQ0hTwxRdvtcILgRQOqrhsEa/PGR
         Y0LtS2Qu1ARjZu1cxAnWWyFpdhmBbksBYD16BMkNt1So0x8N8h1bDbwuhiGt4opBo6iF
         Crrg==
X-Gm-Message-State: AOAM531qaKB6tr82wC3MQTXkL5mdDsTJEoJuUcKhobMMybt8t6FcB7fU
        3bDa8OI9O1u3icm1kS+Yo66IW8h4cLrZ8FIgqmE=
X-Google-Smtp-Source: ABdhPJxAd6SIHK9JCXTL1zUKbofP3ZGxAOwHevJkSp/6v94YwE+LSAY8gawXa/sY872L37kHyVCw1zn8uu23t9GB0zU=
X-Received: by 2002:a05:6a00:2347:b0:4ba:bd36:1743 with SMTP id
 j7-20020a056a00234700b004babd361743mr46705912pfj.15.1641230236941; Mon, 03
 Jan 2022 09:17:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com> <20220103095337.600536-1-fs@gigacodes.de>
In-Reply-To: <20220103095337.600536-1-fs@gigacodes.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 3 Jan 2022 12:17:06 -0500
Message-ID: <CAPig+cS6h6o2_dJAZC1M1Ace29bN2mhPgaEtTWtj3oXfcHq9cA@mail.gmail.com>
Subject: Re: [PATCH v2] gpg-interface: trim CR from ssh-keygen
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Git List <git@vger.kernel.org>,
        Pedro Martelletto <pedro@yubico.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 3, 2022 at 9:24 AM Fabian Stelzer <fs@gigacodes.de> wrote:
> We need to trim \r from the output of 'ssh-keygen -Y find-principals' on
> Windows, or we end up calling 'ssh-keygen -Y verify' with a bogus signer
> identity. ssh-keygen.c:2841 contains a call to puts(3), which confirms
> this hypothesis. Signature verification passes with the fix.
>
> Helped-by: Pedro Martelletto <pedro@yubico.com>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
> diff --git a/gpg-interface.c b/gpg-interface.c
> @@ -509,7 +509,10 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
> -                       trust_size = strcspn(line, "\n");
> +                       trust_size = strcspn(line, "\n"); /* truncate at LF */
> +                       if (trust_size && trust_size != strlen(line) &&
> +                           line[trust_size - 1] == '\r')
> +                               trust_size--; /* the LF was part of CRLF at the end */

I may be misunderstanding, but isn't the strlen() unnecessary?

    if (trust_size && line[trust_size] &&
        line[trust_size - 1] == '\r')
            trust_size--;

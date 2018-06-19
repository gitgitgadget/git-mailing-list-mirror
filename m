Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE3E91F403
	for <e@80x24.org>; Tue, 19 Jun 2018 18:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966825AbeFSSWx convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 19 Jun 2018 14:22:53 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:38372 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966078AbeFSSWx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 14:22:53 -0400
Received: by mail-yw0-f176.google.com with SMTP id w13-v6so234671ywa.5
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 11:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9ps2bW9j2WA4y/FJlu0SasbsfFtzU0XyqPQbajM3tWU=;
        b=Pnhwjxy57tcHlKKh3kLPafow5NPjKP2Rg8o8NjwcR1IML5EZAG6QXNLsBDlWXcJboV
         zTEs6r7dTnvGug+/E1RQFY4eS7IXrnJmG8gsjn//EwyynKdUYZlP9lroxkUAoqobTE3e
         /IpkBLsUtTCtYWL8lAQdXv74MC1wUphSThpdrzmPNMt5u23y+GiJg/c8c2prqM5mXTec
         YxMNr4HsrzaikCy9FyXvhGG8WFwj+ioKaWGafK4AngPQWMxW/elt6/Vgtfp3Ngl1fz1x
         haLSRKq7ZF4Yre607AuXHBOrqQjZRSv66lW8Suf4bxgMoKIZZrSf6nmcx1bzdedkgENZ
         weQg==
X-Gm-Message-State: APt69E0IhYnC2u0XXzrAkLne+MOeUKpGCX6cavkIzggsrYELIvBylxRv
        ucX+XHMK1nsSd08gGrL+esiTBM2WKKI9yOMqnP8=
X-Google-Smtp-Source: ADUXVKIniQwRKmzl469i/O0tYuMnKwBxhreLwzOSKzO2Tu2tsaP//g1Fb25c7r/k2n8mG1Uzc8UKKhmJr90GhX70JGo=
X-Received: by 2002:a81:4517:: with SMTP id s23-v6mr8759237ywa.74.1529432572304;
 Tue, 19 Jun 2018 11:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <5ee7a65d-63e1-aa6a-c3c1-663c092d0efe@web.de> <xmqqk1quvegh.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1quvegh.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 19 Jun 2018 14:22:40 -0400
Message-ID: <CAPig+cT2xkR=LbAJLCdeynGkiPysakbVna61cfrtgO3kKh85+g@mail.gmail.com>
Subject: Re: t5562: gzip -k is not portable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git List <git@vger.kernel.org>, Max Kirillov <max@max630.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 2:06 PM Junio C Hamano <gitster@pobox.com> wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
> > t5562 fails here under MacOS:
> > "gzip -k"  is not portable.

Very odd. Stock /usr/bin/gzip on my MacOS 10.12.6 _does_ recognize -k,
and the test does pass.

> Sigh.  Perhaps -c would help.  Or do BSD implementations also lack -c?

MacOS and BSD do support -c, so this solution would also work (and is
"cleaner" the the other proposal).

> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
> @@ -61,9 +61,9 @@ test_expect_success 'setup' '
>  test_expect_success GZIP 'setup, compression related' '
> -       gzip -k fetch_body &&
> +       gzip -c fetch_body >fetch_body.gz &&
>         test_copy_bytes 10 <fetch_body.gz >fetch_body.gz.trunc &&
> -       gzip -k push_body &&
> +       gzip -c push_body >push_body.gz &&
>         test_copy_bytes 10 <push_body.gz >push_body.gz.trunc
>  '

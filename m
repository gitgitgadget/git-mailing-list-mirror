Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35E2D1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 06:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933950AbeGFGDk (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 02:03:40 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33257 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932282AbeGFGBh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 02:01:37 -0400
Received: by mail-yb0-f194.google.com with SMTP id e84-v6so4142740ybb.0
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 23:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yy2QQtmL5BcJS7khtljhKIkTNcKSeUHzyjuLxB8p99o=;
        b=Xbsp2NxRcYksQLILIqvzu4vCE/c1hLqUbl29nMr5HPbaYw9WkpsKM8V7F6fJk090/a
         P1r7Y+3k+DEajVi+z6fDz1UPoBFhetjSePfxYPliPRcat6WH8hJkTOO2FT/XShrNJ99/
         GACng/i0qjUzOeH1uPI5WA6PuUPj8572pzYv0gnWQ4x8pFo901C/XVR9afWGKjdZGKFF
         CiWzVTcpBFPideqkfow0VG+uZNsIH2GuYt8bJxrNrXEexwLBzwLBu7SYH0dwuILOVz6r
         xNp8W3KRg7x0VWSdFeme1gSTAYOG2Qh0hHCyDdt6T5qgNTIwNf6sGUCCzgiqvE00lWwN
         KSeA==
X-Gm-Message-State: APt69E0T8tdLnsi5YDOmZtGKC3bpKS2LZ+ngXoC9rCr5Nsz9PrtLVdpL
        bOTUKTwCYFDVtjynUaR55r+4z+2/RdxmPReLeSo=
X-Google-Smtp-Source: AAOMgpfgrQi71O7QDPtIXi+nljQB2w0jzba4HCboVnoPdP+v7kO2wcssuXEyx8+tpYUkUmHJOJqq1syBgTmm2bq6jXo=
X-Received: by 2002:a25:ac44:: with SMTP id r4-v6mr4550193ybd.497.1530856896291;
 Thu, 05 Jul 2018 23:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180706022357.739657-1-sandals@crustytoothpaste.net> <20180706022357.739657-2-sandals@crustytoothpaste.net>
In-Reply-To: <20180706022357.739657-2-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Jul 2018 02:01:25 -0400
Message-ID: <CAPig+cR7tWw7D8JMg1a9G2Jgi=HQj3YZjCn+tHDNjDEsrfSLqg@mail.gmail.com>
Subject: Re: [PATCH 1/3] send-email: add an auto option for transfer encoding
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, sir@cmpwn.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 5, 2018 at 10:24 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> For most patches, using a transfer encoding of 8bit provides good
> compatibility with most servers and makes it as easy as possible to view
> patches.  However, there are some patches for which 8bit is not a valid
> encoding: RFC 5321 specifies that a message must not have lines
> exceeding 998 octets.
>
> Add a transfer encoding value, auto, which indicates that a patch should
> use 8bit where allowed and quoted-printable otherwise.  Choose
> quoted-printable instead of base64, since base64-encoded plain text is
> treated as suspicious by some spam filters.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/git-send-email.perl b/git-send-email.perl
> @@ -1852,13 +1851,16 @@ sub apply_transfer_encoding {
> +       $to = ($message =~ /.{999,}/) ? 'quoted-printable' :'8bit'
> +               if $to eq 'auto';

Style: space after colon: 'quoted-printable' : '8bit'

> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> +test_expect_success $PREREQ 'long lines with auto encoding are quoted-printable' '
> +       clean_fake_sendmail &&
> +       git send-email \
> +               --from="Example <nobody@example.com>" \
> +               --to=nobody@example.com \
> +               --smtp-server="$(pwd)/fake.sendmail" \
> +               --transfer-encoding=auto \
> +               --no-validate \
> +               longline.patch \
> +               2>errors &&

Why capture stderr to a file then ignore the file?

> +       grep "Content-Transfer-Encoding: quoted-printable" msgtxt1
> +'

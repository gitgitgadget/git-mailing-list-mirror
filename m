Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BC6E1F453
	for <e@80x24.org>; Sun, 10 Feb 2019 01:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfBJBp2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 20:45:28 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:36096 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfBJBp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 20:45:28 -0500
Received: by mail-qt1-f172.google.com with SMTP id r9so8434526qtt.3
        for <git@vger.kernel.org>; Sat, 09 Feb 2019 17:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zt2KTfpdrMsL8P5NWHlWIzLvXiF3PBdaVgYh3KRLyac=;
        b=Msl3Mz+wMct3uAGKKs3oBFBv3u9yWKPG6AhnsRWCBVA/4y5JjUJ6yrNJPHENPBKpdn
         gBeSjdDspTOdCThKGd4qm71nprVVGTXa/5BowINJYi22KfFuxI/SY/DE3QQf0CfDGzuk
         pCam5Y3OhLcneEoAUx4rRW4pOcevj9xGZXBjjmJU7z/y8NwycXeZ0O9FLWY/Tvec4m3O
         UVr/d/4DbrBn/fB8M7AMFqo7niHKixanypRo395NNB1WV889Jo1leQ2JFgKqWpBZVXxo
         l31hxuDiOc1Wk7ddRNLhlFnPw6NCbK1kRc2dy5I/1MTpUTT4mnTWPBtYCPXjRqkEh5Vt
         gf5A==
X-Gm-Message-State: AHQUAubsPdNeNRD4h/TvEFHMcUaNqdyp7lOZz8QNfk+vqOAV9y16LwUk
        zJxY2stG8aQdZr5nntMNWcTncceoaSFNBS/XhLskHn0G
X-Google-Smtp-Source: AHgI3IacQEXg+9l3RQkI3lIqm3C4quq9Uxnq7XA5AWdnVykUY1zmGB1lnmodHvJJTerg93Oza2I4ybUHc6d+rbBn/3Q=
X-Received: by 2002:ac8:2847:: with SMTP id 7mr6822521qtr.335.1549763126882;
 Sat, 09 Feb 2019 17:45:26 -0800 (PST)
MIME-Version: 1.0
References: <20190209145732.GA14229@alpha> <20190209200802.277139-1-sandals@crustytoothpaste.net>
In-Reply-To: <20190209200802.277139-1-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 9 Feb 2019 20:45:16 -0500
Message-ID: <CAPig+cRyzZMOM19ztgR_wqvk68P_1eNNVBBj5pbY=MhQm08WAw@mail.gmail.com>
Subject: Re: [PATCH] utf8: handle systems that don't write BOM for UTF-16
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 9, 2019 at 3:08 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> [...]
> Add a Makefile and #define knob, ICONV_NEEDS_BOM, that can be set if the
> iconv implementation has this behavior. When set, Git will write a BOM
> manually for UTF-16 and UTF-32 and then force the data to be written in
> UTF-16BE or UTF-32BE. We choose big-endian behavior here because the
> tests use the raw "UTF-16" encoding, which will be big-endian when the
> implementation requires this knob to be set.

The name ICONV_NEEDS_BOM makes it sound as if we must feed a BOM
_into_ 'iconv', which is quite confusing since the actual intention is
that 'iconv' doesn't emit a BOM and we need to make up for the
deficiency. Using a name such as ICONV_OMITS_BOM or ICONV_NEGLECTS_BOM
makes it somewhat clearer that there is some deficiency with which we
need to deal.

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/Makefile b/Makefile
> @@ -259,6 +259,9 @@ all::
> +# Define ICONV_NEEDS_BOM if your iconv implementation does not write a
> +# byte-order mark (BOM) when writing UTF-16 or UTF-32.

Not a big deal, but I wonder if it would be helpful to tack on "...,
in which case it outputs big-endian unconditionally." or something.

> diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
> @@ -6,6 +6,25 @@ test_description='working-tree-encoding conversion via gitattributes'
> +test_lazy_prereq NO_UTF16_BOM '
> +       test $(printf abc | iconv -f UTF-8 -t UTF-16 | wc -c) = 6
> +'
> +
> +test_lazy_prereq NO_UTF32_BOM '
> +       test $(printf abc | iconv -f UTF-8 -t UTF-32 | wc -c) = 12
> +'
> +
> +write_utf16 () {
> +       test_have_prereq NO_UTF16_BOM && printf '\xfe\xff'
> +       iconv -f UTF-8 -t UTF-16
> +
> +}

Stray blank line before the closing brace.

> +
> +write_utf32 () {
> +       test_have_prereq NO_UTF32_BOM && printf '\x00\x00\xfe\xff'
> +       iconv -f UTF-8 -t UTF-32
> +}

It's probably doesn't matter much with these two tiny functions, but I
was wondering if it would make sense to maintain the &&-chain, perhaps
like this:

    if test test_have_prereq NO_UTF32_BOM
    then
        printf '\x00\x00\xfe\xff'
    fi &&
    iconv -f UTF-8 -t UTF-32

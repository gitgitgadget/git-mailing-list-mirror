Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72612C433E1
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B582073E
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGZXO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 19:14:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53797 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgGZXO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 19:14:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id g8so1308912wmk.3
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 16:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBC4Qhqo2xR/Zza6CxaLaF2r7JhbR9sxzDAnQDI5Oi0=;
        b=fYOBPrCI9KGQVjwre+OD7+jyOELKvoG5Nr1B882tR4t8VIBdwhIEtdQX3jbpJAOzko
         mXL0hBTr7JPsp42fkcfwJBh4O09dkiHAzm8Jvu16PP3SVXWpdMeFcL2F5WlUE8cs7lFJ
         Z4RltWJu5rY4NE130YwhJIaMkIjJeoTF3Hj4ziScr+5FYxHKVmALOP29ftFK7Yn9IYXy
         qT2HCWzFCW5XopKjAFfhLZXziKB18ulGS2HnhV01Jka/OD29sGpLDaWgVJtJ8xAmiGQu
         EkGzGZo6+kH48f9cWcQvYyY0yE4P54qWAfp3llRbqkfDFR18IznO9i9kTT4+rDPEaemP
         QKcw==
X-Gm-Message-State: AOAM5306t4CShgWRoabL52j4QZoKhTCcUei/1aH6jhxQkuy7Vmuan/Dg
        VtF8tpfW2QqaqfQfmppavJSg0VszyjVijnDbpT0=
X-Google-Smtp-Source: ABdhPJwLTD/eMZECJTAEj+87uYXt+MfJPnkYdBFfcveuqP70XDfPPbGGK7Gaz6aZCpqS0ojFQpPZHD/2lBRu/rg2B9M=
X-Received: by 2002:a1c:e304:: with SMTP id a4mr8993110wmh.11.1595805295261;
 Sun, 26 Jul 2020 16:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200726195424.626969-1-sandals@crustytoothpaste.net> <20200726195424.626969-22-sandals@crustytoothpaste.net>
In-Reply-To: <20200726195424.626969-22-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Jul 2020 19:14:44 -0400
Message-ID: <CAPig+cRfvEa72_L5UFwSngWE7TNd9jWYEE2e_8bDOYQe3sSMfw@mail.gmail.com>
Subject: Re: [PATCH v4 21/39] t9300: abstract away SHA-1-specific constants
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 26, 2020 at 3:55 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Adjust the test so that it computes variables for object IDs instead of
> using hard-coded hashes.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> @@ -285,7 +285,7 @@ test_expect_success 'A: verify pack' '
>  test_expect_success 'A: verify diff' '
>         cat >expect <<-EOF &&
> -       :000000 100755 0000000000000000000000000000000000000000 7123f7f44e39be127c5eb701e5968176ee9d78b1 A      copy-of-file2
> +       :000000 100755 0000000000000000000000000000000000000000 $(git rev-parse --verify master:file2) A        copy-of-file2
>         EOF

The other changes in this patch all use a variable to hold the
computed OID rather than computing it inline inside the here-doc as is
done here. By assigning it to a variable, a failure of git-rev-parse
will be caught, whereas it won't necessarily be caught failing inside
the here-doc if it happens to produce the correct output before
crashing. Not necessarily worth a re-roll on its own, but maybe worth
doing if you are re-rolling (and would save Denton the effort of
tackling it instead).

> @@ -935,14 +940,15 @@ test_expect_success 'L: verify internal tree sorting' '
> -       test_cmp expect output
> +       cut -d" " -f1,2,5 output >actual &&
> +       test_cmp expect actual

This change is different from all the other changes in this patch. If
you're re-rolling anyhow, perhaps generalize the commit message a bit
to account for it.

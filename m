Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB30ECAAA1
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 05:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiIBFqQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 2 Sep 2022 01:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIBFqN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 01:46:13 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FDF67456
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 22:46:12 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id g5so1691707ybg.11
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 22:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fQFmbfFamQvPmb6O1c0u5xQuDfvUd4hasUbNbhUBlMQ=;
        b=qkT2wBh2ihxP3DjC6LHrZ2gdcQnS2S0AbuRnSmed5yHfupG8nw+Tgz150KJ/CzE0k0
         R3QgXU7xmf93m6ygUaSirIsL7mdUmfWFKguf0cjOIqz9unx8hOB/8+/yoCbTR8NO6t9H
         zosrNY/9lzHnbcWCWQGQ9HNp3heWOE6IvwKo3SfoFwVKLiwd4u14jBeA7yNAqyPVZFHY
         pI0WPEM95fCSEyz5Zfsaw3NyS6nw8sNFIugvQLu4KYLAraeS2me6Y7/2Z+BNS3HvNhcY
         qmQ9eRyR36k9wCjSUIG4L+zMXWjvTD+wvBKADrEntIRoxTVvdAOcOFkGmo0zUdWDqFHE
         g8NA==
X-Gm-Message-State: ACgBeo3y5YTtyBwiLKeTFRnGyRjK6OxNAiJ3Sn3oJwZLjomNaTC4p7XN
        dHiioLWEcjAG6qzfNZfxgIkq9OEL3SiCdRlWlmoK/GB7QNnQUg==
X-Google-Smtp-Source: AA6agR4EbScn42tL86+kh87TXA5z1XVLa44h1ZO+ItDpd6mvaD2pWpvDWw1NtKu60ZMwGjscGn4va+37mLMO/Q6LaH8=
X-Received: by 2002:a25:7393:0:b0:699:186f:76cf with SMTP id
 o141-20020a257393000000b00699186f76cfmr21645994ybc.54.1662097571416; Thu, 01
 Sep 2022 22:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHJtQJ4uJc2_upHvc-SWVpA3OX2Lpu-XspswGTTDLgXWjG-Gew@mail.gmail.com>
 <20220902050621.94381-1-oystwa@gmail.com>
In-Reply-To: <20220902050621.94381-1-oystwa@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Sep 2022 01:46:00 -0400
Message-ID: <CAPig+cTAN1F1D=DxZF9jbUiTtc4UPnx0hZLLaVFKEecAa-gMsg@mail.gmail.com>
Subject: Re: [PATCH] rev-parse: Detect missing opt-spec
To:     =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Cc:     Git List <git@vger.kernel.org>, ingy@ingy.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 2, 2022 at 1:10 AM Øystein Walle <oystwa@gmail.com> wrote:
> If a line in parseopts's input starts with one of the flag characters it
> is erroneously parsed as a opt-spec where the short name of the option
> is the flag character itself and the long name is after the end of the
> string. This makes Git want to allocate SIZE_MAX bytes of memory at this
> line:
>
>     o->long_name = xmemdupz(sb.buf + 2, s - sb.buf - 2);
>
> Since s and sb.buf are equal the second argument is -2 (except unsigned)
> and xmemdupz allocates len + 1 bytes, ie. -1 meaning SIZE_MAX.
>
> Avoid this by checking whether a flag character was found in the zeroth
> position.
>
> Signed-off-by: Øystein Walle <oystwa@gmail.com>

Perhaps add a:

    Reported-by: Ingy dot Net <ingy@ingy.net>

trailer?

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> @@ -479,6 +479,9 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
> +               if (s == sb.buf)
> +                       die(_("Missing opt-spec before option flags"));

There is a bit of a mix in this file already, but these days, we tend
to start error messages with lowercase:

    die(_("missing opt-spec before option flags"));

> diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
> @@ -306,6 +306,13 @@ test_expect_success 'test --parseopt help output: "wrapped" options normal "or:"
> +test_expect_success 'test --parseopt invalid opt-spec' '
> +       test_write_lines x -- "=, x" >spec &&
> +       echo "fatal: Missing opt-spec before option flags" >expect &&
> +       test_must_fail git rev-parse --parseopt -- >out <spec >actual 2>&1 &&
> +       test_cmp expect actual
> +'
> +
> @@ -337,3 +344,5 @@ test_expect_success 'test --parseopt help output: multi-line blurb after empty l
>
>  test_done
> +
> +test_done

Um? Debugging leftover?

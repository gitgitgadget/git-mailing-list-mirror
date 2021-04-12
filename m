Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BA8C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932F0611CE
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243840AbhDLRBv convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 12 Apr 2021 13:01:51 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:41570 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243837AbhDLRAh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:00:37 -0400
Received: by mail-ej1-f46.google.com with SMTP id g17so18682964ejp.8
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+ld03dZrVL6xfD44oZIey1g1YiflTuTw71X0udlWozk=;
        b=BKZfXVR/QQLkLXePaL/ipO4zQCkp7Yy+m7stw+60rOWbLeFBt2ORR6veXIMzcDvG7g
         5AUP0qhVFzb5WU4w8kF1ageuo283dohhoYxvRqAW+tbMEkd2XX4xFsRFtU3tO9PM642P
         zrDl+N0E+YQ5QTL7rux4q3Sp5rzRAftTrWv8xxp7dHUQiDVrNhLlbvhxSeN4I/StabTu
         16TY+HytVqTdjLUBAc028WSDigtzU5ee3GGvJmojE1J/5reBJNpaQbvEOx2IyfM9EXmh
         jDYzxsIGFtDBWaTEo2NT9trTslytdeqG2LZx6GI7hPN3lHLY/1+5vWKKK9D6+1oeTfVq
         7aPQ==
X-Gm-Message-State: AOAM531uVwDyivO23KNg5nd3tWaEyGXjUAgtsBqqli7bKIuYBnldlecR
        Pj7LjsxR1rdBOTkJp9nb0nm8rJmIXv1/VrMQM1E=
X-Google-Smtp-Source: ABdhPJxFQRMiDZjoHR10qmnXeNShO3U7X5SQb4I2si39E60ZPEuDJsaSfvS8V0iLo3m6XCdRvKC3FpPBt0D/zVUtDOs=
X-Received: by 2002:a17:907:3a98:: with SMTP id fh24mr18390847ejc.371.1618246817424;
 Mon, 12 Apr 2021 10:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com> <patch-01.16-8e4b4a2a216-20210412T110456Z-avarab@gmail.com>
In-Reply-To: <patch-01.16-8e4b4a2a216-20210412T110456Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Apr 2021 13:00:06 -0400
Message-ID: <CAPig+cQFFsLeE921WpzTxVnBMnNRiKs4N=hUQ2UQi1VznNEQwg@mail.gmail.com>
Subject: Re: [PATCH 01/16] check-non-portable-shell: complain about "test"
 a/-o instead of &&/||
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 7:09 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Expand the t/check-non-portable-shell.pl checks to complain about the
> use of "-a" and "-o" to the "test" shell built-in to to mean "and" and
> "or", as opposed to using two "test" invocations with "&&" or "||".
>
> There aren't any portability issues with using that construct that I
> know of, but since Junio expressed a dislike of it in [1] and we've
> currently got no such constructs let's add it to the lint checking. I
> had various in-flight and WIP patches that used this construct.

It's not only Junio's dislike of `-a` and `-o` but also that they have
long been considered obsolescent by POSIX[1]. GNU has likewise warned
against it[2] for a few decades.

[1]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html#tag_20_128_16
[2]: https://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.70/html_node/Limitations-of-Builtins.html

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
> @@ -35,6 +35,7 @@ sub err {
> +       # Portability issues
> @@ -48,6 +49,9 @@ sub err {
> +       # Coding style preferences

Given that these flags are considered obsolescent, thus may someday be
dropped from some implementations, these seem a better fit for the
"portability issues" section than the "coding style preferences"
section. (I'd probably just drop those section titles, though.)

> +       /\btest\s+-[a-z]\s+.*?\s+-a\s+/ and err '"test A && test B" preferred to "test A -a B"';
> +       /\btest\s+-[a-z]\s+.*?\s+-o\s+/ and err '"test A || test B" preferred to "test A -o B"';

These will only match the simplistic forms of `test -X blah` (where
"-X" is some single letter option), but will miss expressions such as
`test "$foo" = bar`. Crafting a regex to match more generally would be
non-trivial, so this simpler match is a reasonable start. Okay.

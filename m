Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FA4C433EF
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 01:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1302F61037
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 01:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhKGBKO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 6 Nov 2021 21:10:14 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:34480 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhKGBKN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 21:10:13 -0400
Received: by mail-ed1-f49.google.com with SMTP id x15so15960799edv.1
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 18:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iOvIMDo9Rvpe1YQ8MrJ3XJZ/i0dIOGm3hLRK1dYfhsQ=;
        b=34+Zr4tylt9rxDvG5RXlRRyYSz8Q8cPqcAuVIaBxUK96XOgx2/m2nd3tHAq1WOMZGH
         zw3o7hp0UgJ5vsUPDPNA8Y5bWHm97WyNTesY6xYGpHVy29WT7yPo5qnNsQUZUKVM4l6u
         /RKuu2OEX9L2HIYeRP8jM2MnPz+AtmLHfZdMvnScNRFjp5K32uvUw2ofeY3poN9bVHZE
         iECpqYsogtMeABugCnixPaZ5KSruKNlJejXrpOexpaEQYxeQv6Qmb+Stf9a+2PUvgFgC
         kNxn7RwFiNcFIdUgHWmhevdZ+TivfH9I9vNRDEal3ep07cQSDvV1c5DZlMcRezsI0Fh8
         9yAA==
X-Gm-Message-State: AOAM53350tiQADwaS/wl4lVb7NgPOQaOzpvWZSq9rMJJi43lcw/U58Z4
        vytXLvsOyRRDLd0Ypm/Vre1QMUtknlpdD8977kI=
X-Google-Smtp-Source: ABdhPJyDdK7CyQF5bARnUA3TPhvaUApdZDVw9Zi8KK2gDrr8PNt04tQ+0M2HFuXDHq/uWc1GBanL0ZHFEz84djROhyI=
X-Received: by 2002:a05:6402:50d0:: with SMTP id h16mr17488844edb.70.1636247250784;
 Sat, 06 Nov 2021 18:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqlf33i36a.fsf@gitster.g> <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
 <patch-01.10-c8040da8e55-20211106T214259Z-avarab@gmail.com>
In-Reply-To: <patch-01.10-c8040da8e55-20211106T214259Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 6 Nov 2021 21:07:19 -0400
Message-ID: <CAPig+cSuSaZsTh8_FBHNpT1LKGWWFPd-bkjvfF=0fZDQaDiqvQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] cat-file tests: test bad usage
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 6, 2021 at 5:47 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Stress test the usage emitted when options are combined in ways that
> isn't supported. Let's test various option combinations, some of these
> we buggily allow right now.
>
> E.g. this reveals a bug in 321459439e1 (cat-file: support
> --textconv/--filters in batch mode, 2016-09-09) that we'll fix in a
> subsequent commit. We're supposed to be emitting a relevant message
> when --batch-all-objects is combined with --textconv or --filters, but
> we don't.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> @@ -4,6 +4,96 @@ test_description='git cat-file'
> +test_cmdmode_usage() {

Style nit: add space before ()

> +       test_expect_code 129 "$@" 2>err &&
> +       grep "^error:.*is incompatible with" err
> +}
> +
> +test_expect_success 'usage: cmdmode' '
> +       test_cmdmode_usage git cat-file -e -p &&
> +       test_cmdmode_usage git cat-file -p -t &&
> +       test_cmdmode_usage git cat-file -t -s &&
> +       test_cmdmode_usage git cat-file -s --textconv &&
> +       test_cmdmode_usage git cat-file --textconv --filters
> +'

A minor observation: I usually avoid combining tests into a
conglomerate since it makes it harder to discover at a glance
the problematic test if one does start failing. I'd probably have used a
separate test_expect_success() invocation for each allowed switch
combination (in other words, five distinct tests instead of all five
cases stuffed into a single test). Not a big deal.

> +test_incompatible_usage() {

Style nit: add space before ()

> +       test_expect_code 129 "$@" 2>err &&
> +       grep -E "^error:.*$switch.*needs" err
> +}

What is `$switch`? There doesn't seem to be any such variable defined
which means the regex is really:

    ^error:.*.*needs

thus matches "by accident".

> +for opt in $short_modes
> +do
> +       test_expect_success "usage: $opt requires another option" '
> +               test_expect_code 129 git cat-file $opt
> +       '
> +
> +       for opt2 in --batch \
> +               --batch-check \
> +               --follow-symlinks
> +       do
> +               test_expect_failure "usage: incompatible options: $opt and $opt2" '
> +                       test_incompatible_usage git cat-file $opt $opt2
> +               '
> +       done
> +
> +       opt2="--path=foo HEAD:some-path.txt"
> +       test_expect_success "usage: incompatible options: $opt and $opt2" '
> +               test_incompatible_usage git cat-file $opt $opt2
> +       '
> +done

So, the only reason the final `opt2` is not part of the for-loop:

    for opt2 in --batch \
        --batch-check \
        --follow-symlinks \
        "--path=foo HEAD:some-path.txt"

is that it succeeds but the others fail?

> +for opt in --buffer \
> +       --follow-symlinks \
> +       --batch-all-objects
> +do
> +       status=success
> +       if test $opt = "--buffer"
> +       then
> +               status=failure
> +       fi
> +       test_expect_$status "usage: bad option combination: $opt without batch mode" '
> +               test_expect_code 129 git cat-file $opt &&
> +               test_expect_code 129 git cat-file $opt commit HEAD
> +       '
> +done

In this case, `status` differentiates between success and failure...

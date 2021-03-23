Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F534C433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 05:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13AB16198C
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 05:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhCWFbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 01:31:44 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:46825 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhCWFbT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 01:31:19 -0400
Received: by mail-ed1-f52.google.com with SMTP id h10so21956486edt.13
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 22:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Koogeao0Az8+Jx7pTZ1PUBDfiDVMw7/7w9xtDJqD9lY=;
        b=d3AuNB8bBhTvOHrOYm71nNSiqWzVbVDApOnxmD3rhyRawv6YgBLmEqbyPFeGv/0OX7
         DrCCe3jo7YGiZYEBvQZlm9nlck3HEBHXGnd9/VJFWW/xLnyJyj2MK0t8ObbsTtwB3ut6
         DK1mwXo8HW5fuEObjk33c5qVtu5nB/d8qmdJ9WJ4m/qkcl+lSPPHndxAZMXAafNz4WpD
         HLIedOFu8jcJ/wpNwzb4syw+n7LRLJpOLVvRSxxps961DHRnYj4KfTD7zyHcDNl+oNBz
         Bu+LUxEDgzOlI1OXecLLJOpLMSKsyq34Fh2cu2uRTIa+zP90Ng1kRkRnMQGmFUx/WAZL
         zesw==
X-Gm-Message-State: AOAM530f+D9e9yx7S6kzKKqlgt1ZG/dRV9lGXR2srXxzW/xdF2kzqxYh
        epUtwX8+DDErsv0lqX6HTwmDdjOpVRvftK1N/nf+ZIRSamg=
X-Google-Smtp-Source: ABdhPJzeFsBVDdeC1V6iYqPBf//oTzISXp48ZEKjIucj048+ZveAERC+FhXCfLQPCKGB5b14G9GQxyL/z4XrIquxGgs=
X-Received: by 2002:aa7:d0cb:: with SMTP id u11mr2784717edo.163.1616477478601;
 Mon, 22 Mar 2021 22:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.v8.git.1616252178414.gitgitgadget@gmail.com> <pull.885.v9.git.1616317225769.gitgitgadget@gmail.com>
In-Reply-To: <pull.885.v9.git.1616317225769.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Mar 2021 01:31:07 -0400
Message-ID: <CAPig+cQ5jBc-fz69ygpWUP7uCVNAT8GT_01y6GnxDEa6XDNZ=g@mail.gmail.com>
Subject: Re: [PATCH v9] format-patch: allow a non-integral version numbers
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 21, 2021 at 5:00 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> Allow `format-patch` to take such a non-integral iteration
> number.
> [...]
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>

Just a few nits below; nothing very important (except perhaps the
final comment about the potential for people to get confused while
reading the tests). Junio already has this marked as ready to merge to
"next", so these nits may not be worth a re-roll.

> diff --git a/log-tree.c b/log-tree.c
> @@ -368,9 +368,14 @@ void fmt_output_subject(struct strbuf *filename,
>         int max_len = start_len + info->patch_name_max - (strlen(suffix) + 1);
> +       struct strbuf temp = STRBUF_INIT;
>
> +       if (info->reroll_count) {
> +               strbuf_addf(&temp, "v%s", info->reroll_count);
> +               format_sanitized_subject(filename, temp.buf, temp.len);
> +               strbuf_addstr(filename, "-");
> +               strbuf_release(&temp);
> +       }

The new `temp` strbuf is use only inside the conditional, so it
could/should have been declared in that block rather than in the outer
block:

    if (info->reroll_count) {
        struct strbuf temp = STRBUF_INIT;

        strbuf_addf(&temp, "v%s", info->reroll_count);
        ...
    }

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> @@ -378,6 +378,22 @@ test_expect_success 'reroll count' '
> +test_expect_success 'reroll count with a fractional number' '
> +       rm -fr patches &&
> +       git format-patch -o patches --cover-letter --reroll-count 4.4 main..side >list &&
> +       ! grep -v "^patches/v4.4-000[0-3]-" list &&
> +       sed -n -e "/^Subject: /p" $(cat list) >subjects &&
> +       ! grep -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
> +'
> +
> +test_expect_success 'reroll count with a non number' '
> +       rm -fr patches &&
> +       git format-patch -o patches --cover-letter --reroll-count 4rev2 main..side >list &&
> +       ! grep -v "^patches/v4rev2-000[0-3]-" list &&
> +       sed -n -e "/^Subject: /p" $(cat list) >subjects &&
> +       ! grep -v "^Subject: \[PATCH v4rev2 [0-3]/3\] " subjects
> +'

The above two tests...

> @@ -386,6 +402,38 @@ test_expect_success 'reroll count (-v)' '
> +test_expect_success 'reroll count (-v) with a fractional number' '
> +       rm -fr patches &&
> +       git format-patch -o patches --cover-letter -v4.4 main..side >list &&
> +       ! grep -v "^patches/v4.4-000[0-3]-" list &&
> +       sed -n -e "/^Subject: /p" $(cat list) >subjects &&
> +       ! grep -v "^Subject: \[PATCH v4.4 [0-3]/3\] " subjects
> +'
> +
> +test_expect_success 'reroll (-v) count with a non number' '
> +       rm -fr patches &&
> +       git format-patch -o patches --cover-letter -v4rev2 main..side >list &&
> +       ! grep -v "^patches/v4rev2-000[0-3]-" list &&
> +       sed -n -e "/^Subject: /p" $(cat list) >subjects &&
> +       ! grep -v "^Subject: \[PATCH v4rev2 [0-3]/3\] " subjects
> +'

... are repeated here with the only difference being `--reroll-count`
versus `-v`. Since other tests have already established that
`--reroll-count` and `-v` are identical, it's not really necessary to
do that work again with these duplicate tests.

> +test_expect_success 'reroll (-v) count with a "injection (1)"' '
> +       rm -fr patches &&
> +       git format-patch -o patches --cover-letter -v4..././../1/.2//  main..side >list &&
> +       ! grep -v "^patches/v4.-.-.-1-.2-000[0-3]-" list &&
> +       sed -n -e "/^Subject: /p" $(cat list) >subjects &&
> +       ! grep -v "^Subject: \[PATCH v4..././../1/.2// [0-3]/3\] " subjects
> +'

A couple comments:

The test title might be easier for other people to understand if it
says "non-pathname character" or "non filename character" rather than
"injection".

Note that the `grep -v` is casting a wider net than it seems at first
glance. The `.` matches any character, not just a period ".". To
tighten the matching and make `.` match just a ".", you can use `grep
-vF`.

> +test_expect_success 'reroll (-v) count with a "injection (2)"' '
> +       rm -fr patches &&
> +       git format-patch -o patches --cover-letter -v4-----//1//--.--  main..side >list &&
> +       ! grep -v "^patches/v4-1-000[0-3]-" list &&
> +       sed -n -e "/^Subject: /p" $(cat list) >subjects &&
> +       ! grep -v "^Subject: \[PATCH v4-----//1//--.-- [0-3]/3\] " subjects
> +'

Presumably the coverage of format_sanitized_subject() is already being
tested elsewhere, so it's not clear that this second "injection" test
adds any value over the first test. Moreover, this second test can
confuse readers into thinking that it is testing something that the
first test didn't cover, but that isn't the case (as far as I can
tell).

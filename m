Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 190A81F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 19:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406694AbeKWGID convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 23 Nov 2018 01:08:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44575 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406680AbeKWGIC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 01:08:02 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so8434396qte.11;
        Thu, 22 Nov 2018 11:27:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JsDlE/EqQePVWStVSMhHbBccsjkCk4KTZ9ga2/SndPE=;
        b=O8hvCiS9lMxh9vSvBojbh0HYLj37hOLk48NqxW0XTvyROqZ6xF2G/Dt0bEN0kPrWnO
         4ULBSkHu9a32Z66sPuXaTJK9CyI2NiLIKNDODmG6fSwAm/Rnd5duDphWOMCwvNXP/OUt
         NwrooxZum82HMKKCAy7wFdEoI0HKYU7sEFQeJC2Vxp3hBNt2q0E84g7/KBIKsS0C6ejW
         Go7fDn7MC6Es6+/ws0m9Ic2c6hkCWk4RGZ+mzRrfq3HAnBsDG1X0bHFAa2Af4rM/y2eI
         CEa6jclN4XydzFy5Q61moEqNmH2jCABvpxrJYFoWSssEamFvNY2G5lFb9LkvNyFYbTLD
         xGcw==
X-Gm-Message-State: AA+aEWY4CTGQhEqhm7cN65L03Cqzts7CYcwBKD/NubbXxBlLvvNuzrYb
        KKxQF9kmpAkqHihXKOd12e0p5Mqz4MW9S66v/j8=
X-Google-Smtp-Source: AFSGD/Xr94qlX3JyZ56O5sGzpGoOLYHIsU9O77iNKRkSna5B4UHGNMAZyY4uAWZxQwKBdE5vP5Ftp8dH2i8vf/H8dLM=
X-Received: by 2002:a0c:d29b:: with SMTP id q27mr11517297qvh.62.1542914835946;
 Thu, 22 Nov 2018 11:27:15 -0800 (PST)
MIME-Version: 1.0
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com> <87ftvt14uw.fsf@evledraar.gmail.com>
In-Reply-To: <87ftvt14uw.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 22 Nov 2018 14:27:04 -0500
Message-ID: <CAPig+cSzyT5N5=YeX+VgRq1t0VbWqXLHSB=g=V=O-nLdCWrE9g@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.20.0-rc1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 22, 2018 at 10:58 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> There's a regression related to this that I wanted to send a headsup
> for, but don't have time to fix today. Now range-diff in format-patch
> includes --stat output. See e.g. my
> https://public-inbox.org/git/20181122132823.9883-1-avarab@gmail.com/

Umf. Unfortunate fallout from [1].

> diff --git a/builtin/log.c b/builtin/log.c
> @@ -1094,9 +1094,12 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>         if (rev->rdiff1) {
> +               const int oldfmt = rev->diffopt.output_format;
>                 fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
> +               rev->diffopt.output_format &= ~(DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY);
>                 show_range_diff(rev->rdiff1, rev->rdiff2,
>                                 rev->creation_factor, 1, &rev->diffopt);
> +               rev->diffopt.output_format = oldfmt;
>         }
>  }

A few questions/observations:

Does this same "fix" need to be applied to the --interdiff case just
above this --range-diff block?

Does the same "fix" need to be applied to the --interdiff and
--range-diff cases in log-tree.c:show_log()?

Aside from fixing the broken --no-patches option[2], a goal of the
series was to some day make --stat do something useful. Doesn't this
"fix" go against that goal?

The way this change needs to be spread around at various locations is
making it feel like a BandAid "fix" rather than a proper solution. It
seems like it should be fixed at a different level, though I'm not
sure yet if that level is higher (where the options get set) or lower
(where they actually affect the operation).

Until we figure out the answers to these questions, I wonder if a more
sensible short-term solution would be to back out [1] and just keep
[2], which fixed the --no-patches regression.

> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> @@ -248,8 +248,10 @@ test_expect_success 'dual-coloring' '
>  for prev in topic master..topic
>  do
>         test_expect_success "format-patch --range-diff=$prev" '
> +               cat actual &&

Debugging session gunk?

>                 git format-patch --stdout --cover-letter --range-diff=$prev \
>                         master..unmodified >actual &&
> +               ! grep "a => b" actual &&
>                 grep "= 1: .* s/5/A" actual &&

[1]: https://public-inbox.org/git/20181113185558.23438-4-avarab@gmail.com/
[2]: https://public-inbox.org/git/20181113185558.23438-3-avarab@gmail.com/

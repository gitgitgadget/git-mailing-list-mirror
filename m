Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47470C433F5
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 03:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BB6F61929
	for <git@archiver.kernel.org>; Sun,  7 Nov 2021 03:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhKGDDr convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 6 Nov 2021 23:03:47 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:41761 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbhKGDDq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 23:03:46 -0400
Received: by mail-ed1-f47.google.com with SMTP id ee33so48117238edb.8
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 20:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=05SXDwXHh2nB/4AEDEd/HyNoq3ubFi0wr/oLqmIlYuQ=;
        b=5MMrw009Xs1kzewPAHitPf2mZOiFL0AQhr6hVkpzC/V9iaURzDnUDujwjLTxX0aTgm
         ySBe+vnavyaYWTULqTX8tCk0KA2xKF4jSTMSyzwVMWr2+hfobKiNzNwyKjljUYnz5eHY
         X921YNJCSZhVQE+YoDMR/kw424L4ei6ylAGNrUgdLB2g7Et+RLxEguG8XIwlTaj28yuS
         MrQHZhLyK+SxnOInsUTw4FmS3aPJR1++rNS6hP8+KWpzzUdkrO39wQmduuTRAnOS9UXx
         aYtgJ/+TW6hhVByf2kHZ8rL4335+HLNBP3YwDYynzyyLwcA7IQc8AN7rOTdbT15zuP4q
         oWVA==
X-Gm-Message-State: AOAM533koEXe0ZG+Gp/whCdSCnUXQpjxX1Hk82tLalLA+KA0EIEhbOkW
        980gqI37s3PB0E5U+3T3tby3Salf7ntiPhSLKRo=
X-Google-Smtp-Source: ABdhPJzOYCYS3vI50LWpdgzJcjUGLy4k76S/CBWJmgQ4p7ZN+Pg5KoZCN7mLuSwbRfl21N+1HCFXQAGyY8hx6lVn9Jc=
X-Received: by 2002:a05:6402:10da:: with SMTP id p26mr93629552edu.283.1636254063587;
 Sat, 06 Nov 2021 20:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqlf33i36a.fsf@gitster.g> <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
 <patch-06.10-ee49e586483-20211106T214259Z-avarab@gmail.com>
In-Reply-To: <patch-06.10-ee49e586483-20211106T214259Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 6 Nov 2021 23:00:52 -0400
Message-ID: <CAPig+cTouP1mpffAkFQ0XR-jsVPGDDqS9XDvytTX7CVd-0_N7w@mail.gmail.com>
Subject: Re: [PATCH 06/10] cat-file: make --batch-all-objects a CMDMODE
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
> The usage of OPT_CMDMODE() in "cat-file"[1] was added in parallel with
> the development of[3] the --batch-all-objects option[4], so we've
> since grown[5] checks that it can't be combined with other command
> modes, when it should just be made a top-level command-mode
> instead. It doesn't combine with --filters, --textconv etc.
>
> By giving parse_options() information about what options are mutually
> exclusive with one another we can get the die9) message being removed
> here for free, we didn't even use that removed message in some cases,
> e.g. for both of:

s/die9)/die()/

>     --batch-all-objects --textconv
>     --batch-all-objects --filters
>
> We'd take the "goto usage" in the "if (opt)" branch, and never reach
> the previous message. Now we'll emit e.g.:
>
>     $ git cat-file --batch-all-objects --filters
>     error: option `filters' is incompatible with --batch-all-objects
>
> 1. b48158ac94c (cat-file: make the options mutually exclusive, 2015-05-03)
> 2. https://lore.kernel.org/git/xmqqtwspgusf.fsf@gitster.dls.corp.google.com/
> 3. https://lore.kernel.org/git/20150622104559.GG14475@peff.net/
> 4. 6a951937ae1 (cat-file: add --batch-all-objects option, 2015-06-22)
> 5. 321459439e1 (cat-file: support --textconv/--filters in batch mode, 2016-09-09)
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F999C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 02:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2579D20878
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 02:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393648AbgJPCSQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 15 Oct 2020 22:18:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46032 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393644AbgJPCSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 22:18:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id dg9so667888edb.12
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 19:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lRq17MZ3XYahhddkO3K1goQHSIGYDntBHqpdLOzQ66c=;
        b=LCgVSdrrUrM1PmqSWEmNktdgGDnjyGkUKR0k427zFBGyCLR0248G2Y7/7wFvVSCnuc
         ZJiFvi0J/hwU+6Ag4RtVbYgZtcyvPLp7rpNpe9GSshosCtgIW7bKbpyR+0kivuSnpfF0
         Te+rxZbO/aiGHPlmXen5y48tYehOdPFp1WyrCeQczQLKRCkblBZJK1HoxivOZ+pwfSxX
         WrzYkrLZ+atqBLmgFqehZvq181YiWSciHc3yZqEWFDIF8LLto+SReGelB+IeTsaYJjXo
         /XGJyG1+CnTPTU0Lk10MBChlihDrkvqQCNQL5Pgv5blDzygx24UbeADvnVjn6QGhJNzG
         Awww==
X-Gm-Message-State: AOAM532VRur4hlqnmAh+dI4D5voLPo4RLQpEFRiG3ONFHU42hGgiWdWP
        u/eoz00rgoGPVUup3MS++6RRX9PXPRRFVWZb4aU=
X-Google-Smtp-Source: ABdhPJyRWgxEXm7CTRWIgRMROdccQ3B8VrFWkgT/E4hSzEVAP+XxShpRrKyFRMcpKbkNoynaXKbmto89vu64hvGHpZo=
X-Received: by 2002:a05:6402:13da:: with SMTP id a26mr1346960edx.291.1602814694091;
 Thu, 15 Oct 2020 19:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200809060810.31370-1-sunshine@sunshineco.com>
 <20200809174209.15466-1-sunshine@sunshineco.com> <20201016001704.GA2937048@coredump.intra.peff.net>
In-Reply-To: <20201016001704.GA2937048@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 15 Oct 2020 22:18:03 -0400
Message-ID: <CAPig+cSU=1GcQuqZab+0Vff_A-JmD59wEc3RMr3wDojpgRYUuw@mail.gmail.com>
Subject: Re: [PATCH v2] test_cmp: diagnose incorrect arguments
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 8:17 PM Jeff King <peff@peff.net> wrote:
> On Sun, Aug 09, 2020 at 01:42:09PM -0400, Eric Sunshine wrote:
> > [...] Make it easier for test authors to discover such problems early
> > by sanity-checking the arguments to test_cmp(). [...]
>
> This patch caused some interesting confusion for me today.
>   error: bug in the test script: test_cmp 'r2/.git/HEAD' missing
> which was somewhat unhelpful (or at least less helpful than a regular
> test failure). The test in question does this:
>         test_cmp r0/.git/HEAD r2/.git/HEAD &&
> and expects to fail if an earlier step didn't correctly create r2. Is it
> a bug or misuse of test_cmp for it to do so? I could see an argument
> that it is, but I'm also not sure if there's a convenient alternative.

I can see the argument going both ways as to whether it's a misuse of
'test_cmp'.

> The best I could come up with is:
>
>   test_path_is_file r2/.git/HEAD &&
>   test_cmp r0/.git/HEAD r2/.git/HEAD
>
> which isn't that great.

Ævar ran into the same issue recently[1] and came up with the same
workaround. Despite its good intention (trying to catch bugs in
'test_expect_failure' tests), this change[2] doesn't seem to have
caught any genuine bugs (it wouldn't even have caught the bug which
served as its inspiration[3]), but has nevertheless caused a couple
hiccups already. As such, I would not be opposed to seeing the change
reverted.

[1]: https://lore.kernel.org/git/20200921104000.2304-15-avarab@gmail.com/
[2]: https://lore.kernel.org/git/20200809060810.31370-1-sunshine@sunshineco.com/
[3]: https://lore.kernel.org/git/7f408b7d4069403b969d334f4940ebf87f1dc797.1596906081.git.gitgitgadget@gmail.com/

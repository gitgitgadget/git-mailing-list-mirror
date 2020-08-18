Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC61C433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 16:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E793020786
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 16:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgHRQwS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:52:18 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:36519 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgHRQwR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 12:52:17 -0400
Received: by mail-ej1-f53.google.com with SMTP id kq25so22905574ejb.3
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 09:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iOW+9V/SF92aG/b7NFkcqCbztAL4e/6v+bVvoHTe688=;
        b=G3Qsm6LSDygvMOHxMqfZIZTqid4Kaop6EGWj8GlSpEh22ztU89CzioksojpHvL6984
         hfAkJhcVj/1YFPZYGknOZgpqEdMa2QVO+DGxN5joZ43ReVwEqBcAXBonhHEHwVhZYlN/
         jZZsf48VVLW7d0fGlDNp8MY7mvgsZyPOnVTkKFEnkpr8HPVMd9d67VUAEfnPAyjTKuNc
         1acyWX14PwYcXD2g7K1uljI0TrytaxRbo0Zx6EX+BPCY5RgfYwWtOV5S/iYQkdnuJq8e
         72xwV/oFY7cfGZ3XibxXOw9WLe9jppYgXxsR5048bTVpu9rq0cAoNI8Ke3LuTpShSQS4
         29Ng==
X-Gm-Message-State: AOAM533q5w/ShwKHzoxqwDYSTI/U+PD5d5bWsla+fmIgi+1NlVk0Hkdj
        pxdvOW+VSdHtFbp5BJBR4C0UcNX+sgqLHxQ0txE=
X-Google-Smtp-Source: ABdhPJzr9hxnlAYbpQUSef5HHbH+W+N7acAc+/xd4OToe+VguHsi4ceeIDsZ5uNcAl7LfdDngM2ZsPtoxBpt2zgqH94=
X-Received: by 2002:a17:907:b0b:: with SMTP id h11mr22229417ejl.371.1597769534692;
 Tue, 18 Aug 2020 09:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAAUOv8jP00_W6=qFBWL1RpV0Dd1Fh1k19PQ33ycBnwVMLfRypA@mail.gmail.com>
In-Reply-To: <CAAUOv8jP00_W6=qFBWL1RpV0Dd1Fh1k19PQ33ycBnwVMLfRypA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 18 Aug 2020 12:52:03 -0400
Message-ID: <CAPig+cRF=PXWTgOzxAsMQ=bSUPnsORBKWUTk38BCvMSVzS=KJw@mail.gmail.com>
Subject: Re: [NEW] Git
To:     Gopal Yadav <gopunop@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 18, 2020 at 8:23 AM Gopal Yadav <gopunop@gmail.com> wrote:
> I am new to git and have submitted a microproject to get familiar with
> the process of submitting patches. Would further like to work on
> resolving this issue https://github.com/gitgitgadget/git/issues/353
>
> Some questions regarding that:
> What is meant by skipping evaluation of lazy prereq?

If, in order to run successfully, a test requires a certain facility
or resource which may or may not be present on a particular system, it
can signal that requirement like this:

    test_expect_success PERL 'test title' '
        test body
    '

where PERL is the prerequisite. If Perl is not available on the
platform, then the test won't be run at all. Determining whether a
prerequisite is met can be done actively or lazily. If actively, then
the determination is done unconditionally for either all test scripts
or all tests in a script, which penalizes tests which don't even care
about a particular prerequisite. If done lazily, then the
determination is done only the first time some particular test needs
to know the answer.

Issue #353 is saying that if we know that we are skipping a test
anyhow due to --run= or GIT_SKIP_TESTS, then there is no point
checking the test's prerequisites (lazy or not). The fact that the
prerequisites are being checked even for tests which we know will be
skipped is wasteful.

> Does it mean that test_lazy_prereq() and test_run_lazy_prereq()
> functions should be skipped in tests which are instructed to be
> skipped by --run?
>
> So for example if we run $sh t0001-init.sh --run='1-33'
> Then current behaviour allows test_lazy_prereq() at line 319 to execute.
> But since we are not running tests past the 33rd test we don't want
> test_lazy_prereq() to be executed.
> Is this the problem statement?

No. test_lazy_prereq() is merely the function which defines how a lazy
prerequisites should be determined when the answer about the
prerequisite is actually needed. What #353 is saying is to not perform
the actual determination if a test which requires it isn't going to be
run.

Fixing the issue might be as simple as moving the test_verify_prereq()
call (and related "export") inside the 'if ! test_skip "$@"'
conditional in the test_expect_success() and test_expect_failure()
functions.

> I know the issue talks about something related to chains but I am
> thinking of starting by resolving the lazy prereq task first.

I took a look at the &&-chain logic and, as far as I can tell by both
direct inspection and by experimentation, the detection of broken
&&-chains is _not_ performed for tests which are being skipped. So, I
think that portion of #353 is just wrong.

Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FB7C433E0
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 08:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE2F206C0
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 08:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgHIItV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Aug 2020 04:49:21 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:38907 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgHIItV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Aug 2020 04:49:21 -0400
Received: by mail-wr1-f45.google.com with SMTP id a14so5406722wra.5
        for <git@vger.kernel.org>; Sun, 09 Aug 2020 01:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wfuHKZ2ihAiDzoxab7vSyQwmVq00J6CdRoQETHakpI=;
        b=Axda53XHeMEDM3WrP3fmmNjXRgG2kbdwxEVsOIIrZqHYzV12ufIY3Kyg0adn04HMXR
         ltrOWbx0X1B74S62dyDpGueuCLOcLle8yskGUzn3k+l9gCHK8saKWxolxuzZfUa1Krak
         BTYrj43GzBnWau4sLOBZ2xbsNEnC03EN0+OaSaCpvkI1qAqZFFGv/kd8uToRFIDUlCzr
         +J76b/hW3oMDsP624sqjzscvhk0fnssAZmcCyrnh6CcPlrHT/vb30Uhv1RrgIdmlEU0z
         vy+3QvlF8EBtBzYsYCj1C/6ZRmC5k3FBxjn5eKXIbWTXp50bBVSzCDiUFQF1HTY8jzd3
         w+9Q==
X-Gm-Message-State: AOAM531+CWatHyzlY0k5PBLVvttv4x1keB8E9oWqp6da9cp5rpDDvMt/
        d3aQFzuFwuZR+H+p4/yDYQyTmyQD2Wd6edVymt8=
X-Google-Smtp-Source: ABdhPJxEzNGaKJglQf9HiU1vEIuEv2LRaETrBMghqcy2nmcAnUMXzikZRSp6Po8Z9dis+fCpTbKRGWJHBeIvY+oRxWg=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr20937920wrs.226.1596962960015;
 Sun, 09 Aug 2020 01:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200809060810.31370-1-sunshine@sunshineco.com> <20200809083227.GA11219@konoha>
In-Reply-To: <20200809083227.GA11219@konoha>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 9 Aug 2020 04:49:09 -0400
Message-ID: <CAPig+cT3Mwy6gJE3=5P78xwmFSp+gJYazboZtrkpFy7v8X7K2A@mail.gmail.com>
Subject: Re: [PATCH] test_cmp: diagnose incorrect arguments
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 9, 2020 at 4:32 AM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
> > +       test -e "$1" || BUG "test_cmp 'expect' file missing"
> > +       test -e "$2" || BUG "test_cmp 'actual' file missing"
>
> I reckon we could be just a little bit more precise here by bugging out
> with the exact filename which is missing instead of 'expect' or 'actual'
> so that the user has more idea as to what happened. What do you think?

Good idea. I'm planning on re-rolling anyhow since Junio pointed out
privately that some callers use "-" (meaning standard input) as one of
the arguments to test_cmp(), so that case ought to be taken into
account, as well.

> BTW, I looked up the 'test_i18ncmp' function as well and if we have
> this small loophole you mentioned above, I think maybe we could make a
> similar fix for it too. What I mean is that in case of absence of the
> required locale, it should error out kind of like what we did above
>
>   BUG "locale missing"
>
> so that the user it is clear to the user what was the failure point.

Sorry, I'm not really sure what you are suggesting, but I'm guessing
that you're misunderstanding of the purpose of test_i18ncmp:

    test_i18ncmp () {
        ! test_have_prereq C_LOCALE_OUTPUT || test_cmp "$@"
    }

which says that test_cmp() should only be called if the current locale
is "C"; in all other cases, we specifically do not want test_cmp() to
be called and instead simply pretend that the test passed.

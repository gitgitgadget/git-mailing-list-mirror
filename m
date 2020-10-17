Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E919C433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 06:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBDE420720
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 06:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436898AbgJQGHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 02:07:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43255 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436893AbgJQGG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 02:06:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id dn5so4903151edb.10
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 23:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98fhQhbJlG5NQX/7ciAK9jyn44ss0n4Xz/NNGZP1nPE=;
        b=B0Zfo9deVEW1LnjHPo9RXB6uji6XqduUrqXdDkMIVFSYBX1lc3ZbjaFINBWD2wIGgU
         hHstsiEPmg51MRsMXyTKv3l+ilYNZeLMz9++g51mbH9Es63bOSXoVNvJuYnrN9QMeeS/
         zpFeYxsipdQzxrv1UEF6jh9X5rTwWqzNTyYgt2NluOpQMqU4jM/wH5vPZjvUNR2YxxUa
         zOLXCuEDVeQidcMu1rz57EVerM0c6cqH16cf1+opz+0AAWXtCmFpj3nClA9SdI8ltzEq
         vgXIHyC0+392qcfYQuMRPEGHUkxoGmdZ5SQfUPIfYcVTf4NYK7ZvNlVrLQvev+Jvvj1P
         2Szw==
X-Gm-Message-State: AOAM530pK0Pcref19FYc1ahGneF/5Z+wsDe4e8JPmhoQnP+jtqBh+2js
        BHbA//aNdl6fF/MkO2qrlDd5gWmusgWMC5Rm08M=
X-Google-Smtp-Source: ABdhPJzyW963RB5RCyltwEmsiOtnQOtOejbi2CWgY8ljX5rVVzRb4GBNP7ISmkfUQtcklGQCmwBE9B7WTItvOiYrLnw=
X-Received: by 2002:aa7:c746:: with SMTP id c6mr7899191eds.221.1602914817413;
 Fri, 16 Oct 2020 23:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200809060810.31370-1-sunshine@sunshineco.com>
 <20200809174209.15466-1-sunshine@sunshineco.com> <20201016001704.GA2937048@coredump.intra.peff.net>
 <CAPig+cSU=1GcQuqZab+0Vff_A-JmD59wEc3RMr3wDojpgRYUuw@mail.gmail.com>
 <xmqqzh4maugq.fsf@gitster.c.googlers.com> <xmqqv9f9ao0v.fsf@gitster.c.googlers.com>
 <xmqqy2k5931k.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2k5931k.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 17 Oct 2020 02:06:46 -0400
Message-ID: <CAPig+cRqnRKUdmwX3K+hbYs8+T0CCpatkPi4T-bu8ofH6jTnNg@mail.gmail.com>
Subject: Re: [PATCH v2] test_cmp: diagnose incorrect arguments
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 16, 2020 at 7:14 PM Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> >  test_cmp() {
> > -     test $# -eq 2 || BUG "test_cmp requires two arguments"
> > -     if ! eval "$GIT_TEST_CMP" '"$@"'
>
> Looking at this again, I think we could keep the "we should have two
> arguments, no more than, no less than, but exactly two".  But I think
> those who write new tests are working to eventually make them pass,
> so hopefully they'll notice and investigate test_cmp that yields false
> anyway, I guess.

The purpose of the change in question[1] was specifically to help
catch bugs in the test_expect_failure() case, which is quite rare in
the Git test suite (and hopefully becomes rarer over time). So, I
think it's fine to revert the change fully, including the 2-argument
check since, as you say, test writers are normally trying to make
their tests pass, and the 2-argument check doesn't provide much, if
any, value for the test_expect_success() case.

[1]: d572f52a64 (test_cmp: diagnose incorrect arguments, 2020-08-09)

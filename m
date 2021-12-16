Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFA0C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 15:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbhLPPsC convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 16 Dec 2021 10:48:02 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41]:45705 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbhLPPr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 10:47:58 -0500
Received: by mail-pj1-f41.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so23029508pjq.4
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 07:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=62pEJR3TD0me6oqwHfYcVATYzqM1AaANQwpAQP2yWH8=;
        b=6iWgH1eVXGdUykbD0e3uFjYwhH2PFzpvBiUN1IA+EnqRQITLxU7sJOCVS8DQk31fP7
         mPgEOKtXp/78zJQRSDnHdbqL/RxmHiXnsaAqYRZNJ2QG8rzVmEc09taaqDigxqss6JJ/
         2WW8ogfBHpt5F1pVAoPx+stNgWaIy5LZZjdoCCmJNTHyxmVNx+fJW1fa3W/v2/Uzzuq8
         yVmr9q2bGFq8GJRfH1oYMQ5BraPHZTKhKiO4f2zaZfzn5w2PYkDyLBUv8DMdhln4Wdwi
         gdWjPcfH6rCCJ/8Uo/wNKAseRqwa00xgppF92YgHRC1NI6P/bTcTbUJ6zK/OjgeRslsH
         d9UQ==
X-Gm-Message-State: AOAM530Mjn0XwfUfDhT7i3nM8MdGwAYR2mg/+Fh75LZl9/XsfQbhNd5/
        qe06E48JpUelyiOa+0gnxK6Ag6PpLlTKy0I7v1Q=
X-Google-Smtp-Source: ABdhPJweWdwQV8CwXh2RC4j9ICsoBdjuQlfPVLg+XvUDVi/WKizHdz5B2DFqg1pw0gavSOsuBiYzQAcL+RMOedTWxiE=
X-Received: by 2002:a17:903:1247:b0:143:b9b9:52a2 with SMTP id
 u7-20020a170903124700b00143b9b952a2mr17135520plh.35.1639669677571; Thu, 16
 Dec 2021 07:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20211213063059.19424-1-sunshine@sunshineco.com>
 <20211213063059.19424-6-sunshine@sunshineco.com> <20211213102224.y5psbojmivlxe5px@fs>
 <CAPig+cSKn6wdPKc=b8Xjqy5D=bVdu6FQtYKJuwN2VoV7pEEgHw@mail.gmail.com>
 <20211213154327.pmhopjbdlkz7dgjh@fs> <211216.86zgp0adls.gmgdl@evledraar.gmail.com>
In-Reply-To: <211216.86zgp0adls.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 16 Dec 2021 10:47:46 -0500
Message-ID: <CAPig+cT_38g51RtcMAf184jjB3Zr67gv=rO0oEY1DG7asnyUJg@mail.gmail.com>
Subject: Re: [PATCH 05/15] t/Makefile: optimize chainlint self-test
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 16, 2021 at 8:22 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> > On 13.12.2021 09:27, Eric Sunshine wrote:
> >>It's not seen in the patch context, but earlier in the file we have:
> >>
> >>    CHAINLINTTESTS = $(sort $(...,$(wildcard chainlint/*.test)))
> >>
> >>which provides stability via `sort`, thus ensures that the order of
> >>the ".test" and ".expect" match.
> >>
> >>I think that addresses your concern (unless I misunderstand your observation).
>
> But just FWIW I think both of you are wrong about the potenital for a
> ".test" and ".expect" bug here.
>
> I.e. yes the CHAINLINTTESTS variable is sorted:
>
> But in Eric's patch we just have this relevant to this concern of
> (paraphrased) "would it not be sorted break it?":
>
>         +       sed -e '/^# LINT: /d' $(patsubst %,chainlint/%.test,$(CHAINLINTTESTS)) >'$(CHAINLINTTMP_SQ)'/tests && \
>         +       cat $(patsubst %,chainlint/%.expect,$(CHAINLINTTESTS)) >'$(CHAINLINTTMP_SQ)'/expect && \
>
> So it doesn't matter if it's sorted our not.
>
> I.e. we've got {A,B,C}.{test,expect} files in a directory, and we're
> constructing a "A.test" and "A.expect" via "$(patsubst)".
>
> So if it's "A B C", "C B A", "A C B" etc. won't matter. We'll always get
> ".test" files corresponding to ".expect".

Yes, sorry, I meant to say something along these lines in my reply, in
addition to mentioning `sort`, but forgot. Taking a look at this
again, though, makes me wonder if the CHAINLINTTESTS assignment should
be done with `:=` rather than `=` (unless GNU make is smart enough to
only invoke the `wildcard` operation only once, in which case it
wouldn't particularly matter).

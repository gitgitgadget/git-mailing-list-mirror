Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D2FC433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 19:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B922D206E9
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 19:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgHBTLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 15:11:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43903 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgHBTLC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 15:11:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id a15so32234519wrh.10
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 12:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1V7qFLT5dPv65IuA07nbpaporINbwqTfbHwYygd/aXo=;
        b=snrFOpP9VRDtrWqBYWklYVCS0X7G3SBeDjwJQxC8v/el/eYi7akduEaOERggWGwgr1
         jKcm7c0N35ekJJ3mXEzbDQ3pN92uBv0ZkuAU8qsiawhGIpEnKky8LXwvUV7+8qrdHZyS
         Qacip9CAshbyrwFMWZNsXK8cDdbgBBAuuRhIQ73hzUMAOwwosSiU5s0lKWFZQP4SbtiY
         FjApq1oJ5fqtcNF5Mjhd98taYI3t0/UzIoCtDtvGtID5s9aInMdqz7n6UHuDzNZVpwSR
         KRk02WTlJIzijAKym7O8yUH7DovW2CMgZ+tbUztWwa+fwlr0NoEZJE2coVRN3Z0/Rwkx
         pDIQ==
X-Gm-Message-State: AOAM533WxsImFRd0L4iGQojBLDPmmI3ZyHe4yyXKmnsmDhA+ZaI0yFEz
        dJtb8y1VeVZ94S9Nfe69GTSdFpS0gWi05d6IiC3/3A0o
X-Google-Smtp-Source: ABdhPJyTM80Bqr4J8I58FWfCL7h2IM0sHdVzDqtCQ4YDTKdUqdoznNiFWdgDSeottLOIWkc3/jx0ks8CiHV+5W843H8=
X-Received: by 2002:adf:b352:: with SMTP id k18mr12531495wrd.386.1596395460442;
 Sun, 02 Aug 2020 12:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.825.git.git.1596349986.gitgitgadget@gmail.com> <361911817559104672d273e199221e8367e8d595.1596349986.git.gitgitgadget@gmail.com>
In-Reply-To: <361911817559104672d273e199221e8367e8d595.1596349986.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 2 Aug 2020 15:10:49 -0400
Message-ID: <CAPig+cRB-tQEtgWpoHfZD1+Jg+SbKnUhsR4hBxWxxjQ_9A1YLw@mail.gmail.com>
Subject: Re: [PATCH 1/4] t6038: make tests fail for the right reason
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 2, 2020 at 2:33 AM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> t6038 had a pair of tests that were expected to fail, but weren't
> failing for the expected reason.  Both were meant to do a merge that
> could be done cleanly after renormalization, but were supposed to fail
> for lack of renormalization.  Unfortunately, both tests has staged

s/has/had/
...or...
s/has/have/

> changes, and checkout -m would abort due to the presence of those staged
> changes before even attempting a merge.
>
> Fix this first issue by utilizing git-restore instead of git-checkout,
> so that the index is left alone and just the working directory gets the
> changes we want.
>
> However, there is a second issue with these tests.  Technically, they
> just wanted to verify that after renormalization, no conflicts would be
> present.  This could have been checked for by grepping for a lack of
> conflict markers, but the test instead tried to compare the working
> directory files to an expected result.  Unfortunately, the setting of
> "text=auto" without setting core.eol to any value meant that the content
> of the file (in particular, the line endings) would be
> platform-dependent and the tests could only pass on some platforms.
> Replace the existing comparison with a call to 'git diff --no-index
> --ignore-cr-at-eol' to verify that the contents, other than possible
> carriage returns in the file, match the expected results and in
> particular that the file has no conflicts from the checkout -m
> operation.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

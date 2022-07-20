Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B9CC433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 00:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiGTAJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 20:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiGTAJR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 20:09:17 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D08C61B19
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 17:09:15 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id j67so6871833ybb.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 17:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njILhqDrdwBDqgGsSmWqgaSmBoKJVD0wLW9RHE6Mzp4=;
        b=mv/GL7i21YYbhzUw7fLpvGcYDg2dBYc7HC4d+u3h7szep9s9gBqOXWzF78X6YcqEko
         5KdXHYBr7qDgMy4UoGlXGjBVsgaJAveDbrcT7DLOMIeXFCzhzVcuf5semBooiN6ywuMO
         gZwkm793QgDJTtTFADZ9NWL9wX5gHokeaOrI/3VJQxp0aySlLXjmZXspJmLNx7OdDt/t
         TtrtPu31q4qE2DZ83xlNmVb2VKaJQrqp4CqGoT7o1B9f7Z4tz/5oMrrIj3USsw8E8dM8
         ZttzMbUcHRxh5W2UVibIaN4DssejxSwWVH+Qqt0L2PWnO8iPwU+20HK6kGqQo6BaOjTZ
         pPtQ==
X-Gm-Message-State: AJIora/OBaaFTz/G70LSCePkN+sN0KEijpnFVbrawLKafCc/opXNkEvC
        J61qCdErmQGmjphUieq6yjNqhdgz2JKKWBTUqLU=
X-Google-Smtp-Source: AGRyM1tQFLK1hTmUvJgSl2o9iAb3qyxqO+pA0LwORyiiln7OJE82USf2VH3DvnbBnTZePb7J6/Wj773BbAirFIJ/frc=
X-Received: by 2002:a25:2397:0:b0:670:8d4a:a1d8 with SMTP id
 j145-20020a252397000000b006708d4aa1d8mr3535737ybj.462.1658275754336; Tue, 19
 Jul 2022 17:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
 <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com> <0783b48c121fe74051c13e7d9118d1a5b7cb9aa9.1655621424.git.gitgitgadget@gmail.com>
 <xmqqzgh466ia.fsf@gitster.g>
In-Reply-To: <xmqqzgh466ia.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 19 Jul 2022 20:09:03 -0400
Message-ID: <CAPig+cTqN6nVRGhm-bG6F2RGACAKi7RYa4yp_qqsp7F5pWVaBA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] merge: do not exit restore_state() prematurely
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[replying to Junio's email since I don't have the original available...]

On Tue, Jul 19, 2022 at 7:22 PM Junio C Hamano <gitster@pobox.com> wrote:
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > +     for b in branch1 branch2 branch3
> > +     do
> > +             git checkout -b $b main &&
> > +             test_commit --no-tag "Change on $b" base $b
> > +     done &&

Let's break out of the loop with `|| return 1` if something in the
loop body fails.

    for b in branch1 branch2 branch3
    do
        git checkout -b $b main &&
        test_commit --no-tag "Change on $b" base $b || return 1
    done &&

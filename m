Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D446C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 03:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiBPDRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 22:17:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbiBPDRh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 22:17:37 -0500
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB57B65FC
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 19:17:25 -0800 (PST)
Received: by mail-pl1-f174.google.com with SMTP id w20so933454plq.12
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 19:17:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zQeZc0/MNbNdAcXXlNydHIKgaddDvFcQgXYBxFW2Rk=;
        b=OlIUEcMEFl9YfbPp9eXBA4VV7Y4cq/wI0bkdkWyhfaCWfRfvRNqP30zb+8EiPiLTOB
         2tfItO8y6cQZTFZz+TBg1+GfjPgoQdxOQDU33XIBFL8eqKK60V5u/586PVDmorNCaNWn
         PV1Dvym4iAzHW0CxoH8hHOSS0Q2W+NXXpE6Kpf7u3MWYH04knoUJqZs+yT9ckqYh55sU
         YK1HYZqzDwhmjxJlgUC1oNHBdhzjF8cJDCvUNQzwESxMe6F3cEQNCczLYEeCkYscg5H1
         61acLwFmWkcoJhJt0vnmT7ugZbZQwBcJyzRs88XjijwC3m5FFW4wOgzLm0ts9wNbfKuP
         Xnyg==
X-Gm-Message-State: AOAM5314zS4nQuq2/+JtEpoAh8JT35Z7YiGg5g/+0d/NZhATtGe8sTbW
        nnJMuBB1haGQ/zZfk6HKmfVQtq292WCHxeSXkvY=
X-Google-Smtp-Source: ABdhPJxpxZpC2rkyvEAHZOvFP9VxY4JFpYruvc6cfp3AaYJay1ocy4bOyYPz5TkF+HNm9PASTLCeAXxGtNSa/BBSAJ8=
X-Received: by 2002:a17:90a:ead8:b0:1b9:f17d:4454 with SMTP id
 ev24-20020a17090aead800b001b9f17d4454mr634783pjb.104.1644981444896; Tue, 15
 Feb 2022 19:17:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com>
 <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com> <aebaf7e3fe1d4448037d2caf03f3de393908ff9a.1644972810.git.gitgitgadget@gmail.com>
 <xmqqfsojy50b.fsf@gitster.g> <BE7471F8-0141-49ED-A34B-04D69BE18D96@gmail.com> <xmqq4k4zwm65.fsf@gitster.g>
In-Reply-To: <xmqq4k4zwm65.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 15 Feb 2022 22:17:13 -0500
Message-ID: <CAPig+cSEO407rp3_ufS_DV1XJnkkb++6MP8UJhpj5aQP04gZ-Q@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] cat-file: add --batch-command mode
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai <johncai86@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 15, 2022 at 10:00 PM Junio C Hamano <gitster@pobox.com> wrote:
> John Cai <johncai86@gmail.com> writes:
> > Yeah, this is what I had before but there was discussion about
> > separation of concerns in [1]. But perhaps it's preferable
> > compared to passing a pointer to nr.
>
> Oh, I see.
>
> I do not see any issue with separation of concerns here, actually.
>
> As long as "dispatch_calls() consumes all the cmd[] before it
> returns to the caller" is clearly understood between the function
> and its caller(s) [*], clearing of "nr" the caller has is entirely
> caller's problem.  It becomes needed only because this caller
> decides to reuse cmd[] array.
>
>         Side note: you do have a comment before the function to tell
>         what to expect out of the helper for its callers, right?

True, it is the caller's problem due to reusing the array, though
dispatch_calls() freeing `line` muddies things slightly. A comment
before the function could indeed be helpful, especially letting
callers know that `line` is being freed.

It probably also would be wise to replace the free() call with
FREE_AND_NULL() in order to address the dangling-pointer concern.

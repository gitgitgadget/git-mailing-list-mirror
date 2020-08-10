Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6EEC433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E170206B5
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgHJVr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:47:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39549 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgHJVr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:47:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id g75so491729wme.4
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4WBCOT0UXzWpjVXu0AXpMhRYq3/mxIUEyg2JbVzpMA=;
        b=Hlu034y6+uoB/TJNKZv2/SIH6Ae0Np+pX9lbSWRx7ByL1yyc73IgFpKdcXoN5kWWDx
         3Ebb7eigwV+sX9AGPEK7zxHgsvIPmyir7wIcWI4tL2W+/k42lAQYjzWU5CFKI/JBMsJk
         ZJB6Lh8euWSyQ2MYGm5K3QIjuTWF5tO58StJU9JKta2GfoV0m8ArYzxd4+TrbdM6gHTT
         jYEvXFMFjfRGrG1L07wa7+kbnq2rhkCEaFx29gGfyF08gYXJ1oVxS6DPnXi4Bu+bvPti
         f10F0tXHxsKG7xIB53OEOdOmp542dtTuznEpPAaEdlHKtwDUBTcsNevgAVlsSEZscGF7
         44zA==
X-Gm-Message-State: AOAM531d0txHHb1gBdzGyZd8fwzViJz0lyUIb6bsBA5uQWwwOHS/a6pV
        fh+Gh7qm8T+r3WYQ4kux6b9RzkJN+A2uqPESZZI=
X-Google-Smtp-Source: ABdhPJxICpyiWDYIxu/FfbKBmLLQ0Zd1ngS3LWaSi+XBiuN9HR8Fv1eKVUjGwFWvB6n07u7cowQYKmEX9dxgaaWOrIc=
X-Received: by 2002:a1c:4e0d:: with SMTP id g13mr1036234wmh.177.1597096077116;
 Mon, 10 Aug 2020 14:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200808075323.36041-1-ray@ameretat.dev> <20200810085343.43717-1-ray@ameretat.dev>
 <CAPig+cSn_wrBuMKzoUZ720Hy-Y9RuPpJtmZ1mr--cnyAP866-Q@mail.gmail.com>
In-Reply-To: <CAPig+cSn_wrBuMKzoUZ720Hy-Y9RuPpJtmZ1mr--cnyAP866-Q@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 10 Aug 2020 17:47:46 -0400
Message-ID: <CAPig+cQCMG3Dx99LWTOAe8wZ2ocdikQAzdDS=-APfYE9HVn+=A@mail.gmail.com>
Subject: Re: [PATCH] t4069: test diff behavior with i-t-a paths
To:     "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 10, 2020 at 12:23 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> To tighten this test, perhaps it makes sense to take a different
> approach and check the exact output rather than merely grepping for a
> particular string. In other words, something like this might be better
> (typed in email, so untested):
>
>     cat >expect <<-\EOF &&
>     diff --git a/test-file b/test-file
>     index HEX..HEX HEX
>     --- a/test-file
>     +++ b/test-file
>     EOF
>     cat blueprint >test-file &&
>     git diff --ita-visible-in-index -- test-file >raw &&
>     sed "s/[0-9a-f][0-9a-f]*/HEX/g' raw >actual &&
>     test_cmp expect actual

This can be improved by taking advantage of the OID_REGEX variable
defined by the test suite for matching an OID. So something like this
would be even better:

    cat >expect <<-\EOF &&
    diff --git a/test-file b/test-file
    index OID..OID 100644
    --- a/test-file
    +++ b/test-file
    EOF
    cat blueprint >test-file &&
    git diff --ita-visible-in-index -- test-file >raw &&
    sed "s/$OID_REGEX/OID/g" raw >actual &&
    test_cmp expect actual

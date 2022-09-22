Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CECC6FA8B
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 06:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiIVGk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 02:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiIVGkp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 02:40:45 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D96B6D47
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 23:40:40 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id a67so11370004ybb.3
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 23:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=I7eOyhyGEatVYrEmcOZbD8woTLkTg71wSz7FIjjf9/U=;
        b=h3sci6a1ZPYKo2qBL/IuQhVF/3FMQ/BaggEUJGNSqINDCaXhpHZUryb9GTW0AiH8Tf
         KUvR1+aqUj/IUwQu/UV35Jt84RmLACRMKQ3ulD9a/xWr9sv0d2m38LDkcWHDYsyAZCo3
         Oaas8dnpsBhMfskFTvkPvUoxPWSuyLrZi+Gd+gOl6gr6chs/txgPfT4sABhxk/7VTfKn
         3EwRt0Cs55/YOaYNdnd13MTLPVF4+hDpOq2kMaB6wMqvkBbd7vPGpnvmZFcVznsZ8kkA
         xH8IamqD21IhGJ062B9duGxVW0l5GXqn+vXJ3zTXyx7u0nobpAAZM0H0rt29MxtEkfe7
         8Qmg==
X-Gm-Message-State: ACrzQf2PldjiyrbGZn91JN5uwzJ4SFCH3tFLv3w+5EatUOHZIDFAt9Q0
        H91215TllukmePNZ52rE4JgRyLP3F7dE3XHKfJJSl0sX7RwLbw==
X-Google-Smtp-Source: AMsMyM7IaiXH1Langa9Fi5TxZ6mZWAcLxIgTRqI7f6BwSUjmizr6dMatn9l+nnp93uCwegwXX2UAi2FWrgT77Y5aNcw=
X-Received: by 2002:a05:6902:1201:b0:6ae:eeee:a6d2 with SMTP id
 s1-20020a056902120100b006aeeeeea6d2mr2116871ybu.462.1663828839507; Wed, 21
 Sep 2022 23:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <YyvzIQL9H9aTYNch@coredump.intra.peff.net> <YyvzVdfQVdysvMp2@coredump.intra.peff.net>
 <CAPig+cTEF=jBoW07_eLQ_BAWxULfWtehVa-JbJKpS+8rPenSiQ@mail.gmail.com>
 <Yyv+GjjauvvcX3M1@coredump.intra.peff.net> <CAPig+cQxSwz2cZFLNwg_rJ==M5=pxMVvwgbDFV1r=v+rzbCuNg@mail.gmail.com>
 <YywCImASth7I0Wx2@coredump.intra.peff.net>
In-Reply-To: <YywCImASth7I0Wx2@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 22 Sep 2022 02:40:28 -0400
Message-ID: <CAPig+cSwYYD6U0bgHL+8pp+j8wOPRhVc6o6LdkP5eR=vOOy6HQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] clone: allow "--bare" with "-o"
To:     Jeff King <peff@peff.net>
Cc:     "John A. Leuenhagen" <john@zlima12.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2022 at 2:35 AM Jeff King <peff@peff.net> wrote:
> On Thu, Sep 22, 2022 at 02:26:09AM -0400, Eric Sunshine wrote:
> > I was thinking, in particular, about this snippet from t/test-lib.sh:
> >
> >     # git sees Windows-style pwd
> >     pwd () {
> >         builtin pwd -W
> >     }
> >
> > If that's inherited by the subshell used in the test, then I suppose
> > all is okay, though I think it would not be inherited.
>
> I think it's OK. $() is itself a subshell, and you can find many calls
> to FOO=$(pwd) or similar. And in general, functions are inherited in
> subshells:
>
>   $ sh -c 'foo() { echo bar; }; (cd .. && foo)'
>   bar
>
> They'd have to be or many things in our test suite would break, since we
> use test_must_fail, etc, inside subshells.

Yep, thanks for the sanity dose. For some reason, my brain was
off-kilter, thinking that it was running a shell afresh, not just
using a subshell.

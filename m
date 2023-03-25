Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143CDC6FD1F
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 06:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjCYGy7 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 25 Mar 2023 02:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjCYGy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 02:54:58 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DADEB4C
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 23:54:57 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso3635156pjb.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 23:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679727297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdPjo4wck372Q04yJDfti6NwssVrkIHqVB4ai5Q6vpQ=;
        b=QbJFeVLTWd11rB0/VnzHUcufPZmedq/OtE2Mn/m3+qH30A9H7/Fe3yKrtoVT9hL/UH
         T7ENf9We9kYl5FXHgd7KrIbHSzMu3cYF9K/kwt1PaWmj24hbynwLUjQZwiz1PPGhxTKY
         RilG25OyoXzH04pw7A9tnppoAzkJwT4czC3z2XUEFdZNwfaIunCTj2o8rSTR9QWyQA71
         poTR3wtWime6siKGKcCmOgBK+LDG4EnoTzBzEE/2+dRrD3Z4C0aXk7Z1D+t7IK7VUizI
         zirsUHnnocGXz49x5SH/bvquJQ5BB+d3ayuOiNLHY2uOzsFm1+m1mp3iFqehrYHQh2Aq
         OdpA==
X-Gm-Message-State: AAQBX9cM3bhG4hO/80/QLn0a+5PIIJ7pc8+1jb3BGnIY/ewz6h7wNn4K
        SYPjTnvdviO4AwC52dsBGtv5wqfKdizAlFsOykA=
X-Google-Smtp-Source: AKy350Y7Q989Ip/tRmCYL/C/gz7lafi84alUMPLm+bmy1Z2oU+Gt5emhvio5Uk8inpa5HlroFCpQSWU7vYjIM2Hp+ew=
X-Received: by 2002:a17:902:dacc:b0:19a:7bd4:5b0d with SMTP id
 q12-20020a170902dacc00b0019a7bd45b0dmr1760611plx.8.1679727297009; Fri, 24 Mar
 2023 23:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <13accf6f99d367d137eefd02e3f6bf05bf099e00.1679328580.git.phillip.wood@dunelm.org.uk>
 <3714ba2f6528c38eb9c438126316a08b0cefca7c.1679696180.git.git@grubix.eu> <20230325063731.GB562387@coredump.intra.peff.net>
In-Reply-To: <20230325063731.GB562387@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 25 Mar 2023 02:54:45 -0400
Message-ID: <CAPig+cT9zjP++ECkTMjh33gzWyh_ho6n8_XYkXTHxnuGiDbnow@mail.gmail.com>
Subject: Re: [PATCH] t3070: make chain lint tester happy
To:     Jeff King <peff@peff.net>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2023 at 2:38 AM Jeff King <peff@peff.net> wrote:
> On Fri, Mar 24, 2023 at 11:17:11PM +0100, Michael J Gruber wrote:
> > 1f2e05f0b7 ("wildmatch: fix exponential behavior", 2023-03-20)
> > introduced a new test with a background process. Backgrounding
> > necessarily gives a result of 0, so that a seemingly broken && chain is
> > not really broken.
> >
> > Adjust t3070 slightly so that our chain list test recognizes the

s/list/lint/

> > construct for what it is and does not raise a false positive.
>
> Good catch. While I agree that there's no missed exit code here, I'd say
> that this is more than just a false positive. If there were any lines
> above the "&", like:
>
>   foo &&
>   bar &
>   pid=$! &&
>   ...etc...
>
> then we'd be losing the exit value of "foo". It's OK here because the
> backgrounded command is the first line of the test, but it definitely
> violates our guidelines.

This is one of a few cases chainlint recognizes specially by
suppressing the complaint about the broken &&-chain since "&" can
never fail. The fact that a broken &&-chain prior to the "&" would be
missed was considered a reasonable tradeoff rather than complaining
and asking the test author to jump through hoops just to pacify the
linter. So, there are a few known cases when a broken &&-chain is
allowed to slip through, and tightening linting to disallow those
cases would require too many churn-like changes with little or no
benefit.

> Which isn't to say that your patch needs to do anything differently. I
> just wondered if it meant we should be improving the chain linter, but I
> think it is doing the right thing to alert us here.

Now it gets confusing (for me, at least).

> > +     {
> > +             test-tool wildmatch wildmatch \
> > +                     aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab \
> > +                     "*a*a*a*a*a*a*a*a*a*a*a*a*a*a*a*a" &
> > +             pid=$!
> > +     } &&
>
> This looks like the right solution. I do wonder how Phillip managed to
> miss it, though, since the test script complains loudly.

I am unable to reproduce any linting errors when running this script
through chainlint, which is why I was more than a little confused by
this patch when I read it, and I was just about to ask for more
information, such as the actual error message.

Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB14C433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4672072C
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 17:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgJNRqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 13:46:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34397 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgJNRqc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 13:46:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id x1so372322eds.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 10:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wn0kv7b2Db1BZW+UsNSFNYw1fD06/lUqNYdvBceJPw0=;
        b=mPGicdCSRj6o8VpWenierZEA/AgZXZl+tB5YyamUVmP6Jz8/UaiFMUfwEF1FG+rDEx
         RSMv3iHk6LWwO2BEgphlqLBtanrF7SZYIlqDQuO7cVp/ZnMjDKEhqRCA6FYGeIWlEziy
         K8M9EO0jnOb3/NKAzm1anPVn61z6mdn8pcr2TghNNZC3pC9i+HnExLpNd52+KRVIJM24
         pyUtBZZqABQLSD4f7cz1x6RhrHgrBjU7DRBVyr9hp9mb7GjETYuCoBlMY8rjyfyjtpgw
         5cxapTlXduScgZgPqPGs4lf7C8bUqgOT+adqF7Eg1rayC43b9XrcH59g0rhNNGUnboUV
         CWWQ==
X-Gm-Message-State: AOAM530Q7cmKx8VLGtL/JBsEfNYDUeUMacjllw+3XaPNbU2qDsxDwMoY
        9zrcIjMeQXe5OIgBz4Fbz+NpRpWTUqmoBAGFus8=
X-Google-Smtp-Source: ABdhPJwLA1x1+eNKSQjR060GysqweVTYiwpa4nRDTPWg7Zs5GGTXk1eD18OywbpE11VqRygFR/XfoNLOj+DHrswEanI=
X-Received: by 2002:a05:6402:1151:: with SMTP id g17mr44568edw.312.1602697589869;
 Wed, 14 Oct 2020 10:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com> <41e2528e83ba7087c9d21f0b15efed416f1512f8.1602616786.git.gitgitgadget@gmail.com>
 <20201014170413.GB21687@coredump.intra.peff.net>
In-Reply-To: <20201014170413.GB21687@coredump.intra.peff.net>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 14 Oct 2020 10:46:15 -0700
Message-ID: <CAPc5daVa4j5mDvTzCFCX2bLr1qVFLO=P=nSakT+mDG1kqeXa+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] test-lib: allow selecting tests by substring/regex
 with --run
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > @@ -819,9 +821,8 @@ match_test_selector_list () {
> >                       *)
> >                               if expr "z$selector" : "z[0-9]*[^0-9]" >/dev/null
> >                               then
> > -                                     echo "error: $title: invalid non-numeric in test" \
> > -                                             "selector: '$orig_selector'" >&2
> > -                                     exit 1
> > +                                     echo "$title" | grep -q "$selector" && return
> > +                                     continue
> >                               fi
>
> I like that you allow regexes. It's unfortunate that the skip-check
> costs us a process in every test. It may not be that big a deal since we
> only pay it if you use a non-numeric selector. But I wonder if there's
> any reason not to use "expr" here, as well.

If you define the pattern is not regexp but is glob, you can use
case/esac to do this without any forking.

Your expr may well be built-in, though.

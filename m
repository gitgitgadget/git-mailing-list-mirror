Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353AFC433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 01:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1154E600AA
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 01:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhIOB5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 21:57:18 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:40667 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhIOB5R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 21:57:17 -0400
Received: by mail-ej1-f41.google.com with SMTP id o20so2635653ejd.7
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 18:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfeVJ2L0E5imaSfOnWdaLzvezzAM+yyup7zLyDGvqA4=;
        b=OJLaU9obQvti18zsm5kicUkpWGE9caoCH1EyR1Tog4bcHz/OOPROBnEzYWZJnyXrME
         o4ClPFDqMdQq84gl9Q4EasBg40bHzlv5XNEyue3aCz+Cr0L/2G8ffTJKh9hW1OFlXOED
         ffT+E4UtN9hlATMOYJZ5/eHwHxT9+K6hFg1ia39xZWK69hWC3kwly6zT2++ThcmdsC8y
         +kkrrPt+E4R1UXIGTLiVJWTaxs+/FjnAW96MW70FuMKkWh5iQYaXmkFu/frzElKqdrcW
         +rhvc1owtoljq1i/N7LbjFr8VqEVp3gyx2YFZC3u5OVy5d2mORblYh7ffFCTwnIuaHbd
         8asw==
X-Gm-Message-State: AOAM530QB64i+NrSyyhPtLDgZo4lm47JqVY3f5SanhrQ0iv7IZi9pWDI
        di7j3cdk+p6NaYXV9f21gAdEg19Ia9DxDWTibWI=
X-Google-Smtp-Source: ABdhPJyIjoWCNVs8D44LmLhCw61LbYMwtV1pHnyn97iX/7cPrMHNk2Vex4JkhZ/qMJBDCxZjYNCKe0U7thN+I2I4jNY=
X-Received: by 2002:a17:906:b46:: with SMTP id v6mr22029880ejg.262.1631670958681;
 Tue, 14 Sep 2021 18:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631331139.git.me@ttaylorr.com> <2a16f11790b79ab452233b6f28acac607c0abd28.1631331139.git.me@ttaylorr.com>
 <87ee9va0ie.fsf@evledraar.gmail.com> <YTzYYfBGqG87O5mN@nand.local>
 <YUDxzhAnzI5Anm6F@coredump.intra.peff.net> <YUE0u+T/CL8D5WV/@nand.local>
In-Reply-To: <YUE0u+T/CL8D5WV/@nand.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Sep 2021 21:55:47 -0400
Message-ID: <CAPig+cTpdPT6kD9NY2HXgPPvceX=euSGhQXpvKC+WS5-dLxe2A@mail.gmail.com>
Subject: Re: [PATCH 2/8] builtin/multi-pack-index.c: support --stdin-packs mode
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 7:48 PM Taylor Blau <me@ttaylorr.com> wrote:
> On Tue, Sep 14, 2021 at 03:02:38PM -0400, Jeff King wrote:
> > I think the root of the problem here is the non-idiomatic use of
> > strbuf_getline(). The usual thing (and in fact the thing done by the
> > quite-similar code in read_packs_list_from_stdin() in pack-objects.c)
> > is not to detach, because strbuf_getline() will reset the buffer each
> > time. I.e.:
> >
> >   struct string_list to = STRING_LIST_INIT_DUP;
> >   ...
> >   struct strbuf buf = STRBUF
> >   while (strbuf_getline(&buf, stdin) != EOF)
> >       string_list_append(to, &buf);
>
> > That avoids any clever string-list allocation games. The number of heap
> > allocations is about the same (one strbuf and N list items, versus N
> > strbufs and 0 list items). There's a little extra copying (from the
> > strbuf into the list items), but the strings themselves are more
> > efficiently allocated (strbuf may over-allocate, and we lock in
> > that choice forever by handing over the string).
> >
> > Not that efficiency probably matters either way for this spot. I'd do it
> > this way because it's simple and idiomatic for our code base.
>
> More than anything, I'm persuaded by that (though I was quite partial to
> Eric's suggestion, which I found very clever).

For what it's worth, Peff's suggestion seems best of all those
presented thus far.

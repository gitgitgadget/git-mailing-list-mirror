Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3F5C433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 22:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA64224DF
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 22:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbhAQWZ1 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 17 Jan 2021 17:25:27 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49]:41978 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730541AbhAQWX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 17:23:58 -0500
Received: by mail-ej1-f49.google.com with SMTP id g12so21071571ejf.8
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 14:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ouASbwxiI9yXTc7nIaSSFi7yFQJLigMZU1tYJfiZuJk=;
        b=ienAd8UJfwwspBQkD/HHgR6MuH6ceVprUIVMfKqW/In+YLN3gQ1HPhIb3DfsYWxEs8
         swdo6msShWzj10ULSLiwJ2mHsYlg8XFBwX/I1RAJnV8/kDbvdNkRLq9UjDMt0f2YAmB5
         nHfdVlycogUbJ/RIz/qtszdgVaoY487cUiFWtb5IiR7zaVjvY88h/VRt2Qy2zPZEC7nh
         Nmxzq/8frLng4FQrqBxO5eL+w4Kf+JoPYWtXWGAwsKTQPHxhDBYXMetjXQUdPg7mrcpp
         Yfl4FhFrOUjvO56IQltTOgHblfLPpdTPSBahTSPR6aId77hcKDYf0p16g8nf/4GQia+l
         iA/g==
X-Gm-Message-State: AOAM530nL8dhkKJL+Xb/ePFbQp+IqQEVNtCocBE9wsnUnQlNHjrpFHYB
        uuIFSRHQzAnEXYj7+bGB63jn3+2w/vk9UitncmI=
X-Google-Smtp-Source: ABdhPJyrPZ7Xj5QAhIANtH4M6U++kCIn4kS3lA49SvQUrlcqaTGIWmqXuiiNZlzQyiSYG+ByzZiPrdFVC4rNUiGLqMQ=
X-Received: by 2002:a17:906:1c0a:: with SMTP id k10mr2519474ejg.138.1610922196469;
 Sun, 17 Jan 2021 14:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20210114233515.31298-1-avarab@gmail.com> <20210116153554.12604-3-avarab@gmail.com>
 <YARsCsgXuiXr4uFX@coredump.intra.peff.net>
In-Reply-To: <YARsCsgXuiXr4uFX@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 17 Jan 2021 17:23:05 -0500
Message-ID: <CAPig+cToj8nQmyBCqC1k7DXF2vXaonCEA-fCJ4x7JBZG2ixYBw@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] cache-tree tests: use a sub-shell with less indirection
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 17, 2021 at 11:55 AM Jeff King <peff@peff.net> wrote:
> On Sat, Jan 16, 2021 at 04:35:45PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >       for subtree in $subtrees
> >       do
> > +             (
> > +                     cd "$subtree"
> > +                     generate_expected_cache_tree_rec "$dir$subtree" || return 1
> > +             )
> >       done
>
> We don't check that "cd" worked either before or after your patch.
> Should we?

I'd say "yes".

> After your patch, we "return" from inside a subshell. Is that portable?
> ISTR issues around that before, but it just have been when we are not in
> a function at all. Still, I wonder if:
>
>   for ...
>   do
>         (
>                 cd "$subtree" &&
>                 generate_expected_cache_tree_rec "$dir$subtree"
>         ) || return 1
>   done
>
> might be more obvious.

Yes, a good recommendation. Normally, we `exit 1` from within
subshells[1], but that wouldn't help us exit this loop early, so the
`|| return 1` outside the subshell seems a good solution.

[1]: https://lore.kernel.org/git/20150325052952.GE31924@peff.net/

Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8249EC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F265221E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 19:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgIJTuf convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 10 Sep 2020 15:50:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42204 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgIJTtU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 15:49:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id l63so7560100edl.9
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 12:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+sOYINgFCXLhwZt1eg0i6a7v6552cIND0pBZm021SHo=;
        b=oQeGGPDMol6Z/7rtR6LJih/lX192elMdlhjmSHdvfVLwmrTkfQjmbk30w0hxRlofXT
         pSogsu681E3nhdiMegUJnJ+HpcemDqEkoeTurrhjRS4OkmOKyBagLSO5GpGm+fqTmcdf
         K8LOyYtNAP5mFgiH/VzdvPXACctiFICZSx1Kg32kI5HErU9k0NIwZULY5vggi/DdNXW8
         O5DMyZqctNkrFPFQFnQ4wsC7SwQwTMEa0AM1yeWGAs75j0B7ScUFFarvKSHGivxFsyYr
         yIZD+bonztAaJZd6FK90avIH3PtUOdUrkxHVe82DEV8EDWHIO7Rg/0wt4Cy80hiUvqAF
         hBzg==
X-Gm-Message-State: AOAM533BZltmQ21YkKPChYd3RoliDgjZYTW9EQ7Z3sm73z8E4kA2MAOd
        eCPwPi92FSrdG/qgMJPdxgtDLIHtV6kZThde+DCQkl6jRHY=
X-Google-Smtp-Source: ABdhPJx7yAqiOHX9xi9yBM7WI5iZkmBkOw9Z/flgMyP250ge0cc4zXlbt/25NeHT2c19iyS2YgW2OMUv4YnqLERmcrg=
X-Received: by 2002:aa7:d15a:: with SMTP id r26mr11123974edo.181.1599767358213;
 Thu, 10 Sep 2020 12:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599762679.git.martin.agren@gmail.com> <58a2469cc18839e57b45f687b6e484d69161a34c.1599762679.git.martin.agren@gmail.com>
 <CAPig+cTZLqFayp0wZEFYkaXtoOx8HedUK1oQoOa+zq=Yrgvjbg@mail.gmail.com> <CAN0heSrQT9N3=e70qkgS_rOQ0oy0rrHqud=rRtr-r5JaL=ofNQ@mail.gmail.com>
In-Reply-To: <CAN0heSrQT9N3=e70qkgS_rOQ0oy0rrHqud=rRtr-r5JaL=ofNQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 10 Sep 2020 15:49:07 -0400
Message-ID: <CAPig+cSEOUebNV90Gec2KqskZgAmX=jd++s4tfAyYN6Up4_O3A@mail.gmail.com>
Subject: Re: [PATCH 4/8] worktree: drop useless call to strbuf_reset
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 10, 2020 at 3:40 PM Martin Ågren <martin.agren@gmail.com> wrote:
> On Thu, 10 Sep 2020 at 21:15, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > I think this patch is wrong and should be dropped. That strbuf is
> > static, and the called strbuf_worktree_ref() does not reset it, so
> > each call to worktree_ref() will now merely append to the existing
> > content (which is undesirable) following this change.
>
> That's not to say this optimization won't ever be useful, of course. I
> also begin to hope that no caller keeps their returned pointer around
> for long. It only seems to be used from `other_ref_heads()` and that
> looks ok. If we do want this strbuf reuse, maybe that function could
> just keep its own strbuf and reuse it (not necessarily having it be
> static) and learn not to call `worktree_ref(wt, "HEAD")` twice.

Yep, I wouldn't be unhappy to see worktree_ref() disappear altogether.
There are no external callers and it would be easy enough to retrofit
the lone internal caller to use the safer strbuf_worktree_ref()
anyhow. Plus, both calls to worktree_ref() in other_head_refs() invoke
it with the exact same arguments, `worktree_ref(wt, "HEAD")`, which
makes one wonder if it need be called twice at all in that particular
scenario.

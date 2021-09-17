Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB93C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF51C61076
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344526AbhIQWRW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 18:17:22 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:36688 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhIQWRV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 18:17:21 -0400
Received: by mail-lf1-f46.google.com with SMTP id c8so38543704lfi.3
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 15:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXCeDbZGUVcJ10o1zuIIzGtqPVs0EvunjhRe049axxo=;
        b=vR/vj4dVVVTrSVLrke7dTqMUwsgCtsHRyXIIeUOYHMG7IaiDg9hyvmP4iA3OJgDyuk
         /k7+KMYZQ3d9sWOCxKInakaSlPRE2PTBEu8W+QL/jtKG+cxYl98T+XwaICMTGbL2xmcY
         jeBTaw3nM+5p8V0F+3kgEsjmcWb5ROKIGFmKIVHuSxnWamKauCPUcKtVWKDe9st/PyBG
         kcP9t+O4xupeihixeKIM464+q6+52hsxY7bKfNfVidkpGu2FCNtQTlU/SD02Wv1ixc8d
         1LRvea4v9laUMJVU4WK8mXmAI5ldzdKyEky/+rDP6WGxYsloZXGev1aoTs4jitG0buWm
         qvgQ==
X-Gm-Message-State: AOAM533dgqApUh5EfJmClw6kVrSiYB2MJ499rcPJNZJ5ClGqcYWz4l7o
        RqRsoiVOIpv2obb6wxNHofGJNUcxDwRR9DCrqUb4R41ESyc=
X-Google-Smtp-Source: ABdhPJxf+hteeurvTJiRbBjP8OYB189OnK/sqTq+Dk0I+tH6gl+Gq5XEQU4+8plNxabo2d2HA/e9QJfF8L1/+ZME4ec=
X-Received: by 2002:a2e:9942:: with SMTP id r2mr11848918ljj.92.1631916957314;
 Fri, 17 Sep 2021 15:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210916140943.2442184-1-someguy@effective-light.com>
 <20210916140943.2442184-2-someguy@effective-light.com> <CAPig+cRfFZ=GAevJ0b9oBGTR8P3MnSg+R43ujSP0dZJL08riqA@mail.gmail.com>
 <WCKLZQ.YCP2HWKW7YBB2@effective-light.com> <YUUQA1qNCzY7Vx+j@coredump.intra.peff.net>
In-Reply-To: <YUUQA1qNCzY7Vx+j@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 Sep 2021 18:15:46 -0400
Message-ID: <CAPig+cTD22MM1vjXMSjVcNXfVWfqDgT7rDp1j-e_Fko33osATA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] pretty: colorize pattern matches in commit messages
To:     Jeff King <peff@peff.net>
Cc:     Hamza Mahfooz <someguy@effective-light.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 6:01 PM Jeff King <peff@peff.net> wrote:
> On Fri, Sep 17, 2021 at 05:14:56PM -0400, Hamza Mahfooz wrote:
> > On Fri, Sep 17 2021 at 03:10:12 AM -0400, Eric Sunshine
> > <sunshine@sunshineco.com> wrote:
> > > `buf` and `eol` seem like an accident waiting to happen...
> > > ... because strbuf_grow() may reallocate the underlying buffer, which
> > > means that `buf` and `eol` will end up pointing at freed memory, which
> > > will be accessed by the next call to grep_next_match().
> >
> > I don't see how it's problematic, since `tmp_sb` isn't modified after `buf`
> > is initialized (until strbuf_release() is called, of course).
>
> Yes, you are correct.

Indeed, I got confused by the multiple strbufs with similar names. However...

> However, I do think the code would be much clearer
> if you skipped the strbuf entirely, like:
>
>   line_as_string = xmemdupz(line, linelen);
>   ...
>   buf = line_as_string;
>   eol = buf + linelen;
>
> which makes it much clearer that you don't intend to modify it further
> (especially with all those other calls operating on the _other_ strbuf,
> it's hard to see immediately that this is the case).
>
> The "as_string" name is assuming the purpose is to get a NUL-terminated
> string. I'm not sure why we need one, though, since we pass the buf/eol
> pointers to grep_next_match(). A comment above the xmemdupz() line might
> be a good place to explain that (which would help especially if the
> reasons change later and we can get rid of it).

... as Peff points out, it indeed is unclear why a copy of `line` is
needed at all. It seems like a simple:

    buf = line;
    eol = buf + linelen;

would more than suffice without making any copies. If you do that, then the:

    if (buf != line) {

later in the code -- and which I questioned in my review as making no
sense -- suddenly makes sense.

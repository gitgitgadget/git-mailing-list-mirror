Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8B11F597
	for <e@80x24.org>; Mon, 23 Jul 2018 19:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388038AbeGWUtx (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 16:49:53 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:43637 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387883AbeGWUtw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 16:49:52 -0400
Received: by mail-yb0-f196.google.com with SMTP id x10-v6so722360ybl.10
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 12:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wj3LwNP0Xj1zTpGfsiIy/mo4rpI5l7lq7IxwKYUmvXo=;
        b=ZPPz4SMXEx8jGCbfHRZ8HXLCllq77G9hWrSGnX9HTgD9MJgbosji5BOBuT0eid3fik
         +w51GI8efj8n1RRkE5NP2ZBUzLSTb3lFc4l9KzvHqIyuVUVIl8CenLwQUkpamL4HJTfn
         jQRs1Ftz3kffpMIERk/eNn91MXt9vPBpigoaEAt7slUS+JsH0L39LYy+Izdby1tl5CuI
         Iks8ctMKq907tRGhzSUnCvaSqwIlmpbVd7L+yIxFN+xdpMLLi+j3KHJ7WPADeT8eSe8i
         HdLtQoGizmW80icfCWeCBAOPqUMfMEzPoZG8nb8G8nwDBtW6PRz0jpy/ij9BOFXDjZkT
         VtMA==
X-Gm-Message-State: AOUpUlFZ5cxhV1W8084I+uEqfwDmJ+8eiOdCLXQptgcqN5wVzbtph2wJ
        +7XV0pJSMkyRloChy02JeRnUvhKom3+nbkmzI8g=
X-Google-Smtp-Source: AAOMgpdXqARuhY2V7jFl50wkVJRdfdIz6fxE2lHLG2zMWqNhB7NIaT9LPXVnHWB3C3rBHvw1AA6Dwx2oAwlDI4hPAF8=
X-Received: by 2002:a25:8b04:: with SMTP id i4-v6mr7709128ybl.12.1532375228186;
 Mon, 23 Jul 2018 12:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180722095717.17912-1-sunshine@sunshineco.com>
 <20180722095717.17912-7-sunshine@sunshineco.com> <CACsJy8Aw6R8-3kDfhCqunXziajCg9O_1WrEYc4rfKa+-=m1D5g@mail.gmail.com>
In-Reply-To: <CACsJy8Aw6R8-3kDfhCqunXziajCg9O_1WrEYc4rfKa+-=m1D5g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Jul 2018 15:46:57 -0400
Message-ID: <CAPig+cR=rcoLqtefWJMe0NY_7OX7WR6q1UoF-HnYrHZWtKuHAw@mail.gmail.com>
Subject: Re: [PATCH 06/14] format-patch: allow --interdiff to apply to a lone-patch
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 12:22 PM Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Jul 22, 2018 at 11:58 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > +       if (cmit_fmt_is_mail(ctx.fmt) && opt->idiff_oid1) {
>
> OK putting idiff stuff in rev_info is probably the right choice. But
> we all three fields prefixed with idiff_, maybe you could just add a
> new struct "idiff_options" to contain them and add a pointer to that
> struct in rev_info. Then "opt->idiff" is enough to know if idiff is
> requested instead of relying on idiff_oid1 (seems too random).

I have mixed feelings about this suggestion for the following reasons:

* 'struct rev_info' already contains a number of specialized fields
which apply in only certain use cases but not others, and those fields
often are grouped textually to show relationship rather than being
bundled in a struct.

* These new fields are very specific to this particular operation and
are unlikely to ever have wider use, so adding the extra level of
indirection/abstraction (whatever you'd call it) feels overkill and,
while nice theoretically, adds complexity without much practical
value.

* Bundling these fields in a struct might incorrectly imply to readers
that these items, collectively, can be used in some general-purpose
fashion, which isn't at all the case; they are very specific to this
operation and that struct would never be used elsewhere or for any
other purpose.

The upside of bundling them in a struct, as you mention, is that
"opt->idiff" would be slightly more obvious than "opt->idiff_oid1" as
a "should we print an interdiff?" conditional. On the other hand, this
case is so specific and narrow that I'm not sure it warrants such
generality.

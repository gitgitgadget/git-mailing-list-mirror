Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67289C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E70664FCE
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCKRId (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:08:33 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49]:43014 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhCKRIH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:08:07 -0500
Received: by mail-ej1-f49.google.com with SMTP id p8so47694911ejb.10
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:08:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZXmDqFrG9oERXfhYbvO7baUV84W3e0muzVG2iDgCNEw=;
        b=MRk9uJcjRwRhjeZGYryeB0AbhQHbc+6OFugOenOA0AmQIrRzHixlRbgedp3CVZHO+Q
         d45RNxZ8vpkRIdxfbGOwsfd4CuhaP1ve+D5xFT7cThIeJhGBcUetI2rvnPwre4gG4nUu
         UD0IyVXdmOiRuJZJKD7fycGU2n+yPnUl5MM+Ps0um4a9KfNchozMSbvXckmta1XDMsqG
         kxn4mc8Uvy8mzH8jcpUMnc+vLmSGG14Z1+V42PjXIjzxypFs6nZF/5ZEAr5WmtF0a2l0
         +fcAthEDYDZg9xaT/hHifBMTvInD/soZScNCKe3GY/4JARkM9jF0NQbu/XpFy143hJrc
         u85g==
X-Gm-Message-State: AOAM5315lTxR3TNqj2yOeb5oTZkqXnC7O2lrmAf5v+ER2Wzs/i9bCttJ
        UT7sc+q6wHNx2YJcE2yoh5fScT+BnMr9KijKB3g=
X-Google-Smtp-Source: ABdhPJxpnUsn7XrgA9nIEKh91lmala8r/MnluGu107JTPGOBgvz4AHeMIOU3+ygxQs2lnU3yRNpfHdSznnNFr6L7n6o=
X-Received: by 2002:a17:907:7684:: with SMTP id jv4mr4131785ejc.231.1615482484726;
 Thu, 11 Mar 2021 09:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210310194306.32565-3-charvi077@gmail.com>
 <CAPig+cRxZFV7DDtnYOxRqEYU4PwXK8gb2HSehDyGorqdgsmoNQ@mail.gmail.com> <CAPSFM5c8saGs=+OvXvZw-T2jPpdUfkmm9_BZOmZwUo=WO1sdQg@mail.gmail.com>
In-Reply-To: <CAPSFM5c8saGs=+OvXvZw-T2jPpdUfkmm9_BZOmZwUo=WO1sdQg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 11 Mar 2021 12:07:53 -0500
Message-ID: <CAPig+cTBXBjZkJoGFYpzWBnEOmV52dnoBHxceuoe3pu3F0BnYw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 10:24 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> On Thu, 11 Mar 2021 at 11:55, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > +               size_t len = get_alpha_len(fixup_message);
> > > +               if (len && fixup_message[len] == ':') {
> > > +                       fixup_message[len++] = '\0';
> > > +                       fixup_commit = fixup_message + len;
> >
> > An alternate -- just about as compact and perhaps more idiomatic --
> > way to write all this without introducing the new get_alpha_len()
> > function:
> >
> >     char *p = fixup_mesage;
> >     while (isalpha(*p))
> >         p++;
> >     if (p > fixup_message && *p == ':') {
> >         *p = '\0';
> >         fixup_commit = p + 1;
>
> Earlier we had discussed[1] keeping a separate helper function, so
> that it may re-use it later. But I agree above is easier to get and
> compact so I think maybe it will be ok, for this patch series to
> replace it with the above and remove the function.

I don't have strong feelings one way or the other whether you should
use a function or inline it as I showed above, and since our aim is to
land this series rather than endlessly re-rolling it, let's not spend
a lot of cycles worrying about it.

The one thing that does bother me, however, is the name of the
function, get_alpha_len(), which tells you (somewhat) literally what
it does but doesn't convey to the reader its actual purpose (which is
something we should strive for when naming functions and variables).
In that previous discussion you referenced, Junio mentioned that a
future sub-option might want to have punctuation in its name. If that
ever comes about, then the name get_alpha_len() no longer makes sense
and needs to be renamed so it doesn't become a lie. Giving the
function a better name up front would not only help readers now to
understand what is going on, but would also help down the road when or
if punctuation (or numbers or whatnot) become valid in a sub-option
name. suboption_length() is one possibility. With a slight semantic
change, skip_suboption() or latch_suboption() are other possibilities.
Or, if you were to open-code the loop as I did above, then you might
have a function named is_suboption_char() and use that in place of
isalpha().

So, if you do re-roll, I wouldn't mind seeing a better name for the
function; but the rest is subjective and not worth spending time
refining unless you actually feel that one style has a clear advantage
over others.

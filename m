Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 677391F597
	for <e@80x24.org>; Mon, 23 Jul 2018 19:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbeGWUfL (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 16:35:11 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:38183 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388039AbeGWUfL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 16:35:11 -0400
Received: by mail-yb0-f196.google.com with SMTP id i9-v6so710177ybo.5
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 12:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z88ugnqAQTHGNV5Kkl0T4GDii4inARVUHnPM3syUnA4=;
        b=lYCXYkBRaoA4ny7IGaFZyG7wi1+SKstrY2qfmw98rTCVxBRJLUwQkEZwOsO/DoRWs6
         2qe0rRvs0I278MuEmxuG9zhpP+ol3RW0YHJtI4zdLY4ReKPXPm9Fn2Hy4+RCIDsxU33Z
         V5op+5OvJ/OiZkVwyyG2Bo0XwRMOTPlaZPhLNi4Qov8k0hKxIx7WnwsmbTGG4PWj8HGi
         C5cX3cfpPoSBGpdgDuzbDVyzI2sUv/XVVFD1jZAmxlbYPMx9IQhe8EBPUy+b+cZAuvlG
         9zbQ2wHUGAUU2f0v5DlEDBVMaT3arSltBH1clkphbvPDhOpvhsWhQ8mXL0byr2VSPWiH
         GQ2Q==
X-Gm-Message-State: AOUpUlG8cUopvsAMAG+5Zcc5hn4+S3JNBiqFpGS53fdrhM5P3qnUekpC
        +bWXCHr9DLH8xxBb3TgJ0MuEw/2B5BLEzdba9tY=
X-Google-Smtp-Source: AAOMgpc/u5d1I7KgaPdQNql9DA8m+aJHE7cdzt3JLQp66PXvtteS6QJBMT/9lQJ6aQkiJC+aekRVWq//esH+Czt6GaY=
X-Received: by 2002:a25:488a:: with SMTP id v132-v6mr7795768yba.263.1532374350303;
 Mon, 23 Jul 2018 12:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180722095717.17912-1-sunshine@sunshineco.com>
 <20180722095717.17912-4-sunshine@sunshineco.com> <CACsJy8AGwbrEFU2bTynXyQi1DmEYtwHrtmefMz+jD13GQs=9HQ@mail.gmail.com>
In-Reply-To: <CACsJy8AGwbrEFU2bTynXyQi1DmEYtwHrtmefMz+jD13GQs=9HQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Jul 2018 15:32:19 -0400
Message-ID: <CAPig+cS7xLgoL4SAihz0tjZur2c7Ff0YZWAgp0wTv0FCkYGZLQ@mail.gmail.com>
Subject: Re: [PATCH 03/14] format-patch: teach --interdiff to respect -v/--reroll-count
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

On Mon, Jul 23, 2018 at 12:12 PM Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Jul 22, 2018 at 11:57 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > @@ -215,6 +215,7 @@ struct rev_info {
> >         /* interdiff */
> >         const struct object_id *idiff_oid1;
> >         const struct object_id *idiff_oid2;
> > +       const char *idiff_title;
>
> I feel we're abusing struct rev_info a bit for this since this
> interdiff thing is very builtin/log.c's business and not at all
> related to rev walk. Is it possible (and easy) to just pass
> idfff_title from cmd_format_patch to make_cover_letter()? If it's a
> lot of code, then I guess we can just leave it here.

As originally implemented, this information was passed directly to
make_cover_letter(), however, as you discovered in your review of
patch 6/14[1], which makes it possible to embed an interdiff in the
commentary section of a lone patch, 'struct rev_info' is the only way
to pass this information down that deeply in the patch-generation
process. So, yes, this pretty much needs to use 'struct rev_info',
even if that need doesn't exist at this early step in the series.

[1]: https://public-inbox.org/git/CACsJy8Aw6R8-3kDfhCqunXziajCg9O_1WrEYc4rfKa+-=m1D5g@mail.gmail.com/

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A99611F597
	for <e@80x24.org>; Sun,  5 Aug 2018 05:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeHEH0f (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 03:26:35 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:41063 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725728AbeHEH0f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 03:26:35 -0400
Received: by mail-yb0-f195.google.com with SMTP id q5-v6so980167ybk.8
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 22:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MD4qlW02wSzL0n747CE3xbqOJRYHuaN1cHTvh+H8cSw=;
        b=C/vI+0BRIZwi+Q7U43WoeQULvQmIys3HfcPTkclgSbMQ82tjGGwfl5p2mEj7mWwI2v
         lKtRrxb11seAhE64WywPq8GEEYnt0Mj4ICp+y2cJCuvU+1f9qkEG1CXvgG20hnhGneO0
         d3ww+LGAjovs+qR676b5n5LUWVjSs7idaeYuPU/LSvAqwifXDho2Wx7pLz22WtNWpTcc
         ioBNzW9Wq1/qySTSzv6KlBB9Jm+LclIAXR8HQM4THHU4ldcf7zbtaszx6tP7UF6WJg5z
         odTjrYHBgKX0nLrgPEd40hKfFfXdH2yuEUWOXby4jpdd4y07vJ+ydL2V8x8tuMT1xBVK
         NEpg==
X-Gm-Message-State: AOUpUlHShyVSG4dZTwi1IH0sOR9I9ZEv3iTYIxxXhJ3qOWsS6v0mMLzj
        tx3Mm+WkPWc2cjPVOorxVPA17/bGg0aEi4+h6JI=
X-Google-Smtp-Source: AAOMgpdafZraBgVGVZ2WQe+3U6yWeZI+R3RiA04i7u8QV/BGW0T1/iVCJkfWPi4Acm5fPf2Vbtl4RbgP18wEP7r6Fy4=
X-Received: by 2002:a25:488a:: with SMTP id v132-v6mr5219334yba.263.1533446597320;
 Sat, 04 Aug 2018 22:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180805022002.28907-1-wchargin@gmail.com> <20180805022002.28907-2-wchargin@gmail.com>
 <20180805041956.GI258270@aiede.svl.corp.google.com>
In-Reply-To: <20180805041956.GI258270@aiede.svl.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 5 Aug 2018 01:23:05 -0400
Message-ID: <CAPig+cQSryjWrFZML_g0fR5oq6dzVaWPXm_4R-Jg_ay1R2DzbQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] t/test-lib: make `test_dir_is_empty` more robust
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     wchargin@gmail.com, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 5, 2018 at 12:20 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
> William Chargin wrote:
> >  test_dir_is_empty () {
> >       test_path_is_dir "$1" &&
> > -     if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
> > +     if test "$(ls -A1 "$1" | wc -c)" != 0
>
> Another portability gotcha: wc output includes a space on Mac so this
> test would always return true there.  How about
>
>         if test -n "$(ls -A1 "$1")"
>
> "ls -A" was added in POSIX.1-2017. [...]
> That's very recent, but the widespread implementation it mentions is
> less so.  This would be our first use of "ls -A", so I'd be interested
> to hear from people on more obscure platforms.  It does seem to be
> widespread.

A simpler approach, without the portability concerns of -A, would be
to remove the "." and ".." lines from the top of the listing:

    ls -f1 "$1" | sed '1,2d'

If we're worried about -f not being sufficiently portable, then an
even simpler approach would be to check whether the output of 'ls -a1'
has more lines than the two expected ("." and ".."):

    test $(ls -a1 "$1" | wc -l) -gt 2

I think I favor this final implementation over the others.

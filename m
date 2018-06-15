Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B017E1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 07:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755764AbeFOHnt (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 03:43:49 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37599 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755626AbeFOHns (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 03:43:48 -0400
Received: by mail-yb0-f195.google.com with SMTP id h141-v6so3200453ybg.4
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 00:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39Tr0rOneAvtdZX9W3vRqMcwxRa7rA9ZXY05tmhYppI=;
        b=slg7rWBeSjcUdB9wgkGT7ohy/IsS/7O0DhjPXNRhuPTnH1kTGI/dqfIzucjXnyWTqs
         kHcmFkR9TLgHMZsFHxyCjQ+JcFZQMwURrwE6LoZWCAmG2DUVHzdMICCrgVDAZm6Q3HjV
         NP7ZRQ4rRr/k/zVB0UoKlPQ+8d3WxZm4pfZE+Rco8zTwAf5J1xKnZ0wp4lNoNrzybGZG
         u1o1Qvt3JheeWbOgfLrX0XdOwns5Nk9S7IwaUq5MSHut0q4bFqQsM2YVUgM31Miq5gyZ
         dubjjrOboz/T8oHtQxWICC+lqYBrIsrrCfEiY+TSsJEjO5n8AwPfHNOdgzU9qNCVvACb
         7vtA==
X-Gm-Message-State: APt69E1JXk2GvuNYQFwyw75iofZaLUZhTkcQ/k05UA38hbk5UdjZXNK2
        6fQbckfq0lmQ76NCHXFGwqkD0ayyqzqLi8krca0=
X-Google-Smtp-Source: ADUXVKLcYoavRzOfbD81IKs1uwMnUgPiNK58r6+sQ+V/mbUWe66VIqlTM5EZH7AruLt/E2TPOCOGJ3AoO6eAn4j5hIY=
X-Received: by 2002:a25:1f02:: with SMTP id f2-v6mr269828ybf.76.1529048627903;
 Fri, 15 Jun 2018 00:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com>
 <20180615022503.34111-1-sunshine@sunshineco.com> <20180615065805.GA15146@ruderich.org>
In-Reply-To: <20180615065805.GA15146@ruderich.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 15 Jun 2018 03:43:36 -0400
Message-ID: <CAPig+cQL8rTg+GASp2tSng7PPPYkfeeV2SNyi0D+6-Ep7JKaGg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: make NO_ICONV really mean "no iconv"
To:     simon@ruderich.org
Cc:     Git List <git@vger.kernel.org>,
        Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 15, 2018 at 2:58 AM Simon Ruderich <simon@ruderich.org> wrote:
> On Thu, Jun 14, 2018 at 10:25:03PM -0400, Eric Sunshine wrote:
> > This patch is extra noisy due to the indentation change. Viewing it with
> > "git diff -w" helps. An alternative to re-indenting would have been to
> > "undefine NEEDS_LIBICONV", however, 'undefine' was added to GNU make in
> > 3.82 but MacOS is stuck on 3.81 (from 2006) so 'undefine' was avoided.
>
> Should we put the part about MacOS's make into the commit
> message? Seems like relevant information for future readers.

No. The bit of commentary mentioning MacOS's very old 'make' was just
talking about a possible alternate way of implementing the change.
That alternative was not chosen, so talking about old 'make' in the
commit message would be confusing for readers. More importantly,
although that alternative would have made a less noisy patch, the
actual result would have made the Makefile itself noisier and uglier,
particularly for people just reading the Makefile in the future,
people who did not read the patch. Specifically, these alternatives
were considered:

    ifdef NO_ICONV
        undefine NEEDS_LIBICONV
    endif
    ifdef NEEDS_LIBICONV
        ...as before...
    endif

and:

    ifdef NO_ICONV
        NEEDS_LIBICONV=
    endif
    ifeq ($(NEEDS_LIBICONV),)
        ...as before...
    endif

Both of which are uglier for a future reader of Makefile than the
end-result actually implemented by this patch:

    ifndef NO_ICONV
        ifdef NEEDS_LIBICONV
            ...as before...
        endif
    endif

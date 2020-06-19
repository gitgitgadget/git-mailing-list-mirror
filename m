Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F45FC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 18:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7434D206B7
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 18:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733154AbgFSSBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:01:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33569 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732986AbgFSSBA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 14:01:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id l11so10565375wru.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 11:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3Vv68l5PB4YEJcbq+pWWGku00CZZaWcENMhUOZXS80=;
        b=ITVzyRh2xrx763AZpxJzWc/A6qo5VU9SAIQ+UoYnZllG3YU/XLHLipEGfoy+fDyvYT
         dtMLKktsT+y3j72pipT4x36wJbXEfIRP+UMUH8cRiEqjpYn+14I6SohNDC3VEVu21zcn
         9pMOnXS/NDVNhKfXFKbMeW1tGoieoqlTsWHvlLWl0XAU4CGPqPqQ4LCJAuz8hFzdp7de
         guDfqy0Gem3xDmE6/lFmz+UPGgaXu5I8dBwg9ix6YAKm4sfXT3wvR2jQu1kIKWBifm53
         R4Ze0cF6PkNGkx+ChE3sRmCi2A/2OdOTjSp9fSql3bgL3bf4SHks4czbFZ07Wn+BKM73
         QGiQ==
X-Gm-Message-State: AOAM533enX1A2UpvMHKW5sJdx99FUJbgFlkqu658HwCP1HB5OcvnhhNS
        CUAxJLbGYbYTJH89miNbCJpPvpam2Q3K6QVLZDQ=
X-Google-Smtp-Source: ABdhPJzrDMfUWgMxCvXBonYedX9vj0r/pSMD9fHfGMH0sdRatmFVtu3/A89dlU1muI/BnMytGjmIi84xvSovVHMb1a0=
X-Received: by 2002:adf:e2ce:: with SMTP id d14mr5383031wrj.415.1592589658406;
 Fri, 19 Jun 2020 11:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200619132304.GA2540657@coredump.intra.peff.net>
 <20200619132546.GA2540774@coredump.intra.peff.net> <CAPig+cRNem-S5LGX=v=1Tid64sXWBxNyWH4ffgLgF0o1yN=mtw@mail.gmail.com>
 <20200619160129.GA1843858@coredump.intra.peff.net> <20200619161816.GA9205@flurp.local>
 <20200619174551.GA2123813@coredump.intra.peff.net>
In-Reply-To: <20200619174551.GA2123813@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Jun 2020 14:00:47 -0400
Message-ID: <CAPig+cQxoz1AcS51qhtBr6oaTs9KTDamofCyN3qy_EARUi7oFQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] fast-export: allow dumping the refname mapping
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 1:45 PM Jeff King <peff@peff.net> wrote:
> On Fri, Jun 19, 2020 at 12:18:16PM -0400, Eric Sunshine wrote:
> > Hmph, that shouldn't have failed. Did you quote the $(wc -l refs)
> > invocation? Quoting it would cause it to fail.
>
> Nope (and indeed, I was wary of the issue and made sure I didn't use
> quotes). My original was:
>
> test_expect_success 'refname mapping can be dumped' '
>        [...]
>        expected_count=$(git for-each-ref | wc -l) &&
>        expected_count=$((expected_count - 1)) &&
>        test_line_count = "$expected_count" refs.out &&
>
> So I guess I did quote the variable later.  It works fine on Linux, but
> one of the osx ci jobs failed:
>
> ++ expected_count='       7'
> ++ test_line_count = '       7' refs.out
> ++ test 7 = '       7'
> ++ echo 'test_line_count: line count for refs.out !=        7'
>
> so the whitespace is eaten not when "wc" is run, but rather when the
> variable is expanded.

Not something that should be done by this series (more a
left-over-bitty thing, perhaps), but this almost suggests that
test_line_count() deserves a tweak to make it more robust against that
sort of thing:

    test_line_count () {
        if test $# != 3
        then
            BUG "not 3 parameters to test_line_count"
        elif ! test $(wc -l <"$3") "$1" "$2"
        then
            echo "test_line_count: line count for $3 !$1 $2"
            cat "$3"
            return 1
        fi
    }

If we drop the quotes around $2 from the 'test':

    elif ! test $(wc -l <"$3") "$1" $2

then your code would have worked as expected.

My only worry about that is that a poorly written caller would get a
weird and unhelpful error message:

    test_line_count = 4 4
    --> sh: test: too many arguments

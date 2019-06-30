Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 815471F461
	for <e@80x24.org>; Sun, 30 Jun 2019 22:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfF3WZj (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 18:25:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:55492 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726040AbfF3WZj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 18:25:39 -0400
Received: (qmail 24189 invoked by uid 109); 30 Jun 2019 22:25:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 30 Jun 2019 22:25:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32671 invoked by uid 111); 30 Jun 2019 22:26:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 30 Jun 2019 18:26:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Jun 2019 18:25:37 -0400
Date:   Sun, 30 Jun 2019 18:25:37 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5319: don't trip over a user name with whitespace
Message-ID: <20190630222537.GA21696@sigill.intra.peff.net>
References: <pull.261.git.gitgitgadget@gmail.com>
 <d4a3f56b-5eaa-1325-f8c1-be6797a9ac03@kdbg.org>
 <CAPig+cRpOHRgtCXXiqAZtmEtkWnMy7=4GsTVv0XB9R3fF0-66A@mail.gmail.com>
 <1a5bb5f9-e090-7f42-ec3f-cd74bcad831f@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a5bb5f9-e090-7f42-ec3f-cd74bcad831f@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 30, 2019 at 10:59:34PM +0200, Johannes Sixt wrote:

> Am 30.06.19 um 21:48 schrieb Eric Sunshine:
> > On Sun, Jun 30, 2019 at 2:57 PM Johannes Sixt <j6t@kdbg.org> wrote:
> >> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> >> @@ -443,7 +443,7 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
> >> -               MINSIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 1) &&
> >> +               MINSIZE=$(stat -c %s .git/objects/pack/*pack | sort -n | head -n 1) &&
> > 
> > Unfortunately, this is not portable. While "stat -c %s" works on Linux
> > and MSYS2, neither that option nor the format directive are recognized
> > on BSD-like platforms (I tested Mac OS and FreeBSD), which instead
> > need "stat -f %z".
> 
> Ouch! I did notice that stat(1) is not in POSIX, but hoped that it was
> sufficiently portable. I need a new idea...

If we are OK relying on rudimentary perl[1], then:

  perl -le "print((stat)[7]) for @ARGV"

works. If you want it more readable, then maybe:

  perl -MFile::stat -le "print stat(\$_)->size for @ARGV"

Both of those should work with even antique perl versions.

-Peff

[1] I'd also be fine with implementing a test-tool helper in C that
    behaves like stat(1). Or we could punt on that until somebody feels
    like trying to eradicate perl (because this is far from the first
    perl one-liner in the test suite).

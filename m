Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B251F1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 11:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeKLVYQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 16:24:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:35240 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728153AbeKLVYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 16:24:16 -0500
Received: (qmail 21656 invoked by uid 109); 12 Nov 2018 11:31:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 11:31:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9558 invoked by uid 111); 12 Nov 2018 11:30:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 06:30:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 06:31:23 -0500
Date:   Mon, 12 Nov 2018 06:31:23 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        larsxschneider@gmail.com, sandals@crustytoothpaste.net,
        me@ttaylorr.com, jrnieder@gmail.com
Subject: Re: [PATCH 03/10] fast-export: use value from correct enum
Message-ID: <20181112113123.GA470@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-4-newren@gmail.com>
 <20181111063636.GC30850@sigill.intra.peff.net>
 <87va532x5i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87va532x5i.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 11, 2018 at 09:10:17PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > This is a good argument for naming these SIGNED_TAG_ABORT, etc. But this
> > is obviously an improvement in the meantime.
> 
> In C enum values aren't the types of the enum, but I'd thought someone
> would have added a warning for this:
> 
>     #include <stdio.h>
> 
>     enum { A, B } foo = A;
>     enum { C, D } bar = C;
> 
>     int main(void)
>     {
>         switch (foo) {
>           case C:
>             puts("A");
>             break;
>           case B:
>             puts("B");
>             break;
>         }
>     }
> 
> But none of the 4 C compilers (gcc, clang, suncc & xlc) I have warn
> about it. Good to know.

There is -Wenum-compare, but it does not seem to catch this (and is
enabled by -Wall). It (gcc, at least) does catch:

	enum foo { A, B };
	enum bar { C, D };

	int f(enum foo x)
	{
		return x == C;
	}

but converting that equality check to:

	switch (x) {
	case C:
		return 1;
	default:
		return 0;
	}

is not (which is essentially the same as your snippet). So I think the
bug / feature request is to have -Wenum-compare apply to switch
statements.

Clang has -Wenum-compare-switch, but I cannot seem to get it to complain
about even the "==" version using -Wenum-compare. Not sure if it's
buggy, or if I'm holding it wrong. This patch seems to be what we want:

  https://reviews.llvm.org/D36407

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C95DC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB196112E
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhIOQmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:42:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:48136 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230038AbhIOQlx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 12:41:53 -0400
Received: (qmail 32451 invoked by uid 109); 15 Sep 2021 16:40:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 16:40:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25241 invoked by uid 111); 15 Sep 2021 16:40:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 12:40:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 12:40:33 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 07/11] ls-refs: ignore very long ref-prefix counts
Message-ID: <YUIiAYCAj+YC6w41@coredump.intra.peff.net>
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
 <YUE1hz/KKM0XebCP@coredump.intra.peff.net>
 <CAPig+cQxSTzo0tCUEb3uMhyRLS0hyuOM5ksZyH+h2StFupQ9Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQxSTzo0tCUEb3uMhyRLS0hyuOM5ksZyH+h2StFupQ9Yw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 01:00:01AM -0400, Eric Sunshine wrote:

> On Tue, Sep 14, 2021 at 7:51 PM Jeff King <peff@peff.net> wrote:
> > diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> > @@ -158,6 +158,37 @@ test_expect_success 'refs/heads prefix' '
> > +test_expect_success 'ignore very large set of prefixes' '
> > +       # generate a large number of ref-prefixes that we expect
> > +       # to match nothing; the value here exceeds TOO_MANY_PREFIXES
> > +       # from ls-refs.c.
> > +       {
> > +               echo command=ls-refs &&
> > +               echo object-format=$(test_oid algo)
> > +               echo 0001 &&
> > +               perl -le "print \"ref-prefix refs/heads/\$_\" for (1..65536)" &&
> > +               echo 0000
> > +       } |
> > +       test-tool pkt-line pack >in &&
> 
> Broken &&-chain in {...}.

Thanks, will fix.

> (Granted, it doesn't matter in this case since the exit code gets lost
> down the pipe, but better to be consistent about it.)

Yep. I think what happened is that I started to convert this to a
here-doc to match the nearby tests, but then realized that expanding the
multi-line bit was weird (even more so when it was a shell loop with a
pipe, before I switched it to perl).

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB73C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E288561244
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhIOQeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:34:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:48096 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhIOQeI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 12:34:08 -0400
Received: (qmail 32398 invoked by uid 109); 15 Sep 2021 16:32:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 16:32:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25128 invoked by uid 111); 15 Sep 2021 16:32:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 12:32:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 12:32:45 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 09/11] serve: reject bogus v2 "command=ls-refs=foo"
Message-ID: <YUIgLWbvfVOy1njt@coredump.intra.peff.net>
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
 <YUE1ym1dALRQLztq@coredump.intra.peff.net>
 <CAPig+cQNipgVwYZw3r2nQMZ_AOOsFEp1=MgEdmZcdAPnFE7gZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQNipgVwYZw3r2nQMZ_AOOsFEp1=MgEdmZcdAPnFE7gZA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 01:09:19AM -0400, Eric Sunshine wrote:

> > diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> > @@ -72,6 +72,16 @@ test_expect_success 'request invalid command' '
> > +test_expect_success 'requested command is command=value' '
> > +       test-tool pkt-line pack >in <<-\EOF &&
> > +       command=ls-refs=whatever
> > +       object-format=$(test_oid algo)
> > +       0000
> > +       EOF
> 
> This here-doc uses <<-\EOF yet (presumably) expects $(test_oid algo)
> to be expanded. I'm guessing that you meant <<-EOF but never
> noticed...

Ah, thanks. It's muscle memory to inhibit expansion in my here-docs. :)

> > +       test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
> 
> ... because of this test_must_fail().
> 
> > +       grep invalid.command.*ls-refs=whatever err
> > +'

Actually, it's a little more complicated. The "grep" here would notice
if we failed for the wrong reason. But we never actually look at the
object-format line at all, because we barf as soon as we see the bogus
command line.

So the object-format line is superfluous in this test. I added it mostly
for consistency with the other tests (including the existing
unknown-command test, which is in the same boat). But it also makes the
test slightly more robust, in that the command is more likely to succeed
(and thus fail the test) if the code accidentally did not notice the
wrong command line.

But obviously it's worth fixing. Thanks for noticing.

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73859C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 17:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3826103C
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 17:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhIORkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 13:40:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:48256 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhIORkV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 13:40:21 -0400
Received: (qmail 32685 invoked by uid 109); 15 Sep 2021 17:39:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 17:39:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26015 invoked by uid 111); 15 Sep 2021 17:39:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 13:39:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 13:39:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 09/11] serve: reject bogus v2 "command=ls-refs=foo"
Message-ID: <YUIvtEYybqnvpSQ/@coredump.intra.peff.net>
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
 <YUE1ym1dALRQLztq@coredump.intra.peff.net>
 <xmqq8rzxyc9f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8rzxyc9f.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 10:33:32AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > When we see a line from the client like "command=ls-refs", we parse
> > everything after the equals sign as a capability, which we check against
> > our capabilities table. If we don't recognize the command (e.g.,
> > "command=foo"), we'll reject it. But we use the same parser that checks
> > for regular capabilities like "object-format=sha256". And so we'll
> > accept "ls-refs=foo", even though everything after the equals is bogus,
> > and simply ignored.
> 
> Maybe I am slow but I had to read the above a few times and finally
> look at the implementation of parse_command() to realize that what
> the last sentence describes is:
> 
>     When parse_command() is fed "command=ls-refs=foo", it strips
>     "command=", feeds "ls-refs=foo" to get_capability(), and because
>     we do not ensure value is NULL, we silently ignore "=foo" that
>     is bogus.
> 
> And it makes sense.  It would probably have helped if I peeked the
> updated test ;-)

Since I'm re-rolling anyway, I'll expand it a bit (and also cover Ævar's
"what exactly does violate mean here" question).

-Peff

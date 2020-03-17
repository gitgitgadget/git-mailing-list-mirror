Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C209C10F29
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 17:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CEE20663
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 17:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCQRSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:18:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:41932 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726619AbgCQRSz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 13:18:55 -0400
Received: (qmail 3592 invoked by uid 109); 17 Mar 2020 17:18:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Mar 2020 17:18:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8034 invoked by uid 111); 17 Mar 2020 17:28:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Mar 2020 13:28:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Mar 2020 13:18:53 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Conditional newline in pretty format
Message-ID: <20200317171853.GA6598@coredump.intra.peff.net>
References: <CAHd499DiCi3FJb9qWJNBNKyVQg_zYMgJRuYcH_pOP3LnGwk5Tg@mail.gmail.com>
 <CAHd499B+ro+d0bGA+-Y1Qnfkc1vMzXCnBfZmtZv+CscUXim=wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499B+ro+d0bGA+-Y1Qnfkc1vMzXCnBfZmtZv+CscUXim=wQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 17, 2020 at 10:37:13AM -0500, Robert Dailey wrote:

> > It works perfectly right now except for the case where `%b` is empty.
> > In that case, I just want one newline after `%s` instead of 2. Is
> > there a way to make my second `%n` conditional on `%b` having a value?
> [...]
> Another solution I tried is `%+b`, based on this documentation:

That's what I would have suggested. And it does seem to work if you do:

  git log --format='* %s%n%+b'

but not when you add in the indentation and wrapping:

  git log --format='* %s%n%w(100,2,2)%+b'

Which is unfortunate, but I think makes sense: the wrapping sees the
extra newline as part of the text to be wrapped, so it gets folded into
the first line.

I think what you really want is a conditional that can cover multiple
placeholders, and put the wrapped body inside that. You can do that with
the for-each-ref placeholders, which have a real "%(if)...%(end)" block.
But I don't think the pretty-format placeholders have an equivalent. It
would be nice to unify them one day, but progress has been slow on that
front.

I wonder in the meantime if it would be possible to introduce a block
syntax to the pretty formats, like:

  git log --format='* %s%n%+{%w(100,2,2)%b}'

or something. I don't know the conditional code well enough to say
whether that would be a trivial patch or a horribly complicated one. :)

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44CEC433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 21:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E76E6112F
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 21:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbhIVVUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 17:20:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:52998 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237770AbhIVVUF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 17:20:05 -0400
Received: (qmail 11789 invoked by uid 109); 22 Sep 2021 21:18:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Sep 2021 21:18:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18817 invoked by uid 111); 22 Sep 2021 21:18:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Sep 2021 17:18:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Sep 2021 17:18:33 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
Message-ID: <YUudqYmzy9N3e0Bk@coredump.intra.peff.net>
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
 <xmqq8rzo770h.fsf@gitster.g>
 <YUuNXOb5blV7iN6P@coredump.intra.peff.net>
 <xmqqk0j85o6c.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0j85o6c.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 01:51:39PM -0700, Junio C Hamano wrote:

> >> Neither pattern of the above two will not match the HTTP/2 one, so
> >> the first one would report "there is no leakage of Auth with a
> >> caplital letter"; the second one may see only one pre-upgrade Auth
> >> with a capital letter, but as long as it does find one, it should be
> >> happy, no?
> >> 
> >> I am a bit puzzled how the test gets confused.
> >
> > The first one matches nothing, because the HTTP/2 one which fails to
> > redact has a lower-case "A". The second one _does_ match, because ...
> 
> I thought we were talking about the original case sensitive test
> getting confused when testing the software that is fixed,
> i.e. HTTP/2 lowercase "authorization" line properly redacted.

No, sorry. I meant: before the fix, even if we were running HTTP/2, the
test does not detect the bug. And thus it is hard to realize that the
fix is indeed making the bug go away. :)

> > I get (with some extraneous headers omitted):
> > ...
> >   => Send header: GET /auth/smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1
> >   => Send header: Authorization: Basic <redacted>
> 
> So, this is what we see in HTTP/1.1 (with capitalization).  And then
> ...
> 
> > ...
> >   => Send header: POST /auth/smart/repo.git/git-upload-pack HTTP/2
> >   => Send header: authorization: Basic dXNlckBob3N0OnBhc3NAaG9zdA==
> 
> this one, once the redaction code is fixed by applying this patch,
> would show that we redacted it, too, no?

Correct. But the test, without switching to "grep -i", does not realize
that.

> With or without the fix in the code, I agree that neither of the two
> "grep" patterns without "grep -i" change will match this line.  So
> the end result is that the test finds no unredacted line, and one
> redacted one (instead of two).
> 
> I agree that it is *not* testing what we want to test, and if you
> said so, I wouldn't have been puzzled.  I just wanted to know if
> there is something _else_ (other than "gee, we are not testing the
> HTTP/2 case at all") going on that I failed to read in your
> "... gets confused".

No, I think we are on the same page now. Do you want me to take
another stab at writing the commit message to clarify things (i.e., do
we think it's badly written, or was it just mis-interpreted)?

-Peff

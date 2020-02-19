Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A1DC34031
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 02:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93143206DB
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 02:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgBSCFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:05:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:47570 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726761AbgBSCFv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 21:05:51 -0500
Received: (qmail 21375 invoked by uid 109); 19 Feb 2020 02:05:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Feb 2020 02:05:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24206 invoked by uid 111); 19 Feb 2020 02:14:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 21:14:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 21:05:50 -0500
From:   Jeff King <peff@peff.net>
To:     Robear Selwans <rwagih.rw@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>
Subject: Re: [GSoC][RFC][PATCH 2/2] STRBUF_INIT_CONST: Adapting strbuf_*
 functions
Message-ID: <20200219020550.GA81751@coredump.intra.peff.net>
References: <CAHk66fskrfcJ0YFDhfimVBTJZB4um7r=GdQuM8heJdZtF8D7UQ@mail.gmail.com>
 <xmqq36b7k4i6.fsf@gitster-ct.c.googlers.com>
 <CALH1-Xr3HVZzDn2-9EvmdiBWmxWQ-zfExM2LNJyR1wR+dgxRSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALH1-Xr3HVZzDn2-9EvmdiBWmxWQ-zfExM2LNJyR1wR+dgxRSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 03:43:26AM +0200, Robear Selwans wrote:

> On Tue, Feb 18, 2020 at 10:46 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> > >> STRBUF_INIT_CONST: a new way to initialize strbuf
> > > Use imperative mood and be more specific in the commit title -
> > > `strbuf: Teach strbuf to initialize immutable strings`
> > s/T/t/;
> I don't get what you mean by that.

We don't usually capitalize the sentence fragment in a subject line
(hence "replace T with t", but said in sed jargon).

> > Also, isn't "if (sb->alloc < sb->len)" too loose a check for the new
> > feature?  AFAICS in 1/2, a strbuf that is still borrowing a const
> > string always has sb->alloc==0.  Other instances of strbuf that
> > happens to satisify the above condition, e.g. (sb->len == 5 &&
> > sb->alloc == 1), is an error.  If we are to check the condition
> > about sb->len, shouldn't we diagnose such a case as an error, no?
> AFAIK after reading the documentation for `strbuf`, there is no other
> case where `sb->len > sb->alloc` as `alloc` needs to always be more
> than `len`. I'd like to be corrected if mistaken, though.

Yeah, I don't see how it could be for an allocated buffer, since that
would imply writing past the allocated size.

> > As Peff, I am a bit hesitant about leaving a strbuf that hasn't been
> > made mutable around, though.
> Yeah, I started to get that when I read Peff's reply. I think I'll go with
> the approach that Peff suggested, where the constant string is
> copied to a stack array and so is made mutable to a degree. Since
> this is a different way, I guess I'll make that from scratch instead of
> editing the existing one.

Yeah, I think it's sufficiently different to start from scratch. Do note
that I think you may need to stuff an extra bit into the struct somehow.
For a const string, you can set alloc to "0" to denote the situation.
But if we're going to be able to attach another buffer that can be
written to (but may not yet be full), you'd need to be able to set alloc
to the true size of that buffer. And then we need some way to note that
it's not a real heap buffer.

There are probably clever tricks you could play with the low bits of the
"alloc" field to avoid making the struct any bigger. But given the way
we use strbufs, I suspect it may not bring a measurable performance
improvement. And I do have dreams of eventually adding more bits. E.g.,
there are a few cases where it would be convenient to extend the "strbuf
that points to a stack buffer but grows" into "strbuf that points to a
stack buffer but truncates" (e.g., in our error handling routines which
want to avoid calling malloc).

That's definitely a few steps out from where we are now, of course, but
we may get there eventually.

-Peff

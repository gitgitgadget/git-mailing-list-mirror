Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEACC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB8960F3A
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 21:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbhJLVsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:48:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:38094 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233650AbhJLVsN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 17:48:13 -0400
Received: (qmail 1765 invoked by uid 109); 12 Oct 2021 21:46:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Oct 2021 21:46:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18200 invoked by uid 111); 12 Oct 2021 21:46:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Oct 2021 17:46:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Oct 2021 17:46:10 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [External Mail]Re: why git is so slow for a tiny git push?
Message-ID: <YWYCIndv/u67lNQU@coredump.intra.peff.net>
References: <c5a8595658d6416684c2bbd317494c49@xiaomi.com>
 <5a6f3e8f29f74c93bf3af5da636df973@xiaomi.com>
 <576b2f3e162e4f86992d8f4e680d0881@xiaomi.com>
 <YWRr9g32cMlIc37V@coredump.intra.peff.net>
 <ef2aa0d3ea8a4d98b910abdfd55191d0@xiaomi.com>
 <YWVJyRJhRTdg39tX@coredump.intra.peff.net>
 <87pmsak0hl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pmsak0hl.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 12, 2021 at 12:06:04PM +0200, Ævar Arnfjörð Bjarmason wrote:

> But more generally with these side-indexes it seems to me that the code
> involved might not be considering these sorts of edge cases, i.e. my
> understanding from you above is that if we have bitmaps anywhere we'll
> try to in-memory use them for all the objects in play? Or that otherwise
> having "partial" bitmaps leads to pathological behavior.

Sure, if there was an easy way to know beforehand whether the bitmap was
going to help or run into these pathological cases, it would be nice to
detect it. I don't know what that is (and I've given it quite a lot of
thought over the past 8 years).

I suspect the most direction would be to teach the bitmap code to behave
more like the regular traversal by just walking down to the
UNINTERESTING commits. Right now it gets a complete bitmap for the
commits we don't want, and then a bitmap for the ones we do want, and
takes a set difference.

It could instead walk both sides in the usual way, filling in the bitmap
for each, and then stop when it hits boundary commits. The bitmap for
the boundary commit (if we don't have a full one on-disk) is filled in
with what's in its tree. That means it's incomplete, and the result
might include some extra objects (e.g., if boundary~100 had a blob that
went away, but later came back in a descendant that isn't marked
uninteresting). That's the same tradeoff the non-bitmap traversal makes.

It would be pretty major surgery to the bitmap code. I haven't actually
tried it before.

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9D1C433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 18:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244016AbhKXSSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:18:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:37794 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350425AbhKXSSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 13:18:16 -0500
Received: (qmail 29261 invoked by uid 109); 24 Nov 2021 18:15:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Nov 2021 18:15:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16281 invoked by uid 111); 24 Nov 2021 18:15:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Nov 2021 13:15:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Nov 2021 13:15:02 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [External Mail]Re: why git is so slow for a tiny git push?
Message-ID: <YZ6BJpAY4ZAWaqkr@coredump.intra.peff.net>
References: <c5a8595658d6416684c2bbd317494c49@xiaomi.com>
 <5a6f3e8f29f74c93bf3af5da636df973@xiaomi.com>
 <576b2f3e162e4f86992d8f4e680d0881@xiaomi.com>
 <YWRr9g32cMlIc37V@coredump.intra.peff.net>
 <ef2aa0d3ea8a4d98b910abdfd55191d0@xiaomi.com>
 <YWVJyRJhRTdg39tX@coredump.intra.peff.net>
 <87pmsak0hl.fsf@evledraar.gmail.com>
 <YWYCIndv/u67lNQU@coredump.intra.peff.net>
 <56994f02ed4542b89cc6f9586d703e05@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56994f02ed4542b89cc6f9586d703e05@xiaomi.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 23, 2021 at 06:42:12AM +0000, 程洋 wrote:

> I got another problem here.
> When I tries to clone from remote server. It took me 25 seconds to enumerating objects. And then 1 second to `couting objects` by bitmap.
> I don't understand, why a fresh clone need `enumerating objects` ? Is `couting objects` enough for the server to determine what to send?

In older versions of Git, the "counting objects" progress meter used to
be the actual object graph traversal. That changed in v2.18 (via
5af050437a), but you may still seem some reference to "counting objects
is expensive".

These days that is called "enumerating objects", and "counting objects"
is just doing a quick-ish pass over that list to do some light analysis
(e.g., if we can reuse an on-disk delta). I'd expect "enumerating" to be
expensive in general, and "counting" to be quick in general.

The "enumerating" phase is where we determine what to send whether it's
for a clone or a fetch, and may involve opening up a bunch of trees to
walk the graph. It's what reachability bitmaps are supposed to make
faster. But if you have 300k refs, as you've mentioned, you almost
certainly don't have complete coverage of all of the ref tips, so we'll
have to fallback to doing at least a partial graph traversal.

Taylor (cc'd) has been looking at some tricks for speeding up cases like
this with a lot of refs. But I don't think there's anything to show
publicly yet.

-Peff

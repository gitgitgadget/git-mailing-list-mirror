Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DB1C433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 12:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE18A60F9C
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 12:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhIDMli (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 08:41:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:39308 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230426AbhIDMlh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 08:41:37 -0400
Received: (qmail 32464 invoked by uid 109); 4 Sep 2021 12:40:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Sep 2021 12:40:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11289 invoked by uid 111); 4 Sep 2021 12:40:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Sep 2021 08:40:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Sep 2021 08:40:35 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>
Subject: [hacky PATCH 0/2] speeding up trivial for-each-ref invocations
Message-ID: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Somebody complained to me off-list recently that for-each-ref was slow
when doing a trivial listing (like refname + objectname) of a large
number of refs, even though you could get mostly the same output by
just dumping the packed-refs file.

So I was nerd-sniped into making this horrible series, which does speed
up some cases. It was a combination of "how fast can we easily get it",
plus I was curious _which_ parts of for-each-ref were actually slow.

In this version there are 2 patches, tested against 'git for-each-ref
--format="%(objectname) %(refname)"' on a fully packed repo with 500k
refs:

  - directly outputting items rather than building up a ref_array yields
    about a 1.5x speedup

  - avoiding the whole atom-formatting system yields a 2.5x speedup on
    top of that

I had originally written it against a slightly older version of Git,
before show_ref_array_item() was inlined. In that version, there was a
middle ground where we still created a ref_array_item for each ref, and
then fed it to the "quick" formatter (so we could see the cost of
having to malloc/free a bunch of ref_array_item structs). The numbers
there wre:

  - streaming out items gave a 1.5x speedup

  - using the "quick" formatter gave a 1.8x speedup

  - avoiding the extra malloc/free for each item gave a 1.4x

which makes sense; 1.8 * 1.4 is ~2.5, so it's the same speedup just
broken down further.

I'm not sure I'm really advocating that we should do something like
this, though it is tempting because it does make some common queries
much faster. But I wanted to share it here to give some insight on where
the time may be going in ref-filter / for-each-ref.

  [1/2]: ref-filter: hacky "streaming" mode
  [2/2]: ref-filter: implement "quick" formats

 builtin/for-each-ref.c |   7 +++
 ref-filter.c           | 113 +++++++++++++++++++++++++++++++++++++----
 ref-filter.h           |  21 ++++++++
 3 files changed, 132 insertions(+), 9 deletions(-)

-Peff

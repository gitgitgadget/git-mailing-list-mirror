Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DAAD202BB
	for <e@80x24.org>; Thu,  4 Apr 2019 23:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfDDXVH (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 19:21:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:47386 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728842AbfDDXVG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 19:21:06 -0400
Received: (qmail 1375 invoked by uid 109); 4 Apr 2019 23:21:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 23:21:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20332 invoked by uid 111); 4 Apr 2019 23:21:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Apr 2019 19:21:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2019 19:21:04 -0400
Date:   Thu, 4 Apr 2019 19:21:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/12] a rabbit hole of update-server-info fixes
Message-ID: <20190404232104.GA27770@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series started with patch 12: I just wanted to drop the
unused "force" parameter from update_info_refs().

But that made me look at its sibling update_info_packs(), and whether it
needs its force parameter. It _does_ in fact do something (though I am
slightly doubtful that anybody actually cares in practice).

However, I did see a memory bug in its parser, which is fixed by patch
6. And a bunch of other cleanups, which are patches 7-11. Fortunately
that buggy parser is not used to look at info/packs files we pull over
dumb-http; it has its own parser. So I looked at that, and of course it
had a bug, too (fixed in patch 5).

And in those cleanups, I needed to get the basename of a pack from its
packed_git. So I looked for other code that did the same, in case we
could benefit from a shared helper. And behold, the midx code does. But
you guessed it, there was a bug (actually 2). Fixed in patches 4 (with
necessary refactoring in patch 3).

And while constructing a test for that bug, I noticed that one of the
other tests in t5319 was buggy. So that's patch 1 (with some cleanup in
patch 2).

And here we are. I present them here in reverse rabbit-hole order (which
is also roughly important fixes first, and minor cleanups last). The
individual chunks are mostly independent, but the server-info cleanups
rely on the shared pack_basename() helper added as part of the midx fix.

  [01/12]: t5319: fix bogus cat-file argument
  [02/12]: t5319: drop useless --buffer from cat-file
  [03/12]: packfile: factor out .pack to .idx name conversion
  [04/12]: packfile: check midx coverage with .idx rather than .pack
  [05/12]: http: simplify parsing of remote objects/info/packs
  [06/12]: server-info: fix blind pointer arithmetic
  [07/12]: server-info: simplify cleanup in parse_pack_def()
  [08/12]: server-info: use strbuf to read old info/packs file
  [09/12]: server-info: drop nr_alloc struct member
  [10/12]: packfile.h: drop extern from function declarations
  [11/12]: server-info: drop objdirlen pointer arithmetic
  [12/12]: update_info_refs(): drop unused force parameter

 http.c                      | 35 ++++++---------
 packfile.c                  | 31 ++++++++++---
 packfile.h                  | 86 ++++++++++++++++++++-----------------
 server-info.c               | 57 +++++++++++-------------
 t/t5319-multi-pack-index.sh | 29 ++++++++++---
 5 files changed, 132 insertions(+), 106 deletions(-)

-Peff

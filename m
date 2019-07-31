Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 323301F731
	for <e@80x24.org>; Wed, 31 Jul 2019 04:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfGaEhB (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 00:37:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:56494 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726439AbfGaEhB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 00:37:01 -0400
Received: (qmail 11340 invoked by uid 109); 31 Jul 2019 04:37:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 04:37:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13543 invoked by uid 111); 31 Jul 2019 04:38:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 00:38:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 00:37:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/6] harden tree-walking against integer overflow
Message-ID: <20190731043659.GA27028@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed that it's possible to get funny integer over/underflows with
tree-walk's traverse_info (with specially-crafted absurdly-sized tree
paths). I wasn't able to turn this into an actual buffer overflow
because the funky sizes cause allocation failures way before we ever get
into make_traverse_path(). But it makes sense to protect ourselves
anyway.

The first two patches are an unrelated memory problem I found (and
they're here in the same series because I build on the cleanups). I
don't think it's security-relevant, though; it involves reading from
uninitialized heap memory, but we don't actually _do_ anything with the
result. We just copy uninitialized bytes from one heap buffer to the
other, and then never look at them again.

  [1/6]: setup_traverse_info(): stop copying oid
  [2/6]: tree-walk: drop oid from traverse_info
  [3/6]: tree-walk: use size_t consistently
  [4/6]: tree-walk: accept a raw length for traverse_path_len()
  [5/6]: tree-walk: add a strbuf wrapper for make_traverse_path()
  [6/6]: tree-walk: harden make_traverse_path() length computations

 Documentation/technical/api-tree-walking.txt |  8 ++-
 builtin/merge-tree.c                         |  5 +-
 cache-tree.c                                 |  2 +-
 tree-walk.c                                  | 64 +++++++++++------
 tree-walk.h                                  | 18 +++--
 unpack-trees.c                               | 74 +++++++++++---------
 6 files changed, 103 insertions(+), 68 deletions(-)

-Peff

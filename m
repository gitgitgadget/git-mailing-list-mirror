Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F34171F437
	for <e@80x24.org>; Fri, 27 Jan 2017 22:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbdA0WC5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 17:02:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:46090 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750873AbdA0WCy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 17:02:54 -0500
Received: (qmail 32675 invoked by uid 109); 27 Jan 2017 22:01:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 22:01:46 +0000
Received: (qmail 10318 invoked by uid 111); 27 Jan 2017 22:01:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 17:01:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jan 2017 17:01:44 -0500
Date:   Fri, 27 Jan 2017 17:01:44 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/2] limit reused delta chains based on --depth
Message-ID: <20170127220143.boo5phhgogqlucsj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back when we switched pack-objects to visiting packs in
most-recently-used order last August, we realized that this could reuse
cross-pack deltas, and that the result could have longer delta chains
than any single pack contains.

I produced a patch back then[1], but we decided not to follow through
with it. Two things happened to make me revive that patch:

  1. I hit a case in the wild with a really long delta chain that caused
     pack-objects' write_one() to run out of stack space.

  2. We dropped the --aggressive depth to match the normal one. So
     there's less concern about mismatches throwing out on-disk deltas
     from a previous aggressive repack (but see the caveats in the first
     patch's commit message).

So here it is, plus another patch that converts the recursion to
iteration (the stack space needed by the function is small enough that
just the first patch was enough to fix my problem case, but it seemed
like tempting fate to leave it recursive).

  [1/2]: pack-objects: enforce --depth limit in reused deltas
  [2/2]: pack-objects: convert recursion to iteration in break_delta_chain()

 builtin/pack-objects.c      | 133 ++++++++++++++++++++++++++++++++++++--------
 pack-objects.h              |   4 ++
 t/t5316-pack-delta-depth.sh |  93 +++++++++++++++++++++++++++++++
 3 files changed, 207 insertions(+), 23 deletions(-)
 create mode 100755 t/t5316-pack-delta-depth.sh

-Peff

[1] http://public-inbox.org/git/20160811095710.p2bffympjlwmv3gc@sigill.intra.peff.net/

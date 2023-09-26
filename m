Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F4CE8181D
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 05:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjIZFzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 01:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIZFzE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 01:55:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A5DE9
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 22:54:57 -0700 (PDT)
Received: (qmail 14741 invoked by uid 109); 26 Sep 2023 05:54:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Sep 2023 05:54:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21392 invoked by uid 111); 26 Sep 2023 05:54:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Sep 2023 01:54:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Sep 2023 01:54:52 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 0/6] some "commit-graph verify" fixes for chains
Message-ID: <20230926055452.GA1341109@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While yak-shaving another topic, I noticed that there are a bunch of
error cases that "git commit-graph verify" does not notice when checking
chained graph files. This series should make it more robust.

Some of these cases are actually covered in t5324 already, but the tests
expect the verify command not to fail, which just seems wrong. I don't
see anything in the commit message or mailing list explaining it, so I
think it was just "well, this is how it behaves now", and not some
clever scheme.

  [1/6]: commit-graph: factor out chain opening function
  [2/6]: commit-graph: check mixed generation validation when loading chain file
  [3/6]: t5324: harmonize sha1/sha256 graph chain corruption
  [4/6]: commit-graph: detect read errors when verifying graph chain
  [5/6]: commit-graph: tighten chain size check
  [6/6]: commit-graph: report incomplete chains during verification

 builtin/commit-graph.c        |  31 +++++++---
 commit-graph.c                | 109 ++++++++++++++++++++++------------
 commit-graph.h                |   4 ++
 t/t5324-split-commit-graph.sh |  48 +++++++++++++--
 4 files changed, 141 insertions(+), 51 deletions(-)

-Peff

PS If you are curious about the yak-shave, it is:

     3. "commit-graph verify" fails to propagate some errors (this
	series)
     2. we are missing a bunch of bounds checks on commit-graph files;
	fixing that makes the tests inconsistent because of (3)
     1. there are some unused parameters that should be used for bounds
	checks, hence (2)

  Just in case anybody thought there was a part of my life that was not
  motivated by removing -Wunused-parameter warnings.

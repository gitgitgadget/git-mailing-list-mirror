Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A159C202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 20:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbdKTU0Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 15:26:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:35014 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752422AbdKTU0O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 15:26:14 -0500
Received: (qmail 3896 invoked by uid 109); 20 Nov 2017 20:26:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 Nov 2017 20:26:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15774 invoked by uid 111); 20 Nov 2017 20:26:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 20 Nov 2017 15:26:25 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Nov 2017 15:26:07 -0500
Date:   Mon, 20 Nov 2017 15:26:07 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/5] avoiding pointless pack-directory re-scans
Message-ID: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently dug into a performance problem running "git fetch" in a
repository with 5000 packs. Now obviously that's a silly number of packs
to have, but I did find some pretty low-hanging fruit.  Most of the time
was spent in pointlessly re-scanning the objects/pack directory.

This series has two fixes, along with a perf test that covers this case.
I think the perf test is especially important here because we actually
fixed one of these cases (patch 4) already, but later regressed it
without noticing. The perf suite could have caught that (and would after
this series).

There are numbers in the individual commits, but here's the before/after
for the whole series:

Test            origin            HEAD
--------------------------------------------------------
5551.4: fetch   5.48(4.99+0.50)   0.14(0.09+0.05) -97.4%

That's on a somewhat-contrived setup meant to maximize us noticing a
regression. But I do think these re-scans are probably kicking in for
normal situations, but just aren't quite expensive enough for anybody to
have noticed and dug into it.

Patches:

  [1/5]: p5550: factor our nonsense-pack creation
  [2/5]: t/perf/lib-pack: use fast-import checkpoint to create packs
  [3/5]: p5551: add a script to test fetch pack-dir rescans
  [4/5]: everything_local: use "quick" object existence check
  [5/5]: sha1_file: don't re-scan pack directory for null sha1

 fetch-pack.c                 |  3 ++-
 sha1_file.c                  |  3 +++
 t/perf/lib-pack.sh           | 25 ++++++++++++++++++++
 t/perf/p5550-fetch-tags.sh   | 25 ++------------------
 t/perf/p5551-fetch-rescan.sh | 55 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 87 insertions(+), 24 deletions(-)
 create mode 100644 t/perf/lib-pack.sh
 create mode 100755 t/perf/p5551-fetch-rescan.sh

-Peff

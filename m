Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A54207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbcJCUd0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:33:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:51407 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751821AbcJCUdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:33:25 -0400
Received: (qmail 17108 invoked by uid 109); 3 Oct 2016 20:33:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:33:24 +0000
Received: (qmail 29606 invoked by uid 111); 3 Oct 2016 20:33:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:33:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:33:22 -0400
Date:   Mon, 3 Oct 2016 16:33:22 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 0/18] alternate object database cleanups
Message-ID: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is the result of René nerd-sniping me with the claim that we
could "easily" teach count-objects to print out the list of alternates
in:

  http://public-inbox.org/git/c27dc1a4-3c7a-2866-d9d8-f5d3eb161650@web.de/

My real goal is just patch 17, which is needed for the quarantine series
in that thread. But along the way there were quite a few opportunities
for cleanups along with a few minor bugfixes (in patches 7 and 18), and
I think the count-objects change in patch 16 is a nice general debugging
tool.

The rest of it is "just" cleanup, but I'll note that it clears up some
hairy allocation code. These were bits that I noticed in my big
allocation-cleanup series last year, but were too nasty to fit any of
the more general fixes. I think the end result is much better.

The number of patches is a little intimidating, but I tried hard to
break the refactoring down into a sequence of obviously-correct steps.
You can be the judge of my success.

  [01/18]: t5613: drop reachable_via function
  [02/18]: t5613: drop test_valid_repo function
  [03/18]: t5613: use test_must_fail
  [04/18]: t5613: whitespace/style cleanups
  [05/18]: t5613: do not chdir in main process
  [06/18]: t5613: clarify "too deep" recursion tests
  [07/18]: link_alt_odb_entry: handle normalize_path errors
  [08/18]: link_alt_odb_entry: refactor string handling
  [09/18]: alternates: provide helper for adding to alternates list
  [10/18]: alternates: provide helper for allocating alternate
  [11/18]: alternates: encapsulate alt->base munging
  [12/18]: alternates: use a separate scratch space
  [13/18]: fill_sha1_file: write "boring" characters
  [14/18]: alternates: store scratch buffer as strbuf
  [15/18]: fill_sha1_file: write into a strbuf
  [16/18]: count-objects: report alternates via verbose mode
  [17/18]: sha1_file: always allow relative paths to alternates
  [18/18]: alternates: use fspathcmp to detect duplicates

 Documentation/git-count-objects.txt |   5 +
 builtin/count-objects.c             |  12 +++
 builtin/fsck.c                      |  10 +-
 builtin/submodule--helper.c         |  11 +-
 cache.h                             |  36 ++++++-
 sha1_file.c                         | 179 ++++++++++++++++++--------------
 sha1_name.c                         |  17 +--
 strbuf.c                            |  20 ++++
 strbuf.h                            |   8 ++
 submodule.c                         |  23 +---
 t/t5613-info-alternate.sh           | 202 ++++++++++++++++++++----------------
 transport.c                         |   4 +-
 12 files changed, 305 insertions(+), 222 deletions(-)


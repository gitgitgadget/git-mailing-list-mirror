Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DACA208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 12:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbdIEMN4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 08:13:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:57118 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750857AbdIEMNz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 08:13:55 -0400
Received: (qmail 31206 invoked by uid 109); 5 Sep 2017 12:13:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 12:13:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12144 invoked by uid 111); 5 Sep 2017 12:14:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 08:14:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 08:13:53 -0400
Date:   Tue, 5 Sep 2017 08:13:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/20] allowing struct lock_file to be deleted
Message-ID: <20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the beginning of time, our code base has had the rule that the
storage for a "struct lock_file" can never go out of scope once it has
been used. This leads to lots of intentional leaks of these structs.

I think it's unlikely that any of the leaks produces truly terrible
behavior, simply because we tend to do a limited number of operations
from a given program (and the structs aren't that big to begin with).
But they make finding _actual_ leaks much harder by polluting
leak-checker output.

And I have to admit that they've just always bugged me.

This series make it possible to free them (and in IMHO makes it harder
to misuse the API in general). I also found a number of interesting
corner cases that turned out to be bugs in the existing code (albeit
quite minor). I've floated the existing fixes to the front, followed by
some preparatory cleanups. The meat is in patches 17 and 18, and then
the last few patches use the new system to clean up some leaks.

There are almost certainly more leaks that can be cleaned. I didn't do
an exhaustive search, but just covered all the ones triggered by t0000
and t0001 (which I've been doggedly trying to get to run clean in a
leak-checker; more on that in a moment).

  [01/20]: write_index_as_tree: cleanup tempfile on error
  [02/20]: setup_temporary_shallow: avoid using inactive tempfile
  [03/20]: setup_temporary_shallow: move tempfile struct into function
  [04/20]: verify_signed_buffer: prefer close_tempfile() to close()
  [05/20]: always check return value of close_tempfile
  [06/20]: tempfile: do not delete tempfile on failed close
  [07/20]: lockfile: do not rollback lock on failed close
  [08/20]: tempfile: prefer is_tempfile_active to bare access
  [09/20]: tempfile: handle NULL tempfile pointers gracefully
  [10/20]: tempfile: replace die("BUG") with BUG()
  [11/20]: tempfile: factor out activation
  [12/20]: tempfile: factor out deactivation
  [13/20]: tempfile: robustify cleanup handler
  [14/20]: tempfile: release deactivated strbufs instead of resetting
  [15/20]: tempfile: use list.h for linked list
  [16/20]: tempfile: remove deactivated list entries
  [17/20]: tempfile: auto-allocate tempfiles on heap
  [18/20]: lockfile: update lifetime requirements in documentation
  [19/20]: ref_lock: stop leaking lock_files
  [20/20]: stop leaking lock structs in some simple cases

 builtin/gc.c               |   8 +-
 builtin/reset.c            |   6 +-
 builtin/update-index.c     |  11 +--
 cache-tree.c               |  37 ++++----
 config.c                   |  24 ++---
 credential-cache--daemon.c |   5 +-
 diff.c                     |  15 ++-
 gpg-interface.c            |  16 ++--
 list.h                     |  38 ++++++++
 lockfile.c                 |   7 +-
 lockfile.h                 |  58 ++++++------
 read-cache.c               |  32 ++++---
 refs/files-backend.c       |  50 +++++-----
 refs/packed-backend.c      |  14 +--
 shallow.c                  |  16 ++--
 tempfile.c                 | 232 +++++++++++++++++++++++----------------------
 tempfile.h                 | 123 +++++++++++-------------
 trailer.c                  |   6 +-
 18 files changed, 358 insertions(+), 340 deletions(-)

-Peff

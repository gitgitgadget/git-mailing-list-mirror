Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 462321F453
	for <e@80x24.org>; Mon,  5 Nov 2018 06:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbeKEPz1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 10:55:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:40348 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729398AbeKEPz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 10:55:26 -0500
Received: (qmail 21439 invoked by uid 109); 5 Nov 2018 06:37:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Nov 2018 06:37:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17048 invoked by uid 111); 5 Nov 2018 06:36:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Nov 2018 01:36:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2018 01:37:18 -0500
Date:   Mon, 5 Nov 2018 01:37:18 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/13] parseopt fixes from -Wunused-parameters
Message-ID: <20181105063718.GA24877@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continuing my exploration of what -Wunused-parameters can show us, here
are some bug-fixes related to parse-options callbacks.

This is the last of the actual bug-fixes I've found. After this, I have
about 60 patches worth of cleanups (i.e., dropping the unused
parameters), and then I have a series to annotate parameters that must
be unused (e.g., for functions that must conform to callback
interfaces). After we can start compiling with -Wunused-parameters,
assuming we don't find the annotations too cumbersome.

But this series fixes real bugs. These first four fix segfaults:

  [01/13]: apply: mark include/exclude options as NONEG
  [02/13]: am: handle --no-patch-format option
  [03/13]: ls-files: mark exclude options as NONEG
  [04/13]: pack-objects: mark index-version option as NONEG

And these four fix cases where we just quietly do the wrong thing:

  [05/13]: cat-file: mark batch options with NONEG
  [06/13]: status: mark --find-renames option with NONEG
  [07/13]: format-patch: mark "--no-numbered" option with NONEG
  [08/13]: show-branch: mark --reflog option as NONEG

These ones are just message improvements:

  [09/13]: tag: mark "--message" option with NONEG
  [10/13]: cat-file: report an error on multiple --batch options
  [11/13]: apply: return -1 from option callback instead of calling exit(1)

This one is a segfault, but it has no callers. ;)

  [12/13]: parse-options: drop OPT_DATE()

And then this last one is mostly about annotating the callbacks. It
doesn't strictly need to happen here, but the alternative is that I'd
eventually have to deal with it in the later series I mentioned.

  [13/13]: assert NOARG/NONEG behavior of parse-options callbacks

 apply.c                       | 24 +++++++++++++++++++++---
 builtin/am.c                  |  4 +++-
 builtin/blame.c               |  4 ++++
 builtin/cat-file.c            | 10 +++++++---
 builtin/checkout-index.c      |  2 ++
 builtin/clean.c               |  1 +
 builtin/commit.c              |  5 ++++-
 builtin/fetch.c               |  2 ++
 builtin/grep.c                | 14 +++++++++++++-
 builtin/init-db.c             |  1 +
 builtin/interpret-trailers.c  |  2 ++
 builtin/log.c                 | 12 +++++++++++-
 builtin/ls-files.c            | 14 +++++++++++---
 builtin/merge-file.c          |  2 ++
 builtin/merge.c               |  1 +
 builtin/notes.c               |  7 +++++++
 builtin/pack-objects.c        |  5 ++++-
 builtin/read-tree.c           |  3 +++
 builtin/rebase.c              |  6 ++++++
 builtin/show-branch.c         |  3 ++-
 builtin/show-ref.c            |  1 +
 builtin/tag.c                 |  6 ++++--
 builtin/update-index.c        | 21 +++++++++++++++++++--
 parse-options-cb.c            | 14 +++++++-------
 parse-options.h               | 18 ++++++++++++++----
 ref-filter.c                  |  2 ++
 t/helper/test-parse-options.c |  2 +-
 t/t0040-parse-options.sh      | 22 ----------------------
 28 files changed, 155 insertions(+), 53 deletions(-)

-Peff

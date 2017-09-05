Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47F46208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 13:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbdIENBx (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 09:01:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:57280 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750932AbdIENBw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 09:01:52 -0400
Received: (qmail 1884 invoked by uid 109); 5 Sep 2017 13:01:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 13:01:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12697 invoked by uid 111); 5 Sep 2017 13:02:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 09:02:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 09:01:50 -0400
Date:   Tue, 5 Sep 2017 09:01:50 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/10] towards clean leak-checker output
Message-ID: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using leak-checking tools like valgrind or LSAN is usually not all that
productive with Git, because the output is far from clean. And _most_ of
these are just not interesting, as they're either:

  1. Real leaks, but ones that only be triggered a small, set number of
     times per program.

  2. Intentional leaks of variables as the main cmd_* functions go out
     of scope (as opposed to manually cleaning).

I focused here on getting t0000 and t0001 to run clean against a
leak-checking tool. That's a fraction of the total test suite, but my
goal was have a tractable sample which could let us see if the path
seems sane.

I feel positive overall about the approach this series takes. The
suppressions aren't too terrible to write, and I found some real (albeit
minor) leaks in these few tests. I hope it can serve as a base for an
ongoing effort to get the whole test suite clean.

A few things to note:

  - I switched from valgrind to ASAN/LSAN early on. It's just way
    faster, which makes the compile-test-fix cycle a lot more pleasant.
    With these patches, you should be able to do:

      make SANITIZE=leak && (cd t && ./t1234-* -v -i)

    and get a leak report for a single script dumped to stderr.

    If you want to try it with t0000, you'll need the lock-file series I
    just posted at:

      https://public-inbox.org/git/20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net/

    and the fix from Martin at:

      https://public-inbox.org/git/CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com/

    to get a clean run.

  - I'm using LSAN instead of the full-on ASAN because it's faster. The
    docs warn that it's a bit experimental, and I did notice a few funny
    behaviors (like truncated backtraces), but overall it seems fine.
    You can also do:

      make SANITIZE=address &&
        (cd t && ASAN_OPTIONS=abort_on_error=1 ./t1234-* -v -i)

    to do a full ASAN run (the extra environment setting is necessary to
    override test-lib's defaults).

  - gcc's leak-checker doesn't seem to handle reachability correctly (or
    maybe I'm holding it wrong). As a simple case, building with ASAN
    and running git-init complains:

      $ make SANITIZE=address && ./git init foo
      ...
      Direct leak of 2 byte(s) in 1 object(s) allocated from:
          #0 0x7f011dc699e0 in malloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xd99e0)
          #1 0x558eeedbdab5 in do_xmalloc /home/peff/compile/git/wrapper.c:60
          #2 0x558eeedbdbab in do_xmallocz /home/peff/compile/git/wrapper.c:100
          #3 0x558eeedbdd0d in xmallocz /home/peff/compile/git/wrapper.c:108
          #4 0x558eeedbdd0d in xmemdupz /home/peff/compile/git/wrapper.c:124
          #5 0x558eeedbdd0d in xstrndup /home/peff/compile/git/wrapper.c:130
          #6 0x558eeea0507a in main /home/peff/compile/git/common-main.c:39
          #7 0x7f011cf612e0 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x202e0)

    That line is the setting of argv0_path, which is a global (and thus
    shouldn't be marked as leaking). Interestingly, it only happens with
    -O2. Compiling with -O0 works fine. I'm not sure if it's a bug or
    what.

    I did most of my testing with clang-6.0, which gets this case right.

  - I have no idea who close or far this is to covering the whole suite.
    Only 98 test scripts complete with no leaks. But many of those
    failures will be hitting the same leaks over and over. It looks like
    running "git show' hits a few, which is going to affect a lot of
    scripts. But bear in mind when reading the patches that this might
    be the first step on a successful road, or it could be a dead end. :)

Most of this is actual leak fixes. The interesting part, I think, is the
UNLEAK annotation in patch 10.

  [01/10]: test-lib: --valgrind should not override --verbose-log
  [02/10]: test-lib: set LSAN_OPTIONS to abort by default
  [03/10]: add: free leaked pathspec after add_files_to_cache()
  [04/10]: update-index: fix cache entry leak in add_one_file()
  [05/10]: config: plug user_config leak
  [06/10]: reset: make tree counting less confusing
  [07/10]: reset: free allocated tree buffers
  [08/10]: repository: free fields before overwriting them
  [09/10]: set_git_dir: handle feeding gitdir to itself
  [10/10]: add UNLEAK annotation for reducing leak false positives

 Makefile               |  3 +++
 builtin/add.c          |  3 +++
 builtin/commit.c       |  1 +
 builtin/config.c       | 11 +++++++++--
 builtin/init-db.c      |  2 ++
 builtin/ls-files.c     |  1 +
 builtin/reset.c        | 24 +++++++++++++++++-------
 builtin/update-index.c |  4 +++-
 builtin/worktree.c     |  2 ++
 environment.c          |  4 +++-
 git-compat-util.h      |  7 +++++++
 repository.c           | 14 +++++++-------
 setup.c                |  5 -----
 t/test-lib.sh          |  7 ++++++-
 usage.c                | 13 +++++++++++++
 15 files changed, 77 insertions(+), 24 deletions(-)

-Peff

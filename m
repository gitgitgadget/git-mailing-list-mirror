Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B346211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 22:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfAKWOR (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 17:14:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:34198 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725828AbfAKWOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 17:14:16 -0500
Received: (qmail 15683 invoked by uid 109); 11 Jan 2019 22:14:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Jan 2019 22:14:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13371 invoked by uid 111); 11 Jan 2019 22:14:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 Jan 2019 17:14:17 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2019 17:14:14 -0500
Date:   Fri, 11 Jan 2019 17:14:14 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/6] getenv() timing fixes
Message-ID: <20190111221414.GA31335@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to the recent:

  https://public-inbox.org/git/20190109221007.21624-1-kgybels@infogroep.be/

there are some other places where we do not follow the POSIX rule that
getenv()'s return value may be invalidated by other calls to getenv() or
setenv().

For the most part we haven't noticed because:

  - on many platforms, you can call getenv() as many times as you want.
    This changed recently in our mingw_getenv() helper, which is why
    people are noticing now.

  - calling setenv() in between _often_ works, but it depends on whether
    libc feels like it needs to reallocate memory. Which is itself
    platform specific, and even on a single platform may depend on
    things like how many environment variables you have set.

The first patch here is a problem somebody actually found in the wild.
That led me to start looking through the results of:

  git grep '= getenv('

There are a ton of hits. I poked at the first 20 or so. A lot of them
are fine, as they do something like this:

  rla = getenv("GIT_REFLOG_ACTION");
  strbuf_addstr("blah blah %s", rla);

That's not _strictly_ correct, because strbuf_addstr() may actually look
at the environment. But it works for our mingw_getenv() case, because
there we use a rotating series of buffers. So as long as it doesn't look at
30 environment variables, we're fine. And many calls fall into that
bucket (a more complicated one is get_ssh_command(), which runs a fair
bit of code while holding the pointer, but ultimately probably has a
small fixed number of opportunities to call getenv(). What is more
worrisome is code that holds a pointer across an arbitrary number of
calls (like once per diff'd file, or once per submodule, etc).

Of course it's possible for some platform libc to use a single buffer.
But in that case, I'd argue that the path of least resistance is
wrapping getenv, like I described in:

  https://public-inbox.org/git/20181025062037.GC11460@sigill.intra.peff.net/

So anyway. Here are a handful of what seem like pretty low-hanging
fruit. Beyond the first one, I'm not sure if they're triggerable, but
they're easy to fix. There are 100+ grep matches that I _didn't_ audit,
so this is by no means a complete fix. I was mostly trying to get a
sense of how painful these fixes would be.

  [1/6]: get_super_prefix(): copy getenv() result
  [2/6]: commit: copy saved getenv() result
  [3/6]: config: make a copy of $GIT_CONFIG string
  [4/6]: init: make a copy of $GIT_DIR string
  [5/6]: merge-recursive: copy $GITHEAD strings
  [6/6]: builtin_diff(): read $GIT_DIFF_OPTS closer to use

 builtin/commit.c          |  3 ++-
 builtin/config.c          |  2 +-
 builtin/init-db.c         |  6 ++++--
 builtin/merge-recursive.c | 15 ++++++++++-----
 diff.c                    |  5 ++++-
 environment.c             |  4 ++--
 6 files changed, 23 insertions(+), 12 deletions(-)

-Peff

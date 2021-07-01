Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C3AC11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 21:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C736140E
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 21:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhGAV3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 17:29:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:39226 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230328AbhGAV3h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 17:29:37 -0400
Received: (qmail 28939 invoked by uid 109); 1 Jul 2021 21:27:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jul 2021 21:27:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19166 invoked by uid 111); 1 Jul 2021 21:27:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jul 2021 17:27:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jul 2021 17:27:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: git log exclude pathspec from file - supported? plans?
Message-ID: <YN4zKVK7gvuIZ0vK@coredump.intra.peff.net>
References: <CACPiFCLtj5QF6_Goc5UYh9KHWgkrKtjApL-cCH04S5gdTFyk7Q@mail.gmail.com>
 <CACPiFCLXxwaWOuR6sy8H4hCG-H0ZFvVYma7COfDq3zxoUt=VtA@mail.gmail.com>
 <YNywsEbFcrQFeH91@coredump.intra.peff.net>
 <87sg0zdx7z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sg0zdx7z.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 08:22:35PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > The problem is that we try to linearly match every pathspec against
> > every path we consider, so it's quadratic-ish in the number of files in
> > the repo. I played a long time ago with storing non-wildcard pathspecs
> > in a trie that we could traverse as we talked the individual trees we
> > were matching. It performed well, but IIRC the interface was hacky (I
> > had to bolt it specifically onto the way the tree-walker uses
> > pathspecs, and the other pathspec matchers didn't benefit at all).
> >
> > I can probably dig it up if anybody's interested in looking at it.
> 
> If it's not too much trouble I'd find it interesting, but I likely won't
> do anything with it any time soon.

The patches are from 2014 (yikes). I forward ported them to the current
tip of master, but beware:

  - it fails a test in t4010 matching a gitlink with a trailing "/" in the
    pathspec (which I think just didn't exist back then). I suspect this
    is a simple bug (the trie has to record a bit for "this must be a
    dir", and it probably just doesn't understand gitlinks properly).

  - the original renamed diff_tree_sha1() to diff_tree_sha1_recurse(),
    which we then call internally while recursing (to pass the trie
    cursor). And then top-level calls use a diff_tree_sha1() wrapper
    that kicks off the traversal (to avoid disrupting other callers).

    When forward-porting, those functions got renamed and reorganized to
    handle multi-parent diffs. I was able to just use the internal
    ll_diff_tree_paths() as my "recurse" version, but I'm not 100% sure
    that's right (e.g., should internal calls to ll_diff_tree_oid also
    grow a cursor parameter?)

  - a few bits had to be ported from the 2-parent case to handle
    n-parents. It _looked_ pretty trivial as I did it, but it's entirely
    possible there are gotchas. Tests seem to pass, though (there are no
    specific tests for finding changes in a merge here, but all tree
    diffs should be using the new code).

  - there are a few basic tests included, but this was never run in any
    kind of production setting. Caveat emptor. :)

> One of the PCREv2 experiments I had very early WIP work towards was to
> create a search index for commit messages, contents etc. and stick it in
> something similar to the --changed-paths part of the commit-graph.

Yeah, to some degree --change-paths may mitigate this, since for a
series of simple pathspecs we'd generate the bloom filter once and then
get O(1) matching per commit.

My ulterior motive with all of this was to plug it into our custom
"blame-tree" (i.e., which commit last-touched each path), with the idea
being that we'd start with a big pathspec, and then shrink it as we find
answers. Removing an item from a bloom filter is awkward, but possible.

Anyway, here are the patches.

  [1/3]: pathspec: add optional trie index
  [2/3]: pathspec: turn on tries when appropriate
  [3/3]: tree-diff: use pathspec tries

 Makefile                      |   1 +
 pathspec.c                    | 127 ++++++++++++++++++++++++++++++++++
 pathspec.h                    |  13 ++++
 t/helper/test-pathspec.c      |  96 +++++++++++++++++++++++++
 t/helper/test-tool.c          |   1 +
 t/helper/test-tool.h          |   1 +
 t/perf/p4002-diff-pathspec.sh |  26 +++++++
 t/t6137-pathspec-trie.sh      |  57 +++++++++++++++
 tree-diff.c                   | 102 +++++++++++++++++++++++----
 9 files changed, 411 insertions(+), 13 deletions(-)
 create mode 100644 t/helper/test-pathspec.c
 create mode 100755 t/perf/p4002-diff-pathspec.sh
 create mode 100755 t/t6137-pathspec-trie.sh

-Peff

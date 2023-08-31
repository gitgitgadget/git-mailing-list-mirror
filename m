Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEC4C83F10
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 06:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242227AbjHaGRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjHaGRk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 02:17:40 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AE5C2
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:17:36 -0700 (PDT)
Received: (qmail 21136 invoked by uid 109); 31 Aug 2023 06:17:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 06:17:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2940 invoked by uid 111); 31 Aug 2023 06:17:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 02:17:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 02:17:35 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/10] tree name and depth limits
Message-ID: <20230831061735.GA2702156@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There aren't currently any limits on the size of pathnames in tree
objects, nor of the depth of recursive trees. This can create two
problems:

  1. We process pathnames from trees as strings in lots of places, and
     we have a history of using "int" to access strings. I don't know of
     a specific problem area, but I have little doubt there is a spot
     where you can convince an "int" to overflow with a 2GB tree.

     In the long run it would be nice to fix all of that code to use
     size_t. And hopefully other audits to use st_add(), etc, for
     allocations mean that we'd avoid actual buffer overflows. But in
     the meantime, it sure would be nice to have another layer
     protecting us.

  2. Because we recurse for most tree algorithms, it's easy for a
     malicious tree to run you out of stack space and cause a segfault.
     By itself this isn't a security problem, but it's confusing for
     users. And if you happen to run a public hosting site and monitor
     your segfaults, it's awfully annoying to investigate each one to
     see if it's the first sign of a real attack, or if somebody is just
     throwing garbage at you.

So here are some patches I wrote for GitHub several years ago. They add
limits on the size of a single pathname component, as well as on the
depth we're willing to recurse when handling trees.

I kind of hate them, because I hate arbitrary limits. But I also think
they can do some good in practice, and the default limits are set such
that I doubt anybody will ever notice, let alone complain (they have
been in place on github.com for 4+ years, and I don't recall ever
getting any feedback from users who were not security researchers poking
at the system).

And most operating systems have arbitrary limits (that are much
smaller!) anyway. So if you plan to do exotic things like "run
git-checkout", you'd run into problems way before you hit either of
these.

So IMHO they'll do more good than harm.

The first three patches are cleanups / prep.

Patch 4 is the name limit.

Patches 5-10 implement the depth limits.

  [01/10]: tree-walk: reduce stack size for recursive functions
  [02/10]: tree-walk: drop MAX_TRAVERSE_TREES macro
  [03/10]: tree-walk: rename "error" variable
  [04/10]: fsck: detect very large tree pathnames
  [05/10]: add core.maxTreeDepth config
  [06/10]: traverse_trees(): respect max_allowed_tree_depth
  [07/10]: read_tree(): respect max_allowed_tree_depth
  [08/10]: list-objects: respect max_allowed_tree_depth
  [09/10]: tree-diff: respect max_allowed_tree_depth
  [10/10]: lower core.maxTreeDepth default to 2048

 Documentation/config/core.txt |  6 +++
 Documentation/fsck-msgids.txt |  7 +++
 config.c                      |  5 ++
 environment.c                 |  1 +
 environment.h                 |  1 +
 fsck.c                        | 24 ++++++++-
 fsck.h                        |  1 +
 list-objects.c                |  8 +++
 sparse-index.c                |  2 +-
 t/t1450-fsck.sh               | 10 ++++
 t/t6700-tree-depth.sh         | 93 +++++++++++++++++++++++++++++++++++
 tree-diff.c                   | 23 ++++++---
 tree-walk.c                   | 20 +++++---
 tree-walk.h                   |  2 -
 tree.c                        |  9 +++-
 tree.h                        |  1 +
 unpack-trees.c                |  9 +++-
 unpack-trees.h                |  2 +-
 wt-status.c                   |  2 +-
 19 files changed, 201 insertions(+), 25 deletions(-)
 create mode 100755 t/t6700-tree-depth.sh


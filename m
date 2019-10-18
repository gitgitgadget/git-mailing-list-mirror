Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3BD21F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 05:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409611AbfJRFHp (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 01:07:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:51790 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728253AbfJRFHp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 01:07:45 -0400
Received: (qmail 9304 invoked by uid 109); 18 Oct 2019 04:41:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 04:41:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14020 invoked by uid 111); 18 Oct 2019 04:44:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 00:44:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 00:41:03 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/23] parsing and fsck cleanups
Message-ID: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The thread starting at:

  https://public-inbox.org/git/xmqqo8zxnz0m.fsf@gitster-ct.c.googlers.com/

discusses some issues with our handling of corrupt objects, as well as
some weirdness in fsck. This series is my attempt to clean it up. The
number of patches is a little daunting, but the early ones are the most
interesting. The latter half is part of a big refactor/cleanup that's
mostly mechanical (and isn't strictly necessary; see below for
discussion).

  [01/23]: parse_commit_buffer(): treat lookup_commit() failure as parse error
  [02/23]: parse_commit_buffer(): treat lookup_tree() failure as parse error
  [03/23]: parse_tag_buffer(): treat NULL tag pointer as parse error
  [04/23]: remember commit/tag parse failures

    These ones are tightening up our parser to report failures more
    consistently. The first one definitely fixes a demonstrable bug, and
    I suspect the rest of them are fixing hard-to-trigger but lurking
    segfaults.

  [05/23]: fsck: stop checking commit->tree value
  [06/23]: fsck: stop checking commit->parent counts
  [07/23]: fsck: stop checking tag->tagged
  [08/23]: fsck: require an actual buffer for non-blobs

    These ones clean up weirdness where fsck is dependent on the results
    of parse_commit(), etc, rather than just looking at the buffer we
    gave it. I don't think they're _hurting_ anything, but it certainly
    makes following the fsck logic more confusing.

  [09/23]: fsck: unify object-name code

    Cleanup that fixes a few minor bugs.

  [10/23]: fsck_describe_object(): build on our get_object_name() primitive
  [11/23]: fsck: use oids rather than objects for object_name API
  [12/23]: fsck: don't require full object structs for display functions
  [13/23]: fsck: only provide oid/type in fsck_error callback
  [14/23]: fsck: only require an oid for skiplist functions
  [15/23]: fsck: don't require an object struct for report()
  [16/23]: fsck: accept an oid instead of a "struct blob" for fsck_blob()
  [17/23]: fsck: drop blob struct from fsck_finish()
  [18/23]: fsck: don't require an object struct for fsck_ident()
  [19/23]: fsck: don't require an object struct in verify_headers()
  [20/23]: fsck: rename vague "oid" local variables
  [21/23]: fsck: accept an oid instead of a "struct tag" for fsck_tag()
  [22/23]: fsck: accept an oid instead of a "struct commit" for fsck_commit()
  [23/23]: fsck: accept an oid instead of a "struct tree" for fsck_tree()

    This a string of refactors that ends up with all of the
    type-specific fsck functions not getting an object struct at all.
    My goal there was two-fold:

       - it makes it harder to introduce weirdness like we saw in
	 patches 5-8.

       - it _could_ make things less awkward for callers like index-pack
	 which don't necessarily have object structs. And at the end, we
	 basically have an fsck_object() that doesn't need an object
	 struct. But index-pack still calls fsck_walk(), which does (and
	 which relies on the parsed values to traverse). It's not
	 entirely clear to me whether index-pack needs to be doing
	 fsck_walk() in the first place, or if it should be relying on
	 the usual connectivity check.

	 So I'm undecided whether this is worth taking on its own, or if
	 trying to avoid object structs in the fsck code is just a
	 fool's errand. I do think the result isn't too bad to look at,
	 though and there are some minor improvements along the way
	 (e.g., patch 17 is able to drop some awkwardness).

    Most of the patches are pretty mechanical. There are so many because
    I split it by call stack layer. If A calls B calls C, then I
    converted "C" away from "struct object" first, which enables
    converting "B", and so on.

 builtin/fsck.c                         | 126 ++++----
 commit-graph.c                         |   3 -
 commit.c                               |  33 ++-
 fsck.c                                 | 386 +++++++++++--------------
 fsck.h                                 |  39 ++-
 t/t1450-fsck.sh                        |   2 +-
 t/t5318-commit-graph.sh                |   2 +-
 t/t6102-rev-list-unexpected-objects.sh |   2 +-
 tag.c                                  |  21 +-
 9 files changed, 312 insertions(+), 302 deletions(-)


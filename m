Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B0EC1F404
	for <e@80x24.org>; Sat, 25 Aug 2018 08:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbeHYLim (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 07:38:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:55662 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726526AbeHYLim (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 07:38:42 -0400
Received: (qmail 4567 invoked by uid 109); 25 Aug 2018 08:00:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Aug 2018 08:00:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2273 invoked by uid 111); 25 Aug 2018 08:00:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 25 Aug 2018 04:00:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Aug 2018 04:00:31 -0400
Date:   Sat, 25 Aug 2018 04:00:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 0/9] introducing oideq()
Message-ID: <20180825080031.GA32139@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up to the discussion in:

  https://public-inbox.org/git/20180822030344.GA14684@sigill.intra.peff.net/

The general idea is that the majority of callers don't care about actual
plus/minus ordering from oidcmp() and hashcmp(); they just want to know
if two oids are equal. The stricter equality check can be optimized
better by the compiler.

Due to the simplicity of the current code and our inlining, the compiler
can usually figure this out for now. So I wouldn't expect this patch to
actually improve performance right away. But as that discussion shows,
we are likely to take a performance hit as we move to more runtime
determination of the_hash_algo parameters. Having these callers use the
more strict form will potentially help us recover that.

So in that sense we _could_ simply punt on this series until then (and
it's certainly post-v2.19 material). But I think it's worth doing now,
simply from a readability/annotation standpoint. IMHO the resulting code
is more clear (though I've long since taught myself to read !foocmp() as
equality).

If we do punt, patch 1 could still be picked up now, as it's a related
cleanup that stands on its own.

The diffstat is scary, but the vast majority of that is purely
mechanical via coccinelle. There's some discussion in the individual
patches.

We also don't _have_ to convert all sites now. I strongly suspect that
only a few calls are actual measurable bottlenecks (the one in
lookup_object() is the one I was primarily interested in).  But it's
just as easy to do it all at once with coccinelle, rather than try to
measure each one (and once we add the coccinelle patches, we have to
convert everything, or "make coccicheck" will nag people to do so).

I didn't bother to hold back changes for any topics in flight.  There
are a handful of conflicts with "pu", but they're mostly trivial.  The
only big one is due to some code movement in ds/reachable. But though
the conflict is big, the resolution is still easy (you can even just
take the other side and "make coccicheck" to do it automatically).

  [1/9]: coccinelle: use <...> for function exclusion
  [2/9]: introduce hasheq() and oideq()
  [3/9]: convert "oidcmp() == 0" to oideq()
  [4/9]: convert "hashcmp() == 0" to hasheq()
  [5/9]: convert "oidcmp() != 0" to "!oideq()"
  [6/9]: convert "hashcmp() != 0" to "!hasheq()"
  [7/9]: convert hashmap comparison functions to oideq()
  [8/9]: read-cache: use oideq() in ce_compare functions
  [9/9]: show_dirstat: simplify same-content check

 bisect.c                           |  6 ++--
 blame.c                            |  8 ++---
 builtin/am.c                       |  2 +-
 builtin/checkout.c                 |  2 +-
 builtin/describe.c                 | 10 +++---
 builtin/diff.c                     |  2 +-
 builtin/difftool.c                 |  4 +--
 builtin/fast-export.c              |  2 +-
 builtin/fetch.c                    |  6 ++--
 builtin/fmt-merge-msg.c            |  6 ++--
 builtin/index-pack.c               |  8 ++---
 builtin/log.c                      |  6 ++--
 builtin/merge-tree.c               |  2 +-
 builtin/merge.c                    |  6 ++--
 builtin/pack-objects.c             |  4 +--
 builtin/pull.c                     |  4 +--
 builtin/receive-pack.c             |  4 +--
 builtin/remote.c                   |  2 +-
 builtin/replace.c                  |  6 ++--
 builtin/rm.c                       |  2 +-
 builtin/show-branch.c              |  6 ++--
 builtin/tag.c                      |  2 +-
 builtin/unpack-objects.c           |  4 +--
 builtin/update-index.c             |  4 +--
 bulk-checkin.c                     |  2 +-
 bundle.c                           |  2 +-
 cache-tree.c                       |  2 +-
 cache.h                            | 22 +++++++++----
 combine-diff.c                     |  4 +--
 commit-graph.c                     | 10 +++---
 commit.c                           |  2 +-
 connect.c                          |  2 +-
 contrib/coccinelle/commit.cocci    |  4 +--
 contrib/coccinelle/object_id.cocci | 50 ++++++++++++++++++++++++------
 diff-lib.c                         |  4 +--
 diff.c                             | 23 ++++++--------
 diffcore-break.c                   |  2 +-
 diffcore-rename.c                  |  2 +-
 dir.c                              |  6 ++--
 fast-import.c                      | 10 +++---
 fetch-pack.c                       |  2 +-
 http-push.c                        |  2 +-
 http-walker.c                      |  4 +--
 http.c                             |  2 +-
 log-tree.c                         |  6 ++--
 match-trees.c                      |  2 +-
 merge-recursive.c                  |  4 +--
 notes-merge.c                      | 24 +++++++-------
 notes.c                            |  8 ++---
 object.c                           |  2 +-
 oidmap.c                           | 12 +++----
 pack-check.c                       |  6 ++--
 pack-objects.c                     |  2 +-
 pack-write.c                       |  4 +--
 packfile.c                         | 12 +++----
 patch-ids.c                        |  8 ++---
 read-cache.c                       | 12 +++----
 ref-filter.c                       |  2 +-
 refs.c                             |  8 ++---
 refs/files-backend.c               |  6 ++--
 refs/packed-backend.c              |  2 +-
 refs/ref-cache.c                   |  2 +-
 remote.c                           |  8 ++---
 revision.c                         |  2 +-
 sequencer.c                        | 40 ++++++++++++------------
 sha1-array.c                       |  2 +-
 sha1-file.c                        | 12 +++----
 sha1-name.c                        |  2 +-
 submodule-config.c                 |  4 +--
 submodule.c                        |  2 +-
 t/helper/test-dump-cache-tree.c    |  2 +-
 transport.c                        |  2 +-
 tree-diff.c                        |  2 +-
 unpack-trees.c                     |  6 ++--
 wt-status.c                        | 10 +++---
 xdiff-interface.c                  |  2 +-
 76 files changed, 259 insertions(+), 224 deletions(-)


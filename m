Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77716C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3145B20776
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgC3OCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:02:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:55602 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725978AbgC3OCt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 10:02:49 -0400
Received: (qmail 15145 invoked by uid 109); 30 Mar 2020 14:02:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Mar 2020 14:02:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18663 invoked by uid 111); 30 Mar 2020 14:12:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Mar 2020 10:12:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Mar 2020 10:02:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/7] oid_array cleanups
Message-ID: <20200330140247.GA476088@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently encountered a repo in the wild that had over 2^31 objects,
and found that cat-file barfed:

  $ git cat-file --batch-all-objects --batch-check
  fatal: size_t overflow: 32 * 18446744071562067968

The issue is that we use an "int" to store the count and the allocation.
Fortunately our st_mult() protection kicks in before we end up with an
undersized buffer, so this shouldn't be dangerous. And while I'd argue
that having that many objects is probably silly and likely to cause
other problems, I'd just as soon we kept our allocating code as robust
as possible.

The first patch is the actual fix, followed by some related type
cleanup. The rest of it is just leftovers from the
s/sha1_array/oid_array/ transition a few years back.

  [1/7]: oid_array: use size_t for count and allocation
  [2/7]: oid_array: use size_t for iteration
  [3/7]: oid_array: rename source file from sha1-array
  [4/7]: test-tool: rename sha1-array to oid-array
  [5/7]: bisect: stop referring to sha1_array
  [6/7]: ref-filter: stop referring to "sha1 array"
  [7/7]: oidset: stop referring to sha1-array

 Makefile                                         |  4 ++--
 bisect.c                                         |  8 ++++----
 builtin/cat-file.c                               |  2 +-
 builtin/diff.c                                   |  2 +-
 builtin/fetch-pack.c                             |  2 +-
 builtin/pack-objects.c                           |  2 +-
 builtin/pull.c                                   |  2 +-
 builtin/receive-pack.c                           |  2 +-
 builtin/send-pack.c                              |  2 +-
 builtin/tag.c                                    |  2 +-
 cache.h                                          |  2 +-
 combine-diff.c                                   |  2 +-
 connect.c                                        |  2 +-
 delta-islands.c                                  |  2 +-
 fetch-pack.c                                     |  2 +-
 object-store.h                                   |  2 +-
 sha1-array.c => oid-array.c                      | 10 +++++-----
 sha1-array.h => oid-array.h                      |  6 +++---
 oidset.h                                         |  2 +-
 parse-options-cb.c                               |  2 +-
 ref-filter.c                                     |  7 +++----
 ref-filter.h                                     |  2 +-
 remote-curl.c                                    |  2 +-
 send-pack.c                                      |  2 +-
 sha1-name.c                                      |  2 +-
 shallow.c                                        |  2 +-
 submodule.c                                      |  2 +-
 t/helper/{test-sha1-array.c => test-oid-array.c} |  8 ++++----
 t/helper/test-tool.c                             |  2 +-
 t/helper/test-tool.h                             |  2 +-
 t/t0064-sha1-array.sh                            | 16 ++++++++--------
 transport.c                                      |  2 +-
 32 files changed, 54 insertions(+), 55 deletions(-)
 rename sha1-array.c => oid-array.c (93%)
 rename sha1-array.h => oid-array.h (97%)
 rename t/helper/{test-sha1-array.c => test-oid-array.c} (83%)


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8F820248
	for <e@80x24.org>; Tue, 12 Mar 2019 13:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfCLNhC (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:37:02 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.57]:36887 "EHLO mta1.cl.cam.ac.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfCLNhB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 09:37:01 -0400
Received: from methi.cl.cam.ac.uk ([2001:630:212:238:fa32:e4ff:fe88:56f3])
        by mta1.cl.cam.ac.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1h3hIy-0002Mg-V5; Tue, 12 Mar 2019 13:18:52 +0000
Received: from nwf20 by methi.cl.cam.ac.uk with local (Exim 4.90_1)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1h3hJ5-0006nw-M8; Tue, 12 Mar 2019 13:18:59 +0000
From:   Nathaniel Filardo <nwf20@cl.cam.ac.uk>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Nathaniel Filardo <nwf20@cl.cam.ac.uk>
Subject: [PATCH 0/4] Speed up repacking when lots of pack-kept objects
Date:   Tue, 12 Mar 2019 13:18:54 +0000
Message-Id: <20190312131858.26115-1-nwf20@cl.cam.ac.uk>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series improves handling of very large repositories, as generated
by, for example, bup (https://github.com/bup/bup).  Prolonged operation
thereof creates quite a lot of small pack files; repacking improves
filesystem performance of the objects/pack directory, but is quite
expensive, in terms of time and memory.  We have adopted a strategy that
marks "large" (tens of GB) of pack files as "kept" and defers repacking
until there are enough un-kept packs or enough bytes of un-kept objects.
(The first patch in the series will make our accounting easier, replacing
some terrible shell scripting with grep.)

While this strategy has generally improved our lives relative to either
extreme (not repacking, or repacking after every bup save operation), it
still leaves a good bit to be desired.  Because our packs are marked as
kept, repacking will leave the objects therein alone, but it still must
instantiate in memory and walk the entire object graph.  However, because
our kept packs are transitively closed, such that an object in one
necessarily references only objects in other kept packs, we should like to
avoid reasoning about them more or less altogether.

This series attempts to do just that.  The middle patches are just some
groundwork for the last patch, which carries the punch line.  This last
patch adds an option to builtin/repack to enumerate commit and tree objects
within kept packs as UNINTERESTING to its spawned builtin/pack-objects
command.  Together with inducing the use of sparse reachability, this speeds
enumerating candidate objects for repacking and thereby substantially
reduces the runtime of our repack operations, while producing identical
results.

I am, however, rather a novice when it comes to git internals, so any and
all feedback is quite welcome.

Nathaniel Filardo (4):
  count-objects: report statistics about kept packs
  revision walk: optionally use sparse reachability
  repack: add --sparse and pass to pack-objects
  repack: optionally assume transitive kept packs

 Documentation/git-gc.txt         |  5 +++
 Documentation/git-repack.txt     | 25 +++++++++++++
 bisect.c                         |  2 +-
 blame.c                          |  2 +-
 builtin/checkout.c               |  2 +-
 builtin/commit.c                 |  2 +-
 builtin/count-objects.c          | 17 ++++++++-
 builtin/describe.c               |  2 +-
 builtin/fast-export.c            |  2 +-
 builtin/fmt-merge-msg.c          |  2 +-
 builtin/gc.c                     |  5 +++
 builtin/log.c                    | 10 ++---
 builtin/merge.c                  |  2 +-
 builtin/pack-objects.c           |  4 +-
 builtin/repack.c                 | 64 +++++++++++++++++++++++++++++++-
 builtin/rev-list.c               |  2 +-
 builtin/shortlog.c               |  2 +-
 bundle.c                         |  2 +-
 http-push.c                      |  2 +-
 merge-recursive.c                |  2 +-
 pack-bitmap-write.c              |  2 +-
 pack-bitmap.c                    |  4 +-
 reachable.c                      |  4 +-
 ref-filter.c                     |  2 +-
 remote.c                         |  2 +-
 revision.c                       | 10 +++--
 revision.h                       |  2 +-
 sequencer.c                      |  6 +--
 shallow.c                        |  2 +-
 submodule.c                      |  4 +-
 t/helper/test-revision-walking.c |  2 +-
 31 files changed, 154 insertions(+), 42 deletions(-)

-- 
2.17.1


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B3111F461
	for <e@80x24.org>; Mon, 24 Jun 2019 12:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfFXMRR (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 08:17:17 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.25.22]:40066 "EHLO
        mta2.cl.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfFXMRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 08:17:16 -0400
Received: from methi.cl.cam.ac.uk ([2001:630:212:238:fa32:e4ff:fe88:56f3])
        by mta2.cl.cam.ac.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.86_2)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1hfNlB-000VdA-Pg; Mon, 24 Jun 2019 13:07:45 +0100
Received: from nwf20 by methi.cl.cam.ac.uk with local (Exim 4.90_1)
        (envelope-from <nwf20@cl.cam.ac.uk>)
        id 1hfNlB-0007EO-Nn; Mon, 24 Jun 2019 13:07:45 +0100
From:   Nathaniel Filardo <nwf20@cl.cam.ac.uk>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, Nathaniel Filardo <nwf20@cl.cam.ac.uk>
Subject: [PATCH v3 0/5] Speed up repacking when lots of pack-kept objects
Date:   Mon, 24 Jun 2019 13:07:06 +0100
Message-Id: <20190624120711.27744-1-nwf20@cl.cam.ac.uk>
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

This series attempts to do just that.  The fourth patch ("repack: optionally
assume transitive kept packs") adds an option to builtin/repack to enumerate
commits (and their trees) within kept packs as UNINTERESTING to its spawned
builtin/pack-objects command.  Together with inducing the use of sparse
reachability, this speeds enumerating candidate objects for repacking and
thereby substantially reduces the runtime of our repack operations, while
producing identical results.  Some test results are reported in that patch's
commit log.

This reroll incorporates feedback from Derrick Stolee, is rebased, and
is updated to pass "make test".

Nathaniel Filardo (5):
  count-objects: report statistics about kept packs
  revision walk: optionally use sparse reachability
  repack: add --sparse and pass to pack-objects
  repack: optionally assume transitive kept packs
  builtin/gc: add --assume-pack-keep-transitive

 Documentation/git-count-objects.txt |  8 ++++
 Documentation/git-gc.txt            |  4 ++
 Documentation/git-repack.txt        | 25 ++++++++++++
 bisect.c                            |  2 +-
 builtin/count-objects.c             | 17 +++++++-
 builtin/gc.c                        |  5 +++
 builtin/pack-objects.c              |  3 +-
 builtin/repack.c                    | 60 ++++++++++++++++++++++++++++-
 builtin/rev-list.c                  |  2 +-
 http-push.c                         |  2 +-
 list-objects.c                      |  5 +--
 list-objects.h                      |  3 +-
 revision.c                          |  3 +-
 revision.h                          |  1 +
 t/t5322-pack-objects-sparse.sh      |  6 +++
 t/t5500-fetch-pack.sh               |  8 ++--
 16 files changed, 137 insertions(+), 17 deletions(-)

-- 
2.17.1


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5ED1202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 20:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbdIVU1C (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 16:27:02 -0400
Received: from siwi.pair.com ([209.68.5.199]:33982 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751845AbdIVU1B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 16:27:01 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D46C384707;
        Fri, 22 Sep 2017 16:27:00 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 533B084706;
        Fri, 22 Sep 2017 16:27:00 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        jeffhost@microsoft.com
Subject: [PATCH 00/13] RFC object filtering for parital clone
Date:   Fri, 22 Sep 2017 20:26:19 +0000
Message-Id: <20170922202632.53714-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>


This patch series contains WIP code demonstrating object (blob) filtering
in rev-list and pack-objects using a common filtering API in
list-objects and traverse-commit-list that allows both commands
to perform the same type of filter operations.  And serve as the
basis of partial-clone and partial-fetch.

This draft contains filters to:
() omit all blobs
() omit blobs larger than some size
() omit blobs using a sparse-checkout specification

In addition to specifying the filter criteria, the rev-list command
was updated to include options to:
() print a list of the omitted objects (due to the current filtering
   criteria)
() print a list of missing objects (probably from a prior partial
   clone/fetch).

This latter print option can be used with or without a new filter
criteria allowing it to be used with a pre-checkout bulk pre-fetch
command.

For example, if blobs were omitted during the clone or a fetch, the
client can do:

   git rev-list --quiet --objects --filter-print-missing NEWBRANCH

and get a list of just the objects that are required to checkout
NEWBRANCH.

Or if a sparse-checkout is in effect, the client can specify the
same criteria to look for just the missing blobs needed to do the
sparse-checkout:

   git rev-list --quiet --objects --filter-print-missing \
       --filter-use-path=./git/info/sparse-checkout NEWBRANCH

It does not matter why a blob is missing; that is, what filter
criteria was used during the clone or fetch.  All that matters
is the blob is missing and is now needed.

These commands output a list of missing blobs that can be fed
into a bulk fetch object request.  The goal here is to minimize
the need for dynamic object fetch mechanisms currently being
discussed.  (We cannot eliminate the need for dynamic fetching,
but we can use this to precompute/prefetch in bulk.)

Pack-objects was updated to allow the server to build incomplete
packfiles without unwanted blobs.

This is the first step to support partial-clone and -fetch. I've
omitted from this patch series corresponding changes to fetch-pack,
upload-pack, index-pack, verify-pack, fsck, gc, and the git protocol.
I can make these available if there is interest.  I omit them from
this RFC to not distract from the basic filtering ideas.

It also does not address the promisor/promised ideas currently
being discussed [2,3].  These should be considered independently.

The code in this patch series can be seen here [1].

[1] https://github.com/jeffhostetler/git/pull/3
[2] https://public-inbox.org/git/xmqq8thbqlqf.fsf@gitster.mtv.corp.google.com/t/
[3] https://github.com/jonathantanmy/git/commits/partialclone2


Jeff Hostetler (13):
  dir: refactor add_excludes()
  oidset2: create oidset subclass with object length and pathname
  list-objects: filter objects in traverse_commit_list
  list-objects-filter-all: add filter to omit all blobs
  list-objects-filter-large: add large blob filter to list-objects
  list-objects-filter-sparse: add sparse-checkout based filter
  object-filter: common declarations for object filtering
  list-objects: add traverse_commit_list_filtered method
  rev-list: add object filtering support
  rev-list: add filtering help text
  t6112: rev-list object filtering test
  pack-objects: add object filtering support
  pack-objects: add filtering help text

 Documentation/git-pack-objects.txt  |  17 +++
 Documentation/git-rev-list.txt      |   9 +-
 Documentation/rev-list-options.txt  |  32 +++++
 Makefile                            |   5 +
 builtin/pack-objects.c              |  24 +++-
 builtin/rev-list.c                  |  73 +++++++++-
 dir.c                               |  53 ++++++-
 dir.h                               |   4 +
 list-objects-filter-all.c           |  85 ++++++++++++
 list-objects-filter-all.h           |  18 +++
 list-objects-filter-large.c         | 108 +++++++++++++++
 list-objects-filter-large.h         |  18 +++
 list-objects-filter-sparse.c        | 221 +++++++++++++++++++++++++++++
 list-objects-filter-sparse.h        |  30 ++++
 list-objects.c                      | 100 +++++++++++---
 list-objects.h                      |  41 ++++++
 object-filter.c                     | 269 ++++++++++++++++++++++++++++++++++++
 object-filter.h                     | 173 +++++++++++++++++++++++
 oidset2.c                           | 104 ++++++++++++++
 oidset2.h                           |  58 ++++++++
 t/t6112-rev-list-filters-objects.sh | 237 +++++++++++++++++++++++++++++++
 21 files changed, 1657 insertions(+), 22 deletions(-)
 create mode 100644 list-objects-filter-all.c
 create mode 100644 list-objects-filter-all.h
 create mode 100644 list-objects-filter-large.c
 create mode 100644 list-objects-filter-large.h
 create mode 100644 list-objects-filter-sparse.c
 create mode 100644 list-objects-filter-sparse.h
 create mode 100644 object-filter.c
 create mode 100644 object-filter.h
 create mode 100644 oidset2.c
 create mode 100644 oidset2.h
 create mode 100755 t/t6112-rev-list-filters-objects.sh

-- 
2.9.3


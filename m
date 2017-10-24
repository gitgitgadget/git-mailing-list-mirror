Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2C221FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 18:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbdJXSx6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:53:58 -0400
Received: from siwi.pair.com ([209.68.5.199]:58041 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751399AbdJXSx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:53:57 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EE75184594;
        Tue, 24 Oct 2017 14:53:56 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5BDB984593;
        Tue, 24 Oct 2017 14:53:56 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 00/13] WIP Partial clone part 1: object filtering
Date:   Tue, 24 Oct 2017 18:53:19 +0000
Message-Id: <20171024185332.57261-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

I've been working with Jonathan Tan to combine our partial clone
proposals.  This patch series represents a first step in that effort
and introduces an object filtering mechanism to select unwanted
objects.

[1] traverse_commit_list and list-objects is extended to allow
    various filters.
[2] rev-list is extended to expose filtering.  This allows testing
    of the filtering options.  And can be used later to predict
    missing objects before commands like checkout or merge.
[3] pack-objects is extended to use filtering parameters and build
    packfiles that omit unwanted objects.

This patch series lays the ground work for subsequent parts which
will extend clone, fetch, fetch-pack, upload-pack, fsck, and etc.


Jeff Hostetler (13):
  dir: allow exclusions from blob in addition to file
  list-objects-filter-map: extend oidmap to collect omitted objects
  list-objects: filter objects in traverse_commit_list
  list-objects-filter-blobs-none: add filter to omit all blobs
  list-objects-filter-blobs-limit: add large blob filtering
  list-objects-filter-sparse: add sparse filter
  list-objects-filter-options: common argument parsing
  list-objects: add traverse_commit_list_filtered method
  extension.partialclone: introduce partial clone extension
  rev-list: add list-objects filtering support
  t6112: rev-list object filtering test
  pack-objects: add list-objects filtering
  t5317: pack-objects object filtering test

 Documentation/git-pack-objects.txt             |   8 +-
 Documentation/git-rev-list.txt                 |   5 +-
 Documentation/rev-list-options.txt             |  30 ++
 Documentation/technical/repository-version.txt |  22 ++
 Makefile                                       |   6 +
 builtin/pack-objects.c                         |  18 +-
 builtin/rev-list.c                             |  84 +++++-
 cache.h                                        |   4 +
 config.h                                       |   3 +
 dir.c                                          |  51 +++-
 dir.h                                          |   3 +
 environment.c                                  |   2 +
 list-objects-filter-blobs-limit.c              | 146 ++++++++++
 list-objects-filter-blobs-limit.h              |  18 ++
 list-objects-filter-blobs-none.c               |  83 ++++++
 list-objects-filter-blobs-none.h               |  18 ++
 list-objects-filter-map.c                      |  63 ++++
 list-objects-filter-map.h                      |  26 ++
 list-objects-filter-options.c                  | 101 +++++++
 list-objects-filter-options.h                  |  50 ++++
 list-objects-filter-sparse.c                   | 241 ++++++++++++++++
 list-objects-filter-sparse.h                   |  30 ++
 list-objects.c                                 | 111 +++++--
 list-objects.h                                 |  43 ++-
 partial-clone-utils.c                          |  99 +++++++
 partial-clone-utils.h                          |  34 +++
 setup.c                                        |  15 +
 t/t5317-pack-objects-filter-objects.sh         | 384 +++++++++++++++++++++++++
 t/t6112-rev-list-filters-objects.sh            | 223 ++++++++++++++
 29 files changed, 1897 insertions(+), 24 deletions(-)
 create mode 100644 list-objects-filter-blobs-limit.c
 create mode 100644 list-objects-filter-blobs-limit.h
 create mode 100644 list-objects-filter-blobs-none.c
 create mode 100644 list-objects-filter-blobs-none.h
 create mode 100644 list-objects-filter-map.c
 create mode 100644 list-objects-filter-map.h
 create mode 100644 list-objects-filter-options.c
 create mode 100644 list-objects-filter-options.h
 create mode 100644 list-objects-filter-sparse.c
 create mode 100644 list-objects-filter-sparse.h
 create mode 100644 partial-clone-utils.c
 create mode 100644 partial-clone-utils.h
 create mode 100755 t/t5317-pack-objects-filter-objects.sh
 create mode 100755 t/t6112-rev-list-filters-objects.sh

-- 
2.9.3


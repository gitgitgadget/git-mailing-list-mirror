Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D0DF202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbdGMRfX (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:35:23 -0400
Received: from siwi.pair.com ([209.68.5.199]:61602 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751267AbdGMRfW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:35:22 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5EAD4844E9;
        Thu, 13 Jul 2017 13:35:21 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B06C8844E5;
        Thu, 13 Jul 2017 13:35:20 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ethomson@edwardthomson.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        jeffhost@microsoft.com
Subject: [PATCH v2 00/19] WIP object filtering for partial clone
Date:   Thu, 13 Jul 2017 17:34:40 +0000
Message-Id: <20170713173459.3559-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This WIP is a follow up to my earlier patch series to teach
pack-objects to omit large blobs from packfiles. [1]

Like the previous version, this version builds upon a suggestion from
Peff [2] to use the traverse_commit_list() machinery to allow custom
object filtering using a filter callback.  This hides the filtering
logic in list-objects.c and list-objects-filters.c and minimizes the
changes to actual commands, such as pack-objects.

This version adds that same filtering capability to rev-list allowing
filtering to be demonstrated without building a packfile.  Filtered
blobs are printed with a leading "~" (along with their sizes).

    $ ./git rev-list --objects HEAD~1..HEAD
    74f806c70507317b8bdbcf3b08459c7c83906bee
    818617707aac81ae4620239182b514f65638e37e 
    d21329bffeb9801682d8d6d6acedc2958d17f4e0 builtin
    306c16551e548ace12c709a332bfea22adcc395f builtin/fetch.c

    $ ./git rev-list --objects --filter-omit-all-blobs --filter-print-manifest HEAD~1..HEAD
    74f806c70507317b8bdbcf3b08459c7c83906bee
    818617707aac81ae4620239182b514f65638e37e 
    d21329bffeb9801682d8d6d6acedc2958d17f4e0 builtin
    ~306c16551e548ace12c709a332bfea22adcc395f 40732

    $ ./git rev-list --objects --filter-omit-all-blobs --filter-print-manifest --quiet HEAD~1..HEAD
    ~306c16551e548ace12c709a332bfea22adcc395f 40732

This version contains 3 filters:
1. filter-omit-all-blobs to exclude all blobs (trees and commits only).

2. filter-omit-large-blobs=<n>[kmg] to exclude blobs larger than <n>
   (but always including ".git*" special files).

3. filter-use-sparse=<blob-ish> to exclude blobs not needed by the
   corresponding sparse-checkout.

Sparse-checkout filtering is currently limited to filtering unneeded blobs.
A later enhancement should be able to also filter unneeded tree objects.

This version updates clone, fetch, fetch-pack, and upload-pack commands
to pass the additional object-filter parameters.

As a (possibly) temporary measure, some commands have been updated to
relax missing blob errors during consistency checks.  Maintining info
on missing blobs is currently being discussed in [3].

TODO
1. Incorporate with a patch series like [4] to dynamically fetch a
   missing blob from the server in read_object on demand.
2. Resolve missing blob consistency check issue.
3. Store filter options from clone in config or .git/info and default
   to them in subsequent fetches.
4. fsck, gc, and assorted commands.
5. testing.


[1] https://public-inbox.org/git/20170622203615.34135-1-git@jeffhostetler.com/
[2] https://public-inbox.org/git/20170309073117.g3br5btsfwntcdpe@sigill.intra.peff.net/
[3] https://public-inbox.org/git/cover.1499800530.git.jonathantanmy@google.com/
[4] https://public-inbox.org/git/20170505152802.6724-1-benpeart@microsoft.com/


Jeff Hostetler (19):
  dir: refactor add_excludes()
  oidset2: create oidset subclass with object length and pathname
  list-objects: filter objects in traverse_commit_list
  list-objects-filters: add omit-all-blobs filter
  list-objects-filters: add omit-large-blobs filter
  list-objects-filters: add use-sparse-checkout filter
  object-filter: common declarations for object filtering
  rev-list: add object filtering support
  rev-list: add filtering help text
  t6112: rev-list object filtering test
  pack-objects: add object filtering support
  pack-objects: add filtering help text
  upload-pack: add filter-objects to protocol documentation
  upload-pack: add object filtering
  fetch-pack: add object filtering support
  connected: add filter_allow_omitted option to API
  clone: add filter arguments
  index-pack: relax consistency checks for omitted objects
  fetch: add object filtering to fetch

 Documentation/git-pack-objects.txt                |  14 +
 Documentation/git-rev-list.txt                    |   7 +-
 Documentation/rev-list-options.txt                |  26 ++
 Documentation/technical/pack-protocol.txt         |  16 +
 Documentation/technical/protocol-capabilities.txt |   7 +
 Makefile                                          |   3 +
 builtin/clone.c                                   |  28 ++
 builtin/fetch-pack.c                              |   3 +
 builtin/fetch.c                                   |  27 +-
 builtin/index-pack.c                              |  15 +
 builtin/pack-objects.c                            |  33 +-
 builtin/rev-list.c                                |  58 +++-
 connected.c                                       |   3 +
 connected.h                                       |   6 +
 dir.c                                             |  53 +++-
 dir.h                                             |   4 +
 fetch-pack.c                                      |  28 ++
 fetch-pack.h                                      |   2 +
 list-objects-filters.c                            | 361 ++++++++++++++++++++++
 list-objects-filters.h                            |  45 +++
 list-objects.c                                    |  66 +++-
 list-objects.h                                    |  30 ++
 object-filter.c                                   | 201 ++++++++++++
 object-filter.h                                   | 145 +++++++++
 oidset2.c                                         | 101 ++++++
 oidset2.h                                         |  56 ++++
 t/t6112-rev-list-filters-objects.sh               |  37 +++
 transport.c                                       |  27 ++
 transport.h                                       |   8 +
 upload-pack.c                                     |  39 ++-
 30 files changed, 1425 insertions(+), 24 deletions(-)
 create mode 100644 list-objects-filters.c
 create mode 100644 list-objects-filters.h
 create mode 100644 object-filter.c
 create mode 100644 object-filter.h
 create mode 100644 oidset2.c
 create mode 100644 oidset2.h
 create mode 100644 t/t6112-rev-list-filters-objects.sh

-- 
2.9.3


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85C6D20281
	for <e@80x24.org>; Thu,  2 Nov 2017 17:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934263AbdKBRuf (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 13:50:35 -0400
Received: from siwi.pair.com ([209.68.5.199]:12769 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933258AbdKBRue (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 13:50:34 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 82F3584552;
        Thu,  2 Nov 2017 13:50:33 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CD22D84517;
        Thu,  2 Nov 2017 13:50:32 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 0/6] Partial clone part 1: object filtering
Date:   Thu,  2 Nov 2017 17:50:07 +0000
Message-Id: <20171102175013.3371-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Here is V2 of the list-object filtering. It replaces [1]
and reflect a refactoring and simplification of the original.

After much discussion on the "list-object-filter-map" I've replaced
it with a regular oidset -- the only need for the map was to store
the first observed pathname for each blob, but that itself was of
questionable value.

I've extended oidmap and oidset to have iterators.  These 2 commits
could be pulled out and applied on their own, but for now I need
them here.

There were also several comments on the layout of the filtering
API and the layout of the filter source code.  I've restructured
the filtering routines to put them in the same source file, and
made them all static.  These are now hidden behind a "factory-like"
function with a vtable.  This greatly simplifies the code in
traverse_commit_list_filtered().

I've added "--filter-ignore-missing" parameter to rev-list and
pack-objects to ignore missing objects rather than error out.
This allows this patch series to better stand on its own eliminates
the need in part 1 for "patch 9" from V1.

This is a brute force ignore all missing objects.  Later, in part
2 or part 3 when --exclude-promisor-objects is introduced, we will
be able to ignore EXPECTED missing objects.

Finally, patch 1 in this series is the same [2] which is currently
cooking in next.

[1] https://public-inbox.org/git/20171024185332.57261-1-git@jeffhostetler.com/

[2] * jh/dir-add-exclude-from-blob (2017-10-27) 1 commit
    - dir: allow exclusions from blob in addition to file


Jeff Hostetler (6):
  dir: allow exclusions from blob in addition to file
  oidmap: add oidmap iterator methods
  oidset: add iterator methods to oidset
  list-objects: filter objects in traverse_commit_list
  rev-list: add list-objects filtering support
  pack-objects: add list-objects filtering

 Documentation/git-pack-objects.txt     |  12 +-
 Documentation/git-rev-list.txt         |   6 +-
 Documentation/rev-list-options.txt     |  34 +++
 Makefile                               |   2 +
 builtin/pack-objects.c                 |  28 ++-
 builtin/rev-list.c                     |  75 +++++-
 dir.c                                  | 132 ++++++++---
 dir.h                                  |   3 +
 list-objects-filter-options.c          | 119 ++++++++++
 list-objects-filter-options.h          |  55 +++++
 list-objects-filter.c                  | 408 +++++++++++++++++++++++++++++++++
 list-objects-filter.h                  |  84 +++++++
 list-objects.c                         |  95 ++++++--
 list-objects.h                         |   2 +-
 oidmap.h                               |  22 ++
 oidset.c                               |  10 +
 oidset.h                               |  36 +++
 t/t5317-pack-objects-filter-objects.sh | 369 +++++++++++++++++++++++++++++
 t/t6112-rev-list-filters-objects.sh    | 225 ++++++++++++++++++
 19 files changed, 1664 insertions(+), 53 deletions(-)
 create mode 100644 list-objects-filter-options.c
 create mode 100644 list-objects-filter-options.h
 create mode 100644 list-objects-filter.c
 create mode 100644 list-objects-filter.h
 create mode 100755 t/t5317-pack-objects-filter-objects.sh
 create mode 100755 t/t6112-rev-list-filters-objects.sh

-- 
2.9.3


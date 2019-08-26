Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120781F4C0
	for <e@80x24.org>; Mon, 26 Aug 2019 02:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfHZCnd (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 22:43:33 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36218 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728986AbfHZCnd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 22:43:33 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 60EB61F461;
        Mon, 26 Aug 2019 02:43:32 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 00/11] hashmap: bugfixes, safety fixes, and WIP improvements
Date:   Mon, 26 Aug 2019 02:43:21 +0000
Message-Id: <20190826024332.3403-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This started out as yak-shaving exercise to introduce the
"container_of" macro to make hashmap more flexible and
less error-prone.

So far I've ended up finding and fixing two real bugs in
patches 1/11 and 2/11 which should be fast-tracked.

Patches 3-9 are straightforward safety fixes to prevent future
bugs of the same type.

10-11 are work-in-progress changes to remove the limitation
of hashmap_entry being the first member of a struct.  It's
also part of my ongoing agenda to spread Linux kernel idioms
into userspace and maybe get git.git hackers more comfortable
with kernel hacking (and vice-versa :>)

I'll try to continue the rest within the next few days.


The following changes since commit 745f6812895b31c02b29bdfe4ae8e5498f776c26:

  First batch after Git 2.23 (2019-08-22 12:41:04 -0700)

are available in the Git repository at:

  https://80x24.org/git-svn.git hashmap-wip-v1

for you to fetch changes up to 4d9857917670218cba447caddec15a2734c86e2c:

  hashmap_get_next returns "struct hashmap_entry *" (2019-08-26 02:25:35 +0000)

----------------------------------------------------------------
Eric Wong (11):
      diff: use hashmap_entry_init on moved_entry.ent
      packfile: use hashmap_entry in delta_base_cache_entry
      hashmap_entry_init takes "struct hashmap_entry *"
      hashmap_entry: detect improper initialization
      hashmap_get_next takes "const struct hashmap_entry *"
      hashmap_add takes "struct hashmap_entry *"
      hashmap_get takes "const struct hashmap_entry *"
      hashmap_remove takes "const struct hashmap_entry *"
      hashmap_put takes "struct hashmap_entry *"
      introduce container_of macro
      hashmap_get_next returns "struct hashmap_entry *"

 attr.c                              |  8 +++----
 blame.c                             | 12 +++++-----
 builtin/describe.c                  |  4 ++--
 builtin/difftool.c                  | 17 +++++++-------
 builtin/fast-export.c               |  9 ++++----
 builtin/fetch.c                     |  4 ++--
 config.c                            |  8 +++----
 diff.c                              | 23 ++++++++++++-------
 diffcore-rename.c                   | 15 ++++++++-----
 git-compat-util.h                   | 10 +++++++++
 hashmap.c                           | 30 ++++++++++++++-----------
 hashmap.h                           | 45 +++++++++++++++++++++----------------
 merge-recursive.c                   | 27 +++++++++++-----------
 name-hash.c                         | 41 +++++++++++++++++----------------
 oidmap.c                            |  2 +-
 packfile.c                          |  8 +++----
 patch-ids.c                         |  6 ++---
 range-diff.c                        |  8 +++----
 ref-filter.c                        |  5 +++--
 refs.c                              |  7 ++++--
 remote.c                            |  8 ++++---
 revision.c                          |  9 ++++----
 sequencer.c                         |  9 ++++----
 sub-process.c                       | 10 ++++-----
 submodule-config.c                  | 20 ++++++++---------
 t/helper/test-hashmap.c             | 24 +++++++++++---------
 t/helper/test-lazy-init-name-hash.c |  4 ++--
 27 files changed, 210 insertions(+), 163 deletions(-)

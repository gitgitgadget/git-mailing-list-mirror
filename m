Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 991321F9FB
	for <e@80x24.org>; Tue, 24 Sep 2019 01:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503729AbfIXBDZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 21:03:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59012 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391905AbfIXBDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 21:03:25 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 9273E1F463;
        Tue, 24 Sep 2019 01:03:24 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: [PATCH v2 00/19] hashmap bug/safety/ease-of-use fixes
Date:   Tue, 24 Sep 2019 01:03:05 +0000
Message-Id: <20190924010324.22619-1-e@80x24.org>
In-Reply-To: <20190826024332.3403-1-e@80x24.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patches 1-11 are largely unchanged from the original series with the
exception of 2, which is new and posted at:

	https://public-inbox.org/git/20190908074953.kux7zz4y7iolqko4@whir/

12-17 take further steps to get us away from hashmap_entry being
the first element, but they're also a bit ugly because __typeof__
isn't portable

18-19 finally brings me to the APIs I want to expose without
relying on __typeof :)

Apologies for the delays, been busy with other stuff...

Previous discussion starts at:

	https://public-inbox.org/git/20190826024332.3403-1-e@80x24.org/

The following changes since commit 745f6812895b31c02b29bdfe4ae8e5498f776c26:

  First batch after Git 2.23 (2019-08-22 12:41:04 -0700)

are available in the Git repository at:

  https://80x24.org/git-svn.git hashmap-wip-v2

for you to fetch changes up to 212a596edd99169b284912b7b70b6280e2fb90e6:

  hashmap: remove type arg from hashmap_{get,put,remove}_entry (2019-09-24 00:42:22 +0000)

----------------------------------------------------------------
Eric Wong (19):
      diff: use hashmap_entry_init on moved_entry.ent
      coccicheck: detect hashmap_entry.hash assignment
      packfile: use hashmap_entry in delta_base_cache_entry
      hashmap_entry_init takes "struct hashmap_entry *"
      hashmap_get_next takes "const struct hashmap_entry *"
      hashmap_add takes "struct hashmap_entry *"
      hashmap_get takes "const struct hashmap_entry *"
      hashmap_remove takes "const struct hashmap_entry *"
      hashmap_put takes "struct hashmap_entry *"
      introduce container_of macro
      hashmap_get_next returns "struct hashmap_entry *"
      hashmap: use *_entry APIs to wrap container_of
      hashmap_get{,_from_hash} return "struct hashmap_entry *"
      hashmap_cmp_fn takes hashmap_entry params
      hashmap: use *_entry APIs for iteration
      hashmap: hashmap_{put,remove} return hashmap_entry *
      hashmap: introduce hashmap_free_entries
      OFFSETOF_VAR macro to simplify hashmap iterators
      hashmap: remove type arg from hashmap_{get,put,remove}_entry

 attr.c                              |  22 ++---
 blame.c                             |  25 +++---
 builtin/describe.c                  |  21 +++--
 builtin/difftool.c                  |  56 ++++++------
 builtin/fast-export.c               |  15 ++--
 builtin/fetch.c                     |  30 ++++---
 config.c                            |  24 +++---
 contrib/coccinelle/hashmap.cocci    |  16 ++++
 diff.c                              |  31 ++++---
 diffcore-rename.c                   |  15 ++--
 git-compat-util.h                   |  33 ++++++++
 hashmap.c                           |  58 ++++++++-----
 hashmap.h                           | 164 +++++++++++++++++++++++++++++-------
 merge-recursive.c                   |  87 ++++++++++---------
 name-hash.c                         |  57 +++++++------
 oidmap.c                            |  20 +++--
 oidmap.h                            |   6 +-
 packfile.c                          |  22 +++--
 patch-ids.c                         |  18 ++--
 range-diff.c                        |  10 +--
 ref-filter.c                        |  31 ++++---
 refs.c                              |  23 +++--
 remote.c                            |  21 +++--
 revision.c                          |  28 +++---
 sequencer.c                         |  44 ++++++----
 sub-process.c                       |  20 +++--
 sub-process.h                       |   4 +-
 submodule-config.c                  |  52 +++++++-----
 t/helper/test-hashmap.c             |  49 ++++++-----
 t/helper/test-lazy-init-name-hash.c |  12 +--
 30 files changed, 647 insertions(+), 367 deletions(-)
 create mode 100644 contrib/coccinelle/hashmap.cocci

Eric Wong (19):
  diff: use hashmap_entry_init on moved_entry.ent
  coccicheck: detect hashmap_entry.hash assignment
  packfile: use hashmap_entry in delta_base_cache_entry
  hashmap_entry_init takes "struct hashmap_entry *"
  hashmap_get_next takes "const struct hashmap_entry *"
  hashmap_add takes "struct hashmap_entry *"
  hashmap_get takes "const struct hashmap_entry *"
  hashmap_remove takes "const struct hashmap_entry *"
  hashmap_put takes "struct hashmap_entry *"
  introduce container_of macro
  hashmap_get_next returns "struct hashmap_entry *"
  hashmap: use *_entry APIs to wrap container_of
  hashmap_get{,_from_hash} return "struct hashmap_entry *"
  hashmap_cmp_fn takes hashmap_entry params
  hashmap: use *_entry APIs for iteration
  hashmap: hashmap_{put,remove} return hashmap_entry *
  hashmap: introduce hashmap_free_entries
  OFFSETOF_VAR macro to simplify hashmap iterators
  hashmap: remove type arg from hashmap_{get,put,remove}_entry

 attr.c                              |  22 ++--
 blame.c                             |  25 +++--
 builtin/describe.c                  |  21 ++--
 builtin/difftool.c                  |  56 ++++++----
 builtin/fast-export.c               |  15 ++-
 builtin/fetch.c                     |  30 ++---
 config.c                            |  24 ++--
 contrib/coccinelle/hashmap.cocci    |  16 +++
 diff.c                              |  31 +++---
 diffcore-rename.c                   |  15 ++-
 git-compat-util.h                   |  33 ++++++
 hashmap.c                           |  58 ++++++----
 hashmap.h                           | 164 +++++++++++++++++++++++-----
 merge-recursive.c                   |  87 ++++++++-------
 name-hash.c                         |  57 +++++-----
 oidmap.c                            |  20 ++--
 oidmap.h                            |   6 +-
 packfile.c                          |  22 ++--
 patch-ids.c                         |  18 +--
 range-diff.c                        |  10 +-
 ref-filter.c                        |  31 ++++--
 refs.c                              |  23 +++-
 remote.c                            |  21 ++--
 revision.c                          |  28 +++--
 sequencer.c                         |  44 +++++---
 sub-process.c                       |  20 ++--
 sub-process.h                       |   4 +-
 submodule-config.c                  |  52 +++++----
 t/helper/test-hashmap.c             |  49 +++++----
 t/helper/test-lazy-init-name-hash.c |  12 +-
 30 files changed, 647 insertions(+), 367 deletions(-)
 create mode 100644 contrib/coccinelle/hashmap.cocci


base-commit: 745f6812895b31c02b29bdfe4ae8e5498f776c26

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFFEC49EA7
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 02:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2A761151
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 02:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhF0Ctm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 22:49:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60426 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhF0Ctl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 22:49:41 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id DA7AC1F8C6;
        Sun, 27 Jun 2021 02:47:18 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/5] optimizations for many odb alternates
Date:   Sun, 27 Jun 2021 02:47:13 +0000
Message-Id: <20210627024718.25383-1-e@80x24.org>
In-Reply-To: <20210624005806.12079-1-e@80x24.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cc-ing Rene and Peff for their previous work on loose object
caching speedups (and also Peff on crit-bit trees).

I'm expecting a use case involving tens of thousands of
repos being tied together by alternates.  I realize this is
an odd case, but there's some fairly small changes that
give significant speedups and memory savings.

I can't seem to get consistent benchmarks on my workstation
(since it doubles as a public-facing server :x), but things
seem generally in the ballpark...

1/5 is a resend and the biggest obvious time improvement
(at some cost to space).

2/5 and 4/5 are pretty obvious; 3/5 should be obvious, too,
but my arithmetic is terrible :x

5/5 is a big (and easily measured) space improvement that
will negate space regression caused by 1/5 (and then some).
I'm not sure if there's much or any change in time in
either direction, though...

Eric Wong (5):
  speed up alt_odb_usable() with many alternates
  avoid strlen via strbuf_addstr in link_alt_odb_entry
  make object_directory.loose_objects_subdir_seen a bitmap
  oidcpy_with_padding: constify `src' arg
  oidtree: a crit-bit tree for odb_loose_cache

 Makefile                |   3 +
 alloc.c                 |   6 ++
 alloc.h                 |   1 +
 cbtree.c                | 167 ++++++++++++++++++++++++++++++++++++++++
 cbtree.h                |  56 ++++++++++++++
 hash.h                  |   2 +-
 object-file.c           |  68 +++++++++-------
 object-name.c           |  28 +++----
 object-store.h          |  24 +++++-
 object.c                |   2 +
 oidtree.c               |  94 ++++++++++++++++++++++
 oidtree.h               |  29 +++++++
 t/helper/test-oidtree.c |  45 +++++++++++
 t/helper/test-tool.c    |   1 +
 t/helper/test-tool.h    |   1 +
 t/t0069-oidtree.sh      |  52 +++++++++++++
 16 files changed, 530 insertions(+), 49 deletions(-)
 create mode 100644 cbtree.c
 create mode 100644 cbtree.h
 create mode 100644 oidtree.c
 create mode 100644 oidtree.h
 create mode 100644 t/helper/test-oidtree.c
 create mode 100755 t/t0069-oidtree.sh

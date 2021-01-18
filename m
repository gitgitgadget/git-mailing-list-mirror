Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BE1C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 23:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05CF422B39
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 23:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbhARXuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 18:50:52 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55888 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387629AbhARXuu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Jan 2021 18:50:50 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A330060781;
        Mon, 18 Jan 2021 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1611013808;
        bh=1glIpr10HKhX+LQY6g9lIquN5DofjKNHAyQenFUuuOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=vGFhj7rq9yDgzxTtSISoBh1sJA7hMtJ2B/iaZi7u3XoQfIf8Sv0CyY71JVVtjBRQL
         dUrUKYzSjYd1PktcdFyHUm80BA7nPxibeh0/Wl83x+ACTB3lu7PL5lC6V8VK91a6j5
         ROk1nVnyG9YUUT2vMODFXltK9wYBE34VDNHyUkyp+QKeEGv1PpyIL4UuqhwRsCuHP+
         klAP6r7fs+pphTYHSCcjkOUECn+o0JIhaKRUpxvHwSR8cUR0colwjuXHzlWkyACV5W
         +ueWsEuDt7EpJ5XT5elMGUmvFI8/7pbhjIQNv2N+XvKLdxBsROe0fNi8K0yibrsdhY
         tSYauZiWciQKzljVa0q18xzal4Tuslp/hgyeLqszv75+/2j782WweX2Abljk3m1QVz
         iismqM7BkNQZEm0QNapirk2Mp0rHfbM8CCvjOXrm3L8VxvAP2v+PVagYR7zVUYlxnb
         LfmgZHrwOSnqDffgBVb3Bv8NId5cQmndXfbmjFDEn2bY3Z6F0C4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 0/6] Support for commits signed by multiple algorithms
Date:   Mon, 18 Jan 2021 23:49:09 +0000
Message-Id: <20210118234915.2036197-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210111035840.2437737-1-sandals@crustytoothpaste.net>
References: <20210111035840.2437737-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series introduces support for verifying commits and tags signed by
multiple algorithms.

These commits allow for signing commits and tags that can be
round-tripped through both SHA-1 and SHA-256.  We verify only the
signature using the current hash algorithm, since we currently don't
rewrite objects.

Changes from v2:
* Fix problems with size_t and unsigned long on 32-bit systems by
  creating a cleanup patch at the beginning of the series.
* Fix a clang warning with initialization by using memset.

Changes from v1:
* Fix brown paper bag bug where some tests failed due to a bad rebase.

brian m. carlson (6):
  ref-filter: switch some uses of unsigned long to size_t
  commit: ignore additional signatures when parsing signed commits
  gpg-interface: improve interface for parsing tags
  commit: allow parsing arbitrary buffers with headers
  ref-filter: hoist signature parsing
  gpg-interface: remove other signature headers before verifying

 builtin/receive-pack.c   |  4 +-
 builtin/tag.c            | 16 ++++++--
 commit.c                 | 85 +++++++++++++++++++++++++++-------------
 commit.h                 | 12 +++++-
 fmt-merge-msg.c          | 29 ++++++++------
 gpg-interface.c          | 15 ++++++-
 gpg-interface.h          |  9 ++++-
 log-tree.c               | 15 +++----
 ref-filter.c             | 33 ++++++++++------
 t/t7004-tag.sh           | 25 ++++++++++++
 t/t7510-signed-commit.sh | 43 +++++++++++++++++++-
 tag.c                    | 15 +++----
 12 files changed, 226 insertions(+), 75 deletions(-)


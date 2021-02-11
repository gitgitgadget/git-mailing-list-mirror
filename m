Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D146EC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7576264EBC
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhBKCJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 21:09:05 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45882 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhBKCJB (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Feb 2021 21:09:01 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 629246079B;
        Thu, 11 Feb 2021 02:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1613009299;
        bh=d+pg+DiCp+bwhhT7Gx8yV1jRjpDKKZ7FUAY3ruXDXW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=0U0cG326B8LBUpG1Xcz7r1chHSUowCQxuePlqjqrMCmvzqz2OBDQYf4VWAdWDPJHZ
         l4iGRnEvA+M4jcGje8QGE9G8bqhJ0YyzZBApeb+FuM+nayHcbcE7CYYwZ/Ba6I73Oe
         kxEMHpl1qmR0Pmec2o8PWw4CYQXOTxPzAZJZY4agdMr0M6+fVlMAq+/iAaaDOyvwPV
         THvZn/YupwCuVKPzoR2a6lTp+VJXqK/3126y3OMQeaZs+D2zapuu7N7bnwYtnugX7v
         rL3nEY/G/9II4S46HV8c4e62qAIQn3fGC2EbTFQQPDsCUxCAg6IjphyOSw3jJN+/4h
         yRt9uwJmY/Tb2r1xbwb5vC1YB8r+k03jXUFAzTd8U5vcBmJ+ZqMDcXa+hzlomwrAwl
         5F2CaQlMcmqBWXzXGVD6sZDZztBDftChikgQqJPZISDpBWKoC4AuSQSSwXnmeUWhOy
         kl+L/Xbrq4guW37GYibAGoyp27H2ixnwiPL9cviRE6WI3JlKGm/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/6] Support for commits signed by multiple algorithms
Date:   Thu, 11 Feb 2021 02:08:00 +0000
Message-Id: <20210211020806.288523-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210118234915.2036197-1-sandals@crustytoothpaste.net>
References: <20210118234915.2036197-1-sandals@crustytoothpaste.net>
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

Changes from v3:
* Fix a double free.

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


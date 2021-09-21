Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE268C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4DE1610A1
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhIUDrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:47:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:51412 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbhIUDrL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 23:47:11 -0400
Received: (qmail 3387 invoked by uid 109); 21 Sep 2021 03:45:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 03:45:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27527 invoked by uid 111); 21 Sep 2021 03:45:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Sep 2021 23:45:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Sep 2021 23:45:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Hamza Mahfooz <someguy@effective-light.com>
Subject: [PATCH 0/5] const-correctness in grep.c
Message-ID: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While discussing [1], I noticed that the grep code mostly takes
non-const buffers, even though it is conceptually a read-only operation
to search in them. The culprit is a handful of spots that temporarily
tie off NUL-terminated strings by overwriting a byte of the buffer and
then restoring it. But I think we no longer need to do so these days,
now that we have a regexec_buf() that can take a ptr/size pair.

The first three patches are a bit repetitive, but I broke them up
individually because they're the high-risk part. I.e., if my assumptions
about needing the NUL are wrong, it could introduce a bug. But based on
my reading of the code, plus running the test suite with ASan/UBSan, I
feel reasonably confident.

The last two are the bigger cleanups, but should obviously avoid any
behavior changes.

  [1/5]: grep: stop modifying buffer in strip_timestamp
  [2/5]: grep: stop modifying buffer in show_line()
  [3/5]: grep: stop modifying buffer in grep_source_1()
  [4/5]: grep: mark "haystack" buffers as const
  [5/5]: grep: store grep_source buffer as const

 grep.c | 87 +++++++++++++++++++++++++++++-----------------------------
 grep.h |  4 +--
 2 files changed, 45 insertions(+), 46 deletions(-)

-Peff

[1] https://lore.kernel.org/git/YUk3zwuse56v76ze@coredump.intra.peff.net/

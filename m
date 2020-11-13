Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85908C388F9
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 05:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E9120B80
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 05:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgKMFGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 00:06:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:56900 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgKMFGc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 00:06:32 -0500
Received: (qmail 23750 invoked by uid 109); 13 Nov 2020 05:06:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Nov 2020 05:06:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6135 invoked by uid 111); 13 Nov 2020 05:06:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Nov 2020 00:06:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Nov 2020 00:06:31 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/5] handling 4GB .idx files
Message-ID: <20201113050631.GA744608@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently ran into a case where Git could not read the pack it had
produced via running "git repack". The culprit turned out to be an .idx
file which crossed the 4GB barrier (in bytes, not number of objects).
This series fixes the problems I saw, along with similar ones I couldn't
trigger in practice, and protects the .idx loading code against integer
overflows that would fool the size checks.

  [1/5]: compute pack .idx byte offsets using size_t
  [2/5]: use size_t to store pack .idx byte offsets
  [3/5]: fsck: correctly compute checksums on idx files larger than 4GB
  [4/5]: block-sha1: take a size_t length parameter
  [5/5]: packfile: detect overflow in .idx file size checks

 block-sha1/sha1.c        |  2 +-
 block-sha1/sha1.h        |  2 +-
 builtin/index-pack.c     |  2 +-
 builtin/pack-redundant.c |  6 +++---
 pack-check.c             | 10 +++++-----
 pack-revindex.c          |  2 +-
 packfile.c               | 14 +++++++-------
 7 files changed, 19 insertions(+), 19 deletions(-)

-Peff

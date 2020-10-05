Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E0EC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 07:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 873C420659
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 07:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgJEHRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 03:17:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:49206 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgJEHRw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 03:17:52 -0400
Received: (qmail 30272 invoked by uid 109); 5 Oct 2020 07:17:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2020 07:17:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16381 invoked by uid 111); 5 Oct 2020 07:17:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2020 03:17:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Oct 2020 03:17:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/7] forbidding symlinked .gitattributes and .gitignore
Message-ID: <20201005071751.GA2290770@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

About 2 years ago as part of a security release we made it illegal to
have a symlinked .gitmodules file (refusing it both in the index and via
fsck). At the time we discussed (on the security list) outlawing
symlinks for other .git files in the same way, but we decided not to do
so as part of the security release, as it wasn't strictly necessary.

We publicly revisited the topic in:

  https://lore.kernel.org/git/20190114230902.GG162110@google.com/

but there were a few fixes needed, and it got forgotten. So here it is
again, with those fixes:

  [1/7]: fsck_tree(): fix shadowed variable
  [2/7]: fsck_tree(): wrap some long lines

    These first two are actually an unrelated fix and cleanup in the
    nearby code. Could be picked up independently.

  [3/7]: t7415: rename to expand scope
  [4/7]: t7450: test verify_path() handling of gitmodules

    Preparatory test cleanup and improvement for existing features.

  [5/7]: t0060: test obscured .gitattributes and .gitignore matching
  [6/7]: verify_path(): disallow symlinks in .gitattributes and .gitignore
  [7/7]: fsck: complain when .gitattributes or .gitignore is a symlink

    The actual feature, covering the index and fsck.

 fsck.c                                        | 79 ++++++++++++++-----
 read-cache.c                                  | 12 ++-
 t/helper/test-path-utils.c                    | 41 +++++++---
 t/t0060-path-utils.sh                         | 20 +++++
 ...odule-names.sh => t7450-bad-meta-files.sh} | 69 ++++++++++++++--
 5 files changed, 179 insertions(+), 42 deletions(-)
 rename t/{t7415-submodule-names.sh => t7450-bad-meta-files.sh} (77%)

-Peff

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0371C433ED
	for <git@archiver.kernel.org>; Sat,  1 May 2021 15:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A38861494
	for <git@archiver.kernel.org>; Sat,  1 May 2021 15:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhEAPlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 11:41:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:42100 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230051AbhEAPlm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 11:41:42 -0400
Received: (qmail 26613 invoked by uid 109); 1 May 2021 15:40:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 May 2021 15:40:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10724 invoked by uid 111); 1 May 2021 15:40:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 May 2021 11:40:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 May 2021 11:40:52 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/9] leftover bits from symlinked gitattributes, etc topics
Message-ID: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A while back, I had a topic[1] that treated symlinked .gitattributes
(and .gitignore and .mailmap) the same as .gitmodules: forbidding them
in the index, complaining about them via fsck, etc.

In the end, we decided not to do that[2], and instead just open the
files with O_NOFOLLOW instead. As I said in that thread, we could
salvage some of the cleanups, fsck checks, and docs from the original
topic. So here that is. (The new topic is in master but not yet
released; so while this is not strictly a bug-fix for an existing topic,
it would be good to get especially the doc improvements into the same
release).

[1] https://lore.kernel.org/git/20201005071751.GA2290770@coredump.intra.peff.net/
[2] https://lore.kernel.org/git/YDiWs6yyv3U9YvC2@coredump.intra.peff.net/

The patches are:

  [1/9]: t7415: remove out-dated comment about translation
  [2/9]: fsck_tree(): fix shadowed variable
  [3/9]: fsck_tree(): wrap some long lines

    These three are really independent fixes and cleanups, that could be
    taken separately.

  [4/9]: t7415: rename to expand scope
  [5/9]: t7450: test verify_path() handling of gitmodules
  [6/9]: t7450: test .gitmodules symlink matching against obscured names

    These three are just cleaning up and improving the tests for the
    existing handling of the .gitmodules symlinks.

  [7/9]: t0060: test ntfs/hfs-obscured dotfiles
  [8/9]: fsck: warn about symlinked dotfiles we'll open with O_NOFOLLOW

    These two extend fsck checks (warnings, not errors) to the new
    files. I think this is an improvement, but I could be persuaded
    otherwise (and these two could be dropped independent of the rest).

  [9/9]: docs: document symlink restrictions for dot-files

    And this covers documentation for all of the files (including
    .gitmodules).

 Documentation/gitattributes.txt               |   7 ++
 Documentation/gitignore.txt                   |   5 +
 Documentation/gitmailmap.txt                  |   7 ++
 Documentation/gitmodules.txt                  |   8 ++
 cache.h                                       |   1 +
 fsck.c                                        |  84 ++++++++++---
 fsck.h                                        |   3 +
 path.c                                        |   5 +
 t/helper/test-path-utils.c                    |  46 +++++--
 t/t0060-path-utils.sh                         |  30 +++++
 ...ule-names.sh => t7450-bad-git-dotfiles.sh} | 116 +++++++++++++-----
 utf8.c                                        |   5 +
 utf8.h                                        |   1 +
 13 files changed, 257 insertions(+), 61 deletions(-)
 rename t/{t7415-submodule-names.sh => t7450-bad-git-dotfiles.sh} (70%)

-Peff

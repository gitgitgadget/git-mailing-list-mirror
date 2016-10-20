Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FE4620986
	for <e@80x24.org>; Thu, 20 Oct 2016 06:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbcJTGPk (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 02:15:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:59851 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753195AbcJTGPk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 02:15:40 -0400
Received: (qmail 18353 invoked by uid 109); 20 Oct 2016 06:15:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 06:15:39 +0000
Received: (qmail 20963 invoked by uid 111); 20 Oct 2016 06:16:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 02:16:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 02:15:36 -0400
Date:   Thu, 20 Oct 2016 02:15:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/7] stop blind fallback to ".git"
Message-ID: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-on to the series in:

  http://public-inbox.org/git/20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net/

That series avoided looking at ".git/config" when we haven't discovered
whether we are in a git repo. This takes that further and avoids ever
looking at ".git" as a fallback.

Patches 1-6 just teach various low-level code to detect and handle the
case when we are not in a configure repository (along with associated
cleanups). The final patch actually disallows this case (and the early
fixes were found by running the test suite with just the final patch).

I think this is a step in the right direction, both in fixing bugs, but
also in making our setup and repository-access code easier to reason
about. However, it does carry a risk of regression, if there are more
"fixes" that I missed. If we wanted to be really conservative, we could
hold back the 7th patch as a separate topic and cook it in "next" for an
extra release cycle or something. I'm not all that worried, though.

I built this on top of jc/diff-unique-abbrev-comments, as it refactors
that same function (and it didn't seem like a bad topic to be held
hostage by).

  [1/7]: read info/{attributes,exclude} only when in repository
  [2/7]: test-*-cache-tree: setup git dir
  [3/7]: find_unique_abbrev: use 4-buffer ring
  [4/7]: diff_unique_abbrev: rename to diff_aligned_abbrev
  [5/7]: diff_aligned_abbrev: use "struct oid"
  [6/7]: diff: handle sha1 abbreviations outside of repository
  [7/7]: setup_git_env: avoid blind fall-back to ".git"

 attr.c                           |  6 +++++-
 builtin/merge.c                  | 11 +++++-----
 builtin/receive-pack.c           | 16 ++++++---------
 cache.h                          |  4 ++--
 combine-diff.c                   |  6 +++---
 diff.c                           | 43 +++++++++++++++++++++++++---------------
 diff.h                           |  6 +++++-
 dir.c                            | 12 +++++------
 environment.c                    |  5 ++++-
 sha1_name.c                      |  4 +++-
 t/helper/test-dump-cache-tree.c  |  1 +
 t/helper/test-scrap-cache-tree.c |  1 +
 12 files changed, 68 insertions(+), 47 deletions(-)

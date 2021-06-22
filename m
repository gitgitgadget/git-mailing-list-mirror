Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB73C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3151760FE3
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFVQFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:05:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:36000 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhFVQFc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 12:05:32 -0400
Received: (qmail 5785 invoked by uid 109); 22 Jun 2021 16:03:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jun 2021 16:03:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28236 invoked by uid 111); 22 Jun 2021 16:03:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jun 2021 12:03:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Jun 2021 12:03:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/5] some "log --decorate" optimizations
Message-ID: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was recently pointed to a repository where:

  git log --format="%H %P" old..new

was abysmally slow, even though old..new only had a few commits, because
load_ref_decorations() takes a long time (and kicks in due to the
auto-decorate behavior). Leaving aside that "rev-list" would probably be
a better tool here, it seems there's some low-hanging fruit:

  - a user-format that doesn't show decorations doesn't need to load
    them (fixed in patch 2 below)

  - we're pretty eager to parse the objects at the tip of each ref
    (fixed in patch 5 below)

The other commits are just cleanups and preparatory refactors.

  [1/5]: pretty.h: update and expand docstring for userformat_find_requirements()
  [2/5]: log: avoid loading decorations for userformats that don't need it
  [3/5]: object.h: expand docstring for lookup_unknown_object()
  [4/5]: object.h: add lookup_object_by_type() function
  [5/5]: load_ref_decorations(): avoid parsing non-tag objects

 builtin/log.c |  3 +++
 log-tree.c    |  6 ++++--
 object.c      | 18 ++++++++++++++++++
 object.h      | 20 +++++++++++++++++++-
 pretty.c      |  4 ++++
 pretty.h      |  8 ++++++--
 reachable.c   | 18 ------------------
 7 files changed, 54 insertions(+), 23 deletions(-)

-Peff

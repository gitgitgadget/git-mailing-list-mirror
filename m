Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54121C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 04:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiIHEwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 00:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIHEwX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 00:52:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11DE9FA85
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 21:52:21 -0700 (PDT)
Received: (qmail 24562 invoked by uid 109); 8 Sep 2022 04:52:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Sep 2022 04:52:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17774 invoked by uid 111); 8 Sep 2022 04:52:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 00:52:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 00:52:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 0/5] plugging some list-objects-filter leaks
Message-ID: <Yxl1BNQoy6Drf0Oe@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test I sent earlier in [1] fails the linux-leaks CI job, not because
it introduces new leaks, but just because it runs existing leaks in a
test marked as passing-leaks.

Of course we can drop the passing flag, but I figured it would probably
be an easy fix. Famous last words. It turned into quite a rabbit hole of
actual leaks (albeit small and bounded per process) and some
questionable memory ownership semantics.

Here's the series I came up with. I'm cc-ing Stolee as the last person
unfortunate enough to have touched this area. :)

  [1/5]: list_objects_filter_copy(): deep-copy sparse_oid_name field
  [2/5]: transport: deep-copy object-filter struct for fetch-pack
  [3/5]: transport: free filter options in disconnect_git()
  [4/5]: list_objects_filter_options: plug leak of filter_spec strings
  [5/5]: prepare_repo_settings(): plug leak of config values

 list-objects-filter-options.c | 20 ++++++++++++++------
 repo-settings.c               |  7 +++----
 transport.c                   |  5 ++++-
 3 files changed, 21 insertions(+), 11 deletions(-)

-Peff

[1] https://lore.kernel.org/git/YxkG3A30vNfu55Sx@coredump.intra.peff.net/

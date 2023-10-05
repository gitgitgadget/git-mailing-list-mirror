Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683DBE92FC0
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 21:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjJEV2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 17:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjJEV2F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 17:28:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D42395
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 14:28:04 -0700 (PDT)
Received: (qmail 27229 invoked by uid 109); 5 Oct 2023 21:28:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Oct 2023 21:28:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29416 invoked by uid 111); 5 Oct 2023 21:28:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Oct 2023 17:28:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Oct 2023 17:28:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] a few more leak fixes
Message-ID: <20231005212802.GA982892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was really bothered that using clang with SANITIZE=leak found a leak
that gcc didn't. And then I was doubly bothered to find that there is
one that gcc finds that clang doesn't!

I don't think either of these are urgent or important leaks on their
own, but the flaky nature of the results makes it annoying while trying
to find and clean up other leaks. So here are some fixes. Patches 1 and
3 are those two cases, respectively. Patch 2 is a more interesting
leak-fix enabled by the infrastructure added in patch 1.

  [1/3]: decorate: add clear_decoration() function
  [2/3]: revision: clear decoration structs during release_revisions()
  [3/3]: daemon: free listen_addr before returning

 daemon.c                         | 37 ++++++++++++++++++--------------
 decorate.c                       | 15 +++++++++++++
 decorate.h                       | 10 +++++++++
 line-log.c                       | 10 +++++++++
 line-log.h                       |  2 ++
 revision.c                       |  9 ++++++++
 t/helper/test-example-decorate.c |  2 ++
 t/t4217-log-limit.sh             |  1 +
 t/t5811-proto-disable-git.sh     |  2 ++
 t/t9004-example.sh               |  2 ++
 10 files changed, 74 insertions(+), 16 deletions(-)

-Peff

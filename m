Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BCAC43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 07:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiGFH5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 03:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiGFH5y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 03:57:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17DB23152
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 00:57:51 -0700 (PDT)
Received: (qmail 2280 invoked by uid 109); 6 Jul 2022 07:57:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Jul 2022 07:57:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18029 invoked by uid 111); 6 Jul 2022 07:57:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Jul 2022 03:57:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Jul 2022 03:57:50 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 0/3] cloning unborn HEAD when other branches are present
Message-ID: <YsVAfudoUA5YkQWH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I ran across a situation today where I was being a little clever with
manipulating branches, and the results were confusing. Basically I have
an old bare server-side repo with a "master" branch, and realized that I
wanted to start a new line of history, but save the old one for
historical purposes. So I did this in the bare repo:

  cd bare.git
  git branch -m master old-history
  git symbolic-ref HEAD new-history

to move the old one and point HEAD at the new unborn branch. Note that I
didn't just name it "master"; now that there are two lines of history, I
gave them identifiable and distinct names.

My intent was to then clone and create the new history:

  git clone bare.git local-repo
  cd local-repo
  git commit [etc]
  git push

I assumed that just like in the empty-repo case, the clone would start
on "new-history". But it doesn't! This series fixes it.

+cc Jonathan Tan. Definitely not your bug, as the behavior has been this
way forever. But this is very adjacent to your empty-repo unborn head
work from 4f37d45706 (clone: respect remote unborn HEAD, 2021-02-05),
and I think harmonizing a related case.

  [1/3]: clone: drop extra newline from warning message
  [2/3]: clone: factor out unborn head setup into its own function
  [3/3]: clone: propagate empty remote HEAD even with other branches

 builtin/clone.c        | 49 ++++++++++++++++++++++++------------------
 t/t5702-protocol-v2.sh | 38 ++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 21 deletions(-)

-Peff

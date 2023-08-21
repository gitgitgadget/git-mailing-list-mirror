Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB8BEE49A6
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 20:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjHUUOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHUUOC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 16:14:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC201101
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:13:59 -0700 (PDT)
Received: (qmail 17324 invoked by uid 109); 21 Aug 2023 20:13:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Aug 2023 20:13:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18528 invoked by uid 111); 21 Aug 2023 20:13:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Aug 2023 16:13:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Aug 2023 16:13:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Romain Chossart <romainchossart@gmail.com>, git@vger.kernel.org
Subject: [PATCH v2 0/7] cleaning up diff_result_code()
Message-ID: <20230821201358.GA2663749@coredump.intra.peff.net>
References: <CAHxTZ4AUxow1p7mNG0fuRtfhkaOu=Wpc7cYvM8wRaB80hPNf9Q@mail.gmail.com>
 <20230821003532.GA1113755@coredump.intra.peff.net>
 <xmqqlee4s82d.fsf@gitster.g>
 <20230821180943.GA2617193@coredump.intra.peff.net>
 <xmqqfs4cp7dj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfs4cp7dj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2023 at 11:39:36AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > That would make the code simpler. It does feel a bit like going in the
> > opposite direction of recent "pass errors up the stack rather than
> > dying" libification efforts. I think that's OK for the builtin_* helpers
> > in diff.c, which are just serving the diff porcelain. But things like
> > run_diff_files(), while pretty big operations, are something we might
> > call as small part of another operation (like git-describe).
> 
> True, for things in diff-lib.c we likely would want to go in the
> opposite "return an error to be handled by the caller" route.

After poking at it a bit, I think it actually is OK to drop the return
codes here. There are some immediate benefits, and I'm not sure it
actually hampers libification that much; see patch 5 for my reasoning.

So here's what I came up with.

  [1/7]: diff: spell DIFF_INDEX_CACHED out when calling run_diff_index()

    Your patch verbatim, since there's tons of textual conflicts
    otherwise.

  [2/7]: diff-files: avoid negative exit value

    A bonus fix that I noticed. It's the same problem as found
    elsewhere, but using a different code path, so it seemed easiest to
    fix on its own.

  [3/7]: diff: show usage for unknown builtin_diff_files() options

    This directly fixes the bug found by Romain (but in a different way
    than v1).

  [4/7]: diff: die when failing to read index in git-diff builtin

    Obvious cleanups.

  [5/7]: diff: drop useless return from run_diff_{files,index} functions

    Possibly controversial cleanups. ;)

  [6/7]: diff: drop useless return values in git-diff helpers
  [7/7]: diff: drop useless "status" parameter from diff_result_code()

    And then these are the payoff cleanups enabled by patch 5.

 add-interactive.c           |  2 +-
 builtin/add.c               |  3 +-
 builtin/am.c                |  4 +-
 builtin/describe.c          |  6 +--
 builtin/diff-files.c        | 12 ++----
 builtin/diff-index.c        |  4 +-
 builtin/diff-tree.c         |  2 +-
 builtin/diff.c              | 79 +++++++++++++++++--------------------
 builtin/log.c               |  2 +-
 builtin/stash.c             | 16 +++-----
 builtin/submodule--helper.c |  7 ++--
 diff-lib.c                  |  8 ++--
 diff-no-index.c             |  2 +-
 diff.c                      |  6 +--
 diff.h                      |  6 +--
 t/t4017-diff-retval.sh      |  5 +++
 wt-status.c                 | 12 +++---
 17 files changed, 81 insertions(+), 95 deletions(-)

No range-diff since it's effectively a brand-new series.

BTW, I know you were looking at --exit-code bugs recently in another
series. But I think this should all be orthogonal (both semantically
and textually). I'll try to give another review on that series, as well.

-Peff

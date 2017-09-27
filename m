Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD3BF20281
	for <e@80x24.org>; Wed, 27 Sep 2017 05:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbdI0Fy2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 01:54:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:51524 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751396AbdI0Fy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 01:54:26 -0400
Received: (qmail 25061 invoked by uid 109); 27 Sep 2017 05:54:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 05:54:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11314 invoked by uid 111); 27 Sep 2017 05:55:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 01:55:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 01:54:24 -0400
Date:   Wed, 27 Sep 2017 01:54:24 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/7] read/write_in_full leftovers
Message-ID: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 25, 2017 at 04:26:47PM -0400, Jeff King wrote:

> This series addresses the bits leftover from the discussion two weeks
> ago in:
> 
>   https://public-inbox.org/git/20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net/
> 
> and its subthread. I don't think any of these is a real problem in
> practice, so this can be considered as a cleanup. I'm on the fence over
> whether the final one is a good idea. See the commit message for
> details.
> 
>   [1/7]: files-backend: prefer "0" for write_in_full() error check
>   [2/7]: notes-merge: drop dead zero-write code
>   [3/7]: read_in_full: reset errno before reading
>   [4/7]: get-tar-commit-id: prefer "!=" for read_in_full() error check
>   [5/7]: worktree: use xsize_t to access file size
>   [6/7]: worktree: check the result of read_in_full()
>   [7/7]: add xread_in_full() helper

Here's a followup based on the discussion on v1. There are actually a
few changes here.

I dropped the "read_in_full() should set errno on short reads" idea (3/7
in the earlier series). It really is the caller's fault for looking at
errno when they know there hasn't been an error in the first place. We
should just bite the bullet and have the callers do the right thing.

I also dropped the "xread_in_full" helper (7/7 earlier). The lego
sentences it created just weren't worth the hassle. Instead, I've fixed
all of the relevant callers to provide good error messages for both
cases. It's a few more lines of code, and it's probably rare for users
to see these in the first place. But it doesn't hurt too much to be
thorough, and I think it's good to model correct error handling. This is
in patches 4 and 5 below.

There are a handful of other changes:

  [1/7]: files-backend: prefer "0" for write_in_full() error check
  [2/7]: notes-merge: drop dead zero-write code

    These two are the same as before.

  [3/7]: prefer "!=" when checking read_in_full() result

    Along with the get-tar-commit-id case, I found two other cases which
    aren't bugs, but which should be updated for style reasons.

  [4/7]: avoid looking at errno for short read_in_full() returns
  [5/7]: distinguish error versus short_read from read_in_full()

    These two are new, and add in the messages. The ones in patch 4 are
    actively wrong (they show a bogus errno). The ones in 5 are just
    less descriptive than they could be. So if we find the extra lines
    of code too much, we could drop 5 (or even convert the ones in 4 to
    just stop looking at errno).

  [6/7]: worktree: use xsize_t to access file size

    Same as before.

  [7/7]: worktree: check the result of read_in_full()

    Similar, but now handles errors and short_reads separately. It also
    avoids leaking descriptors and memory in the error path (noticed by
    Coverity).

 builtin/get-tar-commit-id.c |  6 ++++--
 builtin/worktree.c          | 24 +++++++++++++++++++++---
 bulk-checkin.c              |  5 ++++-
 csum-file.c                 |  2 +-
 notes-merge.c               |  2 --
 pack-write.c                |  7 ++++++-
 packfile.c                  | 11 +++++++++--
 pkt-line.c                  |  2 +-
 refs/files-backend.c        |  2 +-
 sha1_file.c                 | 11 ++++++++---
 10 files changed, 55 insertions(+), 17 deletions(-)

-Peff

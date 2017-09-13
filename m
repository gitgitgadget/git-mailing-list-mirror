Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 931FD20286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751458AbdIMRIK (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:08:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:37010 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751120AbdIMRIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 13:08:09 -0400
Received: (qmail 22291 invoked by uid 109); 13 Sep 2017 17:08:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 17:08:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16251 invoked by uid 111); 13 Sep 2017 17:08:44 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 13:08:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 13:08:07 -0400
Date:   Wed, 13 Sep 2017 13:08:07 -0400
From:   Jeff King <peff@peff.net>
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 0/7] config.c may fail to notice some write() failures
Message-ID: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
References: <CANgJU+Wj_sN8Px6rweHMw_iAX8UA3mW9x4NVCctpUCs8_3ytLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANgJU+Wj_sN8Px6rweHMw_iAX8UA3mW9x4NVCctpUCs8_3ytLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 01:59:17PM +0200, demerphq wrote:

> After being away for a while I saw the following message in one of my git repos:
> 
> $ git status
> On branch yves/xxx
> Your branch is based on 'origin/yves/xxx', but the upstream is gone.
>   (use "git branch --unset-upstream" to fixup)
> 
> nothing to commit, working tree clean
> $ git branch --unset-upstream
> fatal: could not unset 'branch.yves/simple_projection.merge'
> 
> At this point my .git/config file was empty, and all of my config was lost.

Here's the fix, along with some related cleanups. The actual bugfix is
in the first patch, which I think should go to "maint". The rest are not
as important, so could go to master (but would also be fine for maint,
as there should be no user-visible changes).

  [1/7]: config: avoid "write_in_full(fd, buf, len) < len" pattern
  [2/7]: get-tar-commit-id: check write_in_full() return against 0
  [3/7]: avoid "write_in_full(fd, buf, len) != len" pattern
  [4/7]: convert less-trivial versions of "write_in_full() != len"
  [5/7]: pkt-line: check write_in_full() errors against "< 0"
  [6/7]: notes-merge: use ssize_t for write_in_full() return value
  [7/7]: config: flip return value of store_write_*()

 builtin/get-tar-commit-id.c |  3 +--
 builtin/receive-pack.c      |  2 +-
 builtin/rerere.c            |  2 +-
 builtin/unpack-file.c       |  2 +-
 config.c                    | 38 +++++++++++++++++++-------------------
 diff.c                      |  2 +-
 entry.c                     |  5 +++--
 fast-import.c               |  2 +-
 http-backend.c              |  4 ++--
 ll-merge.c                  |  2 +-
 notes-merge.c               |  2 +-
 pkt-line.c                  | 29 ++++++++++++++---------------
 read-cache.c                |  6 +++---
 refs.c                      |  2 +-
 refs/files-backend.c        | 10 +++++-----
 rerere.c                    |  2 +-
 shallow.c                   |  6 +++---
 streaming.c                 |  2 +-
 t/helper/test-delta.c       |  2 +-
 transport-helper.c          |  5 ++---
 wrapper.c                   |  2 +-
 21 files changed, 64 insertions(+), 66 deletions(-)

-Peff

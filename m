Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877BB1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753468AbdC1TnA (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:43:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:53145 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752582AbdC1Tm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:42:59 -0400
Received: (qmail 11527 invoked by uid 109); 28 Mar 2017 19:42:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:42:58 +0000
Received: (qmail 18509 invoked by uid 111); 28 Mar 2017 19:43:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:43:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:42:56 -0400
Date:   Tue, 28 Mar 2017 15:42:56 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/18] snprintf cleanups
Message-ID: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our code base calls snprintf() into a fixed-size buffer in a bunch of
places. Sometimes we check the result, and sometimes we accept a silent
truncation. In some cases an overflow is easy given long input. In some
cases it's impossible. And in some cases it depends on how big PATH_MAX
is on your filesystem, and whether it's actually enforced. :)

This series attempts to give more predictable and consistent results by
removing arbitrary buffer limitations. It also tries to make further
audits of snprintf() easier by converting to xsnprintf() where
appropriate.

There are still some snprintf() calls left after this. A few are in code
that's in flux, or is being cleaned up in nearby series (several of my
recent cleanup series were split off from this). A few should probably
remain (e.g., git-daemon will refuse to consider a repo name larger than
PATH_MAX, which may be a reasonable defense against weird memory tricks.
I wouldn't be sad to see this turned into a strbuf with an explicit
length policy enforced separately, though). And there were a few that I
just didn't get around to converting (the dumb-http walker, for example,
but I think it may need a pretty involved audit overall).

It's a lot of patches, but hopefully they're all pretty straightforward
to read.

  [01/18]: do not check odb_mkstemp return value for errors
  [02/18]: odb_mkstemp: write filename into strbuf
  [03/18]: odb_mkstemp: use git_path_buf
  [04/18]: diff: avoid fixed-size buffer for patch-ids
  [05/18]: tag: use strbuf to format tag header
  [06/18]: fetch: use heap buffer to format reflog
  [07/18]: avoid using fixed PATH_MAX buffers for refs
  [08/18]: avoid using mksnpath for refs
  [09/18]: create_branch: move msg setup closer to point of use
  [10/18]: create_branch: use xstrfmt for reflog message
  [11/18]: name-rev: replace static buffer with strbuf
  [12/18]: receive-pack: print --pack-header directly into argv array
  [13/18]: replace unchecked snprintf calls with heap buffers
  [14/18]: combine-diff: replace malloc/snprintf with xstrfmt
  [15/18]: convert unchecked snprintf into xsnprintf
  [16/18]: transport-helper: replace checked snprintf with xsnprintf
  [17/18]: gc: replace local buffer with git_path
  [18/18]: daemon: use an argv_array to exec children

 bisect.c               |  8 +++++---
 branch.c               | 16 ++++++++--------
 builtin/checkout.c     |  5 ++---
 builtin/fetch.c        |  6 ++++--
 builtin/gc.c           |  8 +-------
 builtin/index-pack.c   | 22 ++++++++++++----------
 builtin/ls-remote.c    | 10 ++++++----
 builtin/name-rev.c     | 21 ++++++++++++---------
 builtin/notes.c        |  9 ++++-----
 builtin/receive-pack.c | 17 ++++++++++-------
 builtin/replace.c      | 50 +++++++++++++++++++++++++++-----------------------
 builtin/rev-parse.c    |  5 +++--
 builtin/tag.c          | 42 ++++++++++++++++++------------------------
 cache.h                |  7 +++++--
 combine-diff.c         |  7 ++++---
 daemon.c               | 38 +++++++++++++++++---------------------
 diff.c                 | 20 +++++++++++++-------
 environment.c          | 14 ++++++--------
 fast-import.c          |  9 +++++----
 grep.c                 |  4 ++--
 http.c                 | 10 +++++-----
 imap-send.c            |  2 +-
 pack-bitmap-write.c    | 14 +++++++-------
 pack-write.c           | 16 ++++++++--------
 refs.c                 | 44 ++++++++++++++++++++++++++------------------
 sha1_file.c            |  4 ++--
 submodule.c            |  2 +-
 transport-helper.c     |  5 +----
 28 files changed, 215 insertions(+), 200 deletions(-)

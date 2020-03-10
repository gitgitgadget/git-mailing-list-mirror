Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CAEC10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F4220727
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="PK5Jfw15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCJSWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:22:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51040 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726414AbgCJSWK (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Mar 2020 14:22:10 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1240360732;
        Tue, 10 Mar 2020 18:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1583864529;
        bh=8Ar2OOqjky3omGHWzEP6bJe3MjRVXB+KU/xwcCPXTek=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=PK5Jfw15PF6FLYJKt0YBjyLRvKYBMnW5LdXgAlDz1wMlkUJREuiThX9tJbefv+L50
         RbJmw/TnK4rAek+v9X/TdwaFB/t44drTJBh2Xg51JXRbL/1jWRDecIVgm8Qp1JlVbZ
         j6odoQN+c+2ld/JAP1HQAKJ/cJ9ToylGa5duqqkmL88yo+l1QOALpbkQMg6HSk6dDt
         QBlVIiJ9SafOSyfVB+ZcLtxXpaZJCai12SysE1vnZILLtDOE+Dc312Eh4XuwJs9Bl1
         SkW1xFek+AS13utw0B67fWKJaIGUrvtqBhNxJwc7v8mHGkb6eeIYMxWiaYVdrO8Mj7
         2tlhEth5tIoTs3HaSPHUj8sKDeVq7ey8b92NfUME99fcYdduLOALJgF+WEnDmko57f
         +qz0xdfBLRnYTdImHfHClYUH8EtQkCXhp/aUF3l+NnrvyXIpDLG2A5ltQZezVtV59I
         BKCXLVKkhu1T6OOITr8rT8tpVEHJaaO07KmGv6grRS/JFBGcPOP
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/8] Additional metadata for filter processes
Date:   Tue, 10 Mar 2020 18:20:38 +0000
Message-Id: <20200310182046.748959-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Smudge and clean filters are currently provided with one particular
piece of data: the pathname of the file being smudged.  While this is
helpful, there are a variety of situations where people would like to
have more data.

One such situation is for users who would like to have a custom
ident-style filter that contains the branch name.  In many cases, it's
sufficient to look up this information based on HEAD, but during
checkout, HEAD does not point to the right place, since it's updated
after the files are written.

Other information users frequently want to know is the commit's object
ID and the object ID of the blob being filtered.  For example, if
filtering is expensive and the filter process sees duplicate blobs
during checkout, it may cache the results and avoid having to compute
the filter twice.

This series provides an additional set of metadata to the filter
process with the keys "ref", "treeish", and "blob".  We prefer to
provide a commit as the treeish whenever possible, but in some cases,
such as when git archive is invoked with a tree, there is no commit, and
we use the tree instead.

Note that we don't provide this metadata in all cases.  Sometimes it is
trivial for the filter to do a simple "git rev-parse HEAD", and in such
cases, metadata other than the blob may not be provided.  We also don't
handle the case where the user is using a smudge or clean command
instead of a filter process command: if the user wants the additional
metadata, it should be possible for them to write a small filter
process, which is reasonably trivial in most languages.  Our
documentation already permits us to add additional metadata and
guarantees only that the pathname will be provided.

My particular use case for this is prefetching and precomputing data
during archive generation, since we don't permit delayed filters there
due to archives needing to be in a predictable order.  I have tried to
make it as generally applicable as possible, since I can imagine (and
have indeed seen requests for) many other useful applications of this
elsewhere.

Feedback is of course welcome.

brian m. carlson (8):
  builtin/checkout: pass branch info down to checkout_worktree
  convert: permit passing additional metadata to filter processes
  convert: provide additional metadata to filters
  builtin/checkout: compute checkout metadata for checkouts
  builtin/clone: compute checkout metadata for clones
  builtin/rebase: compute checkout metadata for rebases
  builtin/reset: compute checkout metadata for reset
  t0021: test filter metadata for additional cases

 apply.c                 |   2 +-
 archive.c               |  13 ++-
 archive.h               |   1 +
 builtin/cat-file.c      |   5 +-
 builtin/checkout.c      |  54 +++++++----
 builtin/clone.c         |   6 +-
 builtin/rebase.c        |   1 +
 builtin/reset.c         |  16 +++-
 cache.h                 |   1 +
 convert.c               |  66 ++++++++++++--
 convert.h               |  29 +++++-
 diff.c                  |   5 +-
 entry.c                 |   7 +-
 merge-recursive.c       |   2 +-
 merge.c                 |   1 +
 sequencer.c             |   1 +
 t/t0021-conversion.sh   | 198 ++++++++++++++++++++++++++++++++++------
 t/t0021/rot13-filter.pl |   6 ++
 unpack-trees.c          |   1 +
 unpack-trees.h          |   1 +
 20 files changed, 341 insertions(+), 75 deletions(-)


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936EFCD6136
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 20:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378200AbjJIUzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 16:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378131AbjJIUzs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 16:55:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2A69E
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 13:55:45 -0700 (PDT)
Received: (qmail 24280 invoked by uid 109); 9 Oct 2023 20:55:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 20:55:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18488 invoked by uid 111); 9 Oct 2023 20:55:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 16:55:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 16:55:44 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/20] bounds-checks for chunk-based files
Message-ID: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of my -Wunused-parameter series, I noticed that a few callbacks
used with the chunk-format API ignored the "chunk_size" parameter. I had
initially just annotated these with UNUSED under the usual "well, not
all callbacks need all parameters" logic.

But if you think about it, a chunk callback that does not look at the
chunk size _must_ be buggy, as there is no way it could ensure that it
does not read past the end of the chunk. In a well-formed file this
isn't a problem, since most chunks have expected sizes (e.g., a
commit-graph has a fixed-size commit-data record for every commit
mentioned in its index chunk). But it is very easy to get out-of-bounds
reads for files that are not well-formed.

I think the security implications here are pretty minor. The only files
which use the chunk format are multi-pack-index and commit-graph,
neither of which we'd expect to receive over the network (so you'd need
to access an untrusted tarball, etc, to even see a malicious file). And
we'd never try to write to this memory (they're read-only mmaps of the
files). So your worst case is probably an unexpected out-of-bounds read
and segfault, on a file that is hard to put in front of the victim.

But I think it's still worth fixing. The extra checks aren't very
expensive, and let us handle bugs or corruption more gracefully, as
well.

It's a lot of patches because there are a lot of chunk types. ;) But
each one is hopefully pretty straightforward in isolation. I tried to
group similar chunks together (e.g., commit-graph and midx both have
OIDF and OIDL chunks), but otherwise just fixed the midx chunks in the
order they appear in the code, followed by the same for commit-graph.

  [01/20]: chunk-format: note that pair_chunk() is unsafe
  [02/20]: t: add library for munging chunk-format files
  [03/20]: midx: stop ignoring malformed oid fanout chunk
  [04/20]: commit-graph: check size of oid fanout chunk
  [05/20]: midx: check size of oid lookup chunk
  [06/20]: commit-graph: check consistency of fanout table
  [07/20]: midx: check size of pack names chunk
  [08/20]: midx: enforce chunk alignment on reading
  [09/20]: midx: check size of object offset chunk
  [10/20]: midx: bounds-check large offset chunk
  [11/20]: midx: check size of revindex chunk
  [12/20]: commit-graph: check size of commit data chunk
  [13/20]: commit-graph: detect out-of-bounds extra-edges pointers
  [14/20]: commit-graph: bounds-check base graphs chunk
  [15/20]: commit-graph: check size of generations chunk
  [16/20]: commit-graph: bounds-check generation overflow chunk
  [17/20]: commit-graph: check bounds when accessing BDAT chunk
  [18/20]: commit-graph: check bounds when accessing BIDX chunk
  [19/20]: commit-graph: detect out-of-order BIDX offsets
  [20/20]: chunk-format: drop pair_chunk_unsafe()

 bloom.c                            |  34 +++++++++
 chunk-format.c                     |  24 ++++--
 chunk-format.h                     |   9 ++-
 commit-graph.c                     | 119 ++++++++++++++++++++++++-----
 commit-graph.h                     |   4 +
 midx.c                             |  68 +++++++++++++----
 midx.h                             |   3 +
 pack-revindex.c                    |  13 +++-
 t/lib-chunk.sh                     |  17 +++++
 t/lib-chunk/corrupt-chunk-file.pl  |  66 ++++++++++++++++
 t/t4216-log-bloom.sh               |  50 ++++++++++++
 t/t5318-commit-graph.sh            |  76 +++++++++++++++++-
 t/t5319-multi-pack-index.sh        | 102 ++++++++++++++++++++++++-
 t/t5324-split-commit-graph.sh      |  20 ++++-
 t/t5328-commit-graph-64bit-time.sh |  10 +++
 15 files changed, 568 insertions(+), 47 deletions(-)
 create mode 100644 t/lib-chunk.sh
 create mode 100644 t/lib-chunk/corrupt-chunk-file.pl

-Peff

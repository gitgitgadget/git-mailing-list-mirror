Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9A352095B
	for <e@80x24.org>; Sat, 18 Mar 2017 21:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbdCRVbN (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 17:31:13 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46200 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751213AbdCRVbI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Mar 2017 17:31:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1DB11280AD;
        Sat, 18 Mar 2017 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489872000;
        bh=1a25Efk1iArgSqhRWSJznz7bmhZ20bqvmBYjRz+WsF4=;
        h=From:To:Cc:Subject:Date:From;
        b=dLTUCS8jXSJnN6VKK+JZ0I2T7jSVHbakFuHLu5IWzOKxItGCK1XETYzLC+zAIVCMY
         BBUY39/l+8cpgfFWmdvws8cFtHsIvS7cDGrh00SFjCA59plRLfso3Jt+DWZYpMO1A9
         fPpNHUy0Q3WvoG5S1cuUdWHTMONYoeGAHNzv39CBttoCCrEtpq2FNxcsRC/3D/cv2Z
         wIfDp0w1G5ANaq62kUvhXH5bTlekG2p52BdPVi6IlQakWJxzOdn0hf4q/mdfoBgRga
         yKcfLnhxP5aTApw7+KJIIkolFXEW6xR3rH9evsAqnd6AR/Emx9HdYMm/lJj8t39b0g
         jWzHG+U+iyccsp5ApRJYabSQ2zHSTEaBzRKikYOwEGAq08UP5xPsx87Icnr5BrZoGs
         ri0XcEmXYCr9C/UuRbeC3HxipgP5kKhMLrdQ74zUHal5DNj9iMF4i9xPwU5xYs6sHS
         TLdwB87xhuNrhAf//skljo0xtjQMECE5rvbBKaUVegw3nQ9Jcav
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/20] object_id part 7
Date:   Sat, 18 Mar 2017 21:19:34 +0000
Message-Id: <20170318211954.564030-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is part 7 in the continuing transition to use struct object_id.

This series focuses on two main areas: adding two constants for the
maximum hash size we'll be using (which will be suitable for allocating
memory) and converting struct sha1_array to struct oid_array.

The rationale for adding separate constants for allocating memory is
that with a new 256-bit hash function, we're going to need two different
items: a constant for allocating memory that's as large as the largest
hash, and a global variable telling us size the current hash is.  I've
opted to provide GIT_MAX_RAWSZ and GIT_MAX_HEXSZ for allocating memory,
and leave GIT_SHA1_RAWSZ and GIT_SHA1_HEXSZ as values that can be later
replaced by the aforementioned global.

Replacing struct sha1_array with struct oid_array necessarily involves
converting the shallow code, so I did that.  The structure now handles
objects of struct object_id.  While I renamed the documentation (since
people will search for that), I chose not to rename the sha1-array.[ch]
files or the test helper because I didn't think it was worth the hassle,
especially for people who don't have rename support turned on by
default.  Of course, if the consensus is that they should be, I'll do so
in v2.

I chose to use Coccinelle quite a bit in this series, as it automates a
lot of the manual work and aides in review.  There is also some use of
Perl one-liners.

This series is available at https://github.com/bk2204/git under
object-id-part7; it may be rebased.  Future series are available in
various states as the object-id-part8, object-id-part9, and
object-id-part10 series.

brian m. carlson (20):
  Define new hash-size constants for allocating memory
  Convert GIT_SHA1_HEXSZ used for allocation to GIT_MAX_HEXSZ
  Convert GIT_SHA1_RAWSZ used for allocation to GIT_MAX_RAWSZ
  builtin/diff: convert to struct object_id
  builtin/pull: convert portions to struct object_id
  builtin/receive-pack: convert portions to struct object_id
  fsck: convert init_skiplist to struct object_id
  parse-options-cb: convert sha1_array_append caller to struct object_id
  test-sha1-array: convert most code to struct object_id
  sha1_name: convert struct disambiguate_state to object_id
  sha1_name: convert disambiguate_hint_fn to take object_id
  submodule: convert check_for_new_submodule_commits to object_id
  builtin/pull: convert to struct object_id
  sha1-array: convert internal storage for struct sha1_array to
    object_id
  Make sha1_array_append take a struct object_id *
  Convert remaining callers of sha1_array_lookup to object_id
  Convert sha1_array_lookup to take struct object_id
  Convert sha1_array_for_each_unique and for_each_abbrev to object_id
  Rename sha1_array to oid_array
  Documentation: update and rename api-sha1-array.txt

 .../{api-sha1-array.txt => api-oid-array.txt}      |  44 +++----
 bisect.c                                           |  43 ++++---
 builtin/blame.c                                    |   4 +-
 builtin/cat-file.c                                 |  14 +--
 builtin/diff.c                                     |  40 +++----
 builtin/fetch-pack.c                               |   2 +-
 builtin/fetch.c                                    |   6 +-
 builtin/merge-index.c                              |   2 +-
 builtin/merge.c                                    |   2 +-
 builtin/pack-objects.c                             |  24 ++--
 builtin/patch-id.c                                 |   2 +-
 builtin/pull.c                                     |  98 +++++++--------
 builtin/receive-pack.c                             | 133 +++++++++++----------
 builtin/rev-list.c                                 |   2 +-
 builtin/rev-parse.c                                |   4 +-
 builtin/send-pack.c                                |   4 +-
 cache.h                                            |  10 +-
 combine-diff.c                                     |  18 +--
 commit.h                                           |  14 +--
 connect.c                                          |   8 +-
 diff.c                                             |   4 +-
 diff.h                                             |   4 +-
 fetch-pack.c                                       |  32 ++---
 fetch-pack.h                                       |   4 +-
 fsck.c                                             |  17 +--
 fsck.h                                             |   2 +-
 hex.c                                              |   2 +-
 parse-options-cb.c                                 |   8 +-
 patch-ids.c                                        |   2 +-
 patch-ids.h                                        |   2 +-
 ref-filter.c                                       |  22 ++--
 ref-filter.h                                       |   2 +-
 remote-curl.c                                      |   4 +-
 remote.h                                           |   6 +-
 send-pack.c                                        |   6 +-
 send-pack.h                                        |   2 +-
 sha1-array.c                                       |  38 +++---
 sha1-array.h                                       |  20 ++--
 sha1_file.c                                        |   6 +-
 sha1_name.c                                        |  94 ++++++++-------
 shallow.c                                          |  38 +++---
 submodule.c                                        |  66 +++++-----
 submodule.h                                        |   8 +-
 t/helper/test-sha1-array.c                         |  20 ++--
 transport.c                                        |  24 ++--
 wt-status.h                                        |   2 +-
 46 files changed, 459 insertions(+), 450 deletions(-)
 rename Documentation/technical/{api-sha1-array.txt => api-oid-array.txt} (61%)


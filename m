Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21BBC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 20:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjARUgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 15:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjARUfs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 15:35:48 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB885EFB2
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 12:35:07 -0800 (PST)
Received: (qmail 3309 invoked by uid 109); 18 Jan 2023 20:35:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Jan 2023 20:35:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24913 invoked by uid 111); 18 Jan 2023 20:35:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Jan 2023 15:35:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Jan 2023 15:35:06 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [RFC/PATCH 0/6] hash-object: use fsck to check objects
Message-ID: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Right now "git hash-object" will do some basic sanity checks of the
input using the usual parser code. This series teaches it to use the
fsck code instead, which should catch more things. See patch 6 for some
discussion of the implications.

The reason this is marked as an RFC is that at the end, compiling with
SANITIZE=address will provoke a failure in t3800. The issue is that
fsck_tag_standalone(), when fed a buffer/size combo, will look for a NUL
at the end of the headers, which might be buffer[size]. This is usually
OK for objects we've loaded from the odb, because we intentionally stick
an extra NUL at the end for safety. But here index_mem() may get an
arbitrary buffer.

I'm not sure yet of the right path forward. It's not too hard to add an
extra NUL in most cases, but one code path will mmap a file on disk. And
sticking a NUL there is hard (we already went down that road trying to
avoid REG_STARTEND for grep, and there wasn't a good solution).

The other option is having the fsck code avoid looking past the size it
was given. I think the intent is that this should work, from commits
like 4d0d89755e (Make sure fsck_commit_buffer() does not run out of the
buffer, 2014-09-11). We do use skip_prefix() and parse_oid_hex(), which
won't respect the size, but I think[1] that's OK because we'll have
parsed up to the end-of-header beforehand (and those functions would
never match past there).

Which would mean that 9a1a3a4d4c (mktag: allow omitting the header/body
\n separator, 2021-01-05) and acf9de4c94 (mktag: use fsck instead of
custom verify_tag(), 2021-01-05) were buggy, and we can just fix them.

[1] But I said "I think" above because it can get pretty subtle. There's
    some more discussion in this thread:

      https://lore.kernel.org/git/20150625155128.C3E9738005C@gemini.denx.de/

    but I haven't yet convinced myself it's safe. This is exactly the
    kind of analysis I wish I had the power to nerd-snipe René into.

Anyway, here are the patches in the meantime. I do think this is a good
direction overall, modulo addressing the NUL-terminator question.

  [1/6]: t1007: modernize malformed object tests
  [2/6]: t1006: stop using 0-padded timestamps
  [3/6]: t7030: stop using invalid tag name
  [4/6]: t: use hash-object --literally when created malformed objects
  [5/6]: fsck: provide a function to fsck buffer without object struct
  [6/6]: hash-object: use fsck for object checks

 fsck.c                           | 29 ++++++++++-------
 fsck.h                           |  8 +++++
 object-file.c                    | 55 +++++++++++++-------------------
 t/t1006-cat-file.sh              |  6 ++--
 t/t1007-hash-object.sh           | 29 +++++++++++------
 t/t1450-fsck.sh                  | 28 ++++++++--------
 t/t4054-diff-bogus-tree.sh       |  2 +-
 t/t4058-diff-duplicates.sh       |  2 +-
 t/t4212-log-corrupt.sh           |  4 +--
 t/t5302-pack-index.sh            |  2 +-
 t/t5504-fetch-receive-strict.sh  |  2 +-
 t/t5702-protocol-v2.sh           |  2 +-
 t/t6300-for-each-ref.sh          |  2 +-
 t/t7030-verify-tag.sh            |  2 +-
 t/t7031-verify-tag-signed-ssh.sh |  2 +-
 t/t7509-commit-authorship.sh     |  2 +-
 t/t7510-signed-commit.sh         |  2 +-
 t/t7528-signed-commit-ssh.sh     |  2 +-
 t/t8003-blame-corner-cases.sh    |  2 +-
 t/t9350-fast-export.sh           |  2 +-
 20 files changed, 101 insertions(+), 84 deletions(-)

-Peff

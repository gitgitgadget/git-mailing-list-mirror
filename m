Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC4F1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfBLBXP (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:15 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34228 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbfBLBXP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:15 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 294776042D;
        Tue, 12 Feb 2019 01:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934593;
        bh=0FQEBefpYxIKYB/wSSYPKG1hbTLydfZ2DvLiz8zyH6A=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=SQLmAbphYpRH3dReyrcDnu+TOaT06pgWEYjWciauUmgxhM25EXxURIyGuq+NVxsTh
         X8TAtGVPlzNuuCB13YF5Qmz4gmFik6Fe/83csGm6Ge4NJAtR5v69GBv8lcr5lOn0A1
         fnzDzjwZtl0rgXPF2V5mOw3kMRlfiH5koAnkFP+hWgp3ZB7qeSEnN16snb3UMUVV0W
         zrWpYVL0LLYdpzUjVMTedU65v5eAWEA4nfwxNIBJmLyvpXv4FoOxU3b+a+ioPqqj8q
         qAJx+eDXrm7e7r+UYDWMs1rJirSPSTL4DlBRTaV4aiCtApHYvRCAkKs8bq80sC59Pt
         KWYew1oG1lRLesSPdFUdXqgkhZ8GzREbCrACXoPDZp3ycvxh1FtXyih6SJbyh9N12e
         LyweqN+vGLQLKgYZJU+fTrhErWY5aZ4Be+2o/jda33adyj/Q+fsDRCBxUGY4FRX7sL
         PAh7Jem8t7SHCkXEyyfQHGRdzUEWtJY5OpN43ooRxvWC6Q93FGd
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 00/31] Hash function transition part 16
Date:   Tue, 12 Feb 2019 01:22:25 +0000
Message-Id: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the sixteenth series of hash function transition patches. This
series contains various fixes, mostly focused around the pack bitmap
code, the HTTP code, the archive code, the index, and parts of our Perl
code.

This is the second to last series required for a "stage 0" Git; that is,
one that can operate only with SHA-256, but not SHA-1. Observers will
notice a focus on getting rid of sha1_to_hex and null_sha1 as well as
the normal types of transforms; the next series will remove both of
these.

This series modifies the index code such that it can work with a hash
algorithm of any length. In order to do so, the structs involved were
changed to use flex array members and not store the hash in a fixed
array member. This design was chosen over a multiple struct approach
because it ensures that we have one consistent, well-tested code path
that works for both algorithms, as well as any algorithms in the future.
Comments on the approach or arguments for other designs are welcome.

This is a rather long series, but most of it is concentrated in a few
small areas, so hopefully it's a little easier to review because of
that.

To preview the series that come after this, there is an additional
series for stage 0 Git (object-id-part17 plus part of sha256-fixes),
plus potentially several series of test fixes (test-fixes-part4 and part
of sha256-fixes). Following that, I plan to introduce, under the
DEVELOPER Makefile flag, the actual code which supports
extensions.objectFormat and makes it so that it works
(transition-stage-4).

brian m. carlson (31):
  t/lib-submodule-update: use appropriate length constant
  pack-bitmap: make bitmap header handling hash agnostic
  pack-bitmap: convert struct stored_bitmap to object_id
  pack-bitmap: replace sha1_to_hex
  pack-bitmap: switch hard-coded constants to the_hash_algo
  submodule: avoid hard-coded constants
  notes-merge: switch to use the_hash_algo
  notes: make hash size independent
  notes: replace sha1_to_hex
  object-store: rename and expand packed_git's sha1 member
  builtin/name-rev: make hash-size independent
  fast-import: make hash-size independent
  fast-import: replace sha1_to_hex
  builtin/am: make hash size independent
  builtin/pull: make hash-size independent
  http-push: convert to use the_hash_algo
  http-backend: allow 64-character hex names
  http-push: remove remaining uses of sha1_to_hex
  http-walker: replace sha1_to_hex
  http: replace hard-coded constant with the_hash_algo
  http: compute hash of downloaded objects using the_hash_algo
  http: replace sha1_to_hex
  remote-curl: make hash size independent
  archive-tar: make hash size independent
  archive: convert struct archiver_args to object_id
  refspec: make hash size independent
  builtin/difftool: use parse_oid_hex
  dir: make untracked cache extension hash size independent
  read-cache: read data in a hash-independent way
  Git.pm: make hash size independent
  gitweb: make hash size independent

 archive-tar.c               |  7 ++--
 archive-zip.c               | 10 ++---
 archive.c                   |  8 ++--
 archive.h                   |  2 +-
 builtin/am.c                |  9 +++--
 builtin/difftool.c          |  6 +--
 builtin/get-tar-commit-id.c | 11 +++++-
 builtin/name-rev.c          | 14 ++++---
 builtin/pack-redundant.c    |  2 +-
 builtin/pull.c              |  5 ++-
 dir.c                       | 28 +++++++-------
 fast-import.c               | 48 +++++++++++++-----------
 gitweb/gitweb.perl          | 63 ++++++++++++++++---------------
 http-backend.c              |  3 ++
 http-push.c                 | 29 ++++++++-------
 http-walker.c               | 18 ++++-----
 http.c                      | 33 +++++++++--------
 http.h                      |  2 +-
 merge-recursive.c           |  2 +-
 notes-merge.c               |  6 +--
 notes.c                     | 44 +++++++++++-----------
 object-store.h              |  2 +-
 pack-bitmap-write.c         |  8 ++--
 pack-bitmap.c               | 20 +++++-----
 pack-bitmap.h               |  2 +-
 packfile.c                  |  6 +--
 perl/Git.pm                 |  2 +-
 read-cache.c                | 74 +++++++++++++++----------------------
 refspec.c                   |  2 +-
 remote-curl.c               | 11 +++---
 submodule.c                 |  2 +-
 t/lib-submodule-update.sh   |  3 +-
 32 files changed, 246 insertions(+), 236 deletions(-)


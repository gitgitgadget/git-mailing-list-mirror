Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841F4C35666
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F440206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="efxVcr5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgBVUSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:02 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39068 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726730AbgBVUSB (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:01 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3EBD96079A
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402680;
        bh=KXNDhGUOoIvWs7Sle5NhIT3i6s/RzT9zSLtHwAtUplQ=;
        h=From:To:Subject:Date:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=efxVcr5SrZd3BnyOShEeI5UAzDxxCSUHZdfGQaOBaGFnf/8SOzk6HzDtNKbKP3SlS
         hD+sa3CvbFQMqyepp/55O5J9RU+Z0wcDmT2ai+WAnum2y7A8ydv2YVhoHiIQElsn3G
         eXF8vsFhP3Kme3Vl3w4Neawjt2mbtauBoTu5aNIgfce6XHO7s/+q2gOvPq6taqwz/6
         7O34cbjTqtY6KCtsBRRvbdQEdvntLiuzJXjsSwecAHNV1S3bzkRoeus49CB6xME+Ed
         hrieKKlpRHL+qJfQ8fwvFxQDUT32oC6AJBw3DiEwvquFWBzIq/M6GNVMsehtzzZbCw
         tkGq6DTBA/aAzMEkCl6atqkT05eJn+dL2I6/HLf4Y6wriCvEcSDd1/6fc6JST0yj3d
         2tC4NdgwwOLAMOI2Omp1IZRRotXILHgAB4YSfvxsfqN09gN3xJ4X5qYPENv46EJyJZ
         dkbSTejXGiQdHnfM54gVTL9rGuqZfajBdFxyAHYF6lMYnWpUYfk
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 00/24] SHA-256 stage 4 implementation, part 1/3
Date:   Sat, 22 Feb 2020 20:17:25 +0000
Message-Id: <20200222201749.937983-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a series for part 1 of 3 of a stage 4 SHA-256 implementation.
It is mostly the same as v1[0], which was RFC.  The interested reader is
referred there for the in-depth explanations.

A few interesting changes have taken place since v1.  First, I
discovered a regression in a recent series which introduced a hard-coded
constant, so patch 1 addresses this.

Second, I discovered a mistaken assumption that we were making about our
hash implementations: that copying the struct was sufficient to copy the
context.  This is not true for libgcrypt, where our context is a pointer
instead, so patch 2 addresses this with a helper function.

Finally, I've added a check to prevent non-developers from creating
SHA-256 repositories, since this series is not sufficient to implement
full SHA-256 support.  Even as a developer, creating a SHA-256
repository immediately leads to a broken state, since we don't recognize
the extension (yet) and therefore promptly refuse to operate on it in
any way.  Preventing this experience seemed prudent.

There are a few other minor changes indicated in the range-diff below.

If folks have opinions about things like option names (or really,
anything else), I'd love to hear them.

There are two more parts for this implementation and one more set of
test fixes.  They will be coming in due course.

[0] https://lore.kernel.org/git/20200113124729.3684846-1-sandals@crustytoothpaste.net/

brian m. carlson (24):
  builtin/pack-objects: make hash agnostic
  hash: implement and use a context cloning function
  hex: introduce parsing variants taking hash algorithms
  hex: add functions to parse hex object IDs in any algorithm
  repository: require a build flag to use SHA-256
  t: use hash-specific lookup tables to define test constants
  t6300: abstract away SHA-1-specific constants
  t6300: make hash algorithm independent
  t/helper/test-dump-split-index: initialize git repository
  t/helper: initialize repository if necessary
  t/helper: make repository tests hash independent
  setup: allow check_repository_format to read repository format
  builtin/init-db: allow specifying hash algorithm on command line
  builtin/init-db: add environment variable for new repo hash
  init-db: move writing repo version into a function
  worktree: allow repository version 1
  commit: use expected signature header for SHA-256
  gpg-interface: improve interface for parsing tags
  tag: store SHA-256 signatures in a header
  fast-import: permit reading multiple marks files
  fast-import: add helper function for inserting mark object entries
  fast-import: make find_marks work on any mark set
  fast-import: add a generic function to iterate over marks
  fast-import: add options for rewriting submodules

 Documentation/git-fast-import.txt |  20 +++
 Documentation/git-init.txt        |   7 +-
 Documentation/git.txt             |   6 +
 builtin/clone.c                   |   2 +-
 builtin/commit.c                  |   2 +-
 builtin/fmt-merge-msg.c           |  26 +++-
 builtin/init-db.c                 |  75 +++++++--
 builtin/mktag.c                   |  14 ++
 builtin/pack-objects.c            |   2 +-
 builtin/receive-pack.c            |   4 +-
 builtin/tag.c                     |  20 ++-
 cache.h                           |  25 ++-
 commit.c                          |  58 +++++--
 commit.h                          |   8 +
 config.mak.dev                    |   2 +
 csum-file.c                       |   2 +-
 fast-import.c                     | 246 ++++++++++++++++++++++--------
 gpg-interface.c                   |  17 ++-
 gpg-interface.h                   |   9 +-
 hash.h                            |  21 +++
 hex.c                             |  57 ++++++-
 log-tree.c                        |  14 +-
 path.c                            |   2 +-
 ref-filter.c                      |  23 ++-
 repository.c                      |   4 +
 sequencer.c                       |   2 +-
 setup.c                           |   6 +-
 sha1-file.c                       |  18 +++
 sha256/gcrypt.h                   |   6 +
 t/helper/test-dump-split-index.c  |   2 +
 t/helper/test-repository.c        |  14 +-
 t/t1450-fsck.sh                   |  24 +++
 t/t5801-remote-helpers.sh         |   4 +-
 t/t6300-for-each-ref.sh           |  61 +++++---
 t/t7004-tag.sh                    |   8 +-
 t/t7030-verify-tag.sh             |  17 +++
 t/t7510-signed-commit.sh          |  16 +-
 t/t9300-fast-import.sh            | 109 +++++++++++++
 t/test-lib.sh                     |  29 ++--
 tag.c                             |  15 +-
 worktree.c                        |  10 +-
 41 files changed, 810 insertions(+), 197 deletions(-)

Range-diff against v1:
 -:  ---------- >  1:  0037d0f950 builtin/pack-objects: make hash agnostic
 -:  ---------- >  2:  e6f632eb38 hash: implement and use a context cloning function
 1:  17e86d7e8a =  3:  205c67144b hex: introduce parsing variants taking hash algorithms
 2:  8a4e05f03f =  4:  09e3f4ca8e hex: add functions to parse hex object IDs in any algorithm
 3:  4efa071dd6 =  5:  3df541b2f0 repository: require a build flag to use SHA-256
 4:  0c26727e8c =  6:  1161b70d24 t: use hash-specific lookup tables to define test constants
 5:  3aff50578d =  7:  fd3a85f59f t6300: abstract away SHA-1-specific constants
 6:  2736da7f60 =  8:  fb93b0900b t6300: make hash algorithm independent
 7:  343cd6c9b2 =  9:  1d873fc05a t/helper/test-dump-split-index: initialize git repository
 8:  1c8e31fd41 = 10:  8e918b28d5 t/helper: initialize repository if necessary
 9:  9dade56ee5 = 11:  7ae0d820eb t/helper: make repository tests hash independent
10:  b08bec90e7 = 12:  f13b1465cf setup: allow check_repository_format to read repository format
11:  acfdc2b0c8 ! 13:  273a2c06ce builtin/init-db: allow specifying hash algorithm on command line
    @@ Commit message
         algorithm.  Ensure that if we are writing a non-SHA-1 repository that we
         set the repository version to 1 and write the objectFormat extension.
     
    +    Restrict this option to work only when ENABLE_SHA256 is set until the
    +    codebase is in a situation to fully support this.
    +
         Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
     
      ## Documentation/git-init.txt ##
    @@ builtin/init-db.c: static int create_default_files(const char *template_path,
      			exit(1);
      	}
      
    ++#ifndef ENABLE_SHA256
    ++	if (fmt->hash_algo != GIT_HASH_SHA1)
    ++		die(_("The hash algorithm %s is not supported in this build."), hash_algos[fmt->hash_algo].name);
    ++#endif
    ++
     +	if (fmt->hash_algo != GIT_HASH_SHA1)
     +		repo_version = GIT_REPO_VERSION_READ;
     +
12:  adbd01c070 = 14:  6f3c736259 builtin/init-db: add environment variable for new repo hash
13:  21cdc16e15 ! 15:  3966b560b5 init-db: move writing repo version into a function
    @@ builtin/init-db.c: static int needs_work_tree_config(const char *git_dir, const
     +	char repo_version_string[10];
     +	int repo_version = GIT_REPO_VERSION;
     +
    ++#ifndef ENABLE_SHA256
    ++	if (hash_algo != GIT_HASH_SHA1)
    ++		die(_("The hash algorithm %s is not supported in this build."), hash_algos[hash_algo].name);
    ++#endif
    ++
     +	if (hash_algo != GIT_HASH_SHA1)
     +		repo_version = GIT_REPO_VERSION_READ;
     +
    @@ builtin/init-db.c: static int create_default_files(const char *template_path,
      			exit(1);
      	}
      
    +-#ifndef ENABLE_SHA256
    +-	if (fmt->hash_algo != GIT_HASH_SHA1)
    +-		die(_("The hash algorithm %s is not supported in this build."), hash_algos[fmt->hash_algo].name);
    +-#endif
    +-
     -	if (fmt->hash_algo != GIT_HASH_SHA1)
     -		repo_version = GIT_REPO_VERSION_READ;
     -
14:  45423efc1c = 16:  5af56f4f6a worktree: allow repository version 1
15:  7b99132acd ! 17:  fb51a683f1 commit: use expected signature header for SHA-256
    @@ commit.c: int remove_signature(struct strbuf *buf)
     
      ## sequencer.c ##
     @@ sequencer.c: static int try_to_commit(struct repository *r,
    - 	if (parse_head(r, &current_head))
      		return -1;
    + 
      	if (flags & AMEND_MSG) {
     -		const char *exclude_gpgsig[] = { "gpgsig", NULL };
     +		const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
16:  b4eecdbc28 ! 18:  3afac82c18 gpg-interface: improve interface for parsing tags
    @@ log-tree.c: static int show_one_mergetag(struct commit *commit,
     +	struct strbuf payload = STRBUF_INIT;
     +	struct strbuf signature = STRBUF_INIT;
      
    - 	hash_object_file(extra->value, extra->len, type_name(OBJ_TAG), &oid);
    - 	tag = lookup_tag(the_repository, &oid);
    + 	hash_object_file(the_hash_algo, extra->value, extra->len,
    + 			 type_name(OBJ_TAG), &oid);
     @@ log-tree.c: static int show_one_mergetag(struct commit *commit,
      			    "parent #%d, tagged '%s'\n", nth + 1, tag->tag);
      	gpg_message_offset = verify_message.len;
17:  5d9c8753b1 = 19:  5e6d1ccbb2 tag: store SHA-256 signatures in a header
18:  4a279f679d = 20:  fb15c66ba1 fast-import: permit reading multiple marks files
19:  01ef63b04d = 21:  273468b0ac fast-import: add helper function for inserting mark object entries
20:  2469dc1324 = 22:  bba3cf497d fast-import: make find_marks work on any mark set
21:  0ad1e4d3a8 = 23:  714ae09a8c fast-import: add a generic function to iterate over marks
22:  bc53f8aaec = 24:  5c50871f30 fast-import: add options for rewriting submodules

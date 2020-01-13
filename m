Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821E8C33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58218207FF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="eX6WPFiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgAMMsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:48:00 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37768 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbgAMMr7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:47:59 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9343560426
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 12:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919677;
        bh=QJiCwNHcnvpkiGXw/A3N7NnuR0VOjJb+lNbOjtfXFeE=;
        h=From:To:Subject:Date:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=eX6WPFiJZ7bTGty/Ja2I2euLkUreQ8xp7lKhcuZ1IO3ouXovg/4j2VHVpLOYoi+Rl
         H+FbDGtFjYo05EamenJGvIWYHzVktSWbWyzhJK7YCwj35D8zsdY0OhCPD26D3tbeaU
         DeqCI551xVHqM/zQl6S6DFju7dAuU4G7ns1H+XhSX1/vFlWeEQhbj+PzJqPIFrQ6sB
         OLO8FHo53e+Z1rxsim0edB4VBdNR76bTYhUgitF3ep5vZEXDfFe4QGyVjI+iUm5Dp6
         2zn/6U5ALXmBqu3isBm4zN3iVCwLGk1JedgIyQFqQ4U68upDTG6pUoJK/REu6QpHTd
         3g3UM6PabQGNHo4B0mehbIUXaz3C821u8Tq3CiMDP7wH2a9BTEvExZXFsp+CQ/d97w
         IurmRdWA9ctGCC+Zu3XhCFwA+oOTnzMcEqjVB34iVilv4nF9oQuIv4jE4I/luW4M5n
         PQKsL7FTdZjNQR+RR5WqwhwqlMfEMDEjM9Tk6U4+LHDDHAJodhj
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [RFC PATCH 00/22] SHA-256 stage 4 implementation, part 1/3
Date:   Mon, 13 Jan 2020 12:47:07 +0000
Message-Id: <20200113124729.3684846-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an RFC series for part 1 of 3 of a SHA-256 implementation.  It
contains a few interesting pieces, and there are also some pieces it
does not contain.

First, it contains the pieces necessary to set up repositories and write
_but not read_ extensions.objectFormat.  In other words, you can create
a SHA-256 repository, but will be unable to read it.  We also
intentionally fail any use of SHA-256 in a repository except when
DEVELOPER=1 is set to discourage anyone from wiring it up, since at this
point it is nonfunctional.

It additionally contains code to adjust the setup code as necessary,
handle repository version 1 in worktrees, properly handle signatures in
tags and commits, and import and export submodules using SHA-256
(required for converting the Git repository).

The setup code now learns an environment variable to specify a default
hash.  This is useful for us because otherwise the test suite would need
every call to "git init" (which is a lot) to add a command line
argument, which would be untidy and burdensome.  It is not recommended
for everyday use.

Furthermore, this contains direct calls to test_oid_init in the test
suite setup code, since the alternative is duplicating those values.
I've opted not to remove the calls in the tests because we have other
topics in flight that may conflict with doing that, but I plan to send a
follow-up patch which does that at the end.  The _z40 variable is
persisted there for compatibility with master and will be dropped once
my current test series in next hits master.

There are also things it does not contain.  As mentioned, it lacks
support for reading extensions.objectFormat at all.  It lacks support
for cloning, fetching, and pushing, which while considered non-goals in
the transition plan, are required for the test suite to even come close
to passing.  That code, both for the original protocol and v2, would be
in part 2.  That code does not provide interoperability between SHA-1
and SHA-256 repositories, which will be the subject of the next major
chunk I do.  Part 3 contains the portions making the
extensions.objectFormat option functional and permitting us to run tests
against the new version.

This series, of course, lacks the test suite fixes which will be
required for the test suite to pass.  Those will be coming in two
further series, one of which I plan to send out soon.

Because this series sets up (and documents!) a useless option (which is
a large footgun) and because I'd like feedback about this approach, this
series is RFC.  I'd also like to know if you think anything is missing
outside of the items I've mentioned, because part 3 will result in the
test suite depending on SHA-256 support and therefore any structural
changes will be difficult to make at that point.  And of course, any
other feedback about this series is certainly welcome.

There may be other things that are interesting about this series, but
this cover letter is too small to contain them, so I encourage you to
look at the series for yourself.

If you'd like to see what the entire series looks like when complete,
you're welcome to inspect the transition-stage-4 branch at
https://github.com/bk2204/git.git.

brian m. carlson (22):
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
 builtin/init-db.c                 |  70 +++++++--
 builtin/mktag.c                   |  14 ++
 builtin/receive-pack.c            |   4 +-
 builtin/tag.c                     |  20 ++-
 cache.h                           |  25 ++-
 commit.c                          |  58 +++++--
 commit.h                          |   8 +
 config.mak.dev                    |   2 +
 fast-import.c                     | 246 ++++++++++++++++++++++--------
 gpg-interface.c                   |  17 ++-
 gpg-interface.h                   |   9 +-
 hex.c                             |  57 ++++++-
 log-tree.c                        |  14 +-
 path.c                            |   2 +-
 ref-filter.c                      |  23 ++-
 repository.c                      |   4 +
 sequencer.c                       |   2 +-
 setup.c                           |   6 +-
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
 36 files changed, 758 insertions(+), 195 deletions(-)


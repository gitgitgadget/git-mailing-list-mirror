From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 00/16] Tests on Windows - main part
Date: Sat, 21 Mar 2009 22:26:23 +0100
Message-ID: <cover.1237667830.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:28:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8kI-0003u8-Vu
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310AbZCUV1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754967AbZCUV1N
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:27:13 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27930 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752918AbZCUV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:26:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id AAEE42C4002;
	Sat, 21 Mar 2009 22:26:54 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7298F1D235;
	Sat, 21 Mar 2009 22:26:54 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114064>

This is the remaining set of changes after which the test suite
passes with the MinGW port. Well, almost: There still are a few
failures, but none of them indicate a serious bug. We will address
them later.

The series is again available from here:

  git://repo.or.cz/git/mingw/j6t.git for-junio

It builds on js/windows-tests (a8cbc9ab).

The heart of this series is an addition to the test infrastructure:
Tests can be tagged by a keyword, which indicates that a particular
feature ("prerequisite") is needed. This idea was presented by Junio
some time ago, but I didn't save away the implementation.

The new features are used in this way:

1. The prerequisite is tested for and the tag is defined:

    if frob --mode=nicate 2>/dev/null; then
	test_set_prereq FROBNICATE
    else
	say "frobnication not possible, skipping some tests
    fi

2. Tests are tagged by the tag name:

    test_expect_success FROBNICATE 'frobnication' '
	frob --mode=nicate
    '

   Such a test is skipped if the tag was not defined before.

3. The prerequisite can also be tested for explicitly:

    if test_have_prereq FROBNICATE; then
	expect=foo
    else
	expect=bar
    fi

I have considered a different approach to define prerequisites,
namely with a helper function that is similar to test_expect_*:

    test_prereq FROBNICATE 'frobnication' '
	frob --mode=nicate 2>/dev/null
    '

but I find it a bit obfuscating.

Currently most prerequisites are tested for on demand. Symbolic
links are tested for in test-lib.sh because so many test scripts
need it. An option would be to move each test in its own file
that would then be sourced on demand.


Johannes Sixt (16):
  test-lib: Work around incompatible sort and find on Windows
  test-lib: Work around missing sum on Windows
  Tests on Windows: $(pwd) must return Windows-style paths
  t0050: Check whether git init detected symbolic link support
    correctly
  test-lib: Infrastructure to test and check for prerequisites
  t3600: Use test prerequisite tags
  Skip tests that fail if the executable bit is not handled by the
    filesystem
  t5302: Use prerequisite tags to skip 64-bit offset tests
  t9100, t9129: Use prerequisite tags for UTF-8 tests
  Use prerequisite tags to skip tests that depend on symbolic links
  t0060: Fix tests on Windows
  Skip tests that require a filesystem that obeys POSIX permissions
  t3700: Skip a test with backslashes in pathspec
  Use prerequisites to skip tests that need unzip
  t7004: Use prerequisite tags to skip tests that need gpg
  t5503: GIT_DEBUG_SEND_PACK is not supported on MinGW

 t/t0000-basic.sh                       |   58 +++++++++++++---
 t/t0004-unwritable.sh                  |    8 +-
 t/t0024-crlf-archive.sh                |    6 +-
 t/t0050-filesystem.sh                  |   28 +++++++-
 t/t0055-beyond-symlinks.sh             |    6 +-
 t/t0060-path-utils.sh                  |  116 +++++++++++++++++++++++---------
 t/t1004-read-tree-m-u-wf.sh            |    6 +-
 t/t1020-subdirectory.sh                |    2 +-
 t/t1300-repo-config.sh                 |    2 +-
 t/t1301-shared-repo.sh                 |   10 ++--
 t/t1504-ceiling-dirs.sh                |    2 +-
 t/t2001-checkout-cache-clash.sh        |    6 +-
 t/t2003-checkout-cache-mkdir.sh        |    8 +-
 t/t2004-checkout-cache-temp.sh         |    2 +-
 t/t2007-checkout-symlink.sh            |    6 ++
 t/t2100-update-cache-badpath.sh        |   14 +++-
 t/t2200-add-update.sh                  |    2 +-
 t/t2201-add-update-typechange.sh       |   16 ++++-
 t/t2300-cd-to-toplevel.sh              |   14 ++--
 t/t3000-ls-files-others.sh             |    7 ++-
 t/t3010-ls-files-killed-modified.sh    |   17 ++++-
 t/t3100-ls-tree-restrict.sh            |   40 +++++++----
 t/t3200-branch.sh                      |    2 +-
 t/t3600-rm.sh                          |   58 ++++++++--------
 t/t3700-add.sh                         |   16 ++--
 t/t3701-add-interactive.sh             |    9 ++-
 t/t4004-diff-rename-symlink.sh         |    7 ++
 t/t4008-diff-break-rewrite.sh          |    8 +-
 t/t4011-diff-symlink.sh                |    7 ++
 t/t4023-diff-rename-typechange.sh      |    7 ++
 t/t4102-apply-rename.sh                |    8 ++-
 t/t4114-apply-typechange.sh            |    7 ++
 t/t4115-apply-symlink.sh               |    7 ++
 t/t4122-apply-symlink-inside.sh        |    7 ++
 t/t4129-apply-samemode.sh              |   19 ++++--
 t/t5000-tar-tree.sh                    |   22 ++++---
 t/t5302-pack-index.sh                  |   15 ++---
 t/t5503-tagfollow.sh                   |    7 ++
 t/t5522-pull-symlink.sh                |    7 ++
 t/t6031-merge-recursive.sh             |   13 ++++
 t/t6200-fmt-merge-msg.sh               |    4 +-
 t/t7001-mv.sh                          |    4 +-
 t/t7004-tag.sh                         |   97 +++++++++++++-------------
 t/t7503-pre-commit-hook.sh             |    4 +-
 t/t7504-commit-msg-hook.sh             |    8 +-
 t/t9100-git-svn-basic.sh               |   37 +++++------
 t/t9129-git-svn-i18n-commitencoding.sh |   22 +++---
 t/t9131-git-svn-empty-symlink.sh       |    2 +-
 t/t9132-git-svn-broken-symlink.sh      |    4 +-
 t/t9200-git-cvsexportcommit.sh         |   13 ++--
 t/t9500-gitweb-standalone-no-errors.sh |   11 ++-
 t/test-lib.sh                          |   74 +++++++++++++++++++--
 52 files changed, 594 insertions(+), 288 deletions(-)

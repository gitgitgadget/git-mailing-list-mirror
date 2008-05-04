From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v3 00/10] Fix git's test suite to pass when the path contains spaces
Date: Sun,  4 May 2008 01:37:50 -0400
Message-ID: <1209879480-16910-1-git-send-email-bdonlan@fushizen.net>
References: <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 07:39:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsWwg-0004V4-Qm
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 07:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbYEDFif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 01:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbYEDFif
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 01:38:35 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:37801 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbYEDFie (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 01:38:34 -0400
Received: from cpe-74-69-246-7.maine.res.rr.com ([74.69.246.7] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1JsWvG-0001Mf-UT; Sun, 04 May 2008 05:38:07 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1JsWvA-0004P5-7Q; Sun, 04 May 2008 01:38:00 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81137>

This patch series fixes bugs in git and git's testsuite to allow all tests
to pass when the working directory contains whitespace and/or shell
metacharacters.

The first three patches in this series fix bugs in git itself that were
uncovered in the process of fixing the test suite. Each contains additional
tests and/or updates to existing tests to exercise the bug in question.

Patches 4 and 5 set up an abstraction for safe handling of editor variables
in tests when we have odd paths; and 6-7 fix bugs in the test libraries.
Patch 8 cleans up some instances of the unportable export FOO=bar construct
in the test suite; patch 9 fixes the remaining individual tests to be
space-sane, and finally 10 arranges for the test suite to always run with the
trash directory name containing spaces, to help prevent regressions in the
future.

Significant changes since v2:
  * Use only spaces in the trash dir names for Windows compatibility
  * Avoid ugliness like \"\$GIT_DIR\"

This series is also available by:
  git pull git://repo.or.cz/git/bdonlan.git wst-submit3

Sorry for the long delay in updating the series; I've been consumed with
schoolwork lately :)

Since it was mentioned providing conversion scripts was useful in review, here
is a hacky script I put together to help fixup the quotation:

http://fushizen.net/~bd/requote.pl

This script was applied on t/t*svn*.sh, then followed by a few manual fixes,
review, and git add -i to change only the chunks that I had made worse in the
previous patches. Note however that the conversion of "->' in places makes for
a large diff...

Bryan Donlan (10):
  git-rebase.sh: Fix --merge --abort failures when path contains
    whitespace
  config.c: Escape backslashes in section names properly
  git-send-email.perl: Handle shell metacharacters in $EDITOR properly
  test-lib.sh: Add a test_set_editor function to safely set $VISUAL
  Use test_set_editor in t9001-send-email.sh
  test-lib.sh: Fix some missing path quoting
  lib-git-svn.sh: Fix quoting issues with paths containing shell
    metacharacters
  Don't use the export NAME=value form in the test scripts.
  Fix tests breaking when checkout path contains shell metacharacters
  Rename the test trash directory to contain spaces.

 config.c                                      |    2 +-
 git-rebase.sh                                 |    2 +-
 git-send-email.perl                           |    2 +-
 t/.gitignore                                  |    2 +-
 t/lib-git-svn.sh                              |    3 +-
 t/lib-httpd.sh                                |    3 +-
 t/t0000-basic.sh                              |    4 +-
 t/t1020-subdirectory.sh                       |   22 ++--
 t/t1303-wacky-config.sh                       |    6 +
 t/t1500-rev-parse.sh                          |    9 +-
 t/t1501-worktree.sh                           |   34 +++---
 t/t3050-subprojects-fetch.sh                  |    2 +-
 t/t3400-rebase.sh                             |    3 +-
 t/t3404-rebase-interactive.sh                 |    3 +-
 t/t3407-rebase-abort.sh                       |   33 +++--
 t/t3500-cherry.sh                             |    3 +-
 t/t5500-fetch-pack.sh                         |    4 +-
 t/t5512-ls-remote.sh                          |    2 +-
 t/t5516-fetch-push.sh                         |    6 +-
 t/t5700-clone-reference.sh                    |    2 +-
 t/t5710-info-alternate.sh                     |    4 +-
 t/t6000lib.sh                                 |    9 +-
 t/t6010-merge-base.sh                         |    9 +-
 t/t6200-fmt-merge-msg.sh                      |    6 +-
 t/t7003-filter-branch.sh                      |    2 +-
 t/t7004-tag.sh                                |    3 +-
 t/t7010-setup.sh                              |    2 +-
 t/t7300-clean.sh                              |    2 +-
 t/t7501-commit.sh                             |    8 +-
 t/t7504-commit-msg-hook.sh                    |   23 ++--
 t/t7505-prepare-commit-msg-hook.sh            |   17 ++-
 t/t9001-send-email.sh                         |    5 +-
 t/t9100-git-svn-basic.sh                      |  120 +++++++++---------
 t/t9101-git-svn-props.sh                      |    8 +-
 t/t9102-git-svn-deep-rmdir.sh                 |   20 ++--
 t/t9103-git-svn-tracked-directory-removed.sh  |   20 ++--
 t/t9104-git-svn-follow-parent.sh              |  172 ++++++++++++------------
 t/t9105-git-svn-commit-diff.sh                |   32 +++---
 t/t9106-git-svn-commit-diff-clobber.sh        |   56 ++++----
 t/t9106-git-svn-dcommit-clobber-series.sh     |   30 ++--
 t/t9107-git-svn-migrate.sh                    |  124 +++++++++---------
 t/t9108-git-svn-glob.sh                       |   76 ++++++------
 t/t9110-git-svn-use-svm-props.sh              |   12 +-
 t/t9111-git-svn-use-svnsync-props.sh          |   12 +-
 t/t9112-git-svn-md5less-file.sh               |    4 +-
 t/t9113-git-svn-dcommit-new-file.sh           |   10 +-
 t/t9114-git-svn-dcommit-merge.sh              |   22 ++--
 t/t9115-git-svn-dcommit-funky-renames.sh      |   12 +-
 t/t9116-git-svn-log.sh                        |   12 +-
 t/t9117-git-svn-init-clone.sh                 |   30 ++--
 t/t9118-git-svn-funky-branch-names.sh         |   24 ++--
 t/t9120-git-svn-clone-with-percent-escapes.sh |    6 +-
 t/t9121-git-svn-fetch-renamed-dir.sh          |   12 +-
 t/t9500-gitweb-standalone-no-errors.sh        |   25 ++--
 t/test-lib.sh                                 |   22 +++-
 55 files changed, 575 insertions(+), 523 deletions(-)

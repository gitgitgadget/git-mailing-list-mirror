From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v2 00/10] Fix git's test suite to pass when the path contains spaces
Date: Thu, 10 Apr 2008 02:50:06 -0400
Message-ID: <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
References: <cover.1207702130.git.bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 08:51:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjqcy-0002u1-31
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 08:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbYDJGue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 02:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753079AbYDJGue
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 02:50:34 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:34029 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbYDJGud (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 02:50:33 -0400
Received: from [130.111.236.232] (helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1Jjqbz-0003wE-LB; Thu, 10 Apr 2008 06:50:19 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1Jjqbw-0007Fp-LO; Thu, 10 Apr 2008 02:50:16 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <cover.1207702130.git.bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79173>

This patch series fixes bugs in git and git's testsuite to allow all tests
to pass when the working directory contains whitespace and/or shell
metacharacters.

The first three patches in this series fix bugs in git itself that were
uncovered in the process of fixing the test suite. Each contains additional
tests and/or updates to existing tests to exercise the bug in question.

Patches 4 and 5 set up an abstraction for safe handling of editor variables
in tests when we have odd paths, and 6-8 fix bugs in the test suite itself.
Patch 9 cleans up some instances of the unportable export FOO=bar construct
in the test suite; and 10 arranges for the test suite to always run with the
trash directory name containing various metacharacters, to help prevent
regressions in the future.

Signifigant changes since v1:
  * Rebase against master
  * Drop some unnecessary quotation additions
  * Use "$@" not $@ in editor invocations in the fix to git-send-email, to
    match builtin-tag.c
  * Be more verbose in the config.c and git-send-email.perl patch commit
    messages
  * Rename 't/trash' to 't/trash directory' to try to trip up more bugs in
    the future
  * Add a patch to convert all export FOO=bar to FOO=bar; export FOO in t/*.sh
  * Noted why t/t7505-prepare-commit-msg-hook.sh isn't using test_set_editor
    in a comment.
  * Clarified the purpose and implementation of test_set_editor in a comment.

This series is also available as a git branch:

  git pull git://repo.or.cz/git/bdonlan.git tags/wst-submit2

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
  Rename the test trash directory to contain shell metacharacters.

 config.c                                      |    2 +-
 git-rebase.sh                                 |    2 +-
 git-send-email.perl                           |    2 +-
 t/.gitignore                                  |    2 +-
 t/lib-git-svn.sh                              |    3 +-
 t/lib-httpd.sh                                |    3 +-
 t/t0000-basic.sh                              |    4 +-
 t/t1020-subdirectory.sh                       |   22 +++++-----
 t/t1303-wacky-config.sh                       |    6 +++
 t/t1500-rev-parse.sh                          |    9 ++--
 t/t1501-worktree.sh                           |   34 ++++++++-------
 t/t3050-subprojects-fetch.sh                  |    2 +-
 t/t3400-rebase.sh                             |    3 +-
 t/t3404-rebase-interactive.sh                 |    3 +-
 t/t3407-rebase-abort.sh                       |   55 ++++++++++++++----------
 t/t3500-cherry.sh                             |    3 +-
 t/t5500-fetch-pack.sh                         |    4 +-
 t/t5512-ls-remote.sh                          |    2 +-
 t/t5516-fetch-push.sh                         |    4 +-
 t/t5700-clone-reference.sh                    |    2 +-
 t/t5710-info-alternate.sh                     |    2 +-
 t/t6000lib.sh                                 |    9 +++-
 t/t6010-merge-base.sh                         |    9 ++--
 t/t6200-fmt-merge-msg.sh                      |    6 +-
 t/t7003-filter-branch.sh                      |    2 +-
 t/t7004-tag.sh                                |    3 +-
 t/t7010-setup.sh                              |    2 +-
 t/t7300-clean.sh                              |    2 +-
 t/t7501-commit.sh                             |    8 ++--
 t/t7504-commit-msg-hook.sh                    |   23 ++++++-----
 t/t7505-prepare-commit-msg-hook.sh            |   17 +++++---
 t/t9001-send-email.sh                         |    5 +-
 t/t9100-git-svn-basic.sh                      |   54 ++++++++++++------------
 t/t9101-git-svn-props.sh                      |    6 +-
 t/t9102-git-svn-deep-rmdir.sh                 |    6 +-
 t/t9103-git-svn-tracked-directory-removed.sh  |   30 +++++++-------
 t/t9104-git-svn-follow-parent.sh              |   50 +++++++++++-----------
 t/t9105-git-svn-commit-diff.sh                |   12 +++---
 t/t9106-git-svn-commit-diff-clobber.sh        |   14 +++---
 t/t9106-git-svn-dcommit-clobber-series.sh     |    6 +-
 t/t9107-git-svn-migrate.sh                    |   48 +++++++++++-----------
 t/t9108-git-svn-glob.sh                       |    8 ++--
 t/t9110-git-svn-use-svm-props.sh              |    8 ++--
 t/t9111-git-svn-use-svnsync-props.sh          |    8 ++--
 t/t9112-git-svn-md5less-file.sh               |    4 +-
 t/t9113-git-svn-dcommit-new-file.sh           |    6 +-
 t/t9114-git-svn-dcommit-merge.sh              |    4 +-
 t/t9115-git-svn-dcommit-funky-renames.sh      |    4 +-
 t/t9116-git-svn-log.sh                        |    4 +-
 t/t9117-git-svn-init-clone.sh                 |   10 ++--
 t/t9118-git-svn-funky-branch-names.sh         |   12 +++---
 t/t9120-git-svn-clone-with-percent-escapes.sh |    2 +-
 t/t9121-git-svn-fetch-renamed-dir.sh          |   12 +++---
 t/t9500-gitweb-standalone-no-errors.sh        |   25 ++++++-----
 t/test-lib.sh                                 |   22 +++++++++-
 55 files changed, 331 insertions(+), 279 deletions(-)

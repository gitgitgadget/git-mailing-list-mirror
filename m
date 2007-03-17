From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] test GIT_WORK_DIR
Date: Sat, 17 Mar 2007 02:33:53 +0100
Message-ID: <20070317013353.GA19305@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 02:34:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSNo0-0006g2-1m
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 02:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933030AbXCQBd5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 21:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933328AbXCQBd5
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 21:33:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:43230 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933030AbXCQBd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 21:33:56 -0400
Received: (qmail invoked by alias); 17 Mar 2007 01:33:55 -0000
X-Provags-ID: V01U2FsdGVkX1+vicoXfoGvGZBGZhcHbtVm/gQhBC6fEbSPhGivbx
	zSaEPFO6JGtRkt
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42415>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
The test number has to be changed here too.
---
 t/t9998-workdir.sh |   91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh      |    1 +
 2 files changed, 92 insertions(+), 0 deletions(-)
 create mode 100755 t/t9998-workdir.sh

diff --git a/t/t9998-workdir.sh b/t/t9998-workdir.sh
new file mode 100755
index 0000000..57a2235
--- /dev/null
+++ b/t/t9998-workdir.sh
@@ -0,0 +1,91 @@
+#!/bin/sh
+
+test_description='test GIT_WORK_DIR'
+. ./test-lib.sh
+
+export GIT_DIR=$(pwd)/repository
+export GIT_CONFIG="$GIT_DIR/config"
+top=$(pwd) || exit 1
+mv .git "$GIT_DIR" || exit 1
+mkdir -p working/directory || exit 1
+
+# test setup code and precedence of core.workdir, GIT_WORK_DIR and --work-dir
+test_expect_failure 'GIT_WORK_DIR=non-existent' \
+	'env GIT_WORK_DIR=non-existent git rev-parse'
+test_expect_success 'GIT_WORK_DIR=working/directory' \
+	'env GIT_WORK_DIR=working/directory git rev-parse'
+test_expect_success 'GIT_WORK_DIR=`pwd`/working/directory' \
+	'env GIT_WORK_DIR="$(pwd)"/working/directory git rev-parse'
+
+test_expect_success '--work-dir' \
+	'git --work-dir working/directory rev-parse'
+test_expect_success '--work-dir overrides GIT_WORK_DIR' \
+	'env GIT_WORK_DIR=non-existent git --work-dir working/directory rev-parse'
+
+test_expect_success 'core.workdir = non-existent' \
+	'git config core.workdir non-existent'
+test_expect_failure 'core.workdir' \
+	'git rev-parse'
+test_expect_success 'GIT_WORK_DIR overrides core.workdir' \
+	'env GIT_WORK_DIR=working/directory git rev-parse'
+test_expect_success '--work-dir overrides core.workdir' \
+	'git --work-dir working/directory rev-parse'
+
+test_expect_success 'core.workdir = `pwd`/working/directory' \
+	'git --work-dir . config core.workdir "$(pwd)"/working/directory'
+test_expect_success 'core.workdir' \
+	'git rev-parse'
+test_expect_success 'core.workdir = ../working/directory' \
+	'git --work-dir . config core.workdir ../working/directory'
+test_expect_success 'core.workdir' \
+	'git rev-parse'
+
+# outside of working directory
+test_expect_success 'outside: --is-bare-repository' \
+	'test "true" = "$(git rev-parse --is-bare-repository)"'
+
+# in toplevel working directory
+cd working/directory || exit 1
+test_expect_success 'inside: --is-bare-repository' \
+	'test "false" = "$(git rev-parse --is-bare-repository)"'
+test_expect_success 'inside: --is-inside-git-dir' \
+	'test "false" = "$(git rev-parse --is-inside-git-dir)"'
+test_expect_success 'inside: --show-prefix' \
+	'test "" = "$(git rev-parse --show-prefix)"'
+test_expect_success 'inside: --show-cdup' \
+	'test "" = "$(git rev-parse --show-cdup)"'
+
+# in subdirectory
+mkdir -p a/b || exit 1
+cd a/b || exit 1
+test_expect_success 'subdirectory: --is-bare-repository' \
+	'test "false" = "$(git rev-parse --is-bare-repository)"'
+test_expect_success 'subdirectory: --is-inside-git-dir' \
+	'test "false" = "$(git rev-parse --is-inside-git-dir)"'
+test_expect_success 'subdirectory: --show-prefix' \
+	'test "a/b/" = "$(git rev-parse --show-prefix)"'
+test_expect_success 'subdirectory: --show-cdup' \
+	'test "../../" = "$(git rev-parse --show-cdup)"'
+
+# in repository directory
+cd "$top/repository" || exit 1
+test_expect_success 'repository: --is-bare-repository' \
+	'test "true" = "$(git rev-parse --is-bare-repository)"'
+test_expect_success 'repository: --is-inside-git-dir' \
+	'test "true" = "$(git rev-parse --is-inside-git-dir)"'
+cd objects || exit 1
+test_expect_success 'repository/objects: --is-inside-git-dir' \
+	'test "true" = "$(git rev-parse --is-inside-git-dir)"'
+cd .. || exit 1
+
+# workdir is subdirectory of repository
+mkdir workdir || exit 1
+cd workdir || exit 1
+test_expect_success 'core.workdir = workdir' \
+	'git config core.workdir workdir'
+test_expect_success 'repository/workdir: --is-bare-repository' \
+	'test "false" = "$(git rev-parse --is-bare-repository)"'
+test_expect_success 'repository/workdir: --is-inside-git-dir' \
+	'test "false" = "$(git rev-parse --is-inside-git-dir)"'
+
+test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index c075474..f73cb2d 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -25,6 +25,7 @@ GIT_COMMITTER_EMAIL=committer@example.com
 GIT_COMMITTER_NAME='C O Mitter'
 unset GIT_DIFF_OPTS
 unset GIT_DIR
+unset GIT_WORK_DIR
 unset GIT_EXTERNAL_DIFF
 unset GIT_INDEX_FILE
 unset GIT_OBJECT_DIRECTORY
-- 
1.5.0.4.408.g563e1

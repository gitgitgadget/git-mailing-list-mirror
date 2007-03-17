From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 4/5] test GIT_WORK_TREE
Date: Sat, 17 Mar 2007 15:44:56 +0100
Message-ID: <20070317144456.GD26290@moooo.ath.cx>
References: <20070317015855.GB19305@moooo.ath.cx> <7vbqiss4yw.fsf@assigned-by-dhcp.cox.net> <20070317143452.GA21140@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 15:45:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSa9X-0007Gf-Na
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 15:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965589AbXCQOo7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 10:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbXCQOo7
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 10:44:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:34121 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752679AbXCQOo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 10:44:58 -0400
Received: (qmail invoked by alias); 17 Mar 2007 14:44:57 -0000
X-Provags-ID: V01U2FsdGVkX18nBcRSnH4nKV6UWy9IqWL7Lw6TO3S8+l5h+5jPqh
	w2wIXbPZr/vXnN
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070317143452.GA21140@moooo.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42440>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 t/t1501-worktree.sh |   91 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 91 insertions(+), 0 deletions(-)
 create mode 100755 t/t1501-worktree.sh

diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
new file mode 100755
index 0000000..bc08994
--- /dev/null
+++ b/t/t1501-worktree.sh
@@ -0,0 +1,91 @@
+#!/bin/sh
+
+test_description='test GIT_WORK_TREE'
+. ./test-lib.sh
+
+export GIT_DIR=$(pwd)/repository
+export GIT_CONFIG="$GIT_DIR/config"
+top=$(pwd) || exit 1
+mv .git "$GIT_DIR" || exit 1
+mkdir -p working/tree || exit 1
+
+# test setup code and precedence of core.worktree, GIT_WORK_TREE and --work-tree
+test_expect_failure 'GIT_WORK_TREE=non-existent' \
+	'env GIT_WORK_TREE=non-existent git rev-parse'
+test_expect_success 'GIT_WORK_TREE=working/tree' \
+	'env GIT_WORK_TREE=working/tree git rev-parse'
+test_expect_success 'GIT_WORK_TREE=`pwd`/working/tree' \
+	'env GIT_WORK_TREE="$(pwd)"/working/tree git rev-parse'
+
+test_expect_success '--work-tree' \
+	'git --work-tree working/tree rev-parse'
+test_expect_success '--work-tree overrides GIT_WORK_TREE' \
+	'env GIT_WORK_TREE=non-existent git --work-tree working/tree rev-parse'
+
+test_expect_success 'core.worktree = non-existent' \
+	'git config core.worktree non-existent'
+test_expect_failure 'core.worktree' \
+	'git rev-parse'
+test_expect_success 'GIT_WORK_TREE overrides core.worktree' \
+	'env GIT_WORK_TREE=working/tree git rev-parse'
+test_expect_success '--work-tree overrides core.worktree' \
+	'git --work-tree working/tree rev-parse'
+
+test_expect_success 'core.worktree = `pwd`/working/tree' \
+	'git --work-tree . config core.worktree "$(pwd)"/working/tree'
+test_expect_success 'core.worktree' \
+	'git rev-parse'
+test_expect_success 'core.worktree = ../working/tree' \
+	'git --work-tree . config core.worktree ../working/tree'
+test_expect_success 'core.worktree' \
+	'git rev-parse'
+
+# outside of working tree
+test_expect_success 'outside: --is-bare-repository' \
+	'test "true" = "$(git rev-parse --is-bare-repository)"'
+
+# in toplevel working tree
+cd working/tree || exit 1
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
+# worktree is subdirectory of repository
+mkdir worktree || exit 1
+cd worktree || exit 1
+test_expect_success 'core.worktree = worktree' \
+	'git config core.worktree worktree'
+test_expect_success 'repository/worktree: --is-bare-repository' \
+	'test "false" = "$(git rev-parse --is-bare-repository)"'
+test_expect_success 'repository/worktree: --is-inside-git-dir' \
+	'test "false" = "$(git rev-parse --is-inside-git-dir)"'
+
+test_done
-- 
1.5.0.4.414.g32da9

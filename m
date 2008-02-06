From: Jeff King <peff@peff.net>
Subject: [PATCH] allow setting GIT_WORK_TREE to "no work tree"
Date: Wed, 6 Feb 2008 05:26:08 -0500
Message-ID: <20080206102608.GA1007@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 11:26:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMhUK-0004Fj-Pt
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 11:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbYBFK0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 05:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbYBFK0M
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 05:26:12 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1737 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbYBFK0M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 05:26:12 -0500
Received: (qmail 27858 invoked by uid 111); 6 Feb 2008 10:26:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 06 Feb 2008 05:26:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2008 05:26:08 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72792>

In setup_git_directory_gently, we have a special rule
that says "if GIT_DIR is set but GIT_WORK_TREE is not, then
use the current working directory as the work tree." This is
the intended behavior for the user perspective.

However, setup_git_directory_gently sets GIT_DIR itself,
meaning that further setups (either because we are executing
a command via alias, or in a subprocess) will see the
non-existent GIT_WORK_TREE and assume we fall into the
"current working directory is the working tree" codepath.

Instead, we now use a special value of GIT_WORK_TREE to
indicate that we have already checked for a worktree and
that there isn't one, setting it when we set GIT_DIR and
checking for it in the special case path.

The special value is a blank GIT_WORK_TREE; it could be any
value, but this should not conflict with any user values
(and as a bonus, you can now tell git "I don't have a work
tree" with "GIT_WORK_TREE= git", though I suspect the use
case for that is limited).

Signed-off-by: Jeff King <peff@peff.net>
---
On Sun, Feb 03, 2008 at 02:59:13AM -0800, Junio C Hamano wrote:

> * "[alias] st = status" and "cd .git && git st" (Jeff King)

This turned out to be easier than expected. Note that this patch causes
t1500 to fail; however, the test is at fault, and is already fixed in
the series I just sent out.

 environment.c                 |    9 +++++++--
 setup.c                       |    1 +
 t/t1502-worktree-semantics.sh |   20 ++++++++++++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)
 create mode 100755 t/t1502-worktree-semantics.sh

diff --git a/environment.c b/environment.c
index 18a1c4e..38e8dff 100644
--- a/environment.c
+++ b/environment.c
@@ -90,8 +90,13 @@ const char *get_git_work_tree(void)
 			/* make_absolute_path also normalizes the path */
 			if (work_tree && !is_absolute_path(work_tree))
 				work_tree = xstrdup(make_absolute_path(git_path(work_tree)));
-		} else if (work_tree)
-			work_tree = xstrdup(make_absolute_path(work_tree));
+		} else if (work_tree) {
+			if (*work_tree)
+				work_tree = xstrdup(
+						make_absolute_path(work_tree));
+			else
+				work_tree = NULL;
+		}
 		initialized = 1;
 		if (work_tree)
 			is_bare_repository_cfg = 0;
diff --git a/setup.c b/setup.c
index adede16..85c0b48 100644
--- a/setup.c
+++ b/setup.c
@@ -309,6 +309,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			if (!work_tree_env)
 				inside_work_tree = 0;
 			setenv(GIT_DIR_ENVIRONMENT, ".", 1);
+			setenv(GIT_WORK_TREE_ENVIRONMENT, "", 1);
 			check_repository_format_gently(nongit_ok);
 			return NULL;
 		}
diff --git a/t/t1502-worktree-semantics.sh b/t/t1502-worktree-semantics.sh
new file mode 100755
index 0000000..fbc355b
--- /dev/null
+++ b/t/t1502-worktree-semantics.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+test_description='semantics of GIT_WORK_TREE variable'
+. ./test-lib.sh
+
+test_expect_success 'setup working tree' 'touch file'
+
+test_expect_success 'setup alias' 'git config alias.a add'
+
+test_expect_success 'blank GIT_WORK_TREE disallows work-tree commands' '
+	! GIT_WORK_TREE= git add .
+'
+
+test_expect_success 'alias inside working tree works' 'git a .'
+
+test_expect_success 'alias inside .git complains about working tree' '
+	cd .git && ! GIT_CONFIG=config git a .
+'
+
+test_done
-- 
1.5.4.26.g301fb

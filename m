From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] fix and testcase for git-commit-tree option
Date: Fri, 27 May 2005 01:03:26 +0200
Message-ID: <20050526230326.GA14736@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 01:02:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbRMD-0004Dz-EO
	for gcvg-git@gmane.org; Fri, 27 May 2005 01:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVEZXDg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 19:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVEZXDg
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 19:03:36 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:41886 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261800AbVEZXD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 19:03:28 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id D468F261; Fri, 27 May 2005 01:03:26 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Actually use GIT_COMMITTER_DATE in git-commit-tree.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

---
commit 00a2437bb75c5c3521f199faa044481783de45aa
tree 97976f550804169368e1e30cd26ead9980461a84
parent 2eab945e865317cb7d390aec214303f1d931b53a
author lsr <lsr@linux> Fri, 27 May 2005 00:53:30 +0200
committer lsr <lsr@linux> Fri, 27 May 2005 00:53:30 +0200

 commit-tree.c                  |    2 -
 t/t1100-commit-tree-options.sh |   45 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

Index: commit-tree.c
===================================================================
--- dbec0de73e52d5b6d0740dd2e226d3ce8e2e51fd/commit-tree.c  (mode:100644)
+++ 97976f550804169368e1e30cd26ead9980461a84/commit-tree.c  (mode:100644)
@@ -153,7 +153,7 @@
 		parse_date(audate, date, sizeof(date));
 	cmdate = gitenv("GIT_COMMITTER_DATE");
 	if (cmdate)
-		parse_date(audate, realdate, sizeof(realdate));
+		parse_date(cmdate, realdate, sizeof(realdate));
 
 	remove_special(gecos); remove_special(realgecos); remove_special(commitgecos);
 	remove_special(email); remove_special(realemail); remove_special(commitemail);
Index: t/t1100-commit-tree-options.sh
===================================================================
--- /dev/null  (tree:dbec0de73e52d5b6d0740dd2e226d3ce8e2e51fd)
+++ 97976f550804169368e1e30cd26ead9980461a84/t/t1100-commit-tree-options.sh  (mode:100755)
@@ -0,0 +1,45 @@
+#!/bin/sh
+#
+# Copyright (C) 2005 Rene Scharfe
+#
+
+test_description='git-commit-tree options test
+
+This test checks that git-commit-tree can create a specific commit
+object by defining all environment variables that it understands.
+'
+
+. ./test-lib.sh
+
+cat >expected <<EOF
+tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
+author Author Name <author@email> 1117148400 +0000
+committer Committer Name <committer@email> 1117150200 +0000
+
+comment text
+EOF
+
+test_expect_success \
+    'test preparation: write empty tree' \
+    'git-write-tree >treeid'
+
+test_expect_success \
+    'construct commit' \
+    'echo comment text |
+     GIT_AUTHOR_NAME="Author Name" \
+     GIT_AUTHOR_EMAIL="author@email" \
+     GIT_AUTHOR_DATE="2005-05-26 23:00" \
+     GIT_COMMITTER_NAME="Committer Name" \
+     GIT_COMMITTER_EMAIL="committer@email" \
+     GIT_COMMITTER_DATE="2005-05-26 23:30" \
+     TZ= git-commit-tree `cat treeid` >commitid 2>/dev/null'
+
+test_expect_success \
+    'read commit' \
+    'git-cat-file commit `cat commitid` >commit'
+
+test_expect_success \
+    'compare commit' \
+    'diff expected commit'
+
+test_done

From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH v2 10/11] Move code to clean up after a branch change to
 branch.c
Date: Thu, 7 Feb 2008 11:40:16 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802071134560.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 17:42:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN9ok-0007U1-HY
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 17:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755878AbYBGQkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 11:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755798AbYBGQkY
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 11:40:24 -0500
Received: from iabervon.org ([66.92.72.58]:39494 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755737AbYBGQkT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 11:40:19 -0500
Received: (qmail 29822 invoked by uid 1000); 7 Feb 2008 16:40:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Feb 2008 16:40:16 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72975>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
This or a related function should perhaps also be used by builtin-commit, 
which is removing some but not all of these.

 branch.c        |    8 ++++++++
 branch.h        |   20 ++++++++++++++++++--
 builtin-reset.c |    6 ++----
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/branch.c b/branch.c
index 45ab820..1fc8788 100644
--- a/branch.c
+++ b/branch.c
@@ -138,3 +138,11 @@ void create_branch(const char *head,
 	if (real_ref)
 		free(real_ref);
 }
+
+void remove_branch_state(void)
+{
+	unlink(git_path("MERGE_HEAD"));
+	unlink(git_path("rr-cache/MERGE_RR"));
+	unlink(git_path("MERGE_MSG"));
+	unlink(git_path("SQUASH_MSG"));
+}
diff --git a/branch.h b/branch.h
index 8bcd9dc..d30abe0 100644
--- a/branch.h
+++ b/branch.h
@@ -1,8 +1,24 @@
 #ifndef BRANCH_H
 #define BRANCH_H
 
-void create_branch(const char *head,
-		   const char *name, const char *start_name,
+/* Functions for acting on the information about branches. */
+
+/*
+ * Creates a new branch, where head is the branch currently checked
+ * out, name is the new branch name, start_name is the name of the
+ * existing branch that the new branch should start from, force
+ * enables overwriting an existing (non-head) branch, reflog creates a
+ * reflog for the branch, and track causes the new branch to be
+ * configured to merge the remote branch that start_name is a tracking
+ * branch for (if any).
+ */
+void create_branch(const char *head, const char *name, const char *start_name,
 		   int force, int reflog, int track);
 
+/*
+ * Remove information about the state of working on the current
+ * branch. (E.g., MERGE_HEAD)
+ */
+void remove_branch_state(void);
+
 #endif
diff --git a/builtin-reset.c b/builtin-reset.c
index 3bec06b..af0037e 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -16,6 +16,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "tree.h"
+#include "branch.h"
 
 static const char builtin_reset_usage[] =
 "git-reset [--mixed | --soft | --hard] [-q] [<commit-ish>] [ [--] <paths>...]";
@@ -270,10 +271,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
-	unlink(git_path("MERGE_HEAD"));
-	unlink(git_path("rr-cache/MERGE_RR"));
-	unlink(git_path("MERGE_MSG"));
-	unlink(git_path("SQUASH_MSG"));
+	remove_branch_state();
 
 	free(reflog_action);
 
-- 
1.5.4
